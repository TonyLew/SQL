



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.PopulateXSEU'), 0) > 0 
	DROP PROCEDURE dbo.PopulateXSEU
GO

CREATE PROCEDURE dbo.PopulateXSEU 
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
// Module:  dbo.PopulateXSEU
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.XSEU table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateXSEU.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateXSEU	
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'XSEU'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), XSEUID int, UTCSPOTDayOfYearPartitionKey int, UTCSPOTDayDate date )

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
												FROM			dbo.XSEU  WITH (NOLOCK)
												GROUP BY		UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
											) xs																ON		d.DayDate				= xs.UTCSPOTDayDate
																												AND		d.DayOfYearPartitionKey	= xs.UTCSPOTDayOfYearPartitionKey
							WHERE				xs.UTCSPOTDayOfYearPartitionKey									IS NULL



							BEGIN TRAN

												INSERT				dbo.XSEU
																(
																	DimSpotID,
																	DimIEID,
																	DimIUID,
																	DimTB_REQUESTID,
																	DimSpotStatusID,
																	DimSpotConflictStatusID,
																	DimIEStatusID,
																	DimIEConflictStatusID,
																	DimSDBSourceID,
																	UTCSPOTDayDate,
																	UTCSPOTDayOfYearPartitionKey,
																	UTCIEDayDate,
																	UTCIEDayOfYearPartitionKey,
																	SPOTDayDate,
																	SPOTDayOfYearPartitionKey,
																	IEDayDate,
																	IEDayOfYearPartitionKey,
																	CreateDate
																)
												OUTPUT				INSERTED.XSEUID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDayDate
												INTO				@InsertedRows
												SELECT
																	DimSpotID													= s.DimSpotID,
																	DimIEID														= e.DimIEID,
																	DimIUID														= u.DimIUID,
																	DimTB_REQUESTID												= tb.DimTB_REQUESTID,
																	DimSpotStatusID												= s.DimSpotStatusID,
																	DimSpotConflictStatusID										= s.DimSpotConflictStatusID,
																	DimIEStatusID												= e.DimIEStatusID,
																	DimIEConflictStatusID										= e.DimIEConflictStatusID,
																	DimSDBSourceID												= sdb.DimSDBSourceID,
																	UTCSPOTDayDate												= s.UTCSPOTDATE,
																	UTCSPOTDayOfYearPartitionKey								= s.UTCSPOTDayOfYearPartitionKey,
																	UTCIEDayDate												= s.UTCIEDATE,
																	UTCIEDayOfYearPartitionKey									= s.UTCIEDayOfYearPartitionKey,
																	SPOTDayDate													= s.SPOTDATE,
																	SPOTDayOfYearPartitionKey									= s.SPOTDayOfYearPartitionKey,
																	IEDayDate													= s.IEDATE,
																	IEDayOfYearPartitionKey										= s.IEDayOfYearPartitionKey,
																	CreateDate													= GETUTCDATE()
												FROM				#DayOfYearPartitionSubset d 
												INNER JOIN			dbo.DimSpot s WITH (NOLOCK)
												ON					d.DayOfYearPartitionKey										= s.UTCSPOTDayOfYearPartitionKey	
												AND					d.DayDate													= s.UTCSPOTDate	
												INNER JOIN			dbo.DimSDBSource sdb WITH (NOLOCK)
												ON					s.SDBSourceID												= sdb.SDBSourceID
												LEFT JOIN			dbo.DimIE e WITH (NOLOCK)
												ON					s.IE_ID														= e.IE_ID
												AND					s.UTCIEDATE													= e.UTCIEDATE
												AND					s.UTCIEDayOfYearPartitionKey								= e.UTCIEDayOfYearPartitionKey
												LEFT JOIN			dbo.DimIU u WITH (NOLOCK)
												ON					e.IU_ID														= u.IU_ID
												AND					s.UTCIEDATE													= u.UTCIEDATE
												AND					s.UTCIEDayOfYearPartitionKey								= u.UTCIEDayOfYearPartitionKey
												LEFT JOIN			dbo.DimTB_REQUEST tb WITH (NOLOCK)	
												ON					u.IU_ID														= tb.IU_ID
												AND					s.UTCIEDATE													= tb.UTCIEDATE
												AND					s.UTCIEDayOfYearPartitionKey								= tb.UTCIEDayOfYearPartitionKey

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