Use DINGODB
GO
IF ISNULL(OBJECT_ID('dbo.GetConflict'), 0) > 0 
	DROP PROCEDURE dbo.GetConflict
GO

CREATE PROCEDURE [dbo].[GetConflict]
		@RegionID			UDT_Int READONLY,
		@SDBID				UDT_Int READONLY,
		@IUID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetConflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the Conflict of evert SPOT of an IU and accompanying information based on the filters applied.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetConflict.proc.sql 3495 2014-02-12 17:28:01Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int					
//				DECLARE @SDBID_TBL			UDT_Int					
//				DECLARE @IUID_TBL			UDT_Int					
//				DECLARE @ReturnValue		INT						
//
//				INSERT	@IUID_TBL (Value) VALUES (2344)
//				INSERT	@IUID_TBL (Value) VALUES (2322)
//				INSERT	@IUID_TBL (Value) VALUES (2336)
//
//				EXEC	dbo.GetConflict					
//						@RegionID			= @RegionID_TBL,		
//						@SDBID				= @SDBID_TBL,			
//						@IUID				= @IUID_TBL,			
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue								
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@SDBID_COUNT INT
		DECLARE				@IUID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @SDBID_COUNT = ID FROM @SDBID
		SELECT				TOP 1 @IUID_COUNT = ID FROM @IUID

		SELECT				TOP (5000)
							REGIONALIZED_IE										= spot.IE_ID,
							Region												= r.Name,
							SDB 												= s.SDBComputerNamePrefix,
							REGIONALIZED_IU										= IU.REGIONALIZED_IU_ID,
							Channel_Name 										= CAST(IU.CHANNEL_NAME AS VARCHAR(40)),
							Market 												= mkt.Name,
							Zone												= zm.ZONE_NAME,
							Network 											= net.NAME,
							TSI 												= IU.COMPUTER_NAME,
							ICProvider 											= IC.Name,
							ROC 												= ROC.Name,
							Time 												= a.Time,
							TimeZoneOffset 										= s.UTCOffset,
							PositionWithinBreak 								= spot.SPOT_ORDER,
							Asset_ID 											= a.Asset_ID,
							Asset_Desc	 										= a.Asset_Desc,
							Spot_Status											= CAST(ss.VALUE AS VARCHAR(55)),					--Varchar(55)	String describing the status of the Spot
							Spot_Status_Age 									= DATEDIFF( MINUTE, spot.UTC_SPOT_NSTATUS_UPDATE_TIME, GETUTCDATE() ),		--Int	Duration in minutes since the SPOT_Status changed value
							Spot_Conflict 										= CAST(cs.VALUE AS VARCHAR(55)),					--Varchar(55) String descripting the conflict state of the Spot
							Spot_Conflict_Age 									= DATEDIFF( MINUTE, spot.UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME, GETUTCDATE() ),			--Int	Duration in minutes since the SPOT_Conflict changed value
							Insertion_Status 									= CAST(ies.VALUE AS VARCHAR(55)),					--Varchar(55)	String descripting the Status of the insertion event for which this Spot belongs
							Insertion_Status_Age 								= DATEDIFF( MINUTE, spot.UTC_IE_NSTATUS_UPDATE_TIME, GETUTCDATE() ),		--Int	Duration in minutes since the Insertion_Status changed value
							Insertion_Conflict 									= CAST(iecs.VALUE AS VARCHAR(55)),					--Varchar(55) String descripting the conflict state of the insertion event for which this spot belongs
							Insertion_Conflict_Age  							= DATEDIFF( MINUTE, spot.UTC_IE_NSTATUS_UPDATE_TIME, GETUTCDATE() ),		--Int	Duration in minutes since the Insertion_Conflict changed value
							Scheduled_Insertions 								= a.Scheduled_Insertions,							--Int	This can be calculated by summing all the scheduled insertion for an Asset
							CreateDate											= a.CreateDate,
							UpdateDate 											= a.UpdateDate

		FROM				dbo.Conflict a (NOLOCK)
		JOIN				dbo.SDBSource s (NOLOCK)
		ON					a.SDBSourceID										= s.SDBSourceID
		JOIN				dbo.SDB_IESPOT spot (NOLOCK)
		ON					a.SDBSourceID										= spot.SDBSourceID
		AND					a.IU_ID												= spot.IU_ID
		AND					a.Asset_ID											= spot.VIDEO_ID
		AND					a.SPOT_ID											= spot.SPOT_ID
		JOIN				dbo.ChannelStatus b (NOLOCK) 
		ON					a.SDBSourceID										= b.SDBSourceID
		AND					a.IU_ID												= b.IU_ID
		JOIN				dbo.REGIONALIZED_ZONE x (NOLOCK)
		ON					b.RegionalizedZoneID								= x.REGIONALIZED_ZONE_ID
		JOIN				dbo.REGIONALIZED_IU IU (NOLOCK)
		ON					a.IU_ID												= IU.IU_ID
		AND					x.REGION_ID											= IU.REGIONID
		JOIN				dbo.Region r (NOLOCK)
		ON					IU.REGIONID											= r.RegionID
		JOIN				dbo.REGIONALIZED_NETWORK_IU_MAP netmap (NOLOCK)
		ON					IU.REGIONALIZED_IU_ID								= netmap.REGIONALIZED_IU_ID
		JOIN				dbo.REGIONALIZED_NETWORK net (NOLOCK)
		ON					netmap.REGIONALIZED_NETWORK_ID						= net.REGIONALIZED_NETWORK_ID
		JOIN				dbo.ZONE_MAP zm (NOLOCK)
		ON					IU.ZONE_NAME										= zm.ZONE_NAME
		JOIN				dbo.ROC ROC (NOLOCK)
		ON					zm.ROCID											= ROC.ROCID
		JOIN				dbo.Market mkt (NOLOCK)
		ON					zm.MarketID											= mkt.MarketID
		JOIN				dbo.ICProvider IC (NOLOCK) 
		ON					zm.ICProviderID										= IC.ICProviderID
		LEFT JOIN			dbo.REGIONALIZED_SPOT_STATUS ss
		ON					spot.SPOT_NSTATUS									= ss.NSTATUS
		AND					IU.REGIONID											= ss.RegionID
		LEFT JOIN			dbo.REGIONALIZED_SPOT_CONFLICT_STATUS cs
		ON					spot.SPOT_CONFLICT_STATUS							= cs.NSTATUS
		AND					IU.REGIONID											= cs.RegionID
		LEFT JOIN			dbo.REGIONALIZED_IE_STATUS ies
		ON					spot.IE_NSTATUS										= ies.NSTATUS
		AND					IU.REGIONID											= ies.RegionID
		LEFT JOIN			dbo.REGIONALIZED_IE_CONFLICT_STATUS iecs
		ON					spot.IE_CONFLICT_STATUS								= iecs.NSTATUS
		AND					IU.REGIONID											= iecs.RegionID
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID				WHERE Value = IU.RegionID)					OR @RegionID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @SDBID					WHERE Value = a.SDBSourceID )				OR @SDBID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @IUID					WHERE Value = IU.REGIONALIZED_IU_ID)		OR @IUID_COUNT IS NULL )
		AND					a.UTCTime											>= GETUTCDATE()
		AND					b.Enabled											= 1
		ORDER BY			a.UTCTime

		SET					@Return												= @@ERROR

END




GO


