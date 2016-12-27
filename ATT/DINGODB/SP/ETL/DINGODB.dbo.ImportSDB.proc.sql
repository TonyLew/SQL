
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.ImportSDB'), 0) > 0 
	DROP PROCEDURE dbo.ImportSDB
GO

CREATE PROCEDURE [dbo].[ImportSDB]
		@RegionID				INT,
		@SDBSourceID			INT,
		@JobRun					BIT = 0
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
// Module:  dbo.ImportSDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: The parent ETL Import SP that will call all child SPs to ETL from a physical SDB.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ImportSDB.proc.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//	 Usage:
//
//				DECLARE @LogIDReturn INT
//				EXEC	dbo.ImportSDB 
//							@RegionID				= 1,
//							@SDBSourceID			= 1,
//							@JobRun					= 0
//				
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@CMD														NVARCHAR(1000)
		DECLARE		@CMDImportBreakCountHistory									NVARCHAR(4000)
		DECLARE		@CMDImportChannelAndConflictStats							NVARCHAR(4000)
		DECLARE		@CMDImportTrafficAndBillingData								NVARCHAR(4000)
		DECLARE		@LogIDReturn												INT
		DECLARE		@LogIDImportBreakCountHistoryReturn							INT
		DECLARE		@LogIDImportChannelAndConflictStatsReturn					INT
		DECLARE		@LogIDImportTrafficAndBillingDataReturn						INT
		DECLARE		@LogIDChannelStatsReturn									INT
		DECLARE		@LogIDConflictsReturn										INT
		DECLARE		@JobID														UNIQUEIDENTIFIER
		DECLARE		@JobName													VARCHAR(100)
		DECLARE		@SDBName													VARCHAR(50)
		DECLARE		@ErrTotal													INT = 0
		DECLARE		@ErrNum														INT = 0
		DECLARE		@ErrMsg														VARCHAR(200)
		DECLARE		@ErrorIDOUT													INT
		DECLARE		@ErrMsgOUT													VARCHAR(200)

		DECLARE		@EventLogStatusID											INT
		DECLARE		@EventLogStatusIDStart										INT
		DECLARE		@EventLogStatusIDSuccess									INT
		DECLARE		@EventLogStatusIDFail										INT
		DECLARE		@EventLogStatusIDImportBreakCountHistoryStart				INT
		DECLARE		@EventLogStatusIDImportBreakCountHistorySuccess				INT
		DECLARE		@EventLogStatusIDImportChannelAndConflictStatsStart			INT
		DECLARE		@EventLogStatusIDImportChannelAndConflictStatsSuccess		INT
		DECLARE		@EventLogStatusIDImportTrafficAndBillingDataStart			INT
		DECLARE		@EventLogStatusIDImportTrafficAndBillingDataSuccess			INT

		DECLARE		@TODAY														DATETIME = GETUTCDATE()
		DECLARE		@SDBUTCOffset												INT
		DECLARE		@Role														INT
		DECLARE		@MPEGDB														VARCHAR(50)
		DECLARE		@ReplicationClusterID										INT
		DECLARE		@ReplicationClusterName										VARCHAR(50)
		DECLARE		@ReplicationClusterNameFQ									VARCHAR(100)
		DECLARE		@ReplicationClusterVIP										VARCHAR(50)
		DECLARE		@SDBSourceSystemID											INT
		DECLARE		@ParmDefinition												NVARCHAR(500)

		--			Need to get @SDBSourceSystemID in order to accomodate the condition of failover
		SELECT		TOP 1 
					@JobID						= CASE WHEN @JobRun = 1  THEN b.JobID		ELSE NULL END,
					@JobName					= CASE WHEN @JobRun = 1  THEN b.JobName		ELSE NULL END,
					@SDBName					= c.SDBComputerName,
					@SDBSourceSystemID			= c.SDBSourceSystemID,
					@Role						= c.Role
		FROM		dbo.MDBSource a (NOLOCK)
		JOIN		dbo.SDBSource b (NOLOCK)
		ON			a.MDBSourceID				= b.MDBSourceID
		JOIN		dbo.SDBSourceSystem c (NOLOCK)
		ON			b.SDBSourceID				= c.SDBSourceID
		WHERE		a.RegionID					= @RegionID
		AND			b.SDBSourceID				= @SDBSourceID 
		AND			c.Status					= 1
		AND			c.Enabled					= 1
		ORDER BY	c.Role

		IF			( ISNULL(@SDBSourceID, 0) = 0 )	RETURN

		EXEC		dbo.GetSDBUTCOffset 
							@SDBSourceID		= @SDBSourceID,
							@SDBComputerName	= @SDBName, 
							@Role				= @Role, 
							@JobID				= @JobID,
							@JobName			= @JobName,
							@UTCOffset			= @SDBUTCOffset OUTPUT

		IF			( @SDBUTCOffset IS NULL )	RETURN
		SET			@TODAY						= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )


				SELECT			TOP 1 
								@ReplicationClusterName						= a.Name,
								@ReplicationClusterNameFQ					= a.NameFQ,
								@MPEGDB										= 'MPEG' + CAST( @SDBSourceSystemID AS VARCHAR(50) )
				FROM			dbo.ReplicationCluster a WITH (NOLOCK)
				JOIN			dbo.SDBSource b WITH (NOLOCK)
				ON				a.ReplicationClusterID						= b.ReplicationClusterID
				JOIN			dbo.SDBSourceSystem c WITH (NOLOCK)
				ON				b.SDBSourceID								= c.SDBSourceID
				WHERE			c.SDBSourceSystemID							= @SDBSourceSystemID
				AND				a.Enabled									= 1
				AND				c.Enabled									= 1
				AND				a.ReplicationClusterID						> 0


		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,			----Started Step
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		IF		ISNULL(OBJECT_ID('tempdb..#ImportTB_REQUEST'), 0) > 0 
				DROP TABLE #ImportTB_REQUEST

		CREATE TABLE #ImportTB_REQUEST
			(
				[ImportTB_REQUESTID] [int] IDENTITY(1,1) NOT NULL,
				[IU_ID] [int] NOT NULL,
				[SCHED_DATE] [datetime] NOT NULL,
				[UTC_SCHED_DATE] [date] NOT NULL,
				[FILENAME] [varchar](128) NOT NULL,
				[FILE_DATETIME] [datetime] NOT NULL,
				[UTC_FILE_DATETIME] [datetime] NOT NULL,
				[STATUS] [int] NOT NULL,
				[PROCESSED] [datetime] NULL,
				[SOURCE_ID] [int] NOT NULL,
				[SDBSourceID] [int] NOT NULL
			)

		IF		ISNULL(OBJECT_ID('tempdb..#ImportIUBreakCount'), 0) > 0 
				DROP TABLE #ImportIUBreakCount

		CREATE TABLE #ImportIUBreakCount
			(
				[ImportIUBreakCountID] [int] IDENTITY(1,1) NOT NULL,
				[BREAK_DATE] DATE NOT NULL,
				[IU_ID] [int] NOT NULL,
				[SOURCE_ID] [int] NOT NULL,
				[BREAK_COUNT] [int] NOT NULL,
				[SDBSourceID] [int] NOT NULL
			)


		IF		ISNULL(OBJECT_ID('tempdb..#ImportIE_SPOT'), 0) > 0 
				DROP TABLE #ImportIE_SPOT

		CREATE TABLE #ImportIE_SPOT
			(
				ImportIE_SPOTID [int] IDENTITY(1,1) NOT NULL,
				[SDBSourceID] [int] NOT NULL,
				[SPOT_ID] [int] NULL,
				[IE_ID] [int] NULL,
				[IU_ID] [int] NULL,
				[SCHED_DATE] [date] NOT NULL,
				[SCHED_DATE_TIME] [datetime] NULL,
				[UTC_SCHED_DATE] [date] NULL,
				[UTC_SCHED_DATE_TIME] [datetime] NULL,
				[IE_NSTATUS] [int] NULL,
				[IE_CONFLICT_STATUS] [int] NULL,
				[SPOTS] [int] NULL,
				[IE_DURATION] [int] NULL,
				[IE_RUN_DATE] [date] NULL,
				[IE_RUN_DATE_TIME] [datetime] NULL,
				[UTC_IE_RUN_DATE] [date] NULL,
				[UTC_IE_RUN_DATE_TIME] [datetime] NULL,
				[BREAK_INWIN] [int] NULL,
				[AWIN_START_DT] [datetime] NULL,
				[AWIN_END_DT] [datetime] NULL,
				[UTC_AWIN_START_DT] [datetime] NULL,
				[UTC_AWIN_END_DT] [datetime] NULL,
				[IE_SOURCE_ID] [int] NULL,
				----------------------
				[VIDEO_ID] [varchar](32) NULL,
				[ASSET_DESC] [varchar](334) NULL,
				[SPOT_DURATION] [int] NULL,
				[SPOT_NSTATUS] [int] NULL,
				[SPOT_CONFLICT_STATUS] [int] NULL,
				[SPOT_ORDER] [int] NULL,
				[SPOT_RUN_DATE_TIME] [datetime] NULL,
				[UTC_SPOT_RUN_DATE_TIME] [datetime] NULL,
				[RUN_LENGTH] [int] NULL,
				[SPOT_SOURCE_ID] [int] NULL
			)

			SELECT		TOP 1 @EventLogStatusIDImportBreakCountHistoryStart					= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportBreakCountHistory First Step'
			SELECT		TOP 1 @EventLogStatusIDImportBreakCountHistorySuccess				= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportBreakCountHistory Success Step'
			SELECT		TOP 1 @EventLogStatusIDImportChannelAndConflictStatsStart			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats First Step'
			SELECT		TOP 1 @EventLogStatusIDImportChannelAndConflictStatsSuccess			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats Success Step'
			SELECT		TOP 1 @EventLogStatusIDImportTrafficAndBillingDataStart				= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData First Step'
			SELECT		TOP 1 @EventLogStatusIDImportTrafficAndBillingDataSuccess			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData Success Step'


			SELECT		@CMDImportBreakCountHistory			=	N'DECLARE	@ErrorIDOUT	INT, @ErrMsgOUT VARCHAR(200) ' +
																N'INSERT INTO #ImportIUBreakCount ' +
																N'( ' +
																	N'BREAK_DATE, ' +
																	N'IU_ID, ' +
																	N'SOURCE_ID, ' +
																	N'BREAK_COUNT, ' +
																	N'SDBSourceID ' +
																N') ' +
																N'EXEC [' + @ReplicationClusterName + '].' + @MPEGDB + N'.dbo.ImportBreakCountHistory ' +
																N'@SDBUTCOffset	= ' + CAST(@SDBUTCOffset AS NVARCHAR(50)) + ', ' +
																N'@SDBSourceID	= ' + CAST(@SDBSourceID AS NVARCHAR(50)) + ', ' +
																N'@Day			= ''' + CAST(@TODAY AS NVARCHAR(50)) + ''', ' +
																N'@ErrorID		= @ErrorIDOUT OUTPUT, ' +
																N'@ErrMsg		= @ErrMsgOUT OUTPUT '


			SELECT		@CMDImportChannelAndConflictStats	=	N'DECLARE	@ErrorIDOUT	INT, @ErrMsgOUT VARCHAR(200) ' +
																N'INSERT INTO #ImportIE_SPOT ' +
																N'(  ' +
																	N'SDBSourceID, ' +
																	N'SPOT_ID, ' +
																	N'IE_ID, ' +
																	N'IU_ID, ' +
																	N'SCHED_DATE, ' +
																	N'SCHED_DATE_TIME, ' + 
																	N'IE_NSTATUS, ' +
																	N'IE_CONFLICT_STATUS, ' +
																	N'AWIN_END_DT, ' +
																	N'IE_SOURCE_ID, ' +
																	N'VIDEO_ID, ' +
																	N'ASSET_DESC, ' +
																	N'SPOT_NSTATUS, ' +
																	N'SPOT_CONFLICT_STATUS, ' +
																	N'SPOT_ORDER, ' +
																	N'SPOT_RUN_DATE_TIME ' +
																N') ' +
																N'EXEC [' + @ReplicationClusterName + '].' + @MPEGDB + N'.dbo.ImportChannelAndConflictStats ' +
																N'@SDBUTCOffset	= ' + CAST(@SDBUTCOffset AS NVARCHAR(50)) + ', ' +
																N'@SDBSourceID	= ' + CAST(@SDBSourceID AS NVARCHAR(50)) + ', ' +
																N'@Day			= ''' + CAST(@TODAY AS NVARCHAR(50)) + ''', ' +
																N'@ErrorID		= @ErrorIDOUT OUTPUT, ' +
																N'@ErrMsg		= @ErrMsgOUT OUTPUT '

			SELECT		@CMDImportTrafficAndBillingData		=	N'DECLARE	@ErrorIDOUT	INT, @ErrMsgOUT VARCHAR(200) ' +
																N'INSERT INTO #ImportTB_REQUEST ' +
																N'( ' +
																	N'SCHED_DATE, ' +
																	N'UTC_SCHED_DATE, ' +
																	N'FILENAME, ' +
																	N'FILE_DATETIME, ' +
																	N'UTC_FILE_DATETIME, ' +
																	N'PROCESSED, ' +
																	N'SOURCE_ID, ' +
																	N'STATUS, ' +
																	N'IU_ID, ' +
																	N'SDBSourceID ' +
																N') ' +
																N'EXEC [' + @ReplicationClusterName + '].' + @MPEGDB + N'.dbo.ImportTrafficAndBillingData ' +
																N'@SDBUTCOffset	= ' + CAST(@SDBUTCOffset AS NVARCHAR(50)) + ', ' +
																N'@SDBSourceID	= ' + CAST(@SDBSourceID AS NVARCHAR(50)) + ', ' +
																N'@Day			= ''' + CAST(@TODAY AS NVARCHAR(50)) + ''', ' +
																N'@ErrorID		= @ErrorIDOUT OUTPUT, ' +
																N'@ErrMsg		= @ErrMsgOUT OUTPUT '

			SET			@ParmDefinition						=	N'@ErrorID int OUTPUT,  @ErrMsg varchar(200) OUTPUT'



			SELECT		TOP 1 @EventLogStatusIDImportBreakCountHistoryStart					= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportBreakCountHistory First Step'
			SELECT		TOP 1 @EventLogStatusIDImportBreakCountHistorySuccess				= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportBreakCountHistory Success Step'
			SELECT		TOP 1 @EventLogStatusIDImportChannelAndConflictStatsStart			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats First Step'
			SELECT		TOP 1 @EventLogStatusIDImportChannelAndConflictStatsSuccess			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats Success Step'
			SELECT		TOP 1 @EventLogStatusIDImportTrafficAndBillingDataStart				= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData First Step'
			SELECT		TOP 1 @EventLogStatusIDImportTrafficAndBillingDataSuccess			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData Success Step'



				EXEC		dbo.LogEvent 
									@LogID							= NULL,
									@EventLogStatusID				= @EventLogStatusIDImportBreakCountHistoryStart,			----Started Step
									@JobID							= @JobID,
									@JobName						= @JobName,
									@DBID							= @SDBSourceID,
									@DBComputerName					= @SDBName,
									@LogIDOUT						= @LogIDImportBreakCountHistoryReturn OUTPUT

				EXECUTE		sp_executesql							@CMDImportBreakCountHistory,		@ParmDefinition, @ErrorID = @ErrorIDOUT OUTPUT, @ErrMsg = @ErrMsgOUT OUTPUT
				SET			@ErrTotal								= @ErrTotal + ISNULL(@ErrorIDOUT, 0)
				IF			( ISNULL(@ErrTotal, 0) = 0 )			EXEC	dbo.LogEvent @LogID = @LogIDImportBreakCountHistoryReturn, @EventLogStatusID = @EventLogStatusIDImportBreakCountHistorySuccess, @Description = @ErrMsg


				IF			( @ErrTotal = 0 ) 
				BEGIN

							EXEC		dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusIDImportChannelAndConflictStatsStart,			----Started Step
												@JobID				= @JobID,
												@JobName			= @JobName,
												@DBID				= @SDBSourceID,
												@DBComputerName		= @SDBName,
												@LogIDOUT			= @LogIDImportChannelAndConflictStatsReturn OUTPUT

							EXECUTE	sp_executesql	@CMDImportChannelAndConflictStats,	@ParmDefinition, @ErrorID = @ErrorIDOUT OUTPUT, @ErrMsg = @ErrMsgOUT OUTPUT
							SET		@ErrTotal						= @ErrTotal + ISNULL(@ErrorIDOUT, 0)
							IF		( ISNULL(@ErrTotal, 0) = 0 )	EXEC	dbo.LogEvent @LogID = @LogIDImportChannelAndConflictStatsReturn, @EventLogStatusID = @EventLogStatusIDImportChannelAndConflictStatsSuccess, @Description = @ErrMsg

				END

				IF			( @ErrTotal = 0 ) 
				BEGIN
							EXEC		dbo.LogEvent @LogID			= @LogIDImportChannelAndConflictStatsReturn, @EventLogStatusID = @EventLogStatusIDImportChannelAndConflictStatsSuccess, @Description = @ErrMsg

							EXEC		dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusIDImportTrafficAndBillingDataStart,			----Started Step
												@JobID				= @JobID,
												@JobName			= @JobName,
												@DBID				= @SDBSourceID,
												@DBComputerName		= @SDBName,
												@LogIDOUT			= @LogIDImportTrafficAndBillingDataReturn OUTPUT

							EXECUTE	sp_executesql	@CMDImportTrafficAndBillingData,	@ParmDefinition, @ErrorID = @ErrorIDOUT OUTPUT, @ErrMsg = @ErrMsgOUT OUTPUT
							SET		@ErrTotal					= @ErrTotal + ISNULL(@ErrorIDOUT, 0)
							IF		( ISNULL(@ErrTotal, 0) = 0 )	EXEC	dbo.LogEvent @LogID = @LogIDImportTrafficAndBillingDataReturn, @EventLogStatusID = @EventLogStatusIDImportTrafficAndBillingDataSuccess, @Description = @ErrMsg

				END


/*
		EXEC			dbo.ImportBreakCountHistory 
							@SDBUTCOffset		= @SDBUTCOffset,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@SDBSourceID		= @SDBSourceID,
							@SDBName			= @SDBName,
							@JobRun				= @JobRun,
							@ErrorID			= @ErrNum OUTPUT
		SET				@ErrTotal				= @ErrTotal + ISNULL(@ErrNum, 0)

		EXEC			dbo.ImportChannelAndConflictStats 
							@SDBUTCOffset		= @SDBUTCOffset,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@SDBSourceID		= @SDBSourceID,
							@SDBName			= @SDBName,
							@Day				= @TODAY,
							@JobRun				= @JobRun,
							@ErrorID			= @ErrNum OUTPUT
		SET				@ErrTotal				= @ErrTotal + ISNULL(@ErrNum, 0)

		EXEC			dbo.ImportTrafficAndBillingData 
							@SDBUTCOffset		= @SDBUTCOffset,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@SDBSourceID		= @SDBSourceID,
							@SDBName			= @SDBName,
							@JobRun				= @JobRun,
							@ErrorID			= @ErrNum OUTPUT
		SET				@ErrTotal				= @ErrTotal + ISNULL(@ErrNum, 0)

*/

		IF				( @ErrTotal = 0 )
		BEGIN

		
						--Run the SaveSDB_IESPOT step (needs the ImportChannelAndConflictStats SP to populate the temp table)
							EXEC		dbo.SaveSDB_IESPOT 
											@JobID				= @JobID,
											@JobName			= @JobName,
											@SDBSourceID		= @SDBSourceID,
											@SDBName			= @SDBName,
											@JobRun				= @JobRun,
											@ErrorID			= @ErrNum OUTPUT

						--Run the SaveSDB_Market step (needs the ImportChannelAndConflictStats SP to populate the temp table)
							EXEC		dbo.SaveSDB_Market 
											@JobID				= @JobID,
											@JobName			= @JobName,
											@SDBSourceID		= @SDBSourceID,
											@SDBName			= @SDBName,
											@JobRun				= @JobRun,
											@ErrorID			= @ErrNum OUTPUT

						--TRY the SaveChannel step

						SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus First Step'

							EXEC		dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusID,			----Started Step
												@JobID				= @JobID,
												@JobName			= @JobName,
												@DBID				= @SDBSourceID,
												@DBComputerName		= @SDBName,
												@LogIDOUT			= @LogIDChannelStatsReturn OUTPUT

						BEGIN TRY
							EXEC		dbo.SaveChannelStatus	@RegionID		= @RegionID,	@SDBSourceID	= @SDBSourceID,  @SDBUTCOffset = @SDBUTCOffset, @ErrorID = @ErrNum OUTPUT			
							EXEC		dbo.SaveCacheStatus		@SDBSourceID	= @SDBSourceID, @CacheType = 'Channel Status'
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus Success Step'
							EXEC		dbo.LogEvent @LogID = @LogIDChannelStatsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
						END TRY
						BEGIN CATCH
							SELECT		@ErrNum		= ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus Fail Step'
							EXEC		dbo.LogEvent @LogID = @LogIDChannelStatsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
							SET			@ErrMsg = ''
						END CATCH


						--TRY the SaveConflicts step
						SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict First Step'
							EXEC		dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusID,			----Started Step
												@JobID				= @JobID,
												@JobName			= @JobName,
												@DBID				= @SDBSourceID,
												@DBComputerName		= @SDBName,
												@LogIDOUT			= @LogIDConflictsReturn OUTPUT
						BEGIN TRY
							EXEC		dbo.SaveConflict		@SDBSourceID	= @SDBSourceID,	@SDBUTCOffset = @SDBUTCOffset, @ErrorID = @ErrNum OUTPUT
							EXEC		dbo.SaveCacheStatus		@SDBSourceID	= @SDBSourceID, @CacheType = 'Media Status'
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict Success Step'
							EXEC		dbo.LogEvent @LogID = @LogIDConflictsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
						END TRY
						BEGIN CATCH
							SELECT		@ErrNum		= ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict Fail Step'
							EXEC		dbo.LogEvent @LogID = @LogIDConflictsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
							SET			@ErrMsg = ''
						END CATCH
						SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB Success Step'
		END
		ELSE			
						SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB Fail Step'

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#ImportTB_REQUEST
		DROP TABLE		#ImportIUBreakCount
		DROP TABLE		#ImportIE_SPOT


END


GO




