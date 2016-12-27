
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.CreateSDBJob'), 0) > 0 
	DROP PROCEDURE dbo.CreateSDBJob
GO

CREATE PROCEDURE [dbo].[CreateSDBJob]
		@RegionID					INT,
		@SDBSourceID				INT,
		@SDBName					VARCHAR(100),
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
// Module:  dbo.CreateSDBJob
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a SQL Job that will ETL data from a specified logical SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateSDBJob.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateSDBJob	
//								@RegionID = 1, 
//								@SDBSourceID = 1,
//								@SDBName = 'MSSNKNLSDB001', 
//								@JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD		= ''
//
*/ 
-- =============================================
BEGIN


		SET NOCOUNT ON;
		DECLARE @JobName NVARCHAR(100) -- = N'Region ' +CAST(@RegionID AS NVARCHAR(50)) + ' ' + @SDBName + N' MPEG Import'
		DECLARE @StepName NVARCHAR(100)
		DECLARE @StepCommand NVARCHAR(500)


		SELECT  @JobName		= Name + ' ' + @SDBName + N' MPEG Import'
		FROM	dbo.Region (NOLOCK) 
		WHERE	RegionID		= @RegionID

		IF EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs WHERE name = @JobName) 
		BEGIN

				UPDATE			dbo.SDBSource
				SET				JobID = j.job_id
				FROM			msdb.dbo.sysjobs j (NOLOCK)
				WHERE			SDBSourceID = @SDBSourceID 
				AND				JobName = @JobName
				AND				JobName = j.name
				
				RETURN

		END


		BEGIN TRANSACTION
		DECLARE @ReturnCode INT
		SELECT @ReturnCode = 0
		/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/09/2013 11:07:38 ******/
		IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
		BEGIN
		EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

		END

		DECLARE @jobId BINARY(16)
		EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
				@enabled=1, 
				@notify_level_eventlog=0, 
				@notify_level_email=0, 
				@notify_level_netsend=0, 
				@notify_level_page=0, 
				@delete_level=0, 
				@description=N'No description available.', 
				@category_name=N'[Uncategorized (Local)]', 
				@owner_login_name=@JobOwnerLoginName, @job_id = @jobId OUTPUT


		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		/****** Object:  Step [ImportBreakCountHistoryXXX]    Script Date: 09/09/2013 11:07:39 ******/

		SET		@StepName = N'Import SDB ' + CAST(@SDBSourceID AS VARCHAR(50))
		SET		@StepCommand = N'EXEC	DINGODB.dbo.ImportSDB @RegionID = ' + CAST(@RegionID AS NVARCHAR(50)) + ', @SDBSourceID = ' + CAST(@SDBSourceID AS VARCHAR(50)) + ', @JobRun = 1 ' 

		EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
				@step_id=1, 
				@cmdexec_success_code=0, 
				@on_success_action=1, 
				@on_success_step_id=0, 
				@on_fail_action=3, 
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
		EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

		UPDATE			dbo.SDBSource
		SET				JobID = j.job_id
		FROM			msdb.dbo.sysjobs j (NOLOCK)
		WHERE			SDBSourceID = @SDBSourceID 
		AND				JobName = @JobName
		AND				JobName = j.name

		COMMIT TRANSACTION
				
		GOTO EndSave
		QuitWithRollback:
			IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
		EndSave:


END



GO
