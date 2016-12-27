Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetAssetStatus'), 0) > 0 
	DROP PROCEDURE dbo.GetAssetStatus
GO


CREATE PROCEDURE [dbo].[GetAssetStatus]
		@RegionID			UDT_Int READONLY,
		@AssetID			UDT_Int READONLY,
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
// Module:  dbo.GetAssetStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Asset Status and all accompanying information based on the applied filters.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetAssetStatus.proc.sql 4284 2014-05-27 17:06:21Z tlew $
//    
//	 Usage:
//
//				DECLARE @Region_TBL			UDT_Int
//				DECLARE @Asset_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//
//				INSERT	@Asset_TBL (Value) VALUES (0)
//				INSERT	@Asset_TBL (Value) VALUES (1)
//				INSERT	@Asset_TBL (Value) VALUES (47)
//				
//				EXEC	dbo.GetAssetStatus 
//						--@RegionID = @Region_TBL, 
//						@AssetID = @Asset_TBL,
//						@Return = @ReturnValue OUTPUT
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE				@RegionID_COUNT INT
		DECLARE				@AssetID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @AssetID_COUNT = ID FROM @AssetID


		SELECT
							--Region													= r.Name,
							--SDB														= sdb.SDBComputerNamePrefix,
							--Channel_Name											= CAST(IU.CHANNEL_NAME AS VARCHAR(40)),
							--Market													= mkt.Name,											--It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
							--Zone													= zm.ZONE_NAME,
							--Network													= net.NAME,
							--TSI 													= IU.COMPUTER_NAME,
							--ICProvider  											= IC.Name,
							--ROC 													= ROC.Name,

							Region													= r.Name,
							Asset_ID												= 'VarChar(12)',									--VarChar(12)
							Asset_Desc												= 'VarChar(12)',									--VarChar(60)
							Asset_Duration											= 0,												--Time	
							Asset_Format											= 0,												--VarChar(10)	
							DTM_Asset_InsertionErrors								= 0,												--Int	
							Scheduled_Insertions									= 0,												--Int	
							MTE_Scheduled_Insertions								= 0,												--Int	
							Time													= GETDATE(),										--DateTime
							TimeZoneOffSet											= 0,												--Int	
							Latest_QC_Result										= 'Latest_QC_Result',								--VarChar	
							Latest_Ingest_Result									= 'Latest_Ingest_Result',							--VarChar	
							CreateDate												= GETDATE(),										--DateTime	
							UpdateDate												= GETDATE()											--DateTime

		FROM				dbo.SDBSource sdb WITH (NOLOCK)
		JOIN				dbo.MDBSource mdb WITH (NOLOCK)
		ON					sdb.MDBSourceID											= mdb.MDBSourceID
		JOIN				dbo.Region r WITH (NOLOCK)
		ON					mdb.RegionID											= r.RegionID
		JOIN				dbo.REGIONALIZED_ZONE z WITH (NOLOCK)
		ON					r.RegionID												= z.REGION_ID
		JOIN				dbo.ZONE_MAP zm WITH (NOLOCK)								--It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
		ON					z.ZONE_NAME												= zm.ZONE_NAME
		LEFT JOIN			dbo.ROC ROC WITH (NOLOCK)
		ON					zm.ROCID												= ROC.ROCID
		LEFT JOIN			dbo.Market mkt WITH (NOLOCK)
		ON					zm.MarketID												= mkt.MarketID
		LEFT JOIN			dbo.ICProvider IC WITH (NOLOCK) 
		ON					zm.ICProviderID											= IC.ICProviderID
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID					WHERE Value = r.RegionID)					OR @RegionID_COUNT IS NULL )
		--AND					( EXISTS(SELECT TOP 1 1 FROM @AssetID					WHERE Value = x.AssetID)					OR @AssetID_COUNT IS NULL )
		ORDER BY			mkt.Name,												--AS Market
							zm.ZONE_NAME											--AS Zone

		SET					@Return = @@ERROR


END


GO


