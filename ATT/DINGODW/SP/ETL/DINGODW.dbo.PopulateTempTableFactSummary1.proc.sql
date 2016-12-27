



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.PopulateTempTableFactSummary1'), 0) > 0 
	DROP PROCEDURE dbo.PopulateTempTableFactSummary1
GO

CREATE PROCEDURE dbo.PopulateTempTableFactSummary1 
							@StartingDate		DATE,
							@EndingDate			DATE
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
// Module:  dbo.PopulateTempTableFactSummary1
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.TempTableFactSummary1 table which is a physical temp table.
//					It is denoted with 1 in order to accomodate a future parallel fact table population.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateTempTableFactSummary1.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateTempTableFactSummary1	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03'
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), TempTableFactSummary1ID int, DayOfYearPartitionKey int, DayDate date )

							TRUNCATE TABLE		dbo.TempTableFactSummary1
							INSERT				dbo.TempTableFactSummary1
											(
												UTCSPOTDayOfYearPartitionKey,
												UTCSPOTDayDate,
												SPOTDayOfYearPartitionKey,
												SPOTDayDate,
												UTCIEDayOfYearPartitionKey,
												UTCIEDayDate,
												IEDayOfYearPartitionKey,
												IEDayDate,
												DimSDBSourceID,
												UTCOffset,
												DimSpotID,
												DimSpotStatusID,
												DimSpotConflictStatusID,
												DimIEID,
												DimIEStatusID,
												DimIEConflictStatusID,
												DimIUID,
												DimTB_REQUESTID,
												AssetID,
												RegionID,
												RegionName,
												ChannelName,
												MarketID,
												MarketName,
												ZoneName,
												NetworkID,
												NetworkName,
												ICProviderID,
												ICProviderName,
												ROCID,
												ROCName,
												SourceID,
												ScheduleDate,
												OTHERTotal,
												DTM_OTHERTotal,
												DTM_OTHERPlayed,
												DTM_OTHERFailed,
												DTM_OTHERNoTone,
												DTM_OTHERMpegError,
												DTM_OTHERMissingCopy,
												OTHERScheduleLoaded,
												OTHERScheduleBreakCount,
												OTHERMissingMedia,
												OTHERMediaPrefixErrors,
												OTHERMediaDurationErrors,
												OTHERMediaFormatErrors,
												ICTotal,
												DTM_ICTotal,
												DTM_ICPlayed,
												DTM_ICFailed,
												DTM_ICNoTone,
												DTM_ICMpegError,
												DTM_ICMissingCopy,
												ICScheduleLoaded,
												ICScheduleBreakCount,
												ICMissingMedia,
												ICMediaPrefixErrors,
												ICMediaDurationErrors,
												ICMediaFormatErrors,
												ATTTotal,
												DTM_ATTTotal,
												DTM_ATTPlayed,
												DTM_ATTFailed,
												DTM_ATTNoTone,
												DTM_ATTMpegError,
												DTM_ATTMissingCopy,
												ATTScheduleLoaded,
												ATTScheduleBreakCount,
												ATTMissingMedia,
												ATTMediaPrefixErrors,
												ATTMediaDurationErrors,
												ATTMediaFormatErrors,
												CreateDate
											)
							OUTPUT				INSERTED.TempTableFactSummary1ID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDayDate
							INTO				@InsertedRows
							SELECT				
												UTCSPOTDayOfYearPartitionKey									= spot.UTCSPOTDayOfYearPartitionKey				, 
												UTCSPOTDate														= spot.UTCSPOTDate								, 
												SPOTDayOfYearPartitionKey										= spot.SPOTDayOfYearPartitionKey				, 
												SPOTDayDate														= spot.SPOTDate									, 
												UTCIEDayOfYearPartitionKey										= spot.UTCIEDayOfYearPartitionKey				, 
												UTCIEDate														= spot.UTCIEDate								, 
												IEDayOfYearPartitionKey											= spot.IEDayOfYearPartitionKey					, 
												IEDayDate														= spot.IEDate									, 
												DimSDBSourceID													= x.DimSDBSourceID								,
												UTCOffset														= spot.UTCOffset								,
												DimSpotID														= spot.DimSpotID								,
												DimSpotStatusID													= spot.DimSpotStatusID							,
												DimSpotConflictStatusID											= spot.DimSpotConflictStatusID					,
												DimIEID															= ie.DimIEID									,
												DimIEStatusID													= ie.DimIEStatusID								,
												DimIEConflictStatusID											= ie.DimIEConflictStatusID						,
												DimIUID															= iu.DimIUID									,
												DimTB_REQUESTID													= tb.DimTB_REQUESTID							,
												AssetID															= spot.VIDEO_ID									,
												RegionID														= spot.RegionID									,
												RegionName														= spot.RegionName								,
												ChannelName														= spot.ChannelName								,
												MarketID														= spot.MarketID									,
												MarketName														= spot.MarketName								,
												ZoneName														= spot.ZoneName									,
												NetworkID														= spot.NetworkID								,
												NetworkName														= spot.NetworkName								,
												ICProviderID													= spot.ICProviderID								,
												ICProviderName													= spot.ICProviderName							,
												ROCID															= spot.ROCID									,
												ROCName															= spot.ROCName									,
												SourceID														= ie.SOURCE_ID									,
												ScheduleDate													= spot.UTCSPOTDate								,

												/* OTHER Provider Breakdown */
												OTHERTotal														= CASE WHEN ie.SOURCE_ID NOT IN (1,2) THEN 1 ELSE 0 END,
												DTM_OTHERTotal													= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) THEN 1 ELSE 0 END,
												DTM_OTHERPlayed													= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 5 THEN 1 ELSE 0 END,
												DTM_OTHERFailed													= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) THEN 1 ELSE 0 END,
												DTM_OTHERNoTone													= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS = 14 THEN 1 ELSE 0 END,
												DTM_OTHERMpegError												= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS IN (2, 4, 115, 128) THEN 1 ELSE 0 END,
												DTM_OTHERMissingCopy											= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 ELSE 0 END,
												OTHERScheduleLoaded												= tb.UTCTB_FILE_DATE_TIME,
												OTHERScheduleBreakCount											= 0,
												OTHERMissingMedia												= CASE WHEN ie.SOURCE_ID NOT IN (1,2) 
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												OTHERMediaPrefixErrors											= CASE WHEN ie.SOURCE_ID NOT IN (1,2) 
																															AND ie.NSTATUS IN (10,11,12,13,14,24)
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												OTHERMediaDurationErrors										= CASE WHEN ie.SOURCE_ID NOT IN (1,2)  
																															AND ie.NSTATUS IN (10,11,12,13,14,24)
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												OTHERMediaFormatErrors											= CASE WHEN ie.SOURCE_ID NOT IN (1,2) 
																															AND ie.NSTATUS IN (10,11,12,13,14,24)
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,



												/* IC Provider Breakdown */
												ICTotal															= CASE WHEN ie.SOURCE_ID = 2 THEN 1 ELSE 0 END,
												DTM_ICTotal														= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) THEN 1 ELSE 0 END,
												DTM_ICPlayed													= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 5 THEN 1 ELSE 0 END,
												DTM_ICFailed													= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) THEN 1 ELSE 0 END,
												DTM_ICNoTone													= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS = 14 THEN 1 ELSE 0 END,
												DTM_ICMpegError													= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS IN (2, 4, 115, 128) THEN 1 ELSE 0 END,
												DTM_ICMissingCopy												= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 ELSE 0 END,

												ICScheduleLoaded												= CASE WHEN ie.SOURCE_ID = 2 THEN tb.UTCTB_FILE_DATE_TIME ELSE '1970-01-01' END,
												ICScheduleBreakCount											= CASE WHEN ie.SOURCE_ID = 2 THEN 1 ELSE 0 END,
												ICMissingMedia													= CASE WHEN ie.SOURCE_ID = 2 
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ICMediaPrefixErrors												= CASE WHEN ie.SOURCE_ID = 2
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ICMediaDurationErrors											= CASE WHEN ie.SOURCE_ID = 2
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ICMediaFormatErrors												= CASE WHEN ie.SOURCE_ID = 2
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,


												/* AT&T Breakdown */
												ATTTotal														= CASE WHEN ie.SOURCE_ID = 1 THEN 1 ELSE 0 END,
												DTM_ATTTotal													= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) THEN 1 ELSE 0 END,
												DTM_ATTPlayed													= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 5 THEN 1 ELSE 0 END,
												DTM_ATTFailed													= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) THEN 1 ELSE 0 END,
												DTM_ATTNoTone													= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS = 14 THEN 1 ELSE 0 END,
												DTM_ATTMpegError												= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS IN (2, 4, 115, 128) THEN 1 ELSE 0 END,
												DTM_ATTMissingCopy												= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 ELSE 0 END,

												ATTScheduleLoaded												= CASE WHEN ie.SOURCE_ID = 1 THEN tb.UTCTB_FILE_DATE_TIME ELSE '1970-01-01' END,
												ATTScheduleBreakCount											= CASE WHEN ie.SOURCE_ID = 1 THEN 1 ELSE 0 END,
												ATTMissingMedia													= CASE WHEN ie.SOURCE_ID = 1
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ATTMediaPrefixErrors											= CASE WHEN ie.SOURCE_ID = 1
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ATTMediaDurationErrors											= CASE WHEN ie.SOURCE_ID = 1
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ATTMediaFormatErrors											= CASE WHEN ie.SOURCE_ID = 1
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,






												--MTE_Insertions_In_Dispatch										= 0,												--Int	
												--First_Conflicts_NextDay											= 0,												--Int	
												--Break_Conflicts													= 0,												--Int	
												--Break_Conflicts_NextDay											= 0,												--Int	

												--ATT_First_Conflicts_NextDay										= 0,												--Int	
												--ATT_LastSchedule_Received										= GETDATE(),										--DateTime	
												--ATT_WrongPrefix													= 0,												--Int	
												--ATT_WrongDuration												= 0,												--Int	
												--ATT_WrongFormat													= 0,												--Int	
												--ATT_NextDay_LastSchedule_Received								= GETDATE(),										--DateTime	
												--ATT_NextDay_WrongPrefix											= 0,												--Int	
												--ATT_NextDay_WrongDuration										= 0,												--Int	
												--ATT_NextDay_WrongFormat											= 0,												--Int	
												--ATT_LastVERReport_Generated										= GETDATE(),										--DateTime	
												--ATT_LastVERReport_RecordCount									= 0,												--Int	
												--ATT_Yesterdays_BreakCount										= 0,												--Int	

												--IC_First_Conflicts_NextDay										= 0,												--Int	
												--IC_LastSchedule_Received										= GETDATE(),										--DateTime	
												--IC_WrongPrefix													= 0,												--Int	
												--IC_WrongDuration												= 0,												--Int	
												--IC_WrongFormat													= 0,												--Int	
												--IC_NextDay_LastSchedule_Received								= GETDATE(),										--DateTime	
												--IC_NextDay_WrongPrefix											= 0,												--Int	
												--IC_NextDay_WrongDuration										= 0,												--Int	
												--IC_NextDay_WrongFormat											= 0,												--Int	
												--IC_LastVERReport_Generated										= GETDATE(),										--DateTime	
												--IC_LastVERReport_RecordCount									= 0,												--Int	
												--IC_Yesterdays_BreakCount										= 0,												--Int	






												CreateDate														= GETUTCDATE()

							FROM				#DayOfYearPartition d 
							INNER JOIN			dbo.XSEU x WITH (NOLOCK)
							ON					d.DayOfYearPartitionKey											= x.UTCSPOTDayOfYearPartitionKey	
							AND					d.DayDate														= x.UTCSPOTDayDate	
							JOIN 				dbo.DimSpot spot  WITH (NOLOCK)									ON x.DimSpotID = spot.DimSpotID
							JOIN 				dbo.DimIE ie  WITH (NOLOCK)										ON x.DimIEID = ie.DimIEID
							JOIN				dbo.DimIU iu (NOLOCK)											ON IE.IU_ID = IU.IU_ID
							JOIN				dbo.DimTB_REQUEST tb WITH (NOLOCK)								ON x.DimTB_REQUESTID = tb.DimTB_REQUESTID
							JOIN				dbo.DimSDBSource sdb WITH (NOLOCK)								ON x.DimSDBSourceID = sdb.DimSDBSourceID
							JOIN				dbo.DimAsset a WITH (NOLOCK)									ON spot.VIDEO_ID = a.AssetID
																												AND spot.RegionID = a.RegionID



END
GO