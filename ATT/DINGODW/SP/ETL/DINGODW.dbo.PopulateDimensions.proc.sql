


USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.PopulateDimensions'), 0) > 0 
	DROP PROCEDURE dbo.PopulateDimensions
GO

CREATE PROCEDURE dbo.PopulateDimensions 
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
// Module:  dbo.PopulateDimensions
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW Dimension tables for the given day.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateDimensions.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateDimensions	
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
							DECLARE				@CurrentTimeZoneOffset										INT
							DECLARE				@DayRecorded												INT
							DECLARE				@CurrentUTCDay												DATE
							DECLARE				@EndingDateMinus1Day										DATE
							DECLARE				@Validity													BIT
							DECLARE				@EventLogTypeIDOUT											INT
							DECLARE				@EventLogStatusID_ETLDimSDBSource							INT
							DECLARE				@EventLogStatusID_ETLDimZoneMap								INT
							DECLARE				@EventLogStatusID_ETLDimAsset								INT
							DECLARE				@EventLogStatusID_ETLDimSpotStatus							INT
							DECLARE				@EventLogStatusID_ETLDimSpotConflictStatus					INT
							DECLARE				@EventLogStatusID_ETLDimIEStatus							INT
							DECLARE				@EventLogStatusID_ETLDimIEConflictStatus					INT
							DECLARE				@EventLogStatusID_ETLDimSpot								INT
							DECLARE				@EventLogStatusID_ETLDimIE									INT
							DECLARE				@EventLogStatusID_ETLDimIU									INT
							DECLARE				@EventLogStatusID_ETLDimTB_REQUEST							INT
							DECLARE				@EventLogStatusID_SaveDimRecordCount						INT
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

												--Log the event that the date range for all SDB systems has already been completed
												--OR log the error that the endingday date parameter is not over.  Then exit.
												--SELECT @Validity, @EndingDateMinus1Day , DATEADD(DAY,-1,@CurrentUTCDay) , DATEDIFF ( HOUR,@CurrentUTCDay,GETUTCDATE() ) 

												SELECT			@Description								= 'Current Day ' + CAST(@CurrentUTCDay AS VARCHAR(30)) + ' is NOT over.' --@ERROR_MESSAGE

												EXEC			DINGODB.dbo.LogEvent 
																		@LogID								= @LogIDReturn, 
																		@EventLogStatusID					= @EventLogStatusIDFail, 
																		@Description						= @Description
												RETURN


												SELECT			@EndingDate									= @CurrentUTCDay,
																@EndingDateMinus1Day						= DATEADD(DAY,-1,@CurrentUTCDay)

							END


							SELECT				TOP 1 @EventLogStatusID_ETLDimSDBSource						= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimSDBSource Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimZoneMap						= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimZoneMap Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimAsset							= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimAsset Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimSpotStatus					= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimSpotStatus Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimSpotConflictStatus			= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimSpotConflictStatus Step'
							SELECT				TOP 1 @EventLogStatusID_ETLDimIEStatus						= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimIEStatus Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimIEConflictStatus				= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimIEConflictStatus Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimSpot							= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimSpot Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimIE							= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimIE Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimIU							= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimIU Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimTB_REQUEST					= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimTB_REQUEST Step'	
							SELECT				TOP 1 @EventLogStatusID_SaveDimRecordCount					= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - SaveDimRecordCount Step'	



							--					Populate the slow changing dimensions first.  
							EXEC				dbo.ETLDimSpotStatus	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimSpotStatus

							EXEC				dbo.ETLDimSpotConflictStatus
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimSpotConflictStatus

							EXEC				dbo.ETLDimIEStatus	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimIEStatus

							EXEC				dbo.ETLDimIEConflictStatus
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimIEConflictStatus

							EXEC				dbo.ETLDimSDBSource	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimSDBSource

							EXEC				dbo.ETLDimZoneMap	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimZoneMap

							EXEC				dbo.ETLDimAsset	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimAsset


							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartition'), 0) > 0 ) DROP TABLE #DayOfYearPartition
							CREATE TABLE		#DayOfYearPartition ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DateDay DATE, SDBSourceID INT )

							INSERT				#DayOfYearPartition ( DayOfYearPartitionKey,DateDay,SDBSourceID )
							SELECT				d.DayOfYearPartitionKey, d.DimDate, s.SDBSourceID
							FROM				dbo.DimDateDay d WITH (NOLOCK)
							CROSS JOIN			dbo.DimSDBSource s WITH (NOLOCK)
							WHERE				d.DimDate													BETWEEN @StartingDate AND @EndingDateMinus1Day
							AND					s.Enabled													= 1


							--					Populate the IU dimension before the other dimensions.  
							--					This will query DINGODB OLTP and get the values defined in DINGODB.
							--					Namely, ChannelName, SDBSourceID, Network, ZoneMap information (Market, ICProvider, ROC)
							--					This information will then be propogated to the other more molecular units (IE and SPOT)
							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.ETLDimIU	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimIU

							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.ETLDimIE	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimIE

							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.ETLDimSPOT
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimSpot

							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.ETLDimTB_REQUEST	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimTB_REQUEST

							
							DROP TABLE			#DayOfYearPartition



END
GO


