

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_7_VideoDurationMismatch'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_7_VideoDurationMismatch
GO

CREATE PROCEDURE dbo.Report_2_10_7_VideoDurationMismatch 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@ChannelName				VARCHAR(100)	= NULL,
				@ScheduleDate				DATE			= NULL,
				@AssetID					VARCHAR(50)		= NULL

AS
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
// Module:  dbo.Report_2_10_7_VideoDurationMismatch
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate FutureReadiness report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_7_VideoDurationMismatch.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_7_VideoDurationMismatch	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@MarketID					= NULL,
//									@ZoneName					= NULL,
//									@NetworkName				= NULL,
//									@ICProviderID				= NULL,	
//									@ROCID						= NULL,
//									@ChannelName				= NULL,
//									@ScheduleDate				= NULL,
//									@AssetID					= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimSPOTID BIGINT, DimIEID BIGINT, DimIUID BIGINT, SPOTDayOfYearPartitionKey INT, IEDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimSPOTID, SPOTDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							= @ScheduleDate 
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCIEDate									= @ScheduleDate
								GROUP BY		x.DimSPOTID, x.DimIEID, x.DimIUID, x.UTCSPOTDayOfYearPartitionKey, x.UTCIEDayOfYearPartitionKey
				ELSE
								INSERT			#DayDateSubset ( DimSPOTID, SPOTDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							= @ScheduleDate 
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.IEDate									= @ScheduleDate
								GROUP BY		x.DimSPOTID, x.DimIEID, x.DimIUID, x.UTCSPOTDayOfYearPartitionKey, x.UTCIEDayOfYearPartitionKey




				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								MarketName,
								ZoneName, 
								NetworkName, 
								ICProviderName,
								ROCName,
								ChannelName, 
								ScheduleDate,
								AssetID,
								Duration
			
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName, 
								MarketName 													= s.MarketName,
								ZoneName	 												= s.ZoneName,
								NetworkName													= s.NetworkName,
								ICProviderName 												= s.ICProviderName,
								ROCName 													= s.ROCName,
								ChannelName													= s.ChannelName,
								ScheduleDate												= @ScheduleDate,
								AssetID														= s.VIDEO_ID,
								Duration													= a.Length

				FROM			#DayDateSubset x
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.SPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimAsset a WITH (NOLOCK)								ON s.RegionID = a.RegionID
																							AND s.VIDEO_ID = a.AssetID
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.ZoneName													= ISNULL(@ZoneName,s.ZoneName)
				AND				s.NetworkName												= ISNULL(@NetworkName,s.NetworkName)
				AND				s.MarketID													= ISNULL(@MarketID,s.MarketID)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)

				DROP TABLE		#DayDateSubset



END


GO


