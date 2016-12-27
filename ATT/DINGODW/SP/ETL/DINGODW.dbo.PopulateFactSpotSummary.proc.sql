



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.PopulateFactSpotSummary'), 0) > 0 
	DROP PROCEDURE dbo.PopulateFactSpotSummary
GO

CREATE PROCEDURE dbo.PopulateFactSpotSummary 
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
// Module:  dbo.PopulateFactSpotSummary
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.FactSpotSummary table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFactSpotSummary.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFactSpotSummary	
//
*/ 
BEGIN


							--					This is deliberately commented because we need to make sure the physical temp table is NOT currently being manipulated.
							--SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'SpotSummary'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), FactSpotSummaryID int, UTCSPOTDayOfYearPartitionKey int, UTCSPOTDayDate date )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )		DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID INT IDENTITY(1,1), FactID INT, FactName VARCHAR(50), DayOfYearPartitionKey INT, UTCDate DATE, TotalRecords int )

							SELECT				@FactID															= f.FactID
							FROM				dbo.Fact f WITH (NOLOCK)
							WHERE				f.Name															= @FactName

							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )

							--					Make sure metrics for a particular day DOES NOT exist.
							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
												FROM			dbo.FactSpotSummary  WITH (NOLOCK)
												GROUP BY		UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
											) xs																ON		d.DayDate				= xs.UTCSPOTDayDate
																												AND		d.DayOfYearPartitionKey	= xs.UTCSPOTDayOfYearPartitionKey
							WHERE				xs.UTCSPOTDayOfYearPartitionKey									IS NULL



							BEGIN TRAN

												INSERT				dbo.FactSpotSummary
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
																	DimSPOTID,
																	DimIEID,
																	DimIUID,
																	DimTB_REQUESTID,
																	DimSpotStatusID,
																	DimSpotConflictStatusID,
																	DimIEStatusID,
																	DimIEConflictStatusID,

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
												OUTPUT				INSERTED.FactSpotSummaryID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDayDate
												INTO				@InsertedRows
												SELECT
																	UTCSPOTDayOfYearPartitionKey								= t.UTCSPOTDayOfYearPartitionKey,
																	UTCSPOTDayDate												= t.UTCSPOTDayDate,
																	SPOTDayOfYearPartitionKey									= t.SPOTDayOfYearPartitionKey,
																	SPOTDayDate													= t.SPOTDayDate,
																	UTCIEDayOfYearPartitionKey									= t.UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate												= t.UTCIEDayDate,
																	IEDayOfYearPartitionKey										= t.IEDayOfYearPartitionKey,
																	IEDayDate													= t.IEDayDate,
																	DimSDBSourceID												= t.DimSDBSourceID,
																	DimSPOTID													= t.DimSPOTID,
																	DimIEID														= t.DimIEID,
																	DimIUID														= t.DimIUID,
																	DimTB_REQUESTID												= t.DimTB_REQUESTID,
																	DimSpotStatusID												= t.DimSpotStatusID,
																	DimSpotConflictStatusID										= t.DimSpotConflictStatusID,
																	DimIEStatusID												= t.DimIEStatusID,
																	DimIEConflictStatusID										= t.DimIEConflictStatusID,

																	OTHERTotal													= t.OTHERTotal,
																	DTM_OTHERTotal												= t.DTM_OTHERTotal,
																	DTM_OTHERPlayed												= t.DTM_OTHERPlayed,
																	DTM_OTHERFailed												= t.DTM_OTHERFailed,
																	DTM_OTHERNoTone												= t.DTM_OTHERNoTone,
																	DTM_OTHERMpegError											= t.DTM_OTHERMpegError,
																	DTM_OTHERMissingCopy										= t.DTM_OTHERMissingCopy,
																	OTHERScheduleLoaded											= t.OTHERScheduleLoaded,
																	OTHERScheduleBreakCount										= t.OTHERScheduleBreakCount,
																	OTHERMissingMedia											= t.OTHERMissingMedia,
																	OTHERMediaPrefixErrors										= t.OTHERMediaPrefixErrors,
																	OTHERMediaDurationErrors									= t.OTHERMediaDurationErrors,
																	OTHERMediaFormatErrors										= t.OTHERMediaFormatErrors,

																	ICTotal														= t.ICTotal,
																	DTM_ICTotal													= t.DTM_ICTotal,
																	DTM_ICPlayed												= t.DTM_ICPlayed,
																	DTM_ICFailed												= t.DTM_ICFailed,
																	DTM_ICNoTone												= t.DTM_ICNoTone,
																	DTM_ICMpegError												= t.DTM_ICMpegError,
																	DTM_ICMissingCopy											= t.DTM_ICMissingCopy,
																	ICScheduleLoaded											= t.ICScheduleLoaded, 
																	ICScheduleBreakCount										= t.ICScheduleBreakCount, 
																	ICMissingMedia												= t.ICMissingMedia, 
																	ICMediaPrefixErrors											= t.ICMediaPrefixErrors, 
																	ICMediaDurationErrors										= t.ICMediaDurationErrors, 
																	ICMediaFormatErrors											= t.ICMediaFormatErrors, 

																	ATTTotal													= t.ATTTotal,
																	DTM_ATTTotal												= t.DTM_ATTTotal,
																	DTM_ATTPlayed												= t.DTM_ATTPlayed,
																	DTM_ATTFailed												= t.DTM_ATTFailed,
																	DTM_ATTNoTone												= t.DTM_ATTNoTone,
																	DTM_ATTMpegError											= t.DTM_ATTMpegError,
																	DTM_ATTMissingCopy											= t.DTM_ATTMissingCopy,
																	ATTScheduleLoaded											= t.ATTScheduleLoaded, 
																	ATTScheduleBreakCount										= t.ATTScheduleBreakCount, 
																	ATTMissingMedia												= t.ATTMissingMedia, 
																	ATTMediaPrefixErrors										= t.ATTMediaPrefixErrors, 
																	ATTMediaDurationErrors										= t.ATTMediaDurationErrors, 
																	ATTMediaFormatErrors										= t.ATTMediaFormatErrors, 
																	CreateDate													= GETUTCDATE()
												FROM				#DayOfYearPartitionSubset d
												JOIN				dbo.TempTableFactSummary1 t
												ON					d.DayOfYearPartitionKey										= t.UTCSPOTDayOfYearPartitionKey	
												AND					d.DayDate													= t.UTCSPOTDayDate	


												INSERT				#TotalCountByDay ( FactID, FactName, DayOfYearPartitionKey, UTCDate, TotalRecords )
												SELECT				FactID														= @FactID,
																	FactName													= @FactName,
																	DayOfYearPartitionKey										= x.UTCSPOTDayOfYearPartitionKey, 
																	UTCDate														= x.UTCSPOTDayDate, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCSPOTDayOfYearPartitionKey, x.UTCSPOTDayDate

												--					Uses Temp Table #TotalCountByDay
												EXEC				dbo.SaveFactRecordCount	


							COMMIT

							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#TotalCountByDay


END
GO