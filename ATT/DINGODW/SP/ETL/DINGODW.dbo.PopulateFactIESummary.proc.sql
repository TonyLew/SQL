



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.PopulateFactIESummary'), 0) > 0 
	DROP PROCEDURE dbo.PopulateFactIESummary
GO

CREATE PROCEDURE dbo.PopulateFactIESummary 
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
// Module:  dbo.PopulateFactIESummary
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.FactIESummary table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFactIESummary.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFactIESummary	
//
*/ 
BEGIN


							--					This is deliberately commented because we need to make sure the physical temp table is NOT currently being manipulated.
							--SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'IESummary'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), FactIESummaryID int, UTCIEDayOfYearPartitionKey int, UTCIEDayDate date )

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
												SELECT			UTCIEDayDate,UTCIEDayOfYearPartitionKey
												FROM			dbo.FactIESummary  WITH (NOLOCK)
												GROUP BY		UTCIEDayDate,UTCIEDayOfYearPartitionKey
											) xs																ON		d.DayDate				= xs.UTCIEDayDate
																												AND		d.DayOfYearPartitionKey	= xs.UTCIEDayOfYearPartitionKey
							WHERE				xs.UTCIEDayOfYearPartitionKey									IS NULL



							BEGIN TRAN

												INSERT				dbo.FactIESummary
																(
																	UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate,
																	IEDayOfYearPartitionKey,
																	IEDayDate,
																	DimIEID,
																	DimIUID,
																	DimTB_REQUESTID,
																	ICScheduleLoaded, 
																	ICScheduleBreakCount,
																	ICMissingMedia,
																	ICMediaPrefixErrors,
																	ICMediaDurationErrors,
																	ICMediaFormatErrors,
																	ATTScheduleLoaded,
																	ATTScheduleBreakCount,
																	ATTMissingMedia,
																	ATTMediaPrefixErrors,
																	ATTMediaDurationErrors,
																	ATTMediaFormatErrors,
																	CreateDate
																)
												OUTPUT				INSERTED.FactIESummaryID, INSERTED.UTCIEDayOfYearPartitionKey, INSERTED.UTCIEDayDate
												INTO				@InsertedRows
												SELECT
																	UTCIEDayOfYearPartitionKey									= t.UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate												= t.UTCIEDayDate,
																	IEDayOfYearPartitionKey										= t.IEDayOfYearPartitionKey,
																	IEDayDate													= t.IEDayDate,
																	DimIEID														= t.DimIEID,
																	DimIUID														= t.DimIUID,
																	DimTB_REQUESTID												= t.DimTB_REQUESTID,
																	ICScheduleLoaded											= t.ICScheduleLoaded, 
																	ICScheduleBreakCount										= t.ICScheduleBreakCount, 
																	ICMissingMedia												= t.ICMissingMedia, 
																	ICMediaPrefixErrors											= t.ICMediaPrefixErrors, 
																	ICMediaDurationErrors										= t.ICMediaDurationErrors, 
																	ICMediaFormatErrors											= t.ICMediaFormatErrors, 
																	ATTScheduleLoaded											= t.ATTScheduleLoaded, 
																	ATTScheduleBreakCount										= t.ATTScheduleBreakCount, 
																	ATTMissingMedia												= t.ATTMissingMedia, 
																	ATTMediaPrefixErrors										= t.ATTMediaPrefixErrors, 
																	ATTMediaDurationErrors										= t.ATTMediaDurationErrors, 
																	ATTMediaFormatErrors										= t.ATTMediaFormatErrors, 

																	CreateDate													= GETUTCDATE()
												FROM				#DayOfYearPartitionSubset d
												JOIN				dbo.TempTableFactSummary1 t
												ON					d.DayOfYearPartitionKey										= t.UTCIEDayOfYearPartitionKey	
												AND					d.DayDate													= t.UTCIEDayDate	


												INSERT				#TotalCountByDay ( FactID, FactName, DayOfYearPartitionKey, UTCDate, TotalRecords )
												SELECT				FactID														= @FactID,
																	FactName													= @FactName,
																	DayOfYearPartitionKey										= x.UTCIEDayOfYearPartitionKey, 
																	UTCDate														= x.UTCIEDayDate, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCIEDayOfYearPartitionKey, x.UTCIEDayDate

												--					Uses Temp Table #TotalCountByDay
												EXEC				dbo.SaveFactRecordCount	


							COMMIT

							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#TotalCountByDay


END
GO