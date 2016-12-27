

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_10_MissingMedia'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_10_MissingMedia
GO

CREATE PROCEDURE dbo.Report_2_10_10_MissingMedia 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ChannelName				VARCHAR(50)		= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@SpotStatusID				INT				= NULL,
				@SpotConflictStatusID		INT				= NULL,
				@StartDateTime				DATETIME,
				@EndDateTime				DATETIME

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
// Module:  dbo.Report_2_10_10_MissingMedia
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetSummaryDetails report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_10_MissingMedia.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_10_MissingMedia	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@ChannelName				= NULL,
//									@MarketID					= NULL,
//									@ZoneName					= NULL,
//									@NetworkName				= NULL,
//									@ICProviderID				= NULL,
//									@ROCID						= NULL,
//									@SpotStatusID				= NULL,
//									@SpotConflictStatusID		= NULL,
//									@StartDateTime				= NULL,
//									@EndDateTime				= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@StartDay													DATE = @StartDateTime
				DECLARE			@EndDay														DATE = @EndDateTime


				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimSPOTID BIGINT, UTCDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCSPOTDatetime							BETWEEN @StartDateTime AND @EndDateTime
				ELSE
								INSERT			#DayDateSubset ( DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate											BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.RUN_DATE_TIME								BETWEEN @StartDateTime AND @EndDateTime





				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								ChannelName,
								MarketName,
								ZoneName,
								NetworkName,
								ICProviderName,
								ROCName,
								Position,
								AssetID,
								SpotStatus,
								SpotConflictStatus,
								ScheduledDateTime
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName,
								ChannelName													= s.ChannelName,
								MarketName													= s.MarketName,
								ZoneName													= s.ZoneName,
								NetworkName													= s.NetworkName,
								ICProviderName												= s.ICProviderName,
								ROCName														= s.ROCName,
								Position													= s.Spot_ORDER,
								AssetID 													= s.VIDEO_ID,
								SpotStatus													= s.NSTATUSValue,
								SpotConflictStatus											= s.CONFLICT_STATUSValue,
								ScheduledDateTime											= CASE	WHEN @UseUTC = 1 THEN s.UTCIEDatetime ELSE s.IEDatetime END

				FROM			#DayDateSubset x
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.UTCDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.MarketID													= ISNULL(@MarketID,s.MarketID)
				AND				s.ZoneName													= ISNULL(@ZoneName,s.ZoneName)
				AND				s.NetworkName												= ISNULL(@NetworkName,s.NetworkName)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)
				AND				s.NSTATUS													= ISNULL(@SpotStatusID,s.NSTATUS)
				AND				s.CONFLICT_STATUS											= ISNULL(@SpotConflictStatusID,s.CONFLICT_STATUS)


				DROP TABLE		#DayDateSubset



END


GO


