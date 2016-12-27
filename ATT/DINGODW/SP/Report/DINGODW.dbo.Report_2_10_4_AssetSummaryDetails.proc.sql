

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_4_AssetSummaryDetails'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_4_AssetSummaryDetails
GO

CREATE PROCEDURE dbo.Report_2_10_4_AssetSummaryDetails 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@AssetID					VARCHAR(50)		= NULL,
				@MinDuration				INT				= NULL,
				@MaxDuration				INT				= NULL,
				@StartDateTime				DATETIME		= NULL,
				@EndDateTime				DATETIME		= NULL

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
// Module:  dbo.Report_2_10_4_AssetSummaryDetails
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetSummaryDetails report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_4_AssetSummaryDetails.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_4_AssetSummaryDetails	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@ICProviderID				= NULL,
//									@ROCID						= NULL,
//									@AssetID					= NULL,
//									@MinDuration				= NULL,
//									@MaxDuration				= NULL,
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
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), FactAssetSummaryID BIGINT, DimSPOTID BIGINT, UTCDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			f.FactAssetSummaryID, f.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.FactAssetSummary f WITH (NOLOCK)		ON d.DimDate = f.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON f.DimSpotID = s.DimSpotID
																							AND	f.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCSPOTDatetime							BETWEEN @StartDateTime AND @EndDateTime
				ELSE
								INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			f.FactAssetSummaryID, f.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.FactAssetSummary f WITH (NOLOCK)
																							ON d.DimDate = f.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON f.DimSpotID = s.DimSpotID
																							AND	f.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.SPOTDate									BETWEEN @StartDateTime AND @EndDateTime


				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								ICProviderName,
								ROCName,
								AssetID,
								Duration,
								Ingested
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName,
								ICProviderName												= s.ICProviderName,
								ROCName														= s.ROCName,
								AssetID 													= s.VIDEO_ID,
								Duration													= f.SecondsLength,
								Ingested													= CASE	WHEN @UseUTC = 1 THEN s.UTCSPOTDatetime
																									ELSE s.RUN_DATE_TIME
																								END

				FROM			#DayDateSubset x
				JOIN			dbo.FactAssetSummary f WITH (NOLOCK)						ON x.FactAssetSummaryID = f.FactAssetSummaryID
																							AND x.UTCDayOfYearPartitionKey = f.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON f.DimSpotID = s.DimSpotID
																							AND f.UTCSPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				WHERE			s.RUN_DATE_TIME												BETWEEN @StartDateTime AND @EndDateTime
				AND				f.SecondsLength												BETWEEN ISNULL( @MinDuration,f.SecondsLength ) AND ISNULL( @MaxDuration,f.SecondsLength )
				AND				s.VIDEO_ID													BETWEEN ISNULL( @AssetID,s.VIDEO_ID ) AND ISNULL( @AssetID,s.VIDEO_ID )
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)


				DROP TABLE		#DayDateSubset



END


GO


