



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.DWETLParent'), 0) > 0 
	DROP PROCEDURE dbo.DWETLParent
GO

CREATE PROCEDURE dbo.DWETLParent 
				@RegionID			INT				= NULL,
				@SDBSourceID		INT				= NULL,
				@SDBName			VARCHAR(64)		= NULL,
				@UTCOffset			INT				= NULL,
				@StartingDate		DATE			= NULL,
				@EndingDate			DATE			= NULL,
				@OverRideCounts		INT				= 0
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
// Module:  dbo.DWETLParent
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose:			This parent SP will call all ETL SPs.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.DWETLParent.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.DWETLParent	
//									@RegionID				= NULL,
//									@SDBSourceID			= NULL,
//									@SDBName				= NULL,
//									@UTCOffset				= NULL,
//									@StartingDate			= '2014-01-01',
//									@EndingDate				= NULL,
//									@OverRideCounts			= 0
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON


				DECLARE				@LogIDReturn												INT
				DECLARE				@EventLogStatusIDStart										INT
				DECLARE				@EventLogStatusIDSuccess									INT
				DECLARE				@EventLogStatusIDFail										INT
				DECLARE				@JobName													NVARCHAR(200)
				DECLARE				@DatabaseID													INT
				DECLARE				@StartingDayOfYear											INT
				DECLARE				@CurrentDay													INT
				DECLARE				@CurrentUTCDay												INT
				DECLARE				@ERROR_MESSAGE												NVARCHAR(500)

				SELECT				@CurrentDay													= DATEPART( DAY,GETDATE() ),
									@CurrentUTCDay												= DATEPART( DAY,GETUTCDATE() ),
									@DatabaseID													= DB_ID()

				--					Make sure the UTC day is over before continuing.
				IF					( @CurrentDay = @CurrentUTCDay )	RETURN

				IF					ISNULL(OBJECT_ID('tempdb..#EventLogIDs'), 0) > 0 
									DROP TABLE #EventLogIDs

				CREATE TABLE		#EventLogIDs
								(
									ID int identity(1,1),
									EventLogStatusID int,
									SP varchar(100)

								)

				INSERT				#EventLogIDs ( EventLogStatusID,SP )
				SELECT				EventLogStatusID, SP 
				FROM				DINGODB.dbo.EventLogStatus WITH (NOLOCK) 
				WHERE				SP LIKE 'DWETLParent%'

				SELECT				TOP 1 @EventLogStatusIDStart								= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent First Step'
				SELECT				TOP 1 @EventLogStatusIDSuccess								= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent Success Step'
				SELECT				TOP 1 @EventLogStatusIDFail									= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent Fail Step'

				EXEC				DINGODB.dbo.LogEvent 
										@LogID													= NULL,
										@EventLogStatusID										= @EventLogStatusIDStart,			----Started Step
										@JobID													= NULL,
										@JobName												= @JobName,
										@DBID													= @DatabaseID,
										@DBComputerName											= @@SERVERNAME,
										@LogIDOUT												= @LogIDReturn OUTPUT

				--					If no starting date parameter is given then use 0:00 UTC minus 1 day
				SELECT				@StartingDate												= ISNULL( @StartingDate,DATEADD( DAY,-1,GETUTCDATE() ) )
				SELECT				@StartingDayOfYear											= DATEPART( DY,@StartingDate )
				SELECT				@EndingDate													= ISNULL( @EndingDate,DATEADD(DAY,1,@StartingDate) )

				EXEC				dbo.PopulateDimensions	
															@EventLogStatusIDFail				= @EventLogStatusIDFail,
															@LogIDReturn						= @LogIDReturn

				EXEC				dbo.PopulateFacts	
															@EventLogStatusIDFail				= @EventLogStatusIDFail,
															@LogIDReturn						= @LogIDReturn

				IF					( 1 = 1 )
									EXEC				DINGODB.dbo.LogEvent 
															@LogID								= @LogIDReturn, 
															@EventLogStatusID					= @EventLogStatusIDSuccess, 
															@Description						= NULL
				ELSE
									EXEC				DINGODB.dbo.LogEvent 
															@LogID								= @LogIDReturn, 
															@EventLogStatusID					= @EventLogStatusIDFail, 
															@Description						= NULL --@ERROR_MESSAGE


				
				DROP TABLE			#EventLogIDs

END

GO

