


USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.PopulateFacts'), 0) > 0 
	DROP PROCEDURE dbo.PopulateFacts
GO

CREATE PROCEDURE dbo.PopulateFacts 
							@StartingDate				DATE = NULL,
							@EndingDate					DATE = NULL,
							@EventLogStatusIDFail		INT = NULL,
							@LogIDReturn				INT = NULL,
							@OverRideCounts				INT = 0
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
// Module:  dbo.PopulateFacts
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW fact tables for the given day.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFacts.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFacts	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03',
//												@EventLogStatusIDFail	= NULL,
//												@LogIDReturn			= NULL,
//												@OverRideCounts			= 0
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@TotalDY													INT
							DECLARE				@TotalDayCount												INT
							DECLARE				@TotalSDBSources											INT
							DECLARE				@TotalDimensions											INT = 3
							DECLARE				@InComplete													INT
							DECLARE				@EventLogStatusID_SaveFactRecordCount						INT
							DECLARE				@EventLogStatusID_PopulateXSEU								INT
							DECLARE				@EventLogStatusID_PopulateTempTableFactSummary1				INT
							DECLARE				@EventLogStatusID_PopulateFactBreakMovingAverage			INT
							DECLARE				@EventLogStatusID_PopulateFactAssetSummary					INT
							DECLARE				@EventLogStatusID_PopulateFactSpotSummary					INT
							DECLARE				@EventLogStatusID_PopulateFactIESummary						INT
							DECLARE				@EventLogStatusID_PopulateFactIUSummary						INT
							DECLARE				@CurrentTimeZoneOffset										INT
							DECLARE				@DayRecorded												INT
							DECLARE				@CurrentUTCDay												DATE
							DECLARE				@EndingDateMinus1Day										DATE
							DECLARE				@Validity													BIT
							DECLARE				@Existence													BIT
							DECLARE				@EventLogTypeIDOUT											INT
							DECLARE				@Description												VARCHAR(200)


							SELECT				@CurrentUTCDay												= GETUTCDATE()


							SELECT				@StartingDate												= ISNULL( @StartingDate,@CurrentUTCDay )
							SELECT				@EndingDate													= ISNULL( @EndingDate, DATEADD(DAY,1,@StartingDate) )
							SELECT				@EndingDateMinus1Day										= DATEADD(DAY,-1,@EndingDate)

							IF					( @EndingDateMinus1Day < @StartingDate ) RETURN


							--					If the date range is >= the current day AND the current UTC day has NOT finished for an hour or over
							--					Then log error and change the ending date range to be the last completed day.
							IF					( (@EndingDateMinus1Day >= DATEADD(DAY,-1,@CurrentUTCDay)) AND ( DATEDIFF ( HOUR,@CurrentUTCDay,GETUTCDATE() ) < 1 ) )
							BEGIN

												--Log the error that the endingday date parameter is not over OR the day has already been logged.  Then exit.
												SELECT			@Description								= 'Current Day ' + CAST(@CurrentUTCDay AS VARCHAR(30)) + ' is NOT over.' --@ERROR_MESSAGE

												EXEC			DINGODB.dbo.LogEvent 
																		@LogID								= @LogIDReturn, 
																		@EventLogStatusID					= @EventLogStatusIDFail, 
																		@Description						= @Description
												RETURN

												SELECT			@EndingDate									= @CurrentUTCDay,
																@EndingDateMinus1Day						= DATEADD(DAY,-1,@CurrentUTCDay)
												
							END


							--					When override is NOT enabled, then determine if data from all SDBs for all dimensions is complete before calculating sums.
							IF					( @OverRideCounts = 0 )
							BEGIN

												EXEC			dbo.CheckDimensionCount	
																	@StartingDate							= @StartingDate,
																	@EndingDate								= @EndingDate,
																	@Complete								= @Validity OUTPUT,
																	@EventLogTypeID							= @EventLogTypeIDOUT OUTPUT
												
												--				If any of the days in the date range are incomplete or missing, then log the error and exit.
												IF				( @Validity=0 )	
												BEGIN
																--@EventLogTypeIDOUT
																--Insert into DINGODB.dbo.EventLog table.
																RETURN
												END

							END

							SELECT				TOP 1 @EventLogStatusID_PopulateXSEU						= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateXSEU Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateTempTableFactSummary1		= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateTempTableFactSummary1 Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateFactBreakMovingAverage		= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactBreakMovingAverage Step'
							SELECT				TOP 1 @EventLogStatusID_PopulateFactAssetSummary			= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactAssetSummary Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateFactSpotSummary				= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactSpotSummary Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateFactIESummary				= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactIESummary Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateFactIUSummary				= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactIUSummary Step'	
							SELECT				TOP 1 @EventLogStatusID_SaveFactRecordCount					= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - SaveFactRecordCount Step'	


							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartition'), 0) > 0 ) DROP TABLE #DayOfYearPartition
							CREATE TABLE		#DayOfYearPartition ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )

							INSERT				#DayOfYearPartition ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DimDate
							FROM				dbo.DimDateDay d WITH (NOLOCK)
							WHERE				d.DimDate													BETWEEN @StartingDate AND @EndingDateMinus1Day


							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateXSEU	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateXSEU

							--					Make sure the subject date range IS recorded in the preliminary fact tables before populating subsequent fact tables.
							EXEC				dbo.CheckFactCount	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate,
														@Exists												= @Existence OUTPUT,
														@EventLogTypeID										= @EventLogTypeIDOUT OUTPUT

							--					If the any date in the entire date range is NON-existent.
							--					Then log error and exit.
							IF					( (@Existence <> 1 ) )
							BEGIN

												--Log the error that the endingday date parameter is not over OR the day has already been logged.  Then exit.
												--@EventLogTypeIDOUT
												--Insert into DINGODB.dbo.EventLog table.
												RETURN

							END


							--					Uses temp table #DayOfYearPartition
							--					This SP will populate a physical temporary table with initial summaries and aggregates
							--					and will be used to populate subsequent fact tables.
							EXEC				dbo.PopulateTempTableFactSummary1	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateTempTableFactSummary1


							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateFactBreakMovingAverage 
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateFactBreakMovingAverage

							
							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateFactAssetSummary	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateFactAssetSummary


							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateFactSpotSummary	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateFactSpotSummary


							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateFactIESummary	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateFactIESummary


							DROP TABLE			#DayOfYearPartition


END
GO


