



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.PopulateFactAssetSummary'), 0) > 0 
	DROP PROCEDURE dbo.PopulateFactAssetSummary
GO

CREATE PROCEDURE dbo.PopulateFactAssetSummary 
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
// Module:  dbo.PopulateFactAssetSummary
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.FactAssetSummary table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFactAssetSummary.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFactAssetSummary	
//
*/ 
BEGIN


							--					This is deliberately commented because we need to make sure the physical temp table is NOT currently being manipulated.
							--SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'AssetSummary'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), FactAssetSummaryID int, UTCSPOTDayOfYearPartitionKey int, UTCSPOTDayDate date )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )		DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID INT IDENTITY(1,1), FactID INT, FactName VARCHAR(50), DayOfYearPartitionKey INT, UTCDate DATE, TotalRecords int )

							SELECT				@FactID															= f.FactID
							FROM				dbo.Fact f WITH (NOLOCK)
							WHERE				f.Name															= @FactName

							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), TempTableFactSummary1ID INT, DayOfYearPartitionKey INT, DayDate DATE )

							--					Make sure metrics for a particular day DOES NOT exist.
							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
												FROM			dbo.FactAssetSummary  WITH (NOLOCK)
												GROUP BY		UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
											) xs																ON		d.DayDate				= xs.UTCSPOTDayDate
																												AND		d.DayOfYearPartitionKey	= xs.UTCSPOTDayOfYearPartitionKey
							WHERE				xs.UTCSPOTDayOfYearPartitionKey									IS NULL



							BEGIN TRAN

												INSERT				dbo.FactAssetSummary
																(
																	UTCSPOTDayOfYearPartitionKey,
																	UTCSPOTDayDate,
																	SPOTDayOfYearPartitionKey,
																	SPOTDayDate,
																	UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate,
																	DimAssetID,
																	DimSDBSourceID,
																	DimSPOTID,
																	DimIEID,
																	DimIUID,
																	DimTB_REQUESTID,
																	DimSpotStatusID,
																	DimSpotConflictStatusID,
																	DimIEStatusID,
																	DimIEConflictStatusID,
																	SecondsLength,
																	CreateDate
																)
												OUTPUT				INSERTED.FactAssetSummaryID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDayDate
												INTO				@InsertedRows
												SELECT
																	UTCSPOTDayOfYearPartitionKey								= t.UTCSPOTDayOfYearPartitionKey,
																	UTCSPOTDayDate												= t.UTCSPOTDayDate,
																	SPOTDayOfYearPartitionKey									= t.SPOTDayOfYearPartitionKey,
																	SPOTDayDate													= t.SPOTDayDate,
																	UTCIEDayOfYearPartitionKey									= t.UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate												= t.UTCIEDayDate,
																	DimAssetID													= a.DimAssetID,
																	DimSDBSourceID												= t.DimSDBSourceID,
																	DimSPOTID													= t.DimSPOTID,
																	DimIEID														= t.DimIEID,
																	DimIUID														= t.DimIUID,
																	DimTB_REQUESTID												= t.DimTB_REQUESTID,
																	DimSpotStatusID												= t.DimSpotStatusID,
																	DimSpotConflictStatusID										= t.DimSpotConflictStatusID,
																	DimIEStatusID												= t.DimIEStatusID,
																	DimIEConflictStatusID										= t.DimIEConflictStatusID,
																	SecondsLength												= a.Length,
																	CreateDate													= GETUTCDATE()
												FROM				#DayOfYearPartitionSubset d
												JOIN				dbo.TempTableFactSummary1 t WITH (NOLOCK)
												ON					d.DayOfYearPartitionKey										= t.UTCSPOTDayOfYearPartitionKey	
												AND					d.DayDate													= t.UTCSPOTDayDate	
												JOIN				dbo.DimAsset a WITH (NOLOCK)
												ON					t.AssetID													= a.AssetID	


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