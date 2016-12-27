

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_4_AssetInfoDuration'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_4_AssetInfoDuration
GO

CREATE PROCEDURE dbo.Report_2_10_4_AssetInfoDuration 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@MinDuration				INT				= NULL,
				@MaxDuration				INT				= NULL,
				@StartDate					DATETIME		= NULL,
				@EndDate					DATETIME		= NULL

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
// Module:  dbo.Report_2_10_4_AssetInfoDuration
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetInfoDuration report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_4_AssetInfoDuration.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_4_AssetInfoDuration	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@MinDuration				= NULL,
//									@MaxDuration				= NULL,
//									@StartDate					= NULL,
//									@EndDate					= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				
				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				DECLARE			@DYPartition												UDT_Int
				DECLARE			@StartDay													DATE
				DECLARE			@EndDay														DATE
				DECLARE			@EndDayMinus1Day											DATE
				DECLARE			@7DaysAgoDate												DATE
				DECLARE			@7DaysAgoDateTime											DATETIME

				IF				( ISNULL(OBJECT_ID('tempdb..#XSEUSubset'), 0) > 0 )			DROP TABLE #XSEUSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), FactAssetSummaryID INT, DimSPOTID INT, DimIEID INT, DayDate DATE, DayOfYearPartitionKey INT, UTCSPOTDayOfYearPartitionKey INT, UTCIEDayOfYearPartitionKey INT )

				SELECT			@UseUTC														=	ISNULL(@UseUTC,1)
				SELECT			@StartDay													=	@StartDate,
								@EndDay														=	@EndDate,
								@EndDayMinus1Day											=	DATEADD( DAY,-1,@EndDay ),
								@7DaysAgoDate												=	DATEADD( DAY,-7,@StartDay),
								@7DaysAgoDateTime											=	DATEADD( DAY,-7,@StartDate)


				INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, DimIEID, DayDate, DayOfYearPartitionKey, UTCSPOTDayOfYearPartitionKey, UTCIEDayOfYearPartitionKey )
				SELECT			f1.FactAssetSummaryID, f1.DimSPOTID, f1.DimIEID, d.DimDate, d.DayOfYearPartitionKey, f1.UTCSPOTDayOfYearPartitionKey, f1.UTCIEDayOfYearPartitionKey
				FROM			
							(	
								SELECT		DimDate, DayOfYearPartitionKey
								FROM		dbo.DimDateDay WITH (NOLOCK)
								WHERE		DimDate											BETWEEN @7DaysAgoDate AND @EndDayMinus1Day
							) d
				JOIN			dbo.FactAssetSummary f1 WITH (NOLOCK)
																							ON d.DimDate =	
																								CASE	WHEN @UseUTC = 1 THEN f1.UTCSPOTDayDate
																										ELSE f1.SPOTDayDate
																								END
																							AND	d.DayOfYearPartitionKey	=	
																								CASE	WHEN @UseUTC = 1 THEN f1.UTCSPOTDayOfYearPartitionKey
																										ELSE f1.SPOTDayOfYearPartitionKey
																								END


				INSERT INTO		#tmp_AllSpots 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								SpotID,
								AssetID,
								Duration,
								Ingested
							)
				SELECT			RegionID													= SPOT.RegionID,
								SDBSourceID													= SPOT.SDBSourceID,
								SDB															= SPOT.SDBName,
								DBSource													= 'DINGODW',
								SpotID														= SPOT.DimSPOTID,
								AssetID 													= SPOT.VIDEO_ID ,
								Duration													= SPOT.RUN_LENGTH,
								Ingested													= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,SPOT.RUN_DATE_TIME ) 
																									ELSE SPOT.RUN_DATE_TIME
																								END

				FROM			#DayDateSubset x
				JOIN			dbo.FactAssetSummary f1 WITH (NOLOCK)						ON x.FactAssetSummaryID = f1.FactAssetSummaryID
																							AND x.UTCSPOTDayOfYearPartitionKey = f1.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimSpot SPOT WITH (NOLOCK)								ON f1.DimSpotID = SPOT.DimSpotID
																							AND x.UTCSPOTDayOfYearPartitionKey = SPOT.UTCSPOTDayOfYearPartitionKey


				DROP TABLE		#DayDateSubset



END


GO


