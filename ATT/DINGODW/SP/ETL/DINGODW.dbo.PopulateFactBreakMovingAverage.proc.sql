



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.PopulateFactBreakMovingAverage'), 0) > 0 
	DROP PROCEDURE dbo.PopulateFactBreakMovingAverage
GO

CREATE PROCEDURE dbo.PopulateFactBreakMovingAverage 
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
// Module:  dbo.PopulateFactBreakMovingAverage
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.FactBreakMovingAverage table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFactBreakMovingAverage.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFactBreakMovingAverage	
//
*/ 
BEGIN


							--					This is deliberately commented because we need to make sure the physical temp table is NOT currently being manipulated.
							--SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@NumPreviousDays												INT = -7
							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'Break'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), FactBreakMovingAverageID int, UTCIEDayOfYearPartitionKey int, UTCIEDayDate date )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )		DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID INT IDENTITY(1,1), FactID INT, FactName VARCHAR(50), DayOfYearPartitionKey INT, UTCDate DATE, TotalRecords int )

							IF					( ISNULL(OBJECT_ID('tempdb..#UTCDayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #UTCDayOfYearPartitionSubset
							CREATE TABLE		#UTCDayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )

							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )



							SELECT				@FactID															= f.FactID
							FROM				dbo.Fact f WITH (NOLOCK)
							WHERE				f.Name															= @FactName


							--					Make sure metrics for a particular day DOES NOT exist (Done for UTC and NonUTC timezones).
							INSERT				#UTCDayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			IEDayOfYearPartitionKey,IEDayDate
												FROM			dbo.FactBreakMovingAverage  WITH (NOLOCK)
												WHERE			UTC												= 1
												GROUP BY		IEDayOfYearPartitionKey,IEDayDate
											) xs																ON		d.DayDate				= xs.IEDayDate
																												AND		d.DayOfYearPartitionKey	= xs.IEDayOfYearPartitionKey
							WHERE				xs.IEDayOfYearPartitionKey										IS NULL

							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			IEDayOfYearPartitionKey,IEDayDate
												FROM			dbo.FactBreakMovingAverage  WITH (NOLOCK)
												WHERE			UTC												= 0
												GROUP BY		IEDayOfYearPartitionKey,IEDayDate
											) xs																ON		d.DayDate				= xs.IEDayDate
																												AND		d.DayOfYearPartitionKey	= xs.IEDayOfYearPartitionKey
							WHERE				xs.IEDayOfYearPartitionKey										IS NULL


							BEGIN TRAN

												INSERT				dbo.FactBreakMovingAverage
																(
																	IEDayOfYearPartitionKey,
																	IEDayDate,
																	RegionID,
																	RegionName,
																	MarketID,
																	MarketName,
																	ZoneName,
																	NetworkID,
																	NetworkName,
																	ICProviderID,
																	ICProviderName,
																	ROCID,
																	ROCName,
																	ChannelName,
																	ICDailyCount,
																	ATTDailyCount,
																	UTC,
																	CreateDate
																)
												OUTPUT				INSERTED.FactBreakMovingAverageID, INSERTED.IEDayOfYearPartitionKey, INSERTED.IEDayDate
												INTO				@InsertedRows
												SELECT
																	IEDayOfYearPartitionKey										= x.IEDayOfYearPartitionKey,
																	IEDayDate													= x.IEDayDate,
																	RegionID													= x.RegionID,
																	RegionName													= x.RegionName,
																	MarketID													= x.MarketID,
																	MarketName													= x.MarketName,
																	ZoneName													= x.ZoneName,
																	NetworkID													= x.NetworkID,
																	NetworkName													= x.NetworkName,
																	ICProviderID												= x.ICProviderID,
																	ICProviderName												= x.ICProviderName,
																	ROCID														= x.ROCID,
																	ROCName														= x.ROCName,
																	ChannelName													= x.ChannelName,
																	ICDailyCount												= x.ICDailyCount,
																	ATTDailyCount												= x.ATTDailyCount,
																	UTC															= x.UTC,
																	CreateDate													= GETUTCDATE()
												FROM				
																(
																	SELECT		IEDayOfYearPartitionKey							= t.UTCIEDayOfYearPartitionKey,
																				IEDayDate										= t.UTCIEDayDate,
																				RegionID										= t.RegionID,
																				RegionName										= t.RegionName,
																				MarketID										= t.MarketID,
																				MarketName										= t.MarketName,
																				ZoneName										= t.ZoneName,
																				NetworkID										= t.NetworkID,
																				NetworkName										= t.NetworkName,
																				ICProviderID									= t.ICProviderID,
																				ICProviderName									= t.ICProviderName,
																				ROCID											= t.ROCID,
																				ROCName											= t.ROCName,
																				ChannelName										= t.ChannelName,
																				UTC												= 1,
																				ICDailyCount									=	SUM(	CASE	
																																				WHEN t.SourceID = 2 THEN 1
																																				ELSE 0
																																			END
																																		),
																				ATTDailyCount									=	SUM(	CASE	
																																				WHEN t.SourceID = 1 THEN 1
																																				ELSE 0
																																			END
																																		)

																	FROM		#UTCDayOfYearPartitionSubset d
																	JOIN		dbo.TempTableFactSummary1 t WITH (NOLOCK)
																	ON			d.DayOfYearPartitionKey							= t.UTCIEDayOfYearPartitionKey	
																	AND			d.DayDate										= t.UTCIEDayDate	
																	GROUP BY	t.UTCIEDayOfYearPartitionKey,
																				t.UTCIEDayDate,
																				t.RegionID,
																				t.RegionName,
																				t.MarketID,
																				t.MarketName,
																				t.ZoneName,
																				t.NetworkID,
																				t.NetworkName,
																				t.ICProviderID,
																				t.ICProviderName,
																				t.ROCID,
																				t.ROCName,
																				t.ChannelName
																	UNION ALL
																	SELECT		IEDayOfYearPartitionKey							= t.IEDayOfYearPartitionKey,
																				IEDayDate										= t.IEDayDate,
																				RegionID										= t.RegionID,
																				RegionName										= t.RegionName,
																				MarketID										= t.MarketID,
																				MarketName										= t.MarketName,
																				ZoneName										= t.ZoneName,
																				NetworkID										= t.NetworkID,
																				NetworkName										= t.NetworkName,
																				ICProviderID									= t.ICProviderID,
																				ICProviderName									= t.ICProviderName,
																				ROCID											= t.ROCID,
																				ROCName											= t.ROCName,
																				ChannelName										= t.ChannelName,
																				UTC												= 0,
																				ICDailyCount									=	SUM(	CASE	
																																				WHEN t.SourceID = 2 THEN 1
																																				ELSE 0
																																			END
																																		),
																				ATTDailyCount									=	SUM(	CASE	
																																				WHEN t.SourceID = 1 THEN 1
																																				ELSE 0
																																			END
																																		)

																	FROM		#DayOfYearPartitionSubset d
																	JOIN		dbo.TempTableFactSummary1 t WITH (NOLOCK)
																	ON			d.DayOfYearPartitionKey							= t.IEDayOfYearPartitionKey	
																	AND			d.DayDate										= t.IEDayDate	
																	GROUP BY	t.IEDayOfYearPartitionKey,
																				t.IEDayDate,
																				t.RegionID,
																				t.RegionName,
																				t.MarketID,
																				t.MarketName,
																				t.ZoneName,
																				t.NetworkID,
																				t.NetworkName,
																				t.ICProviderID,
																				t.ICProviderName,
																				t.ROCID,
																				t.ROCName,
																				t.ChannelName

																) x


												UPDATE				dbo.FactBreakMovingAverage
												SET					ICMovingAvg7Day												= x.ICAvg7Day,
																	ATTMovingAvg7Day											= x.ATTAvg7Day
												FROM			(
																	SELECT	
																				d1.IEDayDate,
																				d1.UTC,
																				d1.ChannelName,
																				TotalDays 										= COUNT(1),
																				ICAvg7Day 										= SUM(d2.ICDailyCount)/COUNT(1),
																				ATTAvg7Day 										= SUM(d2.ATTDailyCount)/COUNT(1)
																	FROM		dbo.FactBreakMovingAverage d1 WITH (NOLOCK)
																	JOIN 		dbo.FactBreakMovingAverage d2 WITH (NOLOCK)
																	ON			d1.UTC 											= d2.UTC
																	AND			d1.ChannelName 									= d2.ChannelName
																	WHERE		d2.IEDayDate 									BETWEEN DATEADD(DAY,-7,d1.IEDayDate) AND d1.IEDayDate
																	GROUP BY	d1.IEDayDate,
																				d1.UTC,
																				d1.ChannelName
																) x
												WHERE				FactBreakMovingAverage.IEDayDate							= x.IEDayDate
												AND					FactBreakMovingAverage.UTC									= x.UTC
												AND					FactBreakMovingAverage.ChannelName							= x.ChannelName
	

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


							DROP TABLE			#UTCDayOfYearPartitionSubset
							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#TotalCountByDay


END
GO