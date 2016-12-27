
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.SetBackupSDBReplication'), 0) > 0 
	DROP PROCEDURE dbo.SetBackupSDBReplication
GO

CREATE PROCEDURE [dbo].[SetBackupSDBReplication]
				@ReplicationClusterID		INT,
				@SDBSystemID				INT,
				@SDBName					VARCHAR(50),
				@EnabledValue				INT
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
// Module:  dbo.SetBackupSDBReplication
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Sets the SDB system replication jobs to Enabled (1) or Disabled (0).
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.SetBackupSDBReplication.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGOSDB.dbo.SetBackupSDBReplication
//								@ReplicationClusterID	= 1,
//								@SDBSystemID			= 1,
//								@SDBName				= 'MSSNTC4SDB001B',
//								@EnabledValue			= 1
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;


				IF OBJECT_ID('tempdb..#JobCurrentStatus') IS NOT NULL
					DROP TABLE #JobCurrentStatus
				CREATE TABLE #JobCurrentStatus
								( 
									Job_ID uniqueidentifier, 
									Last_Run_Date int, 
									Last_Run_Time int, 
									Next_Run_Date int, 
									Next_Run_Time int, 
									Next_Run_Schedule_ID int, 
									Requested_To_Run int, 
									Request_Source int, 
									Request_Source_ID varchar(100), 
									Running int, 
									Current_Step int, 
									Current_Retry_Attempt int, 
									State int 
								)       

				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@Msg									VARCHAR(200)
				DECLARE			@SQLCMDGetCurrentJobStatus				NVARCHAR(500)
				DECLARE			@SQLCMDSetLogReaderJob					NVARCHAR(500)
				DECLARE			@SQLCMDSetPublicationJob				NVARCHAR(500)
				DECLARE			@SQLCMDSetSnapshotJob					NVARCHAR(500)
				DECLARE			@SQLCMDStopLogReaderJob					NVARCHAR(500)
				DECLARE			@SQLCMDStopPublicationJob				NVARCHAR(500)
				DECLARE			@SQLCMDStartSnapshotJob					NVARCHAR(500)
				DECLARE			@ParmDefinition							NVARCHAR(200)
				DECLARE			@LogReaderJobID							UNIQUEIDENTIFIER
				DECLARE			@LogReaderJobName						VARCHAR(200)
				DECLARE			@PublicationJobID						UNIQUEIDENTIFIER
				DECLARE			@PublicationJobName						VARCHAR(200)
				DECLARE			@PullDistributionJobID					UNIQUEIDENTIFIER
				DECLARE			@PullDistributionJobName				VARCHAR(200)
				DECLARE			@PushDistributionJobID					UNIQUEIDENTIFIER
				DECLARE			@PushDistributionJobName				VARCHAR(200)
				DECLARE			@SnapshotJobID							UNIQUEIDENTIFIER
				DECLARE			@SnapshotJobName						VARCHAR(200)
				DECLARE			@ReturnCode								INT = 0
				DECLARE			@ERROR									INT = 0
				DECLARE			@LastStepName							VARCHAR(50)
				DECLARE			@LogReaderReplicationJobTypeID			INT
				DECLARE			@PublicationReplicationJobTypeID		INT
				DECLARE			@PullReplicationJobTypeID				INT
				DECLARE			@PushReplicationJobTypeID				INT
				DECLARE			@SnapshotJobTypeID						INT
				DECLARE			@LogReaderJobStatus						INT
				DECLARE			@PublicationJobStatus					INT
				DECLARE			@PullJobStatus							INT
				

				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'SetBackupSDBReplication First Step'

				IF				( @EventLogStatusID IS NOT NULL )
								EXEC	dbo.LogEvent 
													@LogID				= NULL,
													@EventLogStatusID	= @EventLogStatusID,			----Started Step
													@JobID				= NULL,
													@JobName			= N'Check SDB Replication',
													@DBID				= @ReplicationClusterID,
													@DBComputerName		= @@SERVERNAME,
													@LogIDOUT			= @LogIDReturn OUTPUT

				SELECT			@LogReaderReplicationJobTypeID			= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Log Reader Agent'

				--SELECT			@PublicationReplicationJobTypeID		= ReplicationJobTypeID 
				--FROM			dbo.ReplicationJobType (NOLOCK)
				--WHERE			Description								= 'Publication Agent'

				SELECT			@PullReplicationJobTypeID				= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Pull Distribution Agent'

				SELECT			@PushReplicationJobTypeID				= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Push Distribution Agent'

				SELECT			@SnapshotJobTypeID						= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Snapshot Agent'


				SELECT			@SQLCMDGetCurrentJobStatus				=	N'INSERT INTO #JobCurrentStatus ' +
																			N'EXEC [' + @SDBName + '].MASTER.dbo.xp_sqlagent_enum_jobs 1, '''' ',
								@SQLCMDSetLogReaderJob					=	N'EXEC @Status = [' + @SDBName + '].msdb.dbo.sp_update_job ' + 
																			N'@job_name =  ''TOKEN'', ' +
																			N'@enabled = ' + CAST( @EnabledValue AS NVARCHAR(50) ),
								@SQLCMDSetPublicationJob				=	N'EXEC @Status = [' + @SDBName + '].msdb.dbo.sp_update_job ' + 
																			N'@job_name =  ''TOKEN'', ' +
																			N'@enabled = ' + CAST( @EnabledValue AS NVARCHAR(50) ),
								@SQLCMDSetSnapshotJob					=	N'EXEC @Status = [' + @SDBName + '].msdb.dbo.sp_update_job ' + 
																			N'@job_name =  ''TOKEN'', ' +
																			N'@enabled = ' + CAST( @EnabledValue AS NVARCHAR(50) ),
								@SQLCMDStopLogReaderJob					=	N'EXEC		@Status = [' + @SDBName + '].msdb.dbo.sp_stop_job @job_name = ''TOKEN'' ',
								@SQLCMDStopPublicationJob				=	N'EXEC		@Status = [' + @SDBName + '].msdb.dbo.sp_stop_job @job_name = ''TOKEN'' ',
								@SQLCMDStartSnapshotJob					=	N'EXEC 		@Status = [' + @SDBName + '].msdb.dbo.sp_start_job @job_name =  ''TOKEN'' ',
								@ParmDefinition							=	N'@Status INT OUTPUT'

				SELECT			@SnapshotJobName						= a.JobName
				FROM			dbo.ReplicationJob a
				JOIN			dbo.ReplicationJobType b
				ON				a.ReplicationJobTypeID					= b.ReplicationJobTypeID
				WHERE			a.ReplicationJobTypeID					= @SnapshotJobTypeID
				AND				a.SDBSystemID							= @SDBSystemID

				SELECT			@LogReaderJobID							= JobID,
								@LogReaderJobName						= JobName
				FROM			dbo.ReplicationJob (NOLOCK)
				WHERE			ReplicationJobTypeID					= @LogReaderReplicationJobTypeID
				AND				SDBSystemID								= @SDBSystemID

				SELECT			@PublicationJobID						= JobID,
								@PublicationJobName						= JobName
				FROM			dbo.ReplicationJob (NOLOCK)
				WHERE			ReplicationJobTypeID					= @PublicationReplicationJobTypeID
				AND				SDBSystemID								= @SDBSystemID

				SELECT			@PullDistributionJobID					= JobID,
								@PullDistributionJobName				= JobName
				FROM			dbo.ReplicationJob (NOLOCK)
				WHERE			ReplicationJobTypeID					= @PullReplicationJobTypeID
				AND				SDBSystemID								= @SDBSystemID

				SELECT			@PushDistributionJobID					= JobID,
								@PushDistributionJobID					= JobName
				FROM			dbo.ReplicationJob (NOLOCK)
				WHERE			ReplicationJobTypeID					= @PushReplicationJobTypeID
				AND				SDBSystemID								= @SDBSystemID

				SELECT			@SQLCMDSetLogReaderJob					=	REPLACE( @SQLCMDSetLogReaderJob, 'TOKEN', @LogReaderJobName ),
								--@SQLCMDSetPublicationJob				=	REPLACE( @SQLCMDSetPublicationJob, 'TOKEN', @PublicationJobName ),
								@SQLCMDSetSnapshotJob					=	REPLACE( @SQLCMDSetSnapshotJob, 'TOKEN', @SnapshotJobName ),
								@SQLCMDStopLogReaderJob					=	REPLACE( @SQLCMDStopLogReaderJob, 'TOKEN', @LogReaderJobName ),
								@SQLCMDStopPublicationJob				=	REPLACE( @SQLCMDStopPublicationJob, 'TOKEN', @PublicationJobName ),
								@SQLCMDStartSnapshotJob					=	REPLACE( @SQLCMDStartSnapshotJob, 'TOKEN', @SnapshotJobName )


				--				Set the Log Reader Job.
				IF				( @SQLCMDSetLogReaderJob IS NOT NULL)
				BEGIN
								EXECUTE			sp_executesql	@SQLCMDSetLogReaderJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
								SELECT			@ERROR					= @@ERROR,
												@LastStepName			= 'Log Reader Job - ' + CASE WHEN @EnabledValue = 1 THEN 'Enable' ELSE 'Disable' END,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()
								--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				END


				--				Set the Pull Distribution Job.
				IF				( @PullDistributionJobName IS NOT NULL)
				BEGIN
								EXEC			msdb.dbo.sp_update_job
													@job_name			= @PullDistributionJobName,
													@enabled			= @EnabledValue
								SELECT			@ERROR					= @@ERROR,
												@LastStepName			= 'Set Pull Distribution Job - ' + CASE WHEN @EnabledValue = 1 THEN 'Enable' ELSE 'Disable' END,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()

								EXEC			msdb.dbo.sp_start_job
													@job_name			= @PullDistributionJobName
								SELECT			@ERROR					= @@ERROR,
												@LastStepName			= 'Start Pull Distribution Job',
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()
				END


				--				Finally, initiate the replication by manually starting the Snapshot Job.
				IF				( @SnapshotJobName IS NOT NULL)
				BEGIN

								EXECUTE			sp_executesql	@SQLCMDSetSnapshotJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
								SELECT			@ERROR					= @@ERROR,
												@LastStepName			= 'Set Snapshot Job - ' + CASE WHEN @EnabledValue = 1 THEN 'Enable' ELSE 'Disable' END,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()

								IF				(@EnabledValue = 1)
								BEGIN
												EXECUTE			sp_executesql	@SQLCMDStartSnapshotJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
												SELECT			@ERROR					= @@ERROR,
																@LastStepName			= 'Start Snapshot Job - ' + CASE WHEN @EnabledValue = 1 THEN 'Enable' ELSE 'Disable' END,
																@ErrNum					= ERROR_NUMBER(), 
																@ErrMsg					= ERROR_MESSAGE()
												--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
								END

				END


				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'SetBackupSDBReplication Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'SetBackupSDBReplication Fail Step'
				
				SET				@Msg			= @LastStepName + ': ' + ISNULL(@ErrMsg , '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg

				DROP TABLE		#JobCurrentStatus

END



GO
