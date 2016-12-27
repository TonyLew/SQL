
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.CreateMDBJob'), 0) > 0 
	DROP PROCEDURE dbo.CreateMDBJob
GO

CREATE PROCEDURE [dbo].[CreateMDBJob]
		@RegionID					INT,
		@RegionIDPK					INT,
		@MDBName					VARCHAR(100),
		@JobOwnerLoginName			NVARCHAR(100),
		@JobOwnerLoginPWD			NVARCHAR(100)

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
// Module:  dbo.CreateMDBJob
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a SQL Job that will ETL data from a specified logical SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateMDBJob.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateMDBJob	
//								@RegionID = 1, 
//								@RegionIDPK	= 4,
//								@MDBName = 'MSSNKNLMDB001', 
//								@JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD = N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


		SET NOCOUNT ON;
		DECLARE @JobNameAllRegional NVARCHAR(100)				= N'Update Regional Info'
		DECLARE @JobName NVARCHAR(100)							= N'Region ' + CAST(@RegionID AS NVARCHAR(50)) + N' Job Executor'
		DECLARE @StepName NVARCHAR(100)
		DECLARE @StepCommand NVARCHAR(500)
		DECLARE @ReturnCode INT
		DECLARE @jobId BINARY(16)


		--Create the ETL Job Category
		SELECT @ReturnCode = 0
		/****** Object:  JobCategory [ETL]    Script Date: 10/18/2013 11:18:58 PM ******/
		IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'ETL' AND category_class=1)
		BEGIN
				EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'ETL'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) RETURN
		END


		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameAllRegional )
		BEGIN		

				SELECT		@StepName 							= N'Import MDB', 
							@StepCommand 						= N'DECLARE	@UTC_Cutoff_Day DATE ' + 
																	'SET	@UTC_Cutoff_Day = DATEADD(DAY, -2, GETUTCDATE()) ' +
																	'EXEC	DINGODB.dbo.UpdateRegionalInfo ' + 
																	'		@JobOwnerLoginName = N''' + @JobOwnerLoginName + ''', ' +
																	'		@JobOwnerLoginPWD = N''' + @JobOwnerLoginPWD + ''', ' +
																	'		@UTC_Cutoff_Day = @UTC_Cutoff_Day, ' +
																	'		@JobRun = 1' 

				/****** Object:  Job [Update Regional Info]    Script Date: 10/18/2013 11:18:58 PM ******/
				BEGIN TRANSACTION

				--DECLARE @jobId BINARY(16)
				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameAllRegional, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=N'ETL', 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				/****** Object:  Step [Import MDB]    Script Date: 10/18/2013 11:18:58 PM ******/
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Import MDB', 
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
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Hour', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=8, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_date=20131002, 
						@active_end_date=99991231, 
						@active_start_time=0, 
						@active_end_time=235959, 
						@schedule_uid=N'9c59de52-f5cb-4bdc-86ef-4864882ec10e'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				COMMIT TRANSACTION
				GOTO EndSaveAllRegional
				QuitWithRollbackAllRegional:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveAllRegional:

		END

		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name=@JobName )
		BEGIN		

				SELECT		@StepName 							= N'Step 1 - Launch Child jobs for Region ' + CAST(@RegionID AS NVARCHAR(50)), 
							@StepCommand 						= N'EXEC	DINGODB.dbo.ExecuteRegionChannelJobs @RegionID = ' + CAST(@RegionIDPK AS NVARCHAR(50)),
							@jobId								= NULL

				/****** Object:  Job [Region 1 Job Executor]    Script Date: 10/18/2013 11:19:59 PM ******/
				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=N'ETL', 
						@owner_login_name=@JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				/****** Object:  Step [Step 1 - Launch Child jobs for Region 1]    Script Date: 10/18/2013 11:20:00 PM ******/
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
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 30 Seconds', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=2, 
						@freq_subday_interval=30, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_date=20131002, 
						@active_end_date=99991231, 
						@active_start_time=0, 
						@active_end_time=235959, 
						@schedule_uid=N'6dfecee6-17ef-4436-8fc7-09b812ed9bec'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

				UPDATE	dbo.MDBSource
				SET		JobID						= @jobId
				WHERE	MDBComputerNamePrefix		= @MDBName

				COMMIT TRANSACTION
				GOTO EndSave
				QuitWithRollback:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSave:
		END


END



GO