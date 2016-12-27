
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveChannelStatus'), 0) > 0 
	DROP PROCEDURE dbo.SaveChannelStatus
GO

CREATE PROCEDURE [dbo].[SaveChannelStatus]
		@RegionID			INT,
		@SDBSourceID		INT,
		@SDBUTCOffset		INT,
		@ErrorID			INT OUTPUT
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
// Module:  dbo.SaveChannelStatus
// Created: 2013-Nov-25
// Author:  Tony Lew
// 
// Purpose: 		Upsert the ChannelStatus table for the channels 
//					for a given region and SDB within the context of the executing job
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveChannelStatus.proc.sql 4647 2014-07-24 21:41:30Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveChannelStatus 
//								@RegionID			= 0,
//								@SDBSourceID		= 1,
//								@SDBUTCOffset		= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE			@Today DATE
		DECLARE			@NextDay DATE
		DECLARE			@NowSDBTime DATETIME

		DECLARE			@MTE_Conflicts_Window1 DATETIME
		DECLARE			@MTE_Conflicts_Window2 DATETIME
		DECLARE			@MTE_Conflicts_Window3 DATETIME
		
		SELECT			@NowSDBTime		= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )

		SELECT			@Today = CONVERT( DATE, @NowSDBTime ), @NextDay = CONVERT( DATE, DATEADD(DAY, 1, @NowSDBTime) )
		SET				@ErrorID = 1

		SELECT			@MTE_Conflicts_Window1					= DATEADD( HOUR, 4, @NowSDBTime),
						@MTE_Conflicts_Window2					= DATEADD( HOUR, 6, @NowSDBTime),
						@MTE_Conflicts_Window3					= DATEADD( HOUR, 8, @NowSDBTime)



		IF		ISNULL(OBJECT_ID('tempdb..#ChannelStatistics'), 0) > 0 
				DROP TABLE		#ChannelStatistics

				CREATE TABLE	#ChannelStatistics 
						(
							ID INT Identity(1,1),
							RUN_DATE DATE,
							IU_ID INT,
							ZONE_ID INT,
							ZONE_NAME VARCHAR(32),
							SDBSourceID INT,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday FLOAT,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay FLOAT,
							/* TOTAL DTM Insertions*/
							DTM_Total FLOAT,
							/* DTM Successfuly Insertions */
							DTM_Played FLOAT,
							/* DTM Failed Insertions */
							DTM_Failed FLOAT,
							/* DTM NoTone's */
							DTM_NoTone FLOAT,
							/* DTM mpeg errors */
							DTM_MpegError FLOAT,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy FLOAT,

							/* MTE Conflicts for Today */
							MTE_Conflicts FLOAT,
							/* MTE Conflicts for Window 1 */
							MTE_Conflicts_Window1 FLOAT,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window2 FLOAT,
							/* MTE Conflicts for Window 3 */
							MTE_Conflicts_Window3 FLOAT,

							/* MTE Conflicts for next day */
							MTE_ConflictsNextDay FLOAT,

							/* IC Provider Breakdown */
							ICTotal FLOAT,
							ICTotalNextDay FLOAT,
							DTM_ICTotal FLOAT,
							DTM_ICPlayed FLOAT,
							DTM_ICFailed FLOAT,
							DTM_ICNoTone FLOAT,
							DTM_ICMpegError FLOAT,
							DTM_ICMissingCopy FLOAT,

							MTE_ICConflicts FLOAT,
							MTE_ICConflicts_Window1 FLOAT,
							MTE_ICConflicts_Window2 FLOAT,
							MTE_ICConflicts_Window3 FLOAT,
							MTE_ICConflictsNextDay FLOAT,

							IC_LastSchedule_Load  [datetime],
							IC_NextDay_LastSchedule_Load [datetime],

							/* AT&T Breakdown */
							ATTTotal FLOAT,
							ATTTotalNextDay FLOAT,
							DTM_ATTTotal FLOAT,
							DTM_ATTPlayed FLOAT,
							DTM_ATTFailed FLOAT,
							DTM_ATTNoTone FLOAT,
							DTM_ATTMpegError FLOAT,
							DTM_ATTMissingCopy FLOAT,

							MTE_ATTConflicts FLOAT,
							MTE_ATTConflicts_Window1 FLOAT,
							MTE_ATTConflicts_Window2 FLOAT,
							MTE_ATTConflicts_Window3 FLOAT,
							MTE_ATTConflictsNextDay FLOAT,

							ATT_LastSchedule_Load [datetime],
							ATT_NextDay_LastSchedule_Load [datetime]
						)


		IF		ISNULL(OBJECT_ID('tempdb..#ChannelStatus'), 0) > 0 
				DROP TABLE		#ChannelStatus

				CREATE TABLE	#ChannelStatus 
						(
							ID INT Identity(1,1),
							ChannelStatusID INT,
							ChannelStats_ID INT,
							IU_ID INT,
							RegionID INT,
							RUN_DATE DATE,
							ZONE_MAP_ID INT,
							RegionalizedZoneID INT,
							ZoneID INT,
							ZONE_NAME VARCHAR(32),
							SDBSourceID INT,
							TSI VARCHAR(32),
							ICProvider VARCHAR(32),
							/* Calculated columns */
							DTM_Failed_Rate FLOAT,
							DTM_Run_Rate FLOAT,
							Forecast_Best_Run_Rate FLOAT,
							Forecast_Worst_Run_Rate FLOAT,
							NextDay_Forecast_Run_Rate FLOAT,
							DTM_NoTone_Rate FLOAT,
							DTM_NoTone_Count FLOAT,
							Consecutive_NoTone_Count FLOAT,
							Consecutive_Error_Count FLOAT,
							BreakCount INT,
							NextDay_BreakCount INT,
							Average_BreakCount INT,

							ATT_DTM_Failed_Rate	FLOAT,
							ATT_DTM_Run_Rate FLOAT,
							ATT_Forecast_Best_Run_Rate	FLOAT,
							ATT_Forecast_Worst_Run_Rate	FLOAT,
							ATT_NextDay_Forecast_Run_Rate FLOAT,
							ATT_DTM_NoTone_Rate	FLOAT,
							ATT_DTM_NoTone_Count FLOAT,
							ATT_BreakCount INT NULL,
							ATT_NextDay_BreakCount INT NULL,
							ATT_LastSchedule_Load [datetime] NULL,
							ATT_NextDay_LastSchedule_Load [datetime] NULL,

							IC_DTM_Failed_Rate	FLOAT,
							IC_DTM_Run_Rate	FLOAT,
							IC_Forecast_Best_Run_Rate	FLOAT,
							IC_Forecast_Worst_Run_Rate	FLOAT,
							IC_NextDay_Forecast_Run_Rate	FLOAT,
							IC_DTM_NoTone_Rate	FLOAT,
							IC_DTM_NoTone_Count	FLOAT,
							IC_BreakCount INT NULL,
							IC_NextDay_BreakCount INT NULL,
							IC_LastSchedule_Load  [datetime] NULL,
							IC_NextDay_LastSchedule_Load [datetime] NULL

						)


		INSERT		#ChannelStatistics 
						(
							RUN_DATE,
							IU_ID,
							ZONE_ID,
							ZONE_NAME,
							SDBSourceID,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay,
							/* TOTAL DTM Insertions*/
							DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy,

							/* MTE Confilcts for Today */
							MTE_Conflicts,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window1,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window2,
							/* MTE Conflicts for Window 3 */
							MTE_Conflicts_Window3,
							/* MTE Conflicts for next day */
							MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal,
							ICTotalNextDay,
							DTM_ICTotal,
							DTM_ICPlayed,
							DTM_ICFailed,
							DTM_ICNoTone,
							DTM_ICMpegError,
							DTM_ICMissingCopy,

							MTE_ICConflicts,
							MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3,
							MTE_ICConflictsNextDay,

							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load,

							/* AT&T Breakdown */
							ATTTotal,
							ATTTotalNextDay,
							DTM_ATTTotal,
							DTM_ATTPlayed,
							DTM_ATTFailed,
							DTM_ATTNoTone,
							DTM_ATTMpegError,
							DTM_ATTMissingCopy,

							MTE_ATTConflicts,
							MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3,
							MTE_ATTConflictsNextDay,

							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load
						)
		SELECT
							RUN_DATE							= @Today,
							IU.IU_ID,
							IU.ZONE,
							IU.ZONE_NAME,
							SDBSourceID							= @SDBSourceID,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday				= SUM(IESPOT.CNT),
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay				= SUM(IESPOTNextDay.CNT),
							/* TOTAL DTM Insertions*/
							DTM_Total							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) THEN IESPOT.CNT ELSE 0 END),
							/* DTM Successfuly Insertions */
							DTM_Played							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							/* DTM Failed Insertions */
							DTM_Failed							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							/* DTM NoTone's */
							DTM_NoTone							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							/* DTM mpeg errors */
							DTM_MpegError						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),

							/* MTE Conflicts for Today */
							MTE_Conflicts						= SUM( ISNULL(IESPOT.MTE_Conflicts_Total,0) ),
							MTE_Conflicts_Window1				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window1,0) ),
							MTE_Conflicts_Window2				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window2,0) ),
							MTE_Conflicts_Window3				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window3,0) ),
							/* MTE Conflicts for Next day */
							MTE_ConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_Conflicts_Total,0) ),

							/* IC Provider Breakdown */
							ICTotal								= SUM(CASE WHEN IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.CNT ELSE 0 END),
							ICTotalNextDay						= SUM(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 2 THEN IESPOTNextDay.CNT ELSE 0 END),
							DTM_ICTotal							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICPlayed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICFailed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							DTM_ICNoTone						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICMpegError						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							DTM_ICMissingCopy					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),
							MTE_ICConflicts						= SUM( ISNULL(IESPOT.MTE_ICConflicts_Total,0) ),
							MTE_ICConflicts_Window1				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window1,0) ),
							MTE_ICConflicts_Window2				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window2,0) ),
							MTE_ICConflicts_Window3				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window3,0) ),
							MTE_ICConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_ICConflicts_Total,0) ),
							IC_LastSchedule_Load				= MAX(CASE WHEN IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.LastSchedule_Load END),
							IC_NextDay_LastSchedule_Load		= MAX(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 2 THEN IESPOTNextDay.LastSchedule_Load END),

							/* AT&T Breakdown */
							ATTTotal							= SUM(CASE WHEN IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.CNT ELSE 0 END),
							ATTTotalNextDay						= SUM(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 1 THEN IESPOTNextDay.CNT ELSE 0 END),
							DTM_ATTTotal						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTPlayed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTFailed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTNoTone						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTMpegError					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTMissingCopy					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),
							MTE_ATTConflicts					= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Total,0) ),
							MTE_ATTConflicts_Window1			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window1,0) ),
							MTE_ATTConflicts_Window2			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window2,0) ),
							MTE_ATTConflicts_Window3			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window3,0) ),
							MTE_ATTConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_ATTConflicts_Total,0) ),

							ATT_LastSchedule_Load				= MAX(CASE WHEN IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.LastSchedule_Load END),
							ATT_NextDay_LastSchedule_Load		= MAX(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 1 THEN IESPOTNextDay.LastSchedule_Load END)

		FROM 
						(
							SELECT 
											a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS,
											LastSchedule_Load				= MAX(b.FILE_DATETIME),

											MTE_Conflicts_Total				= SUM(	CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) THEN 1 ELSE 0 END ),
											MTE_Conflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--IC conflict windows
											MTE_ICConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--ATT conflict windows
											MTE_ATTConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window1		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window2		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window3		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),


											COUNT(1) AS CNT
							FROM			#ImportIE_SPOT a
							LEFT JOIN		(
												SELECT		MAX(itb.FILE_DATETIME) AS FILE_DATETIME,
															IU_ID,
															SOURCE_ID,
															SCHED_DATE
												FROM		#ImportTB_REQUEST AS itb
												WHERE		itb.SCHED_DATE = @Today
												GROUP BY	IU_ID,
															SOURCE_ID,
															SCHED_DATE
											) AS b
							ON    			a.IU_ID							= b.IU_ID 
							AND				a.IE_SOURCE_ID					= b.SOURCE_ID
							WHERE			a.SCHED_DATE					= @Today
							AND				a.SCHED_DATE					= ISNULL(b.SCHED_DATE, a.SCHED_DATE)
							GROUP BY		a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS
						)	AS IESPOT
		FULL JOIN
						(
							SELECT 
											a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS,
											LastSchedule_Load				= MAX(b.FILE_DATETIME),


											MTE_Conflicts_Total				= SUM(	CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) THEN 1 ELSE 0 END ),
											MTE_Conflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--IC conflict windows
											MTE_ICConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--ATT conflict windows
											MTE_ATTConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window1		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window2		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window3		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),


											COUNT(1) AS CNT
							FROM			#ImportIE_SPOT a
							LEFT JOIN		(
												SELECT		MAX(itb.FILE_DATETIME) AS FILE_DATETIME,
															IU_ID,
															SOURCE_ID,
															SCHED_DATE
												FROM		#ImportTB_REQUEST AS itb
												WHERE		itb.SCHED_DATE = @NextDay
												GROUP BY	IU_ID,
															SOURCE_ID,
															SCHED_DATE
											) AS b
							ON				a.IU_ID							= b.IU_ID  
							AND				a.IE_SOURCE_ID					= b.SOURCE_ID
							WHERE			a.SCHED_DATE					= @NextDay
							AND				a.SCHED_DATE					= ISNULL(b.SCHED_DATE, a.SCHED_DATE)
							GROUP BY		a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS
						)  AS IESPOTNextDay
		ON				IESPOT.IU_ID															= IESPOTNextDay.IU_ID
		AND				IESPOT.IE_SOURCE_ID 													= IESPOTNextDay.IE_SOURCE_ID
		AND				IESPOT.IE_NSTATUS 														= IESPOTNextDay.IE_NSTATUS
		AND				IESPOT.IE_CONFLICT_STATUS 												= IESPOTNextDay.IE_CONFLICT_STATUS
		AND				IESPOT.SPOT_NSTATUS 													= IESPOTNextDay.SPOT_NSTATUS
		AND				IESPOT.SPOT_CONFLICT_STATUS 											= IESPOTNextDay.SPOT_CONFLICT_STATUS
		JOIN			dbo.REGIONALIZED_IU  IU (NOLOCK)
		ON				IESPOT.IU_ID															= IU.IU_ID
		OR				IESPOTNextDay.IU_ID														= IU.IU_ID
		WHERE			IU.RegionID																= @RegionID
		GROUP BY		IU.IU_ID,
						IU.CHANNEL,
						IU.CHAN_NAME,
						IU.ZONE_NAME,
						IU.ZONE
		ORDER BY		IU.CHANNEL,
						IU.CHAN_NAME,
						IU.ZONE_NAME,
						IU.ZONE,
						IU.IU_ID



		INSERT			#ChannelStatus 
						(
							ChannelStatusID,
							ChannelStats_ID,
							IU_ID,
							RegionID,
							RUN_DATE,
							ZONE_MAP_ID,
							RegionalizedZoneID,
							ZoneID,
							ZONE_NAME,
							SDBSourceID,

							DTM_Failed_Rate,
							DTM_Run_Rate,
							Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate,
							DTM_NoTone_Count,
							Consecutive_NoTone_Count,
							Consecutive_Error_Count,
							BreakCount,
							NextDay_BreakCount,
							Average_BreakCount,

							ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count,
							ATT_BreakCount,
							ATT_NextDay_BreakCount,
							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load,

							IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count,
							IC_BreakCount,
							IC_NextDay_BreakCount,
							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load

						)
		SELECT			
							cs.ChannelStatusID													AS ChannelStatusID,
							a.ID																AS ChannelStats_ID,
							a.IU_ID,
							@RegionID															AS RegionID,
							a.RUN_DATE,
							zm.ZONE_MAP_ID,
							z.REGIONALIZED_ZONE_ID												AS RegionalizedZoneID,
							a.ZONE_ID															AS ZoneID,
							a.ZONE_NAME															AS ZONE_NAME,
							a.SDBSourceID														AS SDBSourceID,

							CASE WHEN ISNULL(a.DTM_Total, 0) = 0 OR ISNULL((a.DTM_Total-a.DTM_NoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_Failed - a.DTM_NoTone) / a.DTM_Total) * 100.00
						   END                 AS DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_Total, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_Total-a.DTM_NoTone) = 0 THEN 100.00 
							 ELSE (a.DTM_Played / (a.DTM_Total-a.DTM_NoTone)) * 100.00
						   END                 AS DTM_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsToday, 0) = 0 THEN 100.00
								WHEN  (a.TotalInsertionsToday-a.DTM_NoTone) = 0 THEN 100.00
							 ELSE (( a.TotalInsertionsToday - a.DTM_Failed ) / (a.TotalInsertionsToday-a.DTM_NoTone)) * 100.00
						   END                 AS Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsToday, 0) = 0 THEN 100.00
								WHEN  (a.TotalInsertionsToday-a.DTM_NoTone) = 0 THEN 100.00 
							 ELSE (( a.TotalInsertionsToday - (a.DTM_Failed + a.MTE_Conflicts)) / (a.TotalInsertionsToday-a.DTM_NoTone)) * 100.00
						   END                 AS Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.TotalInsertionsNextDay - a.MTE_ConflictsNextDay ) / a.TotalInsertionsNextDay) * 100.00
						   END                 AS NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_Total, 0) = 0 THEN 0.00 
							 ELSE (a.DTM_NoTone / a.DTM_Total) * 100.00
						   END                 AS DTM_NoTone_Rate,
							a.DTM_NoTone														AS DTM_NoTone_Count,
							ISNULL(b.ConsecutiveNoTones, 0)										AS Consecutive_NoTone_Count,
							ISNULL(ce.ConsecutiveErrors, 0)										AS Consecutive_Error_Count,
							ISNULL(d.BREAK_COUNT_Today, 0)										AS BreakCount,
							ISNULL(d.BREAK_COUNT_NextDay, 0)									AS NextDay_BreakCount,
							ISNULL(c.BreakCountAVG, 0)											AS Average_BreakCount,

							CASE WHEN ISNULL(a.DTM_ATTTotal, 0) = 0 OR ISNULL((a.DTM_ATTTotal-a.DTM_ATTNoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_ATTFailed - a.DTM_ATTNoTone) / a.DTM_ATTTotal) * 100.00
						   END                 AS ATT_DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_ATTTotal, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100 
							 ELSE (a.DTM_ATTPlayed / (a.DTM_ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_DTM_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotal, 0) = 0 THEN 100.00
								WHEN (a.ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100 
							 ELSE (( a.ATTTotal - a.DTM_ATTFailed ) / (a.ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotal, 0) = 0 THEN 100.00
								WHEN (a.ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100  
							 ELSE (( a.ATTTotal - (a.DTM_ATTFailed + a.MTE_ATTConflicts)) / (a.ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotalNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.ATTTotalNextDay - a.MTE_ATTConflictsNextDay ) / a.ATTTotalNextDay) * 100.00
						   END                 AS ATT_NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_ATTTotal , 0)= 0 THEN 0.00 
							 ELSE (a.DTM_ATTNoTone / a.DTM_ATTTotal) * 100.00
						   END                 AS ATT_DTM_NoTone_Rate,
	   
							a.DTM_ATTNoTone														AS ATT_DTM_NoTone_Count,
							ISNULL(d.ATT_BREAK_COUNT_Today, 0)									AS ATT_BreakCount,
							ISNULL(d.ATT_BREAK_COUNT_NextDay, 0)								AS ATT_NextDay_BreakCount,
							a.ATT_LastSchedule_Load,
							a.ATT_NextDay_LastSchedule_Load,


							CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 OR ISNULL((a.DTM_ICTotal-a.DTM_ICNoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_ICFailed - a.DTM_ICNoTone) / a.DTM_ICTotal) * 100.00
						   END                 AS IC_DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_ICTotal-a.DTM_ICNoTone) = 0 THEN 100.00 
							 ELSE (a.DTM_ICPlayed / (a.DTM_ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_DTM_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotal, 0) = 0 THEN 100.00 
								WHEN (a.ICTotal-a.DTM_ICNoTone) = 0 THEN 100 
							 ELSE (( a.ICTotal - a.DTM_ICFailed ) / (a.ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotal, 0) = 0 THEN 100.00 
								WHEN (a.ICTotal-a.DTM_ICNoTone) = 0 THEN 100 
							 ELSE (( a.ICTotal - (a.DTM_ICFailed + a.MTE_ICConflicts)) / (a.ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotalNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.ICTotalNextDay - a.MTE_ICConflictsNextDay ) / a.ICTotalNextDay) * 100.00
						   END                 AS IC_NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 THEN 0.00 
							 ELSE (a.DTM_ICNoTone / a.DTM_ICTotal) * 100.00
						   END                 AS IC_DTM_NoTone_Rate,
							
							a.DTM_ICNoTone														AS IC_DTM_NoTone_Count,
							ISNULL(d.IC_BREAK_COUNT_Today, 0)									AS IC_BreakCount,
							ISNULL(d.IC_BREAK_COUNT_NextDay, 0)									AS IC_NextDay_BreakCount,
							a.IC_LastSchedule_Load,
							a.IC_NextDay_LastSchedule_Load

		FROM			#ChannelStatistics a
		JOIN			( 
							SELECT		IU_ID, @RegionID AS REGION_ID 
							FROM		dbo.REGIONALIZED_IU (NOLOCK) 
							WHERE		REGIONID = @RegionID
						) IU
		ON				a.IU_ID																	= IU.IU_ID
		JOIN			dbo.ZONE_MAP zm (NOLOCK)
		ON				a.ZONE_NAME																= zm.ZONE_NAME
		JOIN			dbo.REGIONALIZED_ZONE z (NOLOCK)
		ON				a.ZONE_NAME																= z.ZONE_NAME
		AND				IU.REGION_ID															= z.REGION_ID
		LEFT JOIN		dbo.ChannelStatus cs 
		ON				a.SDBSourceID															= cs.SDBSourceID
		AND				a.IU_ID																	= cs.IU_ID
		AND				z.REGIONALIZED_ZONE_ID													= cs.RegionalizedZoneID
		LEFT JOIN		
					(
						SELECT		IE.IU_ID,
									COUNT(DISTINCT IE.IE_ID)						AS ConsecutiveNoTones
						FROM
								( 
									 SELECT
												IU_ID,
												COALESCE(MAX(CASE WHEN IE_CONFLICT_STATUS != 110 THEN [SCHED_DATE_TIME] END),'19700101')  AS LatestGood
									 FROM		#ImportIE_SPOT x
									 WHERE		x.SPOT_RUN_DATE_TIME IS NOT NULL
									 GROUP BY	x.IU_ID
								)	g
						JOIN		#ImportIE_SPOT IE 
						ON			IE.IU_ID										= g.IU_ID
						AND			SCHED_DATE_TIME									> g.LatestGood
						WHERE		IE.IE_CONFLICT_STATUS							= 110
						AND			IE.SPOT_RUN_DATE_TIME							IS NOT NULL
						GROUP BY	IE.IU_ID
					)	b
		ON				a.IU_ID														= b.IU_ID
		LEFT JOIN		
					(
						SELECT		IE.IU_ID,
									COUNT(1)										AS ConsecutiveErrors
						FROM
								( 
									SELECT
												IU_ID,
												COALESCE(MAX(
																CASE	WHEN	(x.SPOT_NSTATUS NOT IN (6, 7) OR (x.SPOT_NSTATUS = 6 AND x.SPOT_CONFLICT_STATUS = 14))
																		THEN	[SPOT_RUN_DATE_TIME] 
																		END
															)  
														,'19700101')				AS LatestNonError
									FROM		#ImportIE_SPOT x
									GROUP BY	x.IU_ID
								)	g
						 JOIN		#ImportIE_SPOT IE 
						 ON			IE.IU_ID 										= g.IU_ID
						 AND		SPOT_RUN_DATE_TIME								> g.LatestNonError
						 WHERE		IE.IE_NSTATUS 									IN (10,11,12,13,14,24)
						 AND		IE.SPOT_RUN_DATE_TIME							IS NOT NULL
						 GROUP BY	IE.IU_ID
					)	ce
		ON				a.IU_ID														= ce.IU_ID
		LEFT JOIN	
					(	--For the Break Count Average, we do NOT care about today and tomorrow, only historical
						SELECT		
									bc.IU_ID,
									AVG(bc.SUM_BREAK_COUNT)							AS BreakCountAVG
						FROM		(
										SELECT		x.IU_ID,
													SUM(x.BREAK_COUNT)				AS SUM_BREAK_COUNT
										FROM		#ImportIUBreakCount x
										WHERE		x.BREAK_DATE					< @Today
										GROUP BY	x.IU_ID, x.BREAK_DATE
									) bc
						GROUP BY	bc.IU_ID
					) c  
		ON				a.IU_ID														= c.IU_ID
		LEFT JOIN
					(
						SELECT		x.IU_ID, 
									SUM(ISNULL(x.BREAK_COUNT_Today, 0)) AS BREAK_COUNT_Today,
									SUM(ISNULL(x.BREAK_COUNT_NextDay, 0)) AS BREAK_COUNT_NextDay,
									SUM(ISNULL(x.ATT_BREAK_COUNT_Today, 0)) AS ATT_BREAK_COUNT_Today,
									SUM(ISNULL(x.ATT_BREAK_COUNT_Nextday, 0)) AS ATT_BREAK_COUNT_Nextday,
									SUM(ISNULL(x.IC_BREAK_COUNT_Today, 0)) AS IC_BREAK_COUNT_Today,
									SUM(ISNULL(x.IC_BREAK_COUNT_Nextday, 0)) AS IC_BREAK_COUNT_Nextday
						FROM		(
										SELECT 
													bc.BREAK_DATE								AS BREAK_DATE,
													bc.IU_ID,
													CASE	WHEN	bc.BREAK_DATE = @Today 
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS BREAK_COUNT_Today,
													CASE	WHEN	bc.BREAK_DATE = @NextDay 
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS BREAK_COUNT_NextDay,
													CASE	WHEN	bc.SOURCE_ID = 1 
															AND		bc.BREAK_DATE = @Today
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS ATT_BREAK_COUNT_Today,
													CASE 
															WHEN	bc.SOURCE_ID = 1 
															AND		bc.BREAK_DATE = @NextDay  
															THEN	SUM(bc.BREAK_COUNT)
													END												AS ATT_BREAK_COUNT_Nextday,
													CASE 
															WHEN	bc.SOURCE_ID = 2 
															AND		bc.BREAK_DATE = @Today
															THEN	SUM(bc.BREAK_COUNT)
													END												AS IC_BREAK_COUNT_Today,
													CASE 
															WHEN	bc.SOURCE_ID = 2 
															AND		bc.BREAK_DATE = @NextDay 
															THEN	SUM(bc.BREAK_COUNT)
													END												AS IC_BREAK_COUNT_Nextday
										FROM		#ImportIUBreakCount bc
										WHERE		bc.BREAK_DATE >= @Today 
										GROUP BY	bc.IU_ID, bc.BREAK_DATE, bc.SOURCE_ID 
									) x
						GROUP BY	x.IU_ID
					)	d
		ON				a.IU_ID														= d.IU_ID

		WHERE			IU.REGION_ID												= @RegionID


		UPDATE			dbo.ChannelStatus
		SET
							/* TOTAL Insertions for today*/
							TotalInsertionsToday									= b.TotalInsertionsToday,

							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay									= b.TotalInsertionsNextDay,

							/* TOTAL DTM Insertions*/	
							DTM_Total												= b.DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played												= b.DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed												= b.DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone												= b.DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError											= b.DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy											= b.DTM_MissingCopy,
							/* MTE Confilcts for Today */
							MTE_Conflicts											= b.MTE_Conflicts,
							MTE_Conflicts_Window1									= b.MTE_Conflicts_Window1,
							MTE_Conflicts_Window2									= b.MTE_Conflicts_Window2,
							MTE_Conflicts_Window3									= b.MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							ConflictsNextDay										= b.MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal													= b.ICTotal,
							ICTotalNextDay											= b.ICTotalNextDay,
							DTM_ICTotal												= b.DTM_ICTotal,
							DTM_ICPlayed											= b.DTM_ICPlayed,
							DTM_ICFailed											= b.DTM_ICFailed,
							DTM_ICNoTone											= b.DTM_ICNoTone,
							DTM_ICMpegError											= b.DTM_ICMpegError,
							DTM_ICMissingCopy										= b.DTM_ICMissingCopy,
							MTE_ICConflicts											= b.MTE_ICConflicts,
							MTE_ICConflicts_Window1									= b.MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2									= b.MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3									= b.MTE_ICConflicts_Window3,
							ICConflictsNextDay										= b.MTE_ICConflictsNextDay,

							/* AT&T Breakdown */
							ATTTotal												= b.ATTTotal,
							ATTTotalNextDay											= b.ATTTotalNextDay,
							DTM_ATTTotal											= b.DTM_ATTTotal,
							DTM_ATTPlayed											= b.DTM_ATTPlayed,
							DTM_ATTFailed											= b.DTM_ATTFailed,
							DTM_ATTNoTone											= b.DTM_ATTNoTone,
							DTM_ATTMpegError										= b.DTM_ATTMpegError,
							DTM_ATTMissingCopy										= b.DTM_ATTMissingCopy,
							MTE_ATTConflicts										= b.MTE_ATTConflicts,		
							MTE_ATTConflicts_Window1								= b.MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2								= b.MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3								= b.MTE_ATTConflicts_Window3,
							ATTConflictsNextDay										= b.MTE_ATTConflictsNextDay,		

							/* Calculated Columns */
							DTM_Failed_Rate											= a.DTM_Failed_Rate,
							DTM_Run_Rate											= a.DTM_Run_Rate,
							Forecast_Best_Run_Rate									= a.Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate									= a.Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate								= a.NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate											= a.DTM_NoTone_Rate,
							DTM_NoTone_Count										= a.DTM_NoTone_Count,
							Consecutive_NoTone_Count								= ISNULL(a.Consecutive_NoTone_Count, 0),
							Consecutive_Error_Count									= ISNULL(a.Consecutive_Error_Count, 0),
							BreakCount												= a.BreakCount,
							NextDay_BreakCount										= a.NextDay_BreakCount,
							Average_BreakCount										= a.Average_BreakCount,

							ATT_DTM_Failed_Rate										= a.ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate										= a.ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate								= a.ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate								= a.ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate							= a.ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate										= a.ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count									= a.ATT_DTM_NoTone_Count,
							ATT_BreakCount											= a.ATT_BreakCount,
							ATT_NextDay_BreakCount									= a.ATT_NextDay_BreakCount,
							ATT_LastSchedule_Load									= a.ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load							= a.ATT_NextDay_LastSchedule_Load,

							IC_DTM_Failed_Rate										= a.IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate											= a.IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate								= a.IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate								= a.IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate							= a.IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate										= a.IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count										= a.IC_DTM_NoTone_Count,
							IC_BreakCount											= a.IC_BreakCount,
							IC_NextDay_BreakCount									= a.IC_NextDay_BreakCount,
							IC_LastSchedule_Load									= a.IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load							= a.IC_NextDay_LastSchedule_Load,

							UpdateDate												= GETUTCDATE()
		FROM				#ChannelStatus a
		JOIN				#ChannelStatistics b
		ON					a.ChannelStats_ID										= b.ID
		WHERE				ChannelStatus.ChannelStatusID							= a.ChannelStatusID
		AND					ChannelStatus.SDBSourceID								= @SDBSourceID

		--				IF the Channel does NOT come through from the SDB table, then blank the values.
		UPDATE			dbo.ChannelStatus
		SET
							/* TOTAL Insertions for today*/
							TotalInsertionsToday									= 0,

							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay									= 0,

							/* TOTAL DTM Insertions*/	
							DTM_Total												= 0,
							/* DTM Successfuly Insertions */
							DTM_Played												= 0,
							/* DTM Failed Insertions */
							DTM_Failed												= 0,
							/* DTM NoTone's */
							DTM_NoTone												= 0,
							/* DTM mpeg errors */
							DTM_MpegError											= 0,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy											= 0,
							/* MTE Confilcts for Today */
							MTE_Conflicts											= 0,
							MTE_Conflicts_Window1									= 0,
							MTE_Conflicts_Window2									= 0,
							MTE_Conflicts_Window3									= 0,
							/* MTE Confilcts for next day */
							ConflictsNextDay										= 0,

							/* IC Provider Breakdown */
							ICTotal													= 0,
							ICTotalNextDay											= 0,
							DTM_ICTotal												= 0,
							DTM_ICPlayed											= 0,
							DTM_ICFailed											= 0,
							DTM_ICNoTone											= 0,
							DTM_ICMpegError											= 0,
							DTM_ICMissingCopy										= 0,
							MTE_ICConflicts											= 0,
							MTE_ICConflicts_Window1									= 0,
							MTE_ICConflicts_Window2									= 0,
							MTE_ICConflicts_Window3									= 0,
							ICConflictsNextDay										= 0,

							/* AT&T Breakdown */
							ATTTotal												= 0,
							ATTTotalNextDay											= 0,
							DTM_ATTTotal											= 0,
							DTM_ATTPlayed											= 0,
							DTM_ATTFailed											= 0,
							DTM_ATTNoTone											= 0,
							DTM_ATTMpegError										= 0,
							DTM_ATTMissingCopy										= 0,
							MTE_ATTConflicts										= 0,		
							MTE_ATTConflicts_Window1								= 0,
							MTE_ATTConflicts_Window2								= 0,
							MTE_ATTConflicts_Window3								= 0,
							ATTConflictsNextDay										= 0,		

							/* Calculated Columns */
							DTM_Failed_Rate											= 0,
							DTM_Run_Rate											= 0,
							Forecast_Best_Run_Rate									= 0,
							Forecast_Worst_Run_Rate									= 0,
							NextDay_Forecast_Run_Rate								= 0,
							DTM_NoTone_Rate											= 0,
							DTM_NoTone_Count										= 0,
							Consecutive_NoTone_Count								= 0,
							Consecutive_Error_Count									= 0,
							BreakCount												= 0,
							NextDay_BreakCount										= 0,
							Average_BreakCount										= 0,

							ATT_DTM_Failed_Rate										= 0,
							ATT_DTM_Run_Rate										= 0,
							ATT_Forecast_Best_Run_Rate								= 0,
							ATT_Forecast_Worst_Run_Rate								= 0,
							ATT_NextDay_Forecast_Run_Rate							= 0,
							ATT_DTM_NoTone_Rate										= 0,
							ATT_DTM_NoTone_Count									= 0,
							ATT_BreakCount											= 0,
							ATT_NextDay_BreakCount									= 0,
							ATT_LastSchedule_Load									= NULL,
							ATT_NextDay_LastSchedule_Load							= NULL,

							IC_DTM_Failed_Rate										= 0,
							IC_DTM_Run_Rate											= 0,
							IC_Forecast_Best_Run_Rate								= 0,
							IC_Forecast_Worst_Run_Rate								= 0,
							IC_NextDay_Forecast_Run_Rate							= 0,
							IC_DTM_NoTone_Rate										= 0,
							IC_DTM_NoTone_Count										= 0,
							IC_BreakCount											= 0,
							IC_NextDay_BreakCount									= 0,
							IC_LastSchedule_Load									= NULL,
							IC_NextDay_LastSchedule_Load							= NULL,

							UpdateDate												= GETUTCDATE()
		FROM				(
								SELECT		a.ChannelStatusID, a.IU_ID, a.SDBSourceID, a.RegionalizedZoneID 
								FROM		dbo.ChannelStatus a (NOLOCK)
								LEFT JOIN	#ChannelStatus b 
								ON			a.IU_ID									= b.IU_ID
								AND			a.SDBSourceID							= b.SDBSourceID
								AND			a.RegionalizedZoneID					= b.RegionalizedZoneID
								WHERE		b.ID									IS NULL
							) x
		WHERE				ChannelStatus.ChannelStatusID							= x.ChannelStatusID
		AND					ChannelStatus.SDBSourceID								= @SDBSourceID



		INSERT			dbo.ChannelStatus
						(
							IU_ID,
							RegionalizedZoneID,
							SDBSourceID,

							/* TOTAL Insertions for today*/
							TotalInsertionsToday,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay,

							/* TOTAL DTM Insertions*/
							DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy,
							/* MTE Confilcts for Today */
							MTE_Conflicts,
							MTE_Conflicts_Window1,
							MTE_Conflicts_Window2,
							MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal,
							ICTotalNextDay,
							DTM_ICTotal,
							DTM_ICPlayed,
							DTM_ICFailed,
							DTM_ICNoTone,
							DTM_ICMpegError,
							DTM_ICMissingCopy,

							MTE_ICConflicts,
							MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3,
							ICConflictsNextDay,

							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load,

							/* AT&T Breakdown */
							ATTTotal,
							ATTTotalNextDay,
							DTM_ATTTotal,
							DTM_ATTPlayed,
							DTM_ATTFailed,
							DTM_ATTNoTone,
							DTM_ATTMpegError,
							DTM_ATTMissingCopy,

							MTE_ATTConflicts,
							MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3,
							ATTConflictsNextDay,

							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load,

							/* Calculated Columns */
							DTM_Failed_Rate,
							DTM_Run_Rate,
							Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate,
							DTM_NoTone_Count,
							Consecutive_NoTone_Count,
							Consecutive_Error_Count,
							BreakCount,
							NextDay_BreakCount,
							Average_BreakCount,
							ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count,
							ATT_BreakCount,
							ATT_NextDay_BreakCount,

							IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count,
							IC_BreakCount,
							IC_NextDay_BreakCount,

							Enabled,
							CreateDate
						)
		SELECT			
							a.IU_ID,
							a.RegionalizedZoneID									AS RegionalizedZoneID,
							--a.ZONE_NAME												AS ZoneName,
							a.SDBSourceID											AS SDBSourceID,

							/* TOTAL Insertions for today*/
							b.TotalInsertionsToday,

							/* TOTAL Insertions for next day*/
							b.TotalInsertionsNextDay,


							/* TOTAL DTM Insertions*/
							b.DTM_Total,
							/* DTM Successfuly Insertions */
							b.DTM_Played,
							/* DTM Failed Insertions */
							b.DTM_Failed,
							/* DTM NoTone's */
							b.DTM_NoTone,
							/* DTM mpeg errors */
							b.DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							b.DTM_MissingCopy,
							/* MTE Confilcts for Today */
							b.MTE_Conflicts,
							b.MTE_Conflicts_Window1,
							b.MTE_Conflicts_Window2,
							b.MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							b.MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							b.ICTotal,
							b.ICTotalNextDay,
							b.DTM_ICTotal,
							b.DTM_ICPlayed,
							b.DTM_ICFailed,
							b.DTM_ICNoTone,
							b.DTM_ICMpegError,
							b.DTM_ICMissingCopy,
							b.MTE_ICConflicts,
							b.MTE_ICConflicts_Window1,
							b.MTE_ICConflicts_Window2,
							b.MTE_ICConflicts_Window3,
							b.MTE_ICConflictsNextDay,
							a.IC_LastSchedule_Load,
							a.IC_NextDay_LastSchedule_Load,


							/* AT&T Breakdown */
							b.ATTTotal,
							b.ATTTotalNextDay,
							b.DTM_ATTTotal,
							b.DTM_ATTPlayed,
							b.DTM_ATTFailed,
							b.DTM_ATTNoTone,
							b.DTM_ATTMpegError,
							b.DTM_ATTMissingCopy,
							b.MTE_ATTConflicts,
							b.MTE_ATTConflicts_Window1,
							b.MTE_ATTConflicts_Window2,
							b.MTE_ATTConflicts_Window3,
							b.MTE_ATTConflictsNextDay,
							a.ATT_LastSchedule_Load,
							a.ATT_NextDay_LastSchedule_Load,
							
							/* Calculated Columns */
							a.DTM_Failed_Rate,
							a.DTM_Run_Rate,
							a.Forecast_Best_Run_Rate,
							a.Forecast_Worst_Run_Rate,
							a.NextDay_Forecast_Run_Rate,
							a.DTM_NoTone_Rate,
							a.DTM_NoTone_Count,
							ISNULL(a.Consecutive_NoTone_Count,0)					AS Consecutive_NoTone_Count,
							ISNULL(a.Consecutive_Error_Count,0)						AS Consecutive_Error_Count,
							a.BreakCount,
							a.NextDay_BreakCount,
							a.Average_BreakCount,
							a.ATT_DTM_Failed_Rate,
							a.ATT_DTM_Run_Rate,
							a.ATT_Forecast_Best_Run_Rate,
							a.ATT_Forecast_Worst_Run_Rate,
							a.ATT_NextDay_Forecast_Run_Rate,
							a.ATT_DTM_NoTone_Rate,
							a.ATT_DTM_NoTone_Count,
							a.ATT_BreakCount,
							a.ATT_NextDay_BreakCount,

							a.IC_DTM_Failed_Rate,
							a.IC_DTM_Run_Rate,
							a.IC_Forecast_Best_Run_Rate,
							a.IC_Forecast_Worst_Run_Rate,
							a.IC_NextDay_Forecast_Run_Rate,
							a.IC_DTM_NoTone_Rate,
							a.IC_DTM_NoTone_Count,
							a.IC_BreakCount,
							a.IC_NextDay_BreakCount,

							1														AS Enabled,
							GETUTCDATE()											AS CreateDate
		FROM			#ChannelStatus a
		JOIN			#ChannelStatistics b
		ON				a.ChannelStats_ID											= b.ID
		LEFT JOIN		dbo.ChannelStatus c 
		ON				a.ChannelStatusID											= c.ChannelStatusID
		AND				a.SDBSourceID												= c.SDBSourceID
		--ON				a.RegionalizedZoneID										= c.RegionalizedZoneID
		--AND				a.IU_ID														= c.IU_ID
		WHERE			c.ChannelStatusID											IS NULL

		DROP TABLE		#ChannelStatistics
		DROP TABLE		#ChannelStatus
		SET				@ErrorID = 0		--SUCCESS


END




GO

