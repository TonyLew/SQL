
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.CreateMaintenanceJobs'), 0) > 0 
	DROP PROCEDURE dbo.CreateMaintenanceJobs
GO

CREATE PROCEDURE [dbo].[CreateMaintenanceJobs]
		@JobOwnerLoginName			NVARCHAR(100) = NULL,
		@JobOwnerLoginPWD			NVARCHAR(100) = NULL,
		@BackUpPathNameFull			NVARCHAR(100) = NULL,
		@BackUpPathNameTranLog		NVARCHAR(100) = NULL

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
// Module:  dbo.CreateMaintenanceJobs
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Creates DB Maintenance Jobs
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateMaintenanceJobs.proc.sql 4049 2014-04-29 15:50:41Z nbrownett $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateMaintenanceJobs	
//								@JobOwnerLoginName = N'',
//								@JobOwnerLoginPWD = N'',
//								@BackUpPathNameFull = NULL,
//								@BackUpPathNameTranLog = NULL
//
*/ 
-- =============================================
BEGIN


		SET NOCOUNT ON;
		DECLARE @StepName NVARCHAR(100)
		DECLARE @StepCommand NVARCHAR(500)
		DECLARE @ReturnCode INT
		DECLARE @jobId BINARY(16)

		DECLARE @JobNameMaintenanceBackupFull					NVARCHAR(100)	= N'MaintenanceBackupFull'
		DECLARE @JobNameMaintenanceBackupTransactionLog			NVARCHAR(100)	= N'MaintenanceBackupTransactionLog'
		DECLARE @JobNameMaintenanceCleanup						NVARCHAR(100)	= N'MaintenanceCleanup'
		DECLARE @JobNameMaintenanceDBIntegrity					NVARCHAR(100)	= N'MaintenanceDBIntegrity'
		DECLARE @JobNameMaintenanceRebuildIndex					NVARCHAR(100)	= N'MaintenanceRebuildIndex'
		DECLARE @JobCategoryMaintenanceName						NVARCHAR(100)	= N'Maintenance'



		--Create the Maintenance Job Category
		SELECT @ReturnCode = 0
		/****** Object:  JobCategory [ETL]    Script Date: 10/18/2013 11:18:58 PM ******/
		IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=@JobCategoryMaintenanceName AND category_class=1)
		BEGIN
				EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=@JobCategoryMaintenanceName
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) RETURN
		END


		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceBackupFull )
		BEGIN		

				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceBackupFull ' + ISNULL('@BackUpPathName = ''' + @BackUpPathNameFull + ''' ','')

				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceBackupFull, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Day', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=1, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_time=030000 
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceBackupFull
				QuitWithRollbackMaintenanceBackupFull:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceBackupFull:

		END



		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceBackupTransactionLog )
		BEGIN		

				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceBackupTransactionLog ' + ISNULL('@BackUpPathName = ''' + @BackUpPathNameTranLog + ''' ',''),
							@jobId								= NULL

				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceBackupTransactionLog, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 15 Minutes', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=4, 
						@freq_subday_interval=15, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_time=010000 
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceBackupTransactionLog
				QuitWithRollbackMaintenanceBackupTransactionLog:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceBackupTransactionLog:

		END




		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceCleanup )
		BEGIN		


				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceCleanup ',
							@jobId								= NULL


				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceCleanup, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Week', 
						@enabled=1, 
						@freq_type=8, 
						@freq_interval=8, 
						@freq_subday_type=1, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=1, 
						@active_start_time=500,
						@active_end_time=235959
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceCleanup
				QuitWithRollbackMaintenanceCleanup:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceCleanup:


		END



		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceDBIntegrity )
		BEGIN		


				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceDBIntegrity ',
							@jobId								= NULL


				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceDBIntegrity, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Day', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=1, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_time=020000 
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceDBIntegrity
				QuitWithRollbackAllRegional:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceDBIntegrity:


		END

		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceRebuildIndex )
		BEGIN		


				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceRebuildIndex ',
							@jobId								= NULL



				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceRebuildIndex, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Day', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=1, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_time=010000 
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceRebuildIndex
				QuitWithRollbackMaintenanceRebuildIndex:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceRebuildIndex:

		END




END



GO