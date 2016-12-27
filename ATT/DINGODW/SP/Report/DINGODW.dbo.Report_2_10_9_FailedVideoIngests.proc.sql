

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_9_FailedVideoIngests'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_9_FailedVideoIngests
GO

CREATE PROCEDURE dbo.Report_2_10_9_FailedVideoIngests 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@FileName					VARCHAR(100)	= NULL,
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
// Module:  dbo.Report_2_10_9_FailedVideoIngests
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate FutureReadiness report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_9_FailedVideoIngests.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_9_FailedVideoIngests	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= 1,
//									@SortOrder					= NULL,
//									@FileName					= NULL,
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
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimSPOTID BIGINT, UTCSPOTDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimSPOTID, UTCSPOTDayOfYearPartitionKey )
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
								WHERE			s.UTCIEDatetime								BETWEEN @StartDateTime AND @EndDateTime
								GROUP BY		x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
				ELSE
								INSERT			#DayDateSubset ( DimSPOTID, UTCSPOTDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.IEDateTime								BETWEEN @StartDateTime AND @EndDateTime
								GROUP BY		x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey


				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								Reason,
								FileName,
								ScheduledDateTime
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName, 
								Reason	 													= 'Reason'+ISNULL(s.VIDEO_ID,''),
								FileName													= 'FileName'+ISNULL(s.VIDEO_ID,''),
								ScheduledDateTime											= CASE	WHEN @UseUTC = 1 THEN s.UTCIEDatetime
																									ELSE s.IEDatetime
																								END
				FROM			#DayDateSubset x
				JOIN			dbo.DimSPOT s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.UTCSPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				--JOIN			dbo.DimIE ie WITH (NOLOCK)									ON x.DimIEID = ie.DimIEID
				--																			AND x.IEDayOfYearPartitionKey = ie.UTCIEDayOfYearPartitionKey
				--JOIN			dbo.DimSpotStatus ss WITH (NOLOCK)							ON x.DimSpotStatusID = ss.DimSpotStatusID
				--JOIN			dbo.DimSpotConflictStatus scs WITH (NOLOCK)					ON x.DimSpotConflictStatusID = scs.DimSpotConflictStatusID
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.NSTATUS													= 14
				AND				s.CONFLICT_STATUS											IN (107)
				AND				s.VIDEO_ID													= ISNULL(@FileName, s.VIDEO_ID)


				DROP TABLE		#DayDateSubset



END


GO


