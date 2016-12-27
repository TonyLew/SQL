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
// Module:  DINGODB database Upgrade script.
// Created: 2014-Mar-11
// Author:  Nigel Brownett
// 
// Purpose: Database Upgrade.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id$
//    
//
*/ 

USE [DINGODB]
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Dropping extended properties'
GO
EXEC sp_dropextendedproperty N'MS_Description', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'CreateDate'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_dropextendedproperty N'MS_Description', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'Description'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_dropextendedproperty N'MS_Description', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'MarketID'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_dropextendedproperty N'MS_Description', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'Name'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_dropextendedproperty N'MS_Description', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'UpdateDate'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[SDB_Market]'
GO
ALTER TABLE [dbo].[SDB_Market] DROP CONSTRAINT [FK_SDB_Market_MarketID_-->_Market_MarketID]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[ZONE_MAP]'
GO
ALTER TABLE [dbo].[ZONE_MAP] DROP CONSTRAINT [FK_ZONE_MAP_MarketID_-->_Market_MarketID]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[ChannelStatus]'
GO
ALTER TABLE [dbo].[ChannelStatus] DROP CONSTRAINT [FK_ChannelStatus_SDBSourceID_-->_SDBSource_SDBSourceID]
ALTER TABLE [dbo].[ChannelStatus] DROP CONSTRAINT [FK_ChannelStatus_RegionalizedZoneID_-->_REGIONALIZED_ZONE_REGIONALIZED_ZONE_ID]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[Market]'
GO
ALTER TABLE [dbo].[Market] DROP CONSTRAINT [PK_Market]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [NC_CacheStatus_SDBSourceID_UpdateDate_CacheStatusTypeID] from [dbo].[CacheStatus]'
GO
DROP INDEX [NC_CacheStatus_SDBSourceID_UpdateDate_CacheStatusTypeID] ON [dbo].[CacheStatus]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i] from [dbo].[ChannelStatus]'
GO
DROP INDEX [UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i] ON [dbo].[ChannelStatus]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [NC_Conflict_SDBSourceID_Time_i] from [dbo].[Conflict]'
GO
DROP INDEX [NC_Conflict_SDBSourceID_Time_i] ON [dbo].[Conflict]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [NC_Conflict_Time_SDBSourceID_i] from [dbo].[Conflict]'
GO
DROP INDEX [NC_Conflict_Time_SDBSourceID_i] ON [dbo].[Conflict]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [UNC_Market_Name] from [dbo].[Market]'
GO
DROP INDEX [UNC_Market_Name] ON [dbo].[Market]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[CreateMDBJob]'
GO
ALTER PROCEDURE [dbo].[CreateMDBJob]
  @RegionID     INT,
  @RegionIDPK     INT,
  @MDBName     VARCHAR(100),
  @JobOwnerLoginName   NVARCHAR(100),
  @JobOwnerLoginPWD   NVARCHAR(100)

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
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.CreateMDBJob.proc.sql 3162 2013-11-22 18:50:10Z tlew $
//    
//  Usage:
//
//    EXEC DINGODB.dbo.CreateMDBJob 
//        @RegionID = 1, 
//        @RegionIDPK = 4,
//        @MDBName = 'MSSNKNLMDB001', 
//        @JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//        @JobOwnerLoginPWD = N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


  SET NOCOUNT ON;
  DECLARE @JobNameAllRegional NVARCHAR(100)    = N'Update Regional Info'
  DECLARE @JobName NVARCHAR(100)       = N'Region ' + CAST(@RegionID AS NVARCHAR(50)) + N' Job Executor'
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

    SELECT  @StepName        = N'Import MDB', 
       @StepCommand       = N'DECLARE @UTC_Cutoff_Day DATE ' + 
                 'SET @UTC_Cutoff_Day = DATEADD(DAY, -2, GETUTCDATE()) ' +
                 'EXEC DINGODB.dbo.UpdateRegionalInfo ' + 
                 '  @JobOwnerLoginName = NULL, ' +
                 '  @JobOwnerLoginPWD = NULL, ' +
                 '  @UTC_Cutoff_Day = @UTC_Cutoff_Day, ' +
                 '  @JobRun = 1' 

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

    SELECT  @StepName        = N'Step 1 - Launch Child jobs for Region ' + CAST(@RegionID AS NVARCHAR(50)), 
       @StepCommand       = N'EXEC DINGODB.dbo.ExecuteRegionChannelJobs @RegionID = ' + CAST(@RegionIDPK AS NVARCHAR(50)),
       @jobId        = NULL

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

    UPDATE dbo.MDBSource
    SET  JobID      = @jobId
    WHERE MDBComputerNamePrefix  = @MDBName

    COMMIT TRANSACTION
    GOTO EndSave
    QuitWithRollback:
     IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
    EndSave:
  END


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[DeriveDBPrefix]'
GO
ALTER FUNCTION [dbo].[DeriveDBPrefix] ( @str VARCHAR(50), @token VARCHAR(5) )
 RETURNS VARCHAR(50)
 WITH EXECUTE AS CALLER
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
// Module:  dbo.DeriveDBPrefix
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Extract DB server name prefix
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id$
//    
//  Usage:
//    DECLARE   @str VARCHAR(50) = 'MSSNKNSDBP033'
//    DECLARE   @token VARCHAR(5) = 'p'
//    SELECT   dbo.DeriveDBPrefix ( @str, @token )
//
*/ 
BEGIN

  DECLARE  @strret VARCHAR(50)
  DECLARE  @ipos INT = CHARINDEX(@token,REVERSE(@str),1)
  SELECT  @strret = SUBSTRING(@str, 1, LEN(@str)- @ipos) +  CAST( SUBSTRING(@str, LEN(@str)-@ipos+2, LEN(@str) ) AS VARCHAR(50) ) 
  RETURN  (@strret)

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[CreateMDBLinkedServer]'
GO
ALTER PROCEDURE [dbo].[CreateMDBLinkedServer]
  @MDBPrimaryName    NVARCHAR(50),
  @MDBSecondaryName   NVARCHAR(50),
  @JobOwnerLoginName   NVARCHAR(100),
  @JobOwnerLoginPWD   NVARCHAR(100)
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
// Module:  dbo.CreateMDBLinkedServer
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Linked Server for each physical MDB server
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.CreateMDBLinkedServer.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    EXEC DINGODB.dbo.CreateMDBLinkedServer 
//        @MDBPrimaryName  = 'MSSNKNLMDB001P',
//        @MDBSecondaryName = 'MSSNKNLMDB001B',
//        @JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//        @JobOwnerLoginPWD = ''
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @MDBPrimaryName)
  BEGIN
      EXEC  sp_addlinkedserver @MDBPrimaryName, N'SQL Server'
      EXEC  sp_addlinkedsrvlogin 
           @rmtsrvname = @MDBPrimaryName, 
           @locallogin = N'sa', 
           @useself = N'False', 
           @rmtuser = @JobOwnerLoginName, 
           @rmtpassword = @JobOwnerLoginPWD
  END

  IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @MDBSecondaryName)
  BEGIN
      EXEC  sp_addlinkedserver @MDBSecondaryName, N'SQL Server'
      EXEC  sp_addlinkedsrvlogin 
           @rmtsrvname = @MDBSecondaryName, 
           @locallogin = N'sa', 
           @useself = N'False', 
           @rmtuser = @JobOwnerLoginName, 
           @rmtpassword = @JobOwnerLoginPWD
  END


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[AddNewMDBNode]'
GO
ALTER PROCEDURE dbo.AddNewMDBNode
  @MDBPrimaryName  NVARCHAR(50),
  @MDBSecondaryName NVARCHAR(50),
  @RegionID   INT,
  @JobOwnerLoginName NVARCHAR(100),
  @JobOwnerLoginPWD NVARCHAR(100)
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
// Module:  dbo.AddNewMDBNode
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Adds a new MDB node (Primary and Backup) for a specified Region.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.AddNewMDBNode.proc.sql 3241 2013-12-09 18:17:13Z tlew $
//    
//  Usage:
//
//    EXEC dbo.AddNewMDBNode 
//        @MDBPrimaryName   = 'MSSNKNLMDB001P',
//        @MDBSecondaryName  = 'MSSNKNLMDB001B',
//        @RegionID    = 3,
//        @JobOwnerLoginName  = N'nbrownett@mcc2-lailab',
//        @JobOwnerLoginPWD  = N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
   SET NOCOUNT ON;

   DECLARE  @CMD NVARCHAR(1000)
   DECLARE  @i INT
   DECLARE  @NodeID INT
   DECLARE  @RegionIDPK INT
   DECLARE  @MDBNodeID INT
   DECLARE  @MDBSourceID INT
   DECLARE  @NewMDBSourceID INT
   DECLARE  @MDBComputerNamePrefix VARCHAR(50)
   DECLARE  @MDBTotalRowsResult INT
   DECLARE  @RegionName VARCHAR(50) = 'Region ' + CAST( @RegionID AS VARCHAR(50))

   IF   ( ISNULL(@MDBPrimaryName, '') = '' OR ISNULL(@MDBSecondaryName, '') = '' ) RETURN

   SELECT  @MDBComputerNamePrefix  = dbo.DeriveDBPrefix ( @MDBPrimaryName, 'P' )

   IF   NOT EXISTS (
         SELECT   TOP 1 1
         FROM   dbo.Region r (NOLOCK)
         WHERE    r.Name    = @RegionName
        )
   BEGIN
      INSERT  dbo.Region ( Name )
      SELECT  y.Name
      FROM  dbo.Region x (NOLOCK)
      RIGHT JOIN (
          SELECT Name = 'Region ' + CAST( @RegionID AS VARCHAR(50))
         ) y
      ON   x.Name        = y.Name
      WHERE  x.RegionID IS NULL
      SELECT  @RegionIDPK       = SCOPE_IDENTITY()
   END
   ELSE
      SELECT  TOP 1 @RegionIDPK     = r.RegionID
      FROM  dbo.Region r (NOLOCK)
      WHERE   r.Name        = @RegionName


   --If the MDBLogical node already exists, then it must remain with its original region
   IF   NOT EXISTS ( 
          SELECT   TOP 1 1
          FROM   dbo.MDBSource m (NOLOCK)
          WHERE    m.MDBComputerNamePrefix = @MDBComputerNamePrefix
         )
   BEGIN   

      BEGIN TRY
         INSERT  dbo.MDBSource ( RegionID, MDBComputerNamePrefix, NodeID, JobName )
         SELECT  RegionID       = @RegionIDPK,
            MDBComputerNamePrefix    = @MDBComputerNamePrefix,
            NodeID        = SUBSTRING( @MDBComputerNamePrefix, LEN(@MDBComputerNamePrefix)-2, LEN(@MDBComputerNamePrefix)),
            JobName        = @RegionName + ' Job Executor' 
         SELECT  @MDBSourceID      = SCOPE_IDENTITY()

         INSERT  dbo.MDBSourceSystem ( MDBSourceID, MDBComputerName, Role, Status, Enabled )
         SELECT  
            MDBSourceID       = @MDBSourceID,
            MDBComputerName      = @MDBPrimaryName,
            Role        = 1,
            Status        = 1,
            Enabled        = 1
         UNION ALL
         SELECT
            MDBSourceID       = @MDBSourceID,
            MDBComputerName      = @MDBSecondaryName,
            Role        = 2,
            Status        = 1,
            Enabled        = 1
      END TRY
      BEGIN CATCH
      END CATCH

   END

   EXEC  dbo.CreateMDBLinkedServer 
            @MDBPrimaryName   = @MDBPrimaryName,
            @MDBSecondaryName  = @MDBSecondaryName,
            @JobOwnerLoginName  = @JobOwnerLoginName,
            @JobOwnerLoginPWD  = @JobOwnerLoginPWD


   EXEC  dbo.CreateMDBJob 
            @RegionID    = @RegionID, 
            @RegionIDPK    = @RegionIDPK, 
            @MDBName    = @MDBComputerNamePrefix,
            @JobOwnerLoginName  = @JobOwnerLoginName,
            @JobOwnerLoginPWD  = @JobOwnerLoginPWD



END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetSDBList]'
GO
ALTER PROCEDURE [dbo].[GetSDBList] 
  @MDBNameActive VARCHAR(50),
  @TotalRows INT OUTPUT 
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
// Module:  dbo.GetSDBList
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Populates a parent SPs temp table named #ResultsALLSDBLogical with all
//     SDBs of the given region's HAdb tables.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetSDBList.proc.sql 3913 2014-04-09 00:21:15Z tlew $
//    
//  Usage:
//
//    DECLARE   @TotalRows INT
//    DECLARE   @MDBNameActive VARCHAR(50) = 'MSSNKNSDBP033P'
//    EXEC   dbo.GetSDBList 
//        @MDBNameActive = @MDBNameActive,
//        @TotalRows  = @TotalRows OUTPUT 
//
*/ 
BEGIN

  DECLARE  @CMD NVARCHAR(2000)

  SET   @CMD = 
       'INSERT #ResultsALLSDBLogical ( SDBLogicalState, PrimaryComputerName, PRoleValue, PStatusValue, PSoftwareVersion, BackupComputerName, BRoleValue, BStatusValue, BSoftwareVersion ) ' +
       'SELECT   SDBLogicalState   = g.State, ' +
       '    PrimaryComputerName  = p.ComputerName ,  ' +
       '    PRoleValue    = 1, ' +
       '    PStatusValue   =  ' +
       '           CASE ' +
       '             WHEN g.State = 1 THEN 1 ' +
       '             WHEN g.State = 5 THEN 0 ' +
       '             ELSE 0 ' +
       '           END, ' +
       '    PSoftwareVersion  = ISNULL(p.SoftwareVersion, ''''), ' +
       '    BackupComputerName  = b.ComputerName, ' +
       '    BRoleValue    = 2, ' +
       '    BStatusValue   =  ' +
       '           CASE ' +
       '             WHEN g.State = 1 THEN 0 ' +
       '             WHEN g.State = 5 THEN 1 ' +
       '             ELSE 0 ' +
       '           END, ' +
       '    BSoftwareVersion  = ISNULL(b.SoftwareVersion, '''') ' +
       'FROM   [' + @MDBNameActive + '].HAdb.dbo.HAGroup g WITH (NOLOCK) ' +
       'LEFT JOIN  [' + @MDBNameActive + '].HAdb.dbo.HAMachine p WITH (NOLOCK) ' +
       'ON    g.Primary_ID = p.ID ' +
       'LEFT JOIN  [' + @MDBNameActive + '].HAdb.dbo.HAMachine b WITH (NOLOCK) ' +
       'ON    g.Backup_ID = b.ID ' +
       'WHERE   p.SystemType = 13 ' +
       'AND   b.SystemType = 13 ' +
	   'AND	ISNULL(p.SoftwareVersion, '''') <> ''''' +
	   'AND	ISNULL(b.SoftwareVersion, '''') <> ''''' 

  EXECUTE  sp_executesql @CMD 
  SELECT  @TotalRows  = @@ROWCOUNT

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[CreateSDBLinkedServer]'
GO
ALTER PROCEDURE [dbo].[CreateSDBLinkedServer]
  @SDBSourceID    INT,
  @JobOwnerLoginName   NVARCHAR(100) = NULL,
  @JobOwnerLoginPWD   NVARCHAR(100) = NULL
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
// Module:  dbo.CreateSDBLinkedServer
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Linked Server for each physical SDB server
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.CreateSDBLinkedServer.proc.sql 3245 2013-12-09 19:34:42Z tlew $
//    
//  Usage:
//
//    EXEC DINGODB.dbo.CreateSDBLinkedServer 
//        @SDBSourceID = 1,
//        @JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//        @JobOwnerLoginPWD = ''
//
*/ 
-- =============================================
BEGIN


  SET NOCOUNT ON;
  DECLARE   @SDBNamePrimaryIn NVARCHAR(100)
  DECLARE   @SDBNameSecondaryIn NVARCHAR(100)

  SELECT   @SDBNamePrimaryIn   = b.SDBComputerName
  FROM   dbo.SDBSource a (NOLOCK)
  JOIN   dbo.SDBSourceSystem b (NOLOCK)
  ON    a.SDBSourceID    = b.SDBSourceID
  WHERE    a.SDBSourceID    = @SDBSourceID
  AND    b.Role      = 1

  SELECT   @SDBNameSecondaryIn   = b.SDBComputerName
  FROM   dbo.SDBSource a (NOLOCK)
  JOIN   dbo.SDBSourceSystem b (NOLOCK)
  ON    a.SDBSourceID    = b.SDBSourceID
  WHERE    a.SDBSourceID    = @SDBSourceID
  AND    b.Role      = 2

  IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @SDBNamePrimaryIn)
  BEGIN

      EXEC  sp_addlinkedserver @SDBNamePrimaryIn, N'SQL Server'
      EXEC  sp_addlinkedsrvlogin 
           @rmtsrvname   = @SDBNamePrimaryIn, 
           @locallogin   = N'sa', 
           @useself   = N'False', 
           @rmtuser   = @JobOwnerLoginName, 
           @rmtpassword  = @JobOwnerLoginPWD

  END

  IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @SDBNameSecondaryIn)
  BEGIN

      EXEC  sp_addlinkedserver @SDBNameSecondaryIn, N'SQL Server'
      EXEC  sp_addlinkedsrvlogin 
           @rmtsrvname   = @SDBNameSecondaryIn, 
           @locallogin   = N'sa', 
           @useself   = N'False', 
           @rmtuser   = @JobOwnerLoginName, 
           @rmtpassword  = @JobOwnerLoginPWD

  END


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[CreateSDBJob]'
GO
ALTER PROCEDURE [dbo].[CreateSDBJob]
  @RegionID     INT,
  @SDBSourceID    INT,
  @SDBName     VARCHAR(100),
  @JobOwnerLoginName   NVARCHAR(100),
  @JobOwnerLoginPWD   NVARCHAR(100)
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
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.CreateSDBJob.proc.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//  Usage:
//
//    EXEC DINGODB.dbo.CreateSDBJob 
//        @RegionID = 1, 
//        @SDBSourceID = 1,
//        @SDBName = 'MSSNKNLSDB001', 
//        @JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//        @JobOwnerLoginPWD  = ''
//
*/ 
-- =============================================
BEGIN


  SET NOCOUNT ON;
  DECLARE @JobName NVARCHAR(100) -- = N'Region ' +CAST(@RegionID AS NVARCHAR(50)) + ' ' + @SDBName + N' MPEG Import'
  DECLARE @StepName NVARCHAR(100)
  DECLARE @StepCommand NVARCHAR(500)


  SELECT  @JobName  = Name + ' ' + @SDBName + N' MPEG Import'
  FROM dbo.Region (NOLOCK) 
  WHERE RegionID  = @RegionID

  IF EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs WHERE name = @JobName) 
  BEGIN

    UPDATE   dbo.SDBSource
    SET    JobID = j.job_id
    FROM   msdb.dbo.sysjobs j (NOLOCK)
    WHERE   SDBSourceID = @SDBSourceID 
    AND    JobName = @JobName
    AND    JobName = j.name
    
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

  SET  @StepName = N'Import SDB ' + CAST(@SDBSourceID AS VARCHAR(50))
  SET  @StepCommand = N'EXEC DINGODB.dbo.ImportSDB @RegionID = ' + CAST(@RegionID AS NVARCHAR(50)) + ', @SDBSourceID = ' + CAST(@SDBSourceID AS VARCHAR(50)) + ', @JobRun = 1 ' 

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

  UPDATE   dbo.SDBSource
  SET    JobID = j.job_id
  FROM   msdb.dbo.sysjobs j (NOLOCK)
  WHERE   SDBSourceID = @SDBSourceID 
  AND    JobName = @JobName
  AND    JobName = j.name

  COMMIT TRANSACTION
    
  GOTO EndSave
  QuitWithRollback:
   IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
  EndSave:


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[AddNewSDBNode]'
GO
ALTER PROCEDURE dbo.AddNewSDBNode
  @MDBName   NVARCHAR(50),
  @RegionID   INT,
  @JobOwnerLoginName NVARCHAR(100),
  @JobOwnerLoginPWD NVARCHAR(100)
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
// Module:  dbo.AddNewSDBNode
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Adds a new SDB node (Primary and Backup) if any exists.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.AddNewSDBNode.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//  Usage:
//
//    EXEC dbo.AddNewSDBNode 
//        @MDBName = 'MSSNKNLMDB001P',
//        @RegionID = 1,
//        @JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//        @JobOwnerLoginPWD = N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;

  DECLARE  @CMD NVARCHAR(1000)
  DECLARE  @i INT
  DECLARE  @NodeID INT
  DECLARE  @MDBNodeID INT
  DECLARE  @MDBSourceID INT
  DECLARE  @SDBSourceID INT
  DECLARE  @SDBComputerNamePrefix VARCHAR(50)
  DECLARE  @SDBRegionName VARCHAR(100)
  DECLARE  @SDBTotalRowsResult INT

  SELECT   @MDBSourceID   = MDBSourceID,
      @MDBNodeID    = a.NodeID,
      @SDBRegionName   = b.Name
  FROM   dbo.MDBSource a (NOLOCK)
  JOIN   dbo.Region b (NOLOCK)
  ON    a.RegionID    = b.RegionID
  WHERE    a.RegionID    = @RegionID

  

  IF OBJECT_ID('tempdb..#ResultsALLSDBLogical') IS NOT NULL
   DROP TABLE #ResultsALLSDBLogical
  CREATE TABLE #ResultsALLSDBLogical ( ID INT IDENTITY(1,1), SDBLogicalState INT, PrimaryComputerName VARCHAR(32), PRoleValue INT, PStatusValue INT, PSoftwareVersion VARCHAR(32), BackupComputerName VARCHAR(32), BRoleValue INT, BStatusValue INT, BSoftwareVersion VARCHAR(32) )
  IF OBJECT_ID('tempdb..#ResultsALLSDB') IS NOT NULL
   DROP TABLE #ResultsALLSDB
  CREATE TABLE #ResultsALLSDB ( ID INT IDENTITY(1,1), SDBComputerNamePrefix VARCHAR(32), SDBComputerName VARCHAR(32), SDBComputerNameLength INT, Role INT, Status TINYINT )
  IF OBJECT_ID('tempdb..#ResultsNew') IS NOT NULL
   DROP TABLE #ResultsNew
  CREATE TABLE #ResultsNew ( ID INT IDENTITY(1,1), SDBComputerNamePrefix VARCHAR(32), SDBComputerName VARCHAR(32), Role INT, Status TINYINT )
  IF OBJECT_ID('tempdb..#ResultsNewNode') IS NOT NULL
   DROP TABLE #ResultsNewNode
  CREATE TABLE #ResultsNewNode ( ID INT IDENTITY(1,1), SDBSourceID INT, SDBLocalTime DATETIMEOFFSET, SDBComputerNamePrefix VARCHAR(32) )

  --    Get all the existent SDB systems for this Region
  EXEC   dbo.GetSDBList 
        @MDBNameActive = @MDBName,
        @TotalRows  = @SDBTotalRowsResult OUTPUT
  IF ( ISNULL(@SDBTotalRowsResult, 0) = 0) RETURN


  --    Identify the new SDB systems
  INSERT   #ResultsNew ( SDBComputerNamePrefix, SDBComputerName, Role, Status )
  SELECT   SDBComputerNamePrefix = CASE WHEN a.Role = 1 THEN dbo.DeriveDBPrefix ( a.SDBComputerName, 'P' )
              ELSE dbo.DeriveDBPrefix ( a.SDBComputerName, 'B' )
             END,
      SDBComputerName   = a.SDBComputerName,
      a.Role,
      a.Status
  FROM   (
        SELECT  PrimaryComputerName AS SDBComputerName, PRoleValue AS Role, PStatusValue AS Status
        FROM  #ResultsALLSDBLogical x
        UNION
        SELECT  BackupComputerName AS SDBComputerName, BRoleValue AS Role, BStatusValue AS Status
        FROM  #ResultsALLSDBLogical y
      ) a
  LEFT JOIN  dbo.SDBSourceSystem b (NOLOCK)
  ON    a.SDBComputerName  = b.SDBComputerName
  WHERE   b.SDBSourceSystemID  IS NULL

  BEGIN TRAN

  --    If new SDB systems exist, first insert all new SDB nodes
  INSERT   dbo.SDBSource
     (
      MDBSourceID,
      SDBComputerNamePrefix,
      NodeID,
      JobName
     )
  SELECT   MDBSourceID    = @MDBSourceID,
      SDBComputerNamePrefix = a.SDBComputerNamePrefix,
      NodeID     = SUBSTRING( a.SDBComputerNamePrefix, LEN(a.SDBComputerNamePrefix)-2, LEN(a.SDBComputerNamePrefix)),
      JobName     = @SDBRegionName + ' ' + a.SDBComputerNamePrefix + ' MPEG Import' 
  FROM   (
        SELECT  SDBComputerNamePrefix
        FROM  #ResultsNew
        GROUP BY SDBComputerNamePrefix
      ) a

  --    Now insert SDB systems
  INSERT   dbo.SDBSourceSystem
     (
      SDBSourceID,
      SDBComputerName,
      Role,
      Status,
      Enabled
     )
  SELECT   
      SDBSourceID    = b.SDBSourceID,
      SDBComputerName   = a.SDBComputerName,
      a.Role,
      a.Status,
      Enabled     = 1
  FROM   #ResultsNew a
  JOIN   dbo.SDBSource b (NOLOCK)
  ON    a.SDBComputerNamePrefix = b.SDBComputerNamePrefix

  COMMIT


  --    For each new node pair, prepare to create the job.
  INSERT   #ResultsNewNode ( SDBSourceID, SDBComputerNamePrefix )
  SELECT   a.SDBSourceID, a.SDBComputerNamePrefix
  FROM   dbo.SDBSource a (NOLOCK)
  WHERE   a.JobID IS NULL

  SELECT   TOP 1 @i = a.ID FROM #ResultsNewNode a ORDER BY a.ID DESC

  --    For each new node, create the associated job.
  WHILE   ( @i > 0 )
  BEGIN

      SELECT TOP 1 @SDBSourceID     = SDBSourceID, 
          @SDBComputerNamePrefix   = a.SDBComputerNamePrefix
      FROM   #ResultsNewNode a 
      WHERE   a.ID = @i

      EXEC   dbo.CreateSDBJob 
            @RegionID    = @RegionID, 
            @SDBSourceID   = @SDBSourceID, 
            @SDBName    = @SDBComputerNamePrefix,
            @JobOwnerLoginName  = @JobOwnerLoginName,
            @JobOwnerLoginPWD  = @JobOwnerLoginPWD

      EXEC   dbo.CreateSDBLinkedServer 
            @SDBSourceID   = @SDBSourceID, 
            @JobOwnerLoginName  = @JobOwnerLoginName,
            @JobOwnerLoginPWD  = @JobOwnerLoginPWD

      SET    @i = @i - 1

  END

  DROP TABLE #ResultsALLSDBLogical
  DROP TABLE #ResultsALLSDB
  DROP TABLE #ResultsNew
  DROP TABLE #ResultsNewNode


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[LogEvent]'
GO
ALTER PROCEDURE [dbo].[LogEvent]
  @LogID     INT     = NULL,
  @EventLogStatusID  INT     = NULL,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(200)  = NULL,
  @DBID     INT     = NULL,
  @DBComputerName   VARCHAR(50)   = NULL,
  @Description   VARCHAR(200)  = NULL,
  @LogIDOUT    INT     = NULL OUTPUT
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
// Module:  dbo.LogEvent
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Interface to the DINGODB EventLog for universal logging.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id$
//    
//  Usage:
//
//    DECLARE @LogIDReturn INT
//    EXEC dbo.LogEvent 
//       @LogID     = NULL,
//       @EventLogStatusID  = 1,
//       @JobID     = NULL,
//       @JobName    = NULL,
//       @DBID     = NULL,
//       @DBComputerName   = NULL,
//       @LogIDOUT    = @LogIDReturn OUTPUT
//    
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;
  DECLARE  @CMD   NVARCHAR(4000)
  DECLARE  @ComputerName VARCHAR(50)

  IF (@EventLogStatusID IS NULL AND @LogID IS NULL) RETURN --Nothing to log

  IF (@LogID IS NULL)
  BEGIN
     INSERT  dbo.EventLog
        (
         EventLogStatusID,
         JobID,
         JobName,
         DBID,
         DBComputerName,
         StartDate
        )
     SELECT 
         @EventLogStatusID  AS EventLogStatusID,
         @JobID     AS JobID,
         @JobName    AS JobName,
         @DBID     AS DBID,
         @DBComputerName   AS DBComputerName,
         GETUTCDATE()   AS StartDate

     SELECT  @LogIDOUT = @@IDENTITY
  END  
  ELSE
  BEGIN
     UPDATE  dbo.EventLog
     SET   FinishDate     = GETUTCDATE(),
        EventLogStatusID   = ISNULL(@EventLogStatusID, EventLogStatusID),
        Description     = @Description
     WHERE  EventLogID     = @LogID
  END


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetActiveMDB]'
GO
ALTER PROCEDURE [dbo].[GetActiveMDB]
  @MDBSourceID   INT,
  @JobID     UNIQUEIDENTIFIER,
  @JobName    NVARCHAR(200),
  @MDBNameActive   VARCHAR(32) OUT
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
// Module:  dbo.GetActiveMDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the computer name of the active node for the given MDB logical node 
//   for both the definition table retrieval and for HAdb access
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetActiveMDB.proc.sql 2960 2013-10-28 20:55:37Z tlew $
//    
//  Usage:
//
//    DECLARE @MDBNameActiveResult VARCHAR(50)
//    EXEC dbo.GetActiveMDB 
//      @MDBSourceID    = 1,
//      @JobID      = '', 
//      @JobName     = 'JobName', 
//      @MDBNameActive    = @MDBNameActiveResult OUTPUT
//    SELECT @MDBNameActiveResult
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;

  DECLARE  @CMD           NVARCHAR(1000)
  DECLARE  @CMDOUT          NVARCHAR(30)
  DECLARE  @StatusPOUT         NVARCHAR(30)
  DECLARE  @StatusBOUT         NVARCHAR(30)
  DECLARE  @ParmDefinition        NVARCHAR(500)
  DECLARE  @MDBNamePrimary        VARCHAR(32)
  DECLARE  @MDBNameSecondary        VARCHAR(32)
  DECLARE  @EventLogStatusID       INT
  DECLARE  @LogIDReturn        INT

  SELECT  @MDBNameActive  = NULL
  
  SELECT   @MDBNamePrimary       = a.MDBComputerName
  FROM   dbo.MDBSourceSystem a (NOLOCK)
  WHERE    a.MDBSourceID       = @MDBSourceID
  AND    a.Role         = 1
  AND    a.Enabled        = 1 

  SELECT   @MDBNameSecondary      = a.MDBComputerName
  FROM   dbo.MDBSourceSystem a (NOLOCK)
  WHERE    a.MDBSourceID       = @MDBSourceID
  AND    a.Role         = 2
  AND    a.Enabled        = 1 

  BEGIN TRY
   SET    @CMD = 'SELECT TOP 1 @Status = ''Ready'' ' +
         'FROM [' + @MDBNamePrimary + '].HAdb.dbo.HAMachine WITH (NOLOCK) '
   SET    @ParmDefinition = N'@Status varchar(30) OUTPUT'
   EXECUTE   sp_executesql @CMD, @ParmDefinition, @Status = @CMDOUT OUTPUT
   IF    ( @CMDOUT = 'Ready') SELECT  @MDBNameActive = @MDBNamePrimary

  END TRY
  BEGIN CATCH

      SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Primary MDB Failure'
      EXEC  dbo.LogEvent 
           @LogID    = NULL,
           @EventLogStatusID = @EventLogStatusID,   ----Log Failure
           @JobID    = @JobID,
           @JobName   = @JobName,
           @DBID    = @MDBSourceID,
           @DBComputerName  = @MDBNamePrimary, 
           @LogIDOUT   = @LogIDReturn OUTPUT
      EXEC  dbo.LogEvent 
           @LogID    = @LogIDReturn, 
           @EventLogStatusID = @EventLogStatusID, 
           @Description  = NULL
      SELECT  @MDBNameActive    = NULL

  END CATCH

  IF   ( @MDBNameActive IS NULL )
  BEGIN
     BEGIN TRY
      SET    @CMD = 'SELECT TOP 1 @Status = ''Ready'' ' +
            'FROM [' + @MDBNamePrimary + '].HAdb.dbo.HAMachine WITH (NOLOCK) '
      SET    @ParmDefinition = N'@Status varchar(30) OUTPUT'
      EXECUTE   sp_executesql @CMD, @ParmDefinition, @Status = @CMDOUT OUTPUT
      IF    ( @CMDOUT = 'Ready') SELECT  @MDBNameActive = @MDBNameSecondary
      ELSE         SELECT  @MDBNameActive = NULL

     END TRY
     BEGIN CATCH

      SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Secondary MDB Failure'
      EXEC  dbo.LogEvent 
           @LogID    = NULL,
           @EventLogStatusID = @EventLogStatusID,   ----Log Failure
           @JobID    = @JobID,
           @JobName   = @JobName,
           @DBID    = @MDBSourceID,
           @DBComputerName  = @MDBNameSecondary,
           @LogIDOUT   = @LogIDReturn OUTPUT
      EXEC  dbo.LogEvent 
           @LogID    = @LogIDReturn, 
           @EventLogStatusID = @EventLogStatusID, 
           @Description  = NULL
      SELECT  @MDBNameActive    = NULL

     END CATCH
  END


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ChannelStatus]'
GO
ALTER TABLE [dbo].[ChannelStatus] ADD
[MTE_Conflicts_Window1] [int] NULL,
[MTE_Conflicts_Window2] [int] NULL,
[MTE_Conflicts_Window3] [int] NULL,
[MTE_ICConflicts_Window1] [int] NULL,
[MTE_ICConflicts_Window2] [int] NULL,
[MTE_ICConflicts_Window3] [int] NULL,
[MTE_ATTConflicts_Window1] [int] NULL,
[MTE_ATTConflicts_Window2] [int] NULL,
[MTE_ATTConflicts_Window3] [int] NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ChannelStatus] ALTER COLUMN [ATT_DTM_NoTone_Count] [int] NULL
ALTER TABLE [dbo].[ChannelStatus] ALTER COLUMN [IC_DTM_NoTone_Count] [int] NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i] on [dbo].[ChannelStatus]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i] ON [dbo].[ChannelStatus] ([SDBSourceID], [Enabled], [IU_ID], [RegionalizedZoneID]) INCLUDE ([ATT_BreakCount], [ATT_DTM_Failed_Rate], [ATT_DTM_NoTone_Rate], [ATT_DTM_Run_Rate], [ATT_Forecast_Best_Run_Rate], [ATT_Forecast_Worst_Run_Rate], [ATT_NextDay_BreakCount], [ATT_NextDay_Forecast_Run_Rate], [ATTConflictsNextDay], [ATTTotal], [ATTTotalNextDay], [Average_BreakCount], [ConflictsNextDay], [Consecutive_Error_Count], [Consecutive_NoTone_Count], [DTM_ATTFailed], [DTM_ATTNoTone], [DTM_ATTPlayed], [DTM_ATTTotal], [DTM_Failed], [DTM_Failed_Rate], [DTM_ICFailed], [DTM_ICNoTone], [DTM_ICPlayed], [DTM_ICTotal], [DTM_NoTone], [DTM_NoTone_Rate], [DTM_Played], [DTM_Run_Rate], [DTM_Total], [Forecast_Best_Run_Rate], [Forecast_Worst_Run_Rate], [IC_BreakCount], [IC_DTM_Failed_Rate], [IC_DTM_NoTone_Rate], [IC_DTM_Run_Rate], [IC_Forecast_Best_Run_Rate], [IC_Forecast_Worst_Run_Rate], [IC_NextDay_BreakCount], [IC_NextDay_Forecast_Run_Rate], [ICConflictsNextDay], [ICTotal], [ICTotalNextDay], [MTE_ATTConflicts], [MTE_ATTConflicts_Window1], [MTE_ATTConflicts_Window2], [MTE_ATTConflicts_Window3], [MTE_Conflicts], [MTE_Conflicts_Window1], [MTE_Conflicts_Window2], [MTE_Conflicts_Window3], [MTE_ICConflicts], [MTE_ICConflicts_Window1], [MTE_ICConflicts_Window2], [MTE_ICConflicts_Window3], [NextDay_Forecast_Run_Rate], [TotalInsertionsNextDay], [TotalInsertionsToday], [UpdateDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[DeleteSDB]'
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = N'P' AND name = N'DeleteSDB')
DROP PROCEDURE dbo.DeleteSDB
GO

CREATE PROCEDURE dbo.DeleteSDB 
  @SDBSourceID   UDT_Int READONLY,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT

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
// Module:  dbo.DeleteSDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Populates a parent SPs temp table named #ResultsALLSDBLogical with all
//     SDBs of the given region's HAdb tables.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.DeleteSDB.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    DECLARE  @SDBSourceID_IN UDT_Int
//    INSERT  @SDBSourceID_IN ( Value ) VALUES ( 4 )
//    INSERT  @SDBSourceID_IN ( Value ) VALUES ( 5 )
//    INSERT  @SDBSourceID_IN ( Value ) VALUES ( 6 )
//    EXEC  dbo.DeleteSDB 
//        @SDBSourceID  = @SDBSourceID_IN,
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//
*/ 
BEGIN

    DECLARE  @LogIDReturn  INT
    DECLARE  @ErrNum    INT
    DECLARE  @ErrMsg    VARCHAR(200)
    DECLARE  @EventLogStatusID INT
    DECLARE  @SDBDeleteID  INT
    DECLARE  @CurrentJobName  NVARCHAR(200)
    DECLARE  @CurrentSDBSourceID INT

    SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB First Step'

    EXEC  dbo.LogEvent 
         @LogID    = NULL,
         @EventLogStatusID = @EventLogStatusID,
         @JobID    = @JobID,
         @JobName   = @JobName,
         @LogIDOUT   = @LogIDReturn OUTPUT

    --   This is simply as an identification.
    UPDATE  dbo.SDBSourceSystem
    SET   Enabled   = 2
    FROM  @SDBSourceID a
    WHERE  SDBSourceSystem.SDBSourceID = a.Value

    SELECT  TOP 1 @SDBDeleteID   = a.ID 
    FROM  @SDBSourceID a
    ORDER BY a.ID DESC

    WHILE  ( @SDBDeleteID > 0)
    BEGIN

       SELECT  @CurrentJobName = b.JobName
       FROM  @SDBSourceID a
       JOIN  dbo.SDBSource b (NOLOCK)
       ON   a.Value   = b.SDBSourceID
       WHERE  a.ID   = @SDBDeleteID
       
       IF   ( @CurrentJobName IS NOT NULL )
          EXEC  msdb.dbo.sp_delete_job @job_name = @CurrentJobName
       SELECT  @SDBDeleteID = @SDBDeleteID - 1,
          @CurrentJobName = NULL
       
    END

    BEGIN TRY


       IF   ( @SDBDeleteID IS NOT NULL )
       BEGIN
          BEGIN TRAN


             DELETE  dbo.SDB_IESPOT
             FROM  @SDBSourceID a
             WHERE  SDB_IESPOT.SDBSourceID   = a.Value

             DELETE  dbo.SDB_Market
             FROM  @SDBSourceID a
             WHERE  SDB_Market.SDBSourceID   = a.Value

             DELETE  dbo.CacheStatus
             FROM  @SDBSourceID a
             WHERE  CacheStatus.SDBSourceID   = a.Value

             DELETE  dbo.ChannelStatus
             FROM  @SDBSourceID a
             WHERE  ChannelStatus.SDBSourceID  = a.Value

             DELETE  dbo.Conflict
             FROM  @SDBSourceID a
             WHERE  Conflict.SDBSourceID   = a.Value

             DELETE  dbo.SDBSourceSystem
             FROM  @SDBSourceID a
             WHERE  SDBSourceSystem.SDBSourceID  = a.Value

             DELETE  dbo.SDBSource
             FROM  @SDBSourceID a
             WHERE  SDBSource.SDBSourceID   = a.Value
       

          COMMIT
       END

       SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB Success Step'

    END TRY
    BEGIN CATCH

       SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
       SET   @ErrorID = @ErrNum
       SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB Fail Step'
       ROLLBACK

    END CATCH

    EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ExecuteRegionChannelJobs]'
GO
ALTER PROCEDURE [dbo].[ExecuteRegionChannelJobs]
  @RegionID INT
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
// Module:  dbo.ExecuteRegionChannelJobs
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Starts the MDB ETL for each region.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.ExecuteRegionChannelJobs.proc.sql 3628 2014-03-07 18:45:44Z tlew $
//    
//  Usage:
//
//    EXEC DINGODB.dbo.ExecuteRegionChannelJobs 
//        @RegionID = 1 
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;

  DECLARE  @i          INT
  DECLARE  @JobID         UNIQUEIDENTIFIER
  DECLARE  @JobName        VARCHAR(100)
  DECLARE  @ErrNum        INT
  DECLARE  @JobCurrentStatus      INT
  DECLARE  @CMD         NVARCHAR(1000)
  DECLARE  @MDBSourceID      INT
  DECLARE  @MDBName       VARCHAR(32)
  DECLARE  @MDBNamePrimaryIn      VARCHAR(32)
  DECLARE  @MDBNameSecondaryIn     VARCHAR(32)
  DECLARE  @MDBNameActiveResult     VARCHAR(32)
  DECLARE  @SDBTotalRowsResult     INT
  DECLARE  @EventLogStatusID     INT
  DECLARE  @LogIDReturn      INT
  DECLARE  @SDBDelete       UDT_Int
  DECLARE  @SDBDeleteCount      INT


  IF OBJECT_ID('tempdb..#ResultsALLSDBLogical') IS NOT NULL
   DROP TABLE #ResultsALLSDBLogical
  CREATE TABLE #ResultsALLSDBLogical ( ID INT IDENTITY(1,1), SDBLogicalState INT, PrimaryComputerName VARCHAR(32), PRoleValue INT, PStatusValue INT, PSoftwareVersion VARCHAR(32), BackupComputerName VARCHAR(32), BRoleValue INT, BStatusValue INT, BSoftwareVersion VARCHAR(32) )

  IF OBJECT_ID('tempdb..#ResultsAll') IS NOT NULL
   DROP TABLE #ResultsAll
  CREATE TABLE #ResultsAll ( ID INT IDENTITY(1,1), SDBSourceID INT, SDBComputerName VARCHAR(50), Role INT, Status INT, SoftwareVersion VARCHAR(32) )

  IF OBJECT_ID('tempdb..#ResultsActive') IS NOT NULL
   DROP TABLE #ResultsActive
  CREATE TABLE #ResultsActive ( ID INT IDENTITY(1,1), SDBSourceID INT, SDBComputerName VARCHAR(50) )

  IF OBJECT_ID('tempdb..#ResultsDelete') IS NOT NULL
   DROP TABLE #ResultsDelete
  CREATE TABLE #ResultsDelete ( ID INT IDENTITY(1,1), SDBSourceID INT )

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


  SELECT   TOP 1 
      @MDBSourceID     = a.MDBSourceID,
      @JobID       = a.JobID,
      @JobName      = a.JobName
  FROM   dbo.MDBSource a (NOLOCK)  
  WHERE    a.RegionID      = @RegionID


  EXEC   dbo.GetActiveMDB 
       @MDBSourceID    = @MDBSourceID,
       @JobID      = @JobID,
       @JobName     = @JobName,
       @MDBNameActive    = @MDBNameActiveResult OUTPUT
  IF    ( @MDBNameActiveResult IS NULL ) RETURN

  EXEC   dbo.GetSDBList 
        @MDBNameActive   = @MDBNameActiveResult,
        @TotalRows    = @SDBTotalRowsResult OUTPUT
  IF    ( ISNULL(@SDBTotalRowsResult, 0) = 0) RETURN

  INSERT   #ResultsAll ( SDBSourceID, SDBComputerName, Role, Status, SoftwareVersion )
  SELECT   a.SDBSourceID, b.SDBComputerName, b.Role, b.Status, b.SoftwareVersion
  FROM   dbo.SDBSourceSystem a (NOLOCK)
  JOIN   (
        SELECT  PrimaryComputerName AS SDBComputerName, PRoleValue AS Role, PStatusValue AS Status, PSoftwareVersion AS SoftwareVersion
        FROM  #ResultsALLSDBLogical x
        UNION
        SELECT  BackupComputerName AS SDBComputerName, BRoleValue AS Role, BStatusValue AS Status, BSoftwareVersion AS SoftwareVersion
        FROM  #ResultsALLSDBLogical y
      ) b
  ON    a.SDBComputerName = b.SDBComputerName

  UPDATE   dbo.SDBSourceSystem 
  SET    Status = a.Status
  FROM   #ResultsAll a
  WHERE   SDBSourceSystem.SDBComputerName = a.SDBComputerName

  INSERT INTO  #JobCurrentStatus 
  EXEC   MASTER.dbo.xp_sqlagent_enum_jobs 1, ''

  --    Identify SDB nodes that need to be deleted 
  INSERT   @SDBDelete ( Value )
  SELECT   a.SDBSourceID AS Value
  FROM   dbo.SDBSource a (NOLOCK)
  LEFT JOIN  (
        SELECT  x.SDBSourceID, x.SoftwareVersion, COUNT(1) AS Nodes
        FROM  #ResultsAll x
        GROUP BY x.SDBSourceID, x.SoftwareVersion
      ) b
  ON    a.SDBSourceID     = b.SDBSourceID
  WHERE   a.MDBSourceID     = @MDBSourceID     --Make sure this applies to ONLY this region
  AND    (
       b.SDBSourceID    IS NULL
       OR (b.SoftwareVersion = '' AND b.Nodes > 1)
      )
  SELECT   @SDBDeleteCount     = @@ROWCOUNT

  IF    ( @SDBDeleteCount > 0 )
  BEGIN

      EXEC dbo.DeleteSDB 
          @SDBSourceID = @SDBDelete,
          @JobID   = @JobID,
          @JobName  = @JobName,
          @ErrorID  = @ErrNum OUTPUT

  END


  INSERT   #ResultsActive ( SDBSourceID, SDBComputerName )
  SELECT   
      a.SDBSourceID,
      (
       SELECT  TOP 1 x.SDBComputerName 
       FROM  #ResultsAll x 
       WHERE  x.SDBSourceID = a.SDBSourceID
       AND   x.Status = 1
       ORDER BY x.Role
      ) AS SDBComputerName
  FROM   dbo.SDBSource a (NOLOCK)
  JOIN   dbo.MDBSource b (NOLOCK)
  ON    a.MDBSourceID = b.MDBSourceID
  JOIN   #JobCurrentStatus c
  ON    a.JobID = c.Job_ID
  WHERE   c.Running <> 1
  AND    b.RegionID = @RegionID

  SELECT   TOP 1 @i = a.ID FROM #ResultsActive a ORDER BY a.ID DESC

  WHILE   ( @i > 0 )
  BEGIN
  
      SELECT TOP 1 @JobName  = b.JobName
      FROM   #ResultsActive a 
      JOIN   dbo.SDBSource b (NOLOCK) 
      ON    a.SDBSourceID = b.SDBSourceID
      WHERE   a.ID = @i

      EXEC   msdb.dbo.sp_start_job @job_name = @JobName

      SET    @i = @i - 1

  END

  DROP TABLE #ResultsALLSDBLogical
  DROP TABLE #ResultsAll
  DROP TABLE #ResultsActive
  DROP TABLE #ResultsDelete
  DROP TABLE #JobCurrentStatus

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetCacheStatus]'
GO
ALTER PROCEDURE [dbo].[GetCacheStatus]
  @RegionID   UDT_Int READONLY,
  @NodeID    UDT_Int READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetCacheStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the Cache Status for a given region and SDB Node ID.
//     Possible values for Cached_data column are "Channel Status" or "Media Status"
//     as specified in table column DINGODB.dbo.CacheStatusType.Description
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetCacheStatus.proc.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//  Usage:
//
//    DECLARE @RegionID_TBL  UDT_Int
//    DECLARE @NodeID_TBL   UDT_Int
//    DECLARE @ReturnValue  INT
//    
//    EXEC dbo.GetCacheStatus 
//      @RegionID   = @RegionID_TBL,
//      @NodeID    = @NodeID_TBL,
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @RegionID_COUNT INT
  DECLARE    @NodeID_COUNT INT

  SELECT    TOP 1 @RegionID_COUNT = ID FROM @RegionID
  SELECT    TOP 1 @NodeID_COUNT = ID FROM @NodeID

  SELECT
       Cached_data        = b.Description,
       Region         = r.Name,
       SDB          = c.SDBComputerNamePrefix,
       Modified_time       = a.UpdateDate
  FROM    dbo.CacheStatus a (NOLOCK)
  JOIN    dbo.CacheStatusType b (NOLOCK)
  ON     a.CacheStatusTypeID = b.CacheStatusTypeID
  JOIN    dbo.SDBSource c (NOLOCK)
  ON     a.SDBSourceID       = c.SDBSourceID
  JOIN    dbo.MDBSource d (NOLOCK)
  ON     c.MDBSourceID       = d.MDBSourceID
  JOIN    dbo.Region r (NOLOCK)
  ON     d.RegionID        = r.RegionID
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @RegionID WHERE Value = d.RegionID)  OR @RegionID_COUNT IS NULL )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @NodeID WHERE Value = c.SDBSourceID) OR @NodeID_COUNT IS NULL )

  SET     @Return = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[Market]'
GO
CREATE TABLE [dbo].[tmp_rg_xx_Market]
(
[MarketID] [int] NOT NULL IDENTITY(0, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CILLI] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProfileID] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NOT NULL,
[UpdateDate] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_rg_xx_Market] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_rg_xx_Market]([MarketID], [Name], [CILLI], [ProfileID], [Description], [CreateDate], [UpdateDate]) SELECT [MarketID], [Name], [CILLI], N'', [Description], [CreateDate], [UpdateDate] FROM [dbo].[Market]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_rg_xx_Market] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
DECLARE @idVal BIGINT
SELECT @idVal = IDENT_CURRENT(N'[dbo].[Market]')
IF @idVal IS NOT NULL
    DBCC CHECKIDENT(N'[dbo].[tmp_rg_xx_Market]', RESEED, @idVal)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
DROP TABLE [dbo].[Market]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_rename N'[dbo].[tmp_rg_xx_Market]', N'Market'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Market] on [dbo].[Market]'
GO
ALTER TABLE [dbo].[Market] ADD CONSTRAINT [PK_Market] PRIMARY KEY CLUSTERED  ([MarketID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [UNC_Market_Name] on [dbo].[Market]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNC_Market_Name] ON [dbo].[Market] ([Name])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetChannelStatus]'
GO
ALTER PROCEDURE [dbo].[GetChannelStatus]
  @RegionID   UDT_Int READONLY,
  @MarketID   UDT_Int READONLY,
  @Channel_IUID  UDT_Int READONLY,
  @ROCID    UDT_Int READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetChannelStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the Channel Status and all accompanying information based on the applied filters.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetChannelStatus.proc.sql 3558 2014-02-26 23:04:44Z tlew $
//    
//  Usage:
//
//    DECLARE @Region_TBL   UDT_Int
//    DECLARE @Market_TBL   UDT_Int
//    DECLARE @Channel_IU_TBL  UDT_Int
//    DECLARE @ROC_TBL   UDT_Int
//    DECLARE @ReturnValue  INT
//
//    INSERT @Market_TBL (Value) VALUES (0)
//    INSERT @Market_TBL (Value) VALUES (1)
//    INSERT @Market_TBL (Value) VALUES (47)
//    
//    EXEC dbo.GetChannelStatus 
//      --@RegionID = @Region_TBL, 
//      @MarketID = @Market_TBL,
//      --@Channel_IUID = @Channel_IU_TBL,
//      --@ROCID = @ROC_TBL, 
//      @Return = @ReturnValue OUTPUT
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;

  DECLARE    @RegionID_COUNT INT
  DECLARE    @MarketID_COUNT INT
  DECLARE    @Channel_IUID_COUNT INT
  DECLARE    @ROCID_COUNT INT

  SELECT    TOP 1 @RegionID_COUNT = ID FROM @RegionID
  SELECT    TOP 1 @MarketID_COUNT = ID FROM @MarketID
  SELECT    TOP 1 @Channel_IUID_COUNT = ID FROM @Channel_IUID
  SELECT    TOP 1 @ROCID_COUNT = ID FROM @ROCID


  SELECT
       Regionalized_IU           = IU.REGIONALIZED_IU_ID,
       Region             = r.Name,
       SDB              = sdb.SDBComputerNamePrefix,
       Channel_Name           = CAST(IU.CHANNEL_NAME AS VARCHAR(40)),
       Market             = mkt.Name,           --It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
       Zone             = zm.ZONE_NAME,
       Network             = net.NAME,
       TSI              = IU.COMPUTER_NAME,
       ICProvider             = IC.Name,
       ROC              = ROC.Name,
       DTM_Run_Rate           = a.DTM_Run_Rate,
       Forecast_Best_Run_Rate         = a.Forecast_Best_Run_Rate,
       Forecast_Worst_Run_Rate         = a.Forecast_Worst_Run_Rate,
       NextDay_Forecast_Run_Rate        = a.NextDay_Forecast_Run_Rate,
       DTM_NoTone_Rate           = a.DTM_NoTone_Rate,
       DTM_Failed_Rate           = a.DTM_Failed_Rate,
       ATT_DTM_Run_Rate          = a.ATT_DTM_Run_Rate,
       ATT_Forecast_Best_Run_Rate        = a.ATT_Forecast_Best_Run_Rate,
       ATT_Forecast_Worst_Run_Rate        = a.ATT_Forecast_Worst_Run_Rate,
       ATT_NextDay_Forecast_Run_Rate       = a.ATT_NextDay_Forecast_Run_Rate,
       ATT_DTM_NoTone_Rate          = a.ATT_DTM_NoTone_Rate,
       ATT_BreakCount           = a.ATT_BreakCount,
       ATT_NextDay_BreakCount         = a.ATT_NextDay_BreakCount,
       ATT_DTM_Failed_Rate          = a.ATT_DTM_Failed_Rate,
       ATT_LastSchedule_Load         = a.ATT_LastSchedule_Load,
       ATT_NextDay_LastSchedule_Load       = a.ATT_NextDay_LastSchedule_Load,
       IC_DTM_Run_Rate           = a.IC_DTM_Run_Rate,
       IC_Forecast_Best_Run_Rate        = a.IC_Forecast_Best_Run_Rate,
       IC_Forecast_Worst_Run_Rate        = a.IC_Forecast_Worst_Run_Rate,
       IC_NextDay_Forecast_Run_Rate       = a.IC_NextDay_Forecast_Run_Rate,
       IC_DTM_NoTone_Rate          = a.IC_DTM_NoTone_Rate,
       IC_DTM_Failed_Rate          = a.IC_DTM_Failed_Rate,
       IC_BreakCount           = a.IC_BreakCount,
       IC_NextDay_BreakCount         = a.IC_NextDay_BreakCount,
       IC_LastSchedule_Load         = a.IC_LastSchedule_Load,
       IC_NextDay_LastSchedule_Load       = a.IC_NextDay_LastSchedule_Load,
       Consecutive_NoTone_Count        = a.Consecutive_NoTone_Count,
       Consecutive_Error_Count         = a.Consecutive_Error_Count,
       Average_BreakCount          = a.Average_BreakCount,

       Total_Insertions_Today         = a.TotalInsertionsToday,       --Int The total number of scheduled insertions
       Total_Insertions_NextDay        = a.TotalInsertionsNextDay,       --Int The total number of scheduled insertions for tomorrow
       DTM_Total_Insertions         = a.DTM_Total,          --Int Day-to-moment attempted insertions
       DTM_Successful_Insertions        = a.DTM_Played,          --Int Day-to-moment successful insertions
       DTM_Failed_Insertions         = a.DTM_Failed,          --Int Day-to-moment failed insertions including NoTones
       DTM_NoTone_Insertions         = a.DTM_NoTone,          --Int Day-to-moment insertions with NoTone
       MTE_Insertion_Conflicts         = a.MTE_Conflicts,         --Int Moment-to-end insertion conflicts
       First_Insertion_Conflicts        = a.MTE_Conflicts_Window1,       --Int Moment-to-end insertion conflicts in time window1
       Second_Insertion_Conflicts        = a.MTE_Conflicts_Window2,       --Int Moment-to-end insertion conflicts in time window2
       Third_Insertion_Conflicts        = a.MTE_Conflicts_Window3,       --Int Moment-to-end insertion conflicts in time window3
       First_Conflicts_NextDay         = 0,            --Int 
       Insertion_Conflicts_NextDay        = a.ConflictsNextDay,        --Int The number of insertion conflicts for tomorrow


       ATT_Total_Insertions_Today        = a.ATTTotal,          --Int AT&T total number of scheduled insertions
       ATT_Total_Insertions_NextDay       = a.ATTTotalNextDay,        --Int AT&T total number of scheduled insertions for tomorrow
       ATT_DTM_Total_Insertions        = a.DTM_ATTTotal,         --Int AT&T Day-to-moment attempted insertions
       ATT_DTM_Successful_Insertions       = a.DTM_ATTPlayed,         --Int AT&T Day-to-moment successful insertions
       ATT_DTM_Failed_Insertions        = a.DTM_ATTFailed,         --Int AT&T Day-to-moment failed insertions including NoTones
       ATT_DTM_NoTone_Insertions        = a.DTM_ATTNoTone,         --Int AT&T Day-to-moment insertions with NoTone
       ATT_MTE_Insertion_Conflicts        = a.MTE_ATTConflicts,        --Int AT&T Moment-to-end insertion conflicts
       ATT_First_Insertion_Conflicts       = a.MTE_ATTConflicts_Window1,      --Int AT&T Moment-to-end insertion conflicts in time window1
       ATT_Second_Insertion_Conflicts       = a.MTE_ATTConflicts_Window2,      --Int AT&T Moment-to-end insertion conflicts in time window2
       ATT_Third_Insertion_Conflicts       = a.MTE_ATTConflicts_Window3,      --Int AT&T Moment-to-end insertion conflicts in time window3
       ATT_First_Conflicts_NextDay        = 0,            --Int 
       ATT_Insertion_Conflicts_NextDay       = a.ATTConflictsNextDay,       --Int The number of AT&T insertion conflicts for tomorrow

       IC_Total_Insertions_Today        = a.ICTotal,          --Int IC total number of scheduled insertions
       IC_Total_Insertions_NextDay        = a.ICTotalNextDay,         --Int IC total number of scheduled insertions for tomorrow
       IC_DTM_Total_Insertions         = a.DTM_ICTotal,         --Int IC Day-to-moment attempted insertions
       IC_DTM_Successful_Insertions       = a.DTM_ICPlayed,         --Int IC Day-to-moment successful insertions
       IC_DTM_Failed_Insertions        = a.DTM_ICFailed,         --Int IC Day-to-moment failed insertions including NoTones
       IC_DTM_NoTone_Insertions        = a.DTM_ICNoTone,         --Int IC Day-to-moment insertions with NoTone
       IC_MTE_Insertion_Conflicts        = a.MTE_ICConflicts,        --Int IC Moment-to-end insertion conflicts
       IC_First_Insertion_Conflicts       = a.MTE_ICConflicts_Window1,      --Int IC Moment-to-end insertion conflicts in time window1
       IC_Second_Insertion_Conflicts       = a.MTE_ICConflicts_Window2,      --Int IC Moment-to-end insertion conflicts in time window2
       IC_Third_Insertion_Conflicts       = a.MTE_ICConflicts_Window3,      --Int IC Moment-to-end insertion conflicts in time window3
       IC_First_Conflicts_NextDay        = 0,            --Int 
       IC_Insertion_Conflicts_NextDay       = a.ICConflictsNextDay        --Int The number of IC insertion conflicts for tomorrow

  FROM    dbo.ChannelStatus a (NOLOCK)
  JOIN    (
         SELECT  x.SDBSourceID
         FROM  dbo.SDB_Market x (NOLOCK)
         LEFT JOIN @MarketID y
         ON   x.MarketID       = y.Value
         WHERE  x.Enabled       = 1
         AND   (  y.Value      IS NOT NULL
             OR @MarketID_COUNT    IS NULL
            )
         GROUP BY x.SDBSourceID
       ) f
  ON     a.SDBSourceID           = f.SDBSourceID
  JOIN    dbo.SDBSource sdb (NOLOCK)
  ON     a.SDBSourceID           = sdb.SDBSourceID
  JOIN    dbo.MDBSource mdb (NOLOCK)
  ON     sdb.MDBSourceID           = mdb.MDBSourceID
  JOIN    dbo.Region r (NOLOCK)
  ON     mdb.RegionID           = r.RegionID
  JOIN    dbo.REGIONALIZED_IU IU (NOLOCK)
  ON     a.IU_ID             = IU.IU_ID
  AND     r.RegionID            = IU.REGIONID
  JOIN    dbo.REGIONALIZED_NETWORK_IU_MAP netmap (NOLOCK)
  ON     IU.REGIONALIZED_IU_ID         = netmap.REGIONALIZED_IU_ID
  JOIN    dbo.REGIONALIZED_NETWORK net (NOLOCK)
  ON     netmap.REGIONALIZED_NETWORK_ID       = net.REGIONALIZED_NETWORK_ID
  JOIN    dbo.REGIONALIZED_ZONE z (NOLOCK)
  ON     a.RegionalizedZoneID         = z.REGIONALIZED_ZONE_ID
  JOIN    dbo.ZONE_MAP zm (NOLOCK)        --It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
  ON     z.ZONE_NAME            = zm.ZONE_NAME
  LEFT JOIN   dbo.ROC ROC (NOLOCK)
  ON     zm.ROCID            = ROC.ROCID
  LEFT JOIN   dbo.Market mkt (NOLOCK)
  ON     zm.MarketID            = mkt.MarketID
  LEFT JOIN   dbo.ICProvider IC (NOLOCK) 
  ON     zm.ICProviderID           = IC.ICProviderID
  WHERE    a.Enabled            = 1
  AND     ( EXISTS(SELECT TOP 1 1 FROM @RegionID     WHERE Value = r.RegionID)     OR @RegionID_COUNT IS NULL )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @MarketID     WHERE Value = mkt.MarketID)     OR @MarketID_COUNT IS NULL )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @Channel_IUID    WHERE Value = IU.REGIONALIZED_IU_ID)  OR @Channel_IUID_COUNT IS NULL )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @ROCID      WHERE Value = zm.ROCID)      OR @ROCID_COUNT IS NULL )
  ORDER BY   mkt.Name,            --AS Market
       net.NAME,            --AS Network
       zm.ZONE_NAME           --AS Zone


  SET     @Return = @@ERROR


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetConflict]'
GO
ALTER PROCEDURE [dbo].[GetConflict]
  @RegionID   UDT_Int READONLY,
  @SDBID    UDT_Int READONLY,
  @IUID    UDT_Int READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetConflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the Conflict of evert SPOT of an IU and accompanying information based on the filters applied.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetConflict.proc.sql 3284 2013-12-10 20:16:20Z tlew $
//    
//  Usage:
//
//    DECLARE @RegionID_TBL  UDT_Int     
//    DECLARE @SDBID_TBL   UDT_Int     
//    DECLARE @IUID_TBL   UDT_Int     
//    DECLARE @ReturnValue  INT      
//
//    INSERT @IUID_TBL (Value) VALUES (2344)
//    INSERT @IUID_TBL (Value) VALUES (2322)
//    INSERT @IUID_TBL (Value) VALUES (2336)
//
//    EXEC dbo.GetConflict     
//      @RegionID   = @RegionID_TBL,  
//      @SDBID    = @SDBID_TBL,   
//      @IUID    = @IUID_TBL,   
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue        
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @RegionID_COUNT INT
  DECLARE    @SDBID_COUNT INT
  DECLARE    @IUID_COUNT INT

  SELECT    TOP 1 @RegionID_COUNT = ID FROM @RegionID
  SELECT    TOP 1 @SDBID_COUNT = ID FROM @SDBID
  SELECT    TOP 1 @IUID_COUNT = ID FROM @IUID

  SELECT    TOP (5000)
       REGIONALIZED_IE          = spot.IE_ID,
       Region            = r.Name,
       SDB             = s.SDBComputerNamePrefix,
       REGIONALIZED_IU          = IU.REGIONALIZED_IU_ID,
       Channel_Name           = CAST(IU.CHANNEL_NAME AS VARCHAR(40)),
       Market             = mkt.Name,
       Zone            = zm.ZONE_NAME,
       Network            = net.NAME,
       TSI             = IU.COMPUTER_NAME,
       ICProvider            = IC.Name,
       ROC             = ROC.Name,
       Time             = a.Time,
       TimeZoneOffset           = s.UTCOffset,
       PositionWithinBreak         = spot.SPOT_ORDER,
       Asset_ID            = a.Asset_ID,
       Asset_Desc            = a.Asset_Desc,
       Spot_Status           = CAST(ss.VALUE AS VARCHAR(55)),     --Varchar(55) String describing the status of the Spot
       Spot_Status_Age          = DATEDIFF( MINUTE, spot.UTC_SPOT_NSTATUS_UPDATE_TIME, GETUTCDATE() ),  --Int Duration in minutes since the SPOT_Status changed value
       Spot_Conflict           = CAST(cs.VALUE AS VARCHAR(55)),     --Varchar(55) String descripting the conflict state of the Spot
       Spot_Conflict_Age          = DATEDIFF( MINUTE, spot.UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME, GETUTCDATE() ),   --Int Duration in minutes since the SPOT_Conflict changed value
       Insertion_Status          = CAST(ies.VALUE AS VARCHAR(55)),     --Varchar(55) String descripting the Status of the insertion event for which this Spot belongs
       Insertion_Status_Age         = DATEDIFF( MINUTE, spot.UTC_IE_NSTATUS_UPDATE_TIME, GETUTCDATE() ),  --Int Duration in minutes since the Insertion_Status changed value
       Insertion_Conflict          = CAST(iecs.VALUE AS VARCHAR(55)),     --Varchar(55) String descripting the conflict state of the insertion event for which this spot belongs
       Insertion_Conflict_Age         = DATEDIFF( MINUTE, spot.UTC_IE_NSTATUS_UPDATE_TIME, GETUTCDATE() ),  --Int Duration in minutes since the Insertion_Conflict changed value
       Scheduled_Insertions         = a.Scheduled_Insertions,       --Int This can be calculated by summing all the scheduled insertion for an Asset
       CreateDate           = a.CreateDate,
       UpdateDate            = a.UpdateDate

  FROM    dbo.Conflict a (NOLOCK)
  JOIN    dbo.SDBSource s (NOLOCK)
  ON     a.SDBSourceID          = s.SDBSourceID
  JOIN    dbo.SDB_IESPOT spot (NOLOCK)
  ON     a.SDBSourceID          = spot.SDBSourceID
  AND     a.IU_ID            = spot.IU_ID
  AND     a.Asset_ID           = spot.VIDEO_ID
  AND     a.SPOT_ID           = spot.SPOT_ID
  JOIN    dbo.ChannelStatus b (NOLOCK) 
  ON     a.SDBSourceID          = b.SDBSourceID
  AND     a.IU_ID            = b.IU_ID
  JOIN    dbo.REGIONALIZED_ZONE x (NOLOCK)
  ON     b.RegionalizedZoneID        = x.REGIONALIZED_ZONE_ID
  JOIN    dbo.REGIONALIZED_IU IU (NOLOCK)
  ON     a.IU_ID            = IU.IU_ID
  AND     x.REGION_ID           = IU.REGIONID
  JOIN    dbo.Region r (NOLOCK)
  ON     IU.REGIONID           = r.RegionID
  JOIN    dbo.REGIONALIZED_NETWORK_IU_MAP netmap (NOLOCK)
  ON     IU.REGIONALIZED_IU_ID        = netmap.REGIONALIZED_IU_ID
  JOIN    dbo.REGIONALIZED_NETWORK net (NOLOCK)
  ON     netmap.REGIONALIZED_NETWORK_ID      = net.REGIONALIZED_NETWORK_ID
  JOIN    dbo.ZONE_MAP zm (NOLOCK)
  ON     IU.ZONE_NAME          = zm.ZONE_NAME
  JOIN    dbo.ROC ROC (NOLOCK)
  ON     zm.ROCID           = ROC.ROCID
  JOIN    dbo.Market mkt (NOLOCK)
  ON     zm.MarketID           = mkt.MarketID
  JOIN    dbo.ICProvider IC (NOLOCK) 
  ON     zm.ICProviderID          = IC.ICProviderID
  LEFT JOIN   dbo.REGIONALIZED_SPOT_STATUS ss
  ON     spot.SPOT_NSTATUS         = ss.NSTATUS
  AND     IU.REGIONID           = ss.RegionID
  LEFT JOIN   dbo.REGIONALIZED_SPOT_CONFLICT_STATUS cs
  ON     spot.SPOT_CONFLICT_STATUS       = cs.NSTATUS
  AND     IU.REGIONID           = cs.RegionID
  LEFT JOIN   dbo.REGIONALIZED_IE_STATUS ies
  ON     spot.IE_NSTATUS          = ies.NSTATUS
  AND     IU.REGIONID           = ies.RegionID
  LEFT JOIN   dbo.REGIONALIZED_IE_CONFLICT_STATUS iecs
  ON     spot.IE_CONFLICT_STATUS        = iecs.NSTATUS
  AND     IU.REGIONID           = iecs.RegionID
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @RegionID    WHERE Value = IU.RegionID)     OR @RegionID_COUNT IS NULL )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @SDBID     WHERE Value = a.SDBSourceID )    OR @SDBID_COUNT IS NULL )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @IUID     WHERE Value = IU.REGIONALIZED_IU_ID)  OR @IUID_COUNT IS NULL )
  AND     a.UTCTime           >= GETUTCDATE()
  AND     b.Enabled           = 1
  ORDER BY   a.UTCTime

  SET     @Return            = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetEventLog]'
GO
ALTER PROCEDURE [dbo].[GetEventLog]
  @Page    INT = 1,
  @PageSize   INT = 50,
  @SortOrder   INT = 2   -- 1 = ascending order and 2 = descending order
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
// Module:  dbo.GetEventLog
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the EventLog with configurable pagination logic
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetEventLog.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    EXEC dbo.GetEventLog
//      @Page    = 1,
//      @PageSize   = 50,
//      @SortOrder   = 2 
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @Results  UDT_Int
  DECLARE    @FirstRowID  INT
  DECLARE    @LastRow  INT
  DECLARE    @FirstRow  INT
  
  SELECT    @Page = @Page - 1     
  --SELECT    TOP 1 @FirstRowID = a.EventLogID
  --FROM    dbo.EventLog a (NOLOCK)
  --ORDER BY   CASE WHEN @SortOrder = 1 THEN a.EventLogID END ASC, 
  --     CASE WHEN @SortOrder = 2 THEN a.EventLogID END DESC

  IF ( @SortOrder = 1 )
    SELECT  
       @FirstRowID  = 1,
       @FirstRow  = @FirstRowID + ( @Page * @PageSize ),
       @LastRow  = @FirstRow + @PageSize - 1 
  ELSE
    SELECT  
       @FirstRowID  = IDENT_CURRENT( 'Eventlog' ),
       @LastRow  = @FirstRowID - ( @Page * @PageSize ), 
       @FirstRow  = @LastRow - @PageSize


  SELECT    TOP ( @PageSize )
       a.EventLogID,
       datediff( SECOND, a.StartDate, ISNULL(a.FinishDate, GETUTCDATE()) ) AS TotalTime,
       b.Description,
       a.JobID,
       a.JobName,
       a.DBID,
       a.DBComputerName,
       a.Description,
       a.StartDate,
       a.FinishDate
  FROM    dbo.EventLog a (NOLOCK)
  JOIN    dbo.EventLogStatus b (NOLOCK)
  ON     a.EventlogStatusID         = b.EventLogStatusID
  WHERE    a.EventLogID BETWEEN @FirstRow AND @LastRow
  ORDER BY   CASE WHEN @SortOrder = 1 THEN a.EventLogID END ASC, 
       CASE WHEN @SortOrder = 2 THEN a.EventLogID END DESC

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetICProvider]'
GO
ALTER PROCEDURE [dbo].[GetICProvider]
  @ICProviderID  UDT_Int READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetICProvider
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the IC Provider information.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetICProvider.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE @ICProviderID_TBL UDT_Int
//    DECLARE @ReturnValue  INT
//    
//    EXEC dbo.GetICProvider 
//      @ICProviderID  = @ICProviderID_TBL,
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue
//
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @ICProviderID_COUNT INT

  SELECT    TOP 1 @ICProviderID_COUNT = ID FROM @ICProviderID

  SELECT
       ICProviderID,
       Name,
       Description,
       CreateDate,
       UpdateDate
  FROM    dbo.ICProvider a (NOLOCK)
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @ICProviderID WHERE Value = a.ICProviderID)  OR ISNULL(@ICProviderID_COUNT,-1) = -1 )
  ORDER BY   Name
  
  SET     @Return = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetIU]'
GO
ALTER PROCEDURE [dbo].[GetIU]
  @RegionID   UDT_Int READONLY,
  @IUID    UDT_Int READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetIU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the SPOT IU ID associated with DINGODBs regionalized IU ID.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetIU.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE @RegionID_TBL  UDT_Int
//    DECLARE @IUID_TBL   UDT_Int
//    DECLARE @ReturnValue  INT
//    
//    EXEC dbo.GetIU 
//      @RegionID   = @RegionID_TBL,
//      @IUID    = @IUID_TBL,
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue
//
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @RegionID_COUNT INT
  DECLARE    @IUID_COUNT INT

  SELECT    @RegionID_COUNT = COUNT(1) FROM @RegionID
  SELECT    @IUID_COUNT = COUNT(1) FROM @IUID

  SELECT
       a.REGIONALIZED_IU_ID,
       a.IU_ID,
       a.REGIONID,
       a.ZONE,
       a.ZONE_NAME,
       a.CHANNEL,
       a.CHAN_NAME,
       --DELAY
       --START_TRIGGER
       --END_TRIGGER
       --AWIN_START
       --AWIN_END
       --VALUE
       --MASTER_NAME
       --COMPUTER_NAME
       --PARENT_ID
       --SYSTEM_TYPE
       --COMPUTER_PORT
       --MIN_DURATION
       --MAX_DURATION
       --START_OF_DAY
       --RESCHEDULE_WINDOW
       --IC_CHANNEL
       --VSM_SLOT
       --DECODER_PORT
       --TC_ID
       --IGNORE_VIDEO_ERRORS
       --IGNORE_AUDIO_ERRORS
       --COLLISION_DETECT_ENABLED
       --TALLY_NORMALLY_HIGH
       --PLAY_OVER_COLLISIONS
       --PLAY_COLLISION_FUDGE
       --TALLY_COLLISION_FUDGE
       --TALLY_ERROR_FUDGE
       --LOG_TALLY_ERRORS
       --TBI_START
       --TBI_END
       --CONTINUOUS_PLAY_FUDGE
       --TONE_GROUP
       --IGNORE_END_TONES
       --END_TONE_FUDGE
       --MAX_AVAILS
       --RESTART_TRIES
       --RESTART_BYTE_SKIP
       --RESTART_TIME_REMAINING
       --GENLOCK_FLAG
       --SKIP_HEADER
       --GPO_IGNORE
       --GPO_NORMAL
       --GPO_TIME
       --DECODER_SHARING
       --HIGH_PRIORITY
       --SPLICER_ID
       --PORT_ID
       --VIDEO_PID
       --SERVICE_PID
       --DVB_CARD
       --SPLICE_ADJUST
       --POST_BLACK
       --SWITCH_CNT
       --DECODER_CNT
       --DVB_CARD_CNT
       --DVB_PORTS_PER_CARD
       --DVB_CHAN_PER_PORT
       --USE_ISD
       --NO_NETWORK_VIDEO_DETECT
       --NO_NETWORK_PLAY
       --IP_TONE_THRESHOLD
       --USE_GIGE
       --GIGE_IP
       --IS_ACTIVE_IND
       a.CreateDate,
       a.UpdateDate

  FROM    dbo.REGIONALIZED_IU a (NOLOCK)
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @RegionID WHERE Value = a.REGIONID)  OR ISNULL(@RegionID_COUNT,0) = 0 )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @IUID WHERE Value = a.IU_ID)  OR ISNULL(@IUID_COUNT,0) = 0 )
  ORDER BY   a.IU_ID, a.REGIONID

  SET     @Return = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetMarket]'
GO
ALTER PROCEDURE [dbo].[GetMarket]
  @MarketID   UDT_Int READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetMarket
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the Market information.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetMarket.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE @MarketID_TBL  UDT_Int
//    DECLARE @ReturnValue  INT
//    
//    EXEC dbo.GetMarket 
//      @MarketID   = @MarketID_TBL,
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @MarketID_COUNT INT

  SELECT    TOP 1 @MarketID_COUNT = ID FROM @MarketID

  SELECT
       MarketID,
       Name,
       Description,
       CreateDate,
       UpdateDate
  FROM    dbo.Market a (NOLOCK)
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @MarketID WHERE Value = a.MarketID)  OR ISNULL(@MarketID_COUNT,-1) = -1 )
  ORDER BY   Name
  
  SET     @Return = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetNetwork]'
GO
ALTER PROCEDURE [dbo].[GetNetwork]
  @RegionID   UDT_Int READONLY,
  @NetworkID   UDT_Int READONLY,
  --@Name    UDT_VarChar50 READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetNetwork
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the Network information.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetNetwork.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE @RegionID_TBL  UDT_Int
//    DECLARE @NetworkID_TBL  UDT_Int
//    DECLARE @Name_TBL   UDT_VarChar50
//    DECLARE @ReturnValue  INT
//    
//    EXEC dbo.GetNetwork
//      @RegionID   = @RegionID_TBL,
//      @NetworkID   = @NetworkID_TBL,
//      @Name    = @Name_TBL,
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue     
//  
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @RegionID_COUNT INT
  DECLARE    @NetworkID_COUNT INT
  --DECLARE    @Name_COUNT INT

  SELECT    TOP 1 @RegionID_COUNT = ID FROM @RegionID
  SELECT    TOP 1 @NetworkID_COUNT = ID FROM @NetworkID
  --SELECT    @Name_COUNT = COUNT(1) FROM @Name

  SELECT
       REGIONALIZED_NETWORK_ID,
       REGIONID,
       NETWORKID,
       NAME,
       DESCRIPTION,
       CreateDate,
       UpdateDate
  FROM    dbo.REGIONALIZED_NETWORK a (NOLOCK)
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @RegionID WHERE Value = a.REGIONID) OR ISNULL(@RegionID_COUNT,0) = 0 )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @NetworkID WHERE Value = a.NETWORKID) OR ISNULL(@NetworkID_COUNT,0) = 0 )
  --AND     ( EXISTS(SELECT TOP 1 1 FROM @Name WHERE Value = a.Name)  OR ISNULL(@Name_COUNT,0) = 0 )
  ORDER BY   Name

  SET     @Return = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetRegion]'
GO
ALTER PROCEDURE [dbo].[GetRegion]
  @RegionID   UDT_Int READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetRegion
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the Region information.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetRegion.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE @RegionID_TBL  UDT_Int
//    DECLARE @ReturnValue  INT
//    
//    EXEC dbo.GetRegion 
//      @RegionID   = @RegionID_TBL,
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue
//
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @RegionID_COUNT INT

  SELECT    TOP 1 @RegionID_COUNT = ID FROM @RegionID

  SELECT
       RegionID,
       Name,
       Description,
       CreateDate,
       UpdateDate
  FROM    dbo.Region a (NOLOCK)
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @RegionID WHERE Value = a.RegionID)  OR ISNULL(@RegionID_COUNT,0) = 0 )
  ORDER BY   Name
  
  SET     @Return = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetROC]'
GO
ALTER PROCEDURE [dbo].[GetROC]
  @ROCID    UDT_Int READONLY,
  --@Name    UDT_VarChar50 READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetROC
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the ROC information.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetROC.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE @ROCID_TBL   UDT_Int
//    DECLARE @Name_TBL   UDT_VarChar50
//    DECLARE @ReturnValue  INT
//    
//    EXEC dbo.GetROC 
//      @ROCID    = @ROCID_TBL,
//      @Name    = @Name_TBL,
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue       
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;

  DECLARE    @ROCID_COUNT INT
  --DECLARE    @Name_COUNT INT

  SELECT    TOP 1 @ROCID_COUNT = ID FROM @ROCID
  --SELECT    TOP 1 @Name_COUNT = ID FROM @Name

  SELECT
       ROCID,
       Name,
       Description,
       CreateDate,
       UpdateDate
  FROM    dbo.ROC a (NOLOCK)
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @ROCID WHERE Value = a.ROCID)  OR ISNULL(@ROCID_COUNT,-1) = -1 )
  --AND     ( EXISTS(SELECT TOP 1 1 FROM @Name WHERE Value = a.Name)  OR ISNULL(@Name_COUNT,0) = 0 )
  ORDER BY   Name

  SET     @Return = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetSDBUTCOffset]'
GO
ALTER PROCEDURE [dbo].[GetSDBUTCOffset]
  @SDBSourceID  INT,
  @SDBComputerName VARCHAR(50),
  @Role    INT,
  @JobID    UNIQUEIDENTIFIER,
  @JobName   VARCHAR(100),
  @UTCOffset   INT OUTPUT
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
// Module:  dbo.GetSDBUTCOffset
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the UTCOffset of the given SDB system.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetSDBUTCOffset.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE  @SDBUTCOffset INT
//    EXEC  dbo.GetSDBUTCOffset 
//        @SDBSourceID  = 1,
//        @SDBComputerName = 'MSSNKNLSDB004B', 
//        @Role    = 1,
//        @JobID    = NULL,
//        @JobName   = ''
//        @UTCOffset   = @SDBUTCOffset OUTPUT
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;
  SET LOCK_TIMEOUT 1000

  DECLARE   @CMD      NVARCHAR(1000)
  DECLARE   @ParmDefinition    NVARCHAR(500)
  DECLARE   @SDBUTCOffset    INT
  DECLARE   @EventLogStatusID   INT
  DECLARE   @LogIDReturn    INT


  SET    @CMD = 
        'SELECT TOP 1 @Offset = Value
        FROM OPENQUERY(' + @SDBComputerName + ', N''SELECT TOP 1 datepart( tz, SYSDATETIMEOFFSET() ) / 60 AS Value '' )'

  SET    @ParmDefinition = N'@Offset INT OUTPUT'
  BEGIN TRY

      EXECUTE   sp_executesql @CMD, @ParmDefinition, @Offset = @SDBUTCOffset OUTPUT
      SET    @UTCOffset     = @SDBUTCOffset
      UPDATE   dbo.SDBSource
      SET    UTCOffset     = @SDBUTCOffset
      FROM   dbo.SDBSourceSystem a (NOLOCK)
      WHERE   SDBSource.SDBSourceID  = a.SDBSourceID
      AND    a.SDBComputerName   = @SDBComputerName
      AND    @SDBUTCOffset    IS NOT NULL

  END TRY
  BEGIN CATCH

      SELECT   @UTCOffset     = NULL

  END CATCH

  IF    ( @UTCOffset IS NULL AND @Role = 1 ) 
      SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Primary SDB Failure'
  ELSE   IF ( @UTCOffset IS NULL AND @Role = 2 ) 
      SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Secondary SDB Failure'

  EXEC   dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,   ----Log Failure
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @SDBSourceID,
       @DBComputerName  = @SDBComputerName, 
       @LogIDOUT   = @LogIDReturn OUTPUT
  EXEC   dbo.LogEvent 
       @LogID    = @LogIDReturn, 
       @EventLogStatusID = @EventLogStatusID, 
       @Description  = NULL



END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[GetZone]'
GO
ALTER PROCEDURE [dbo].[GetZone]
  @RegionID   UDT_Int READONLY,
  @ZoneID    UDT_Int READONLY,
  @Return    INT = 0 OUTPUT
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
// Module:  dbo.GetZone
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Gets the SPOT zone and the associated DINGODB zone id.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.GetZone.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE @RegionID_TBL  UDT_Int
//    DECLARE @ZoneID_TBL   UDT_Int
//    DECLARE @ReturnValue  INT
//    
//    EXEC dbo.GetZone
//      @RegionID   = @RegionID_TBL,
//      @ZoneID    = @ZoneID_TBL,
//      @Return    = @ReturnValue OUTPUT
//    SELECT @ReturnValue
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE    @RegionID_COUNT INT
  DECLARE    @ZoneID_COUNT INT

  SELECT    @RegionID_COUNT = COUNT(1) FROM @RegionID
  SELECT    @ZoneID_COUNT = COUNT(1) FROM @ZoneID

  SELECT
       a.REGIONALIZED_ZONE_ID,
       a.REGION_ID,
       a.ZONE_ID,
       b.ZONE_NAME,
       a.DATABASE_SERVER_NAME,
       --DB_ID,
       --SCHEDULE_RELOADED,
       --MAX_DAYS,
       --MAX_ROWS,
       --TB_TYPE,
       --LOAD_TTL,
       --LOAD_TOD,
       --ASRUN_TTL,
       --ASRUN_TOD,
       --IC_ZONE_ID,
       --PRIMARY_BREAK,
       --SECONDARY_BREAK
       a.CreateDate,
       a.UpdateDate
  FROM    dbo.REGIONALIZED_ZONE a (NOLOCK)
  JOIN    dbo.ZONE_MAP b (NOLOCK)
  ON     a.ZONE_NAME           = b.ZONE_NAME
  WHERE    ( EXISTS(SELECT TOP 1 1 FROM @RegionID WHERE Value = a.REGION_ID)     OR ISNULL(@RegionID_COUNT,0) = 0 )
  AND     ( EXISTS(SELECT TOP 1 1 FROM @ZoneID WHERE Value = a.REGIONALIZED_ZONE_ID)  OR ISNULL(@ZoneID_COUNT,0) = 0 )
  ORDER BY   b.ZONE_NAME

  SET     @Return = @@ERROR

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ImportBreakCountHistory]'
GO
ALTER PROCEDURE [dbo].[ImportBreakCountHistory]
		@SDBUTCOffset			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				VARCHAR(100),
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
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
// Module:  dbo.ImportBreakCountHistory
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 	Imports Break Count History from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.ImportBreakCountHistory.proc.sql 4045 2014-04-29 14:54:19Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.ImportBreakCountHistory 
//								@SDBUTCOffset		= 0
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'SDBName',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD			NVARCHAR(1000)
		DECLARE		@StartDay		DATE
		DECLARE		@EndDay			DATE
		DECLARE		@NowSDBTime		DATE
		DECLARE		@LogIDReturn	INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportBreakCountHistory First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		SELECT		@NowSDBTime		= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
		SELECT		@StartDay		= DATEADD( DAY, -6, @NowSDBTime ),
					@EndDay			= DATEADD( DAY, 2, @NowSDBTime )


		SET			@CMD			= 
		'INSERT		#ImportIUBreakCount
					(
						BREAK_DATE,
						IU_ID,
						SOURCE_ID,
						BREAK_COUNT,
						SDBSourceID
					)
		SELECT			IU_BREAKS.BREAK_DATE,
						IU_BREAKS.IU_ID AS IU_ID,
						IU_BREAKS.SOURCE_ID AS SOURCE_ID,
						IU_BREAKS.BREAK_COUNT,
						' + CAST(@SDBSourceID AS VARCHAR(25)) + ' AS SDBSourceID
		FROM
					(
						SELECT 
							CONVERT( DATE, IE.SCHED_DATE_TIME ) AS BREAK_DATE,
							IE.IU_ID AS IU_ID,
							IE.SOURCE_ID,
							COUNT(1) AS BREAK_COUNT 
						FROM [' + @SDBName + '].mpeg.dbo.IE IE WITH (NOLOCK) ' +
						'WHERE	IE.SCHED_DATE_TIME  >= ''' + CAST(  @StartDay AS VARCHAR(12) ) + ''' ' +
						'AND	IE.SCHED_DATE_TIME < ''' + CAST( @EndDay AS VARCHAR(12) ) + ''' ' +
						'AND	IE.NSTATUS <> 15 ' +
						'GROUP BY CONVERT( DATE, IE.SCHED_DATE_TIME ), IE.IU_ID, IE.SOURCE_ID 
					)		AS IU_BREAKS '


		--Previously, this query was only retrieving the break counts for the last 6 days (dateadd (-6) to dateadd (-1)).
		--Now, we will include today and tomorrow  (dateadd (-6) to dateadd (1))
		BEGIN TRY
			EXECUTE		sp_executesql	@CMD
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportBreakCountHistory Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE()
			SET			@ErrorID = @ErrNum
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ImportChannelAndConflictStats]'
GO
ALTER PROCEDURE [dbo].[ImportChannelAndConflictStats]
		@SDBUTCOffset			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				VARCHAR(100),
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
		@Day					DATETIME = NULL,
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
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
// Module:  dbo.ImportChannelAndConflictStats
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 	Imports Channel And Conflict Stats from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.ImportChannelAndConflictStats.proc.sql 4045 2014-04-29 14:54:19Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.ImportChannelAndConflictStats 
//								@SDBUTCOffset		= 0
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'SDBName',
//								@Day				= '2013-01-01',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@StartDay		DATE
		DECLARE		@EndDay			DATE
		DECLARE		@LogIDReturn	INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		SELECT		@StartDay		= ISNULL(@Day, DATEADD(HOUR, @SDBUTCOffset, GETUTCDATE()) ),
					@EndDay			= DATEADD(DAY, 2, @StartDay)

		SET			@CMD			= 
		'INSERT		#ImportIE_SPOT
					(
						SPOT_ID,
						IE_ID,
						IU_ID,
						SCHED_DATE,
						SCHED_DATE_TIME,
						AWIN_END_DT,
						IE_NSTATUS,
						IE_CONFLICT_STATUS,
						IE_SOURCE_ID,
						VIDEO_ID,
						ASSET_DESC,
						SPOT_ORDER, 
						SPOT_NSTATUS,
						SPOT_CONFLICT_STATUS,
						SPOT_RUN_DATE_TIME,
						SDBSourceID
					)
		SELECT			
						SPOT.SPOT_ID,
						IE.IE_ID,
						IE.IU_ID,
						CONVERT(DATE, IE.SCHED_DATE_TIME),
						IE.SCHED_DATE_TIME,
						IE.AWIN_END_DT WINDOW_CLOSE,
						IE.NSTATUS,
						IE.CONFLICT_STATUS,
						IE.SOURCE_ID,
						SPOT.VIDEO_ID,
						SPOT.TITLE + '' - '' + SPOT.CUSTOMER	AS ASSET_DESC,
						SPOT.SPOT_ORDER, 
						SPOT.NSTATUS,
						SPOT.CONFLICT_STATUS,
						SPOT.RUN_DATE_TIME,
						' + CAST(@SDBSourceID AS VARCHAR(50)) + ' AS SDBSourceID ' +
		'FROM			['+@SDBName+'].mpeg.dbo.IE IE WITH (NOLOCK) ' +
		'JOIN			['+@SDBName+'].mpeg.dbo.SPOT SPOT WITH (NOLOCK) ' +
		'ON				IE.IE_ID = SPOT.IE_ID ' +
		'WHERE			IE.SCHED_DATE_TIME  >= ''' + CAST( @StartDay AS VARCHAR(12)) + ''' ' +
		'AND			IE.SCHED_DATE_TIME < ''' + CAST( @EndDay AS VARCHAR(12)) + ''' ' +
		'AND			IE.NSTATUS <> 15 '


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE()
			SET			@ErrorID = @ErrNum
		END CATCH
		
		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveSDB_Market]'
GO
ALTER PROCEDURE [dbo].[SaveSDB_Market]
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @SDBSourceID   INT,
  @SDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveSDB_Market
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Inserts an SDB to Market relationship to DINGODB and assigns the mapping with a DINGODB SDB_Market ID.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveSDB_Market.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveSDB_Market 
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @SDBSourceID  = 1,
//        @SDBName   = 'MSSNKNLSDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @LogIDReturn   INT
  DECLARE  @ErrNum     INT
  DECLARE  @ErrMsg     VARCHAR(200)
  DECLARE  @EventLogStatusID  INT = 1  --Unidentified Step
  DECLARE  @TempTableCount   INT
  DECLARE  @ZONECount    INT
  DECLARE  @UnMappedMarketID  INT

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market First Step'
  SET   @ErrorID = 1
  SELECT  TOP 1 @UnMappedMarketID = MarketID FROM dbo.Market (NOLOCK) WHERE Name = 'n/a'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @SDBSourceID,
       @DBComputerName  = @SDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  BEGIN TRY
     INSERT    dbo.SDB_Market ( SDBSourceID, MarketID, Enabled )
     SELECT    @SDBSourceID AS SDBSourceID, c.MarketID, 1 AS Enabled
      FROM    (
           SELECT   @SDBSourceID AS SDBSourceID, IU.ZONE_NAME, IU.REGIONID
           FROM   #ImportIE_SPOT ie
           JOIN   dbo.REGIONALIZED_IU  IU (NOLOCK)
           ON    ie.IU_ID = IU.IU_ID
           GROUP BY  IU.ZONE_NAME, IU.REGIONID
          ) a
     LEFT JOIN   dbo.ZONE_MAP c (NOLOCK)         --It is possible that the REGIONALIZED_ZONE.ZONE_NAME has not been mapped
     ON     a.ZONE_NAME            = c.ZONE_NAME
     LEFT JOIN   dbo.SDB_Market d (NOLOCK)
     ON     a.SDBSourceID           = d.SDBSourceID
     AND     c.MarketID            = d.MarketID
     WHERE    d.SDB_MarketID           IS NULL
     AND     c.MarketID            IS NOT NULL
     GROUP BY   c.MarketID

     SET   @ErrorID = 0
     SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market Success Step'
  END TRY
  BEGIN CATCH
     SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
     SET   @ErrorID = @ErrNum
     SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market Fail Step'
  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveSDB_IESPOT]'
GO
ALTER PROCEDURE [dbo].[SaveSDB_IESPOT]
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @SDBSourceID   INT,
  @SDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveSDB_IESPOT
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:    Upserts the SPOT IE to SPOT map to DINGODB and assigns the mapping with a DINGODB IESPOT ID.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveSDB_IESPOT.proc.sql 3144 2013-11-20 22:13:28Z tlew $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveSDB_IESPOT 
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @SDBSourceID  = 1,
//        @SDBName   = 'MSSNKNLSDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  --SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @LogIDReturn  INT
  DECLARE  @ErrNum    INT
  DECLARE  @ErrMsg    VARCHAR(200)
  DECLARE  @EventLogStatusID INT = 1  --Unidentified Step
  DECLARE  @TempTableCount  INT
  DECLARE  @ZONECount   INT
  DECLARE  @UTCNow    DATETIME     = GETUTCDATE()
  DECLARE  @RegionID   INT


  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @SDBSourceID,
       @DBComputerName  = @SDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT


  SELECT    TOP 1 @RegionID       = m.RegionID
  FROM    dbo.SDBSource s WITH (NOLOCK)
  JOIN    dbo.MDBSource m WITH (NOLOCK)
  ON     s.MDBSourceID       = m.MDBSourceID
  WHERE    s.SDBSourceID       = @SDBSourceID

  --  Delete channels where the channel did NOT come back on the SDB import
  --  This has larger implications for the SDB_IESPOT table because it is 
  --  being used elsewhere and for different reasons.
  --  Therefore, it is being commented out until further discussion
  --DELETE    a
  --FROM    dbo.SDB_IESPOT a
  --LEFT JOIN   #ImportIE_SPOT b
  --ON     a.SDBSourceID       = b.SDBSourceID
  --AND     a.IU_ID         = b.IU_ID
  --AND     a.SPOT_ID        = b.SPOT_ID
  --WHERE    a.SDBSourceID       = @SDBSourceID
  --AND     b.ImportIE_SPOTID      IS NULL

  BEGIN TRY
   UPDATE   dbo.SDB_IESPOT
   SET
       IU_ID         = a.IU_ID,
       SCHED_DATE        = a.SCHED_DATE,
       SCHED_DATE_TIME       = a.SCHED_DATE_TIME,
       UTC_SCHED_DATE       = a.UTC_SCHED_DATE,
       UTC_SCHED_DATE_TIME      = a.UTC_SCHED_DATE_TIME,
       IE_NSTATUS        = a.IE_NSTATUS,
       IE_CONFLICT_STATUS      = a.IE_CONFLICT_STATUS,
       SPOTS         = a.SPOTS,
       IE_DURATION        = a.IE_DURATION,
       IE_RUN_DATE_TIME      = a.IE_RUN_DATE_TIME,
       UTC_IE_RUN_DATE_TIME     = a.UTC_IE_RUN_DATE_TIME,
       BREAK_INWIN        = a.BREAK_INWIN,
       AWIN_START_DT       = a.AWIN_START_DT,
       AWIN_END_DT        = a.AWIN_END_DT,
       UTC_AWIN_START_DT      = a.UTC_AWIN_START_DT,
       UTC_AWIN_END_DT       = a.UTC_AWIN_END_DT,
       IE_SOURCE_ID       = a.IE_SOURCE_ID,
       VIDEO_ID        = a.VIDEO_ID,
       ASSET_DESC        = a.ASSET_DESC,
       SPOT_DURATION       = a.SPOT_DURATION,
       SPOT_NSTATUS       = a.SPOT_NSTATUS,
       SPOT_CONFLICT_STATUS     = a.SPOT_CONFLICT_STATUS,
       SPOT_ORDER        = a.SPOT_ORDER,
       SPOT_RUN_DATE_TIME      = a.SPOT_RUN_DATE_TIME,
       UTC_SPOT_RUN_DATE_TIME     = a.UTC_SPOT_RUN_DATE_TIME,
       RUN_LENGTH        = a.RUN_LENGTH,
       SPOT_SOURCE_ID       = a.SPOT_SOURCE_ID,
       UTC_SPOT_NSTATUS_UPDATE_TIME   = CASE WHEN SDB_IESPOT.SPOT_NSTATUS   <> a.SPOT_NSTATUS   THEN @UTCNow ELSE UTC_SPOT_NSTATUS_UPDATE_TIME END,
       UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME = CASE WHEN SDB_IESPOT.SPOT_CONFLICT_STATUS <> a.SPOT_CONFLICT_STATUS THEN @UTCNow ELSE UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME END,
       UTC_IE_NSTATUS_UPDATE_TIME    = CASE WHEN SDB_IESPOT.IE_NSTATUS   <> a.IE_NSTATUS    THEN @UTCNow ELSE UTC_IE_NSTATUS_UPDATE_TIME END,
       UTC_IE_CONFLICT_STATUS_UPDATE_TIME  = CASE WHEN SDB_IESPOT.IE_CONFLICT_STATUS <> a.IE_CONFLICT_STATUS  THEN @UTCNow ELSE UTC_IE_CONFLICT_STATUS_UPDATE_TIME END,

       UpdateDate        = @UTCNow
   FROM   dbo.Conflict c with (NOLOCK)
   JOIN   #ImportIE_SPOT a
   ON    c.SDBSourceID       = a.SDBSourceID
   AND    c.IU_ID         = a.IU_ID
   AND    c.SPOT_ID        = a.SPOT_ID
   WHERE   SDB_IESPOT.SDBSourceID     = a.SDBSourceID
   AND    SDB_IESPOT.SPOT_ID      = a.SPOT_ID
   AND    SDB_IESPOT.IE_ID      = a.IE_ID
   AND    (
       SDB_IESPOT.SPOT_NSTATUS     <> a.SPOT_NSTATUS
       OR SDB_IESPOT.SPOT_CONFLICT_STATUS  <> a.SPOT_CONFLICT_STATUS
       OR SDB_IESPOT.IE_NSTATUS    <> a.IE_NSTATUS
       OR SDB_IESPOT.IE_CONFLICT_STATUS  <> a.IE_CONFLICT_STATUS
       )



   INSERT  dbo.SDB_IESPOT
      (
       SDBSourceID,
       SPOT_ID,
       IE_ID,
       IU_ID,
       SCHED_DATE,
       SCHED_DATE_TIME,
       UTC_SCHED_DATE,
       UTC_SCHED_DATE_TIME,
       IE_NSTATUS,
       IE_CONFLICT_STATUS,
       SPOTS,
       IE_DURATION,
       IE_RUN_DATE_TIME,
       UTC_IE_RUN_DATE_TIME,
       BREAK_INWIN,
       AWIN_START_DT,
       AWIN_END_DT,
       UTC_AWIN_START_DT,
       UTC_AWIN_END_DT,
       IE_SOURCE_ID,
       VIDEO_ID,
       ASSET_DESC,
       SPOT_DURATION,
       SPOT_NSTATUS,
       SPOT_CONFLICT_STATUS,
       SPOT_ORDER,
       SPOT_RUN_DATE_TIME,
       UTC_SPOT_RUN_DATE_TIME,
       RUN_LENGTH,
       SPOT_SOURCE_ID,
       UTC_SPOT_NSTATUS_UPDATE_TIME,
       UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME,
       UTC_IE_NSTATUS_UPDATE_TIME,
       UTC_IE_CONFLICT_STATUS_UPDATE_TIME,
       CreateDate
      )
   SELECT
       a.SDBSourceID       AS SDBSourceID,
       a.SPOT_ID        AS SPOT_ID,
       a.IE_ID         AS IE_ID,
       a.IU_ID         AS IU_ID,
       a.SCHED_DATE       AS SCHED_DATE,
       a.SCHED_DATE_TIME      AS SCHED_DATE_TIME,
       a.UTC_SCHED_DATE      AS UTC_SCHED_DATE,
       a.UTC_SCHED_DATE_TIME     AS UTC_SCHED_DATE_TIME,
       a.IE_NSTATUS       AS IE_NSTATUS,
       a.IE_CONFLICT_STATUS     AS IE_CONFLICT_STATUS,
       a.SPOTS         AS SPOTS,
       a.IE_DURATION       AS IE_DURATION,
       a.IE_RUN_DATE_TIME      AS IE_RUN_DATE_TIME,
       a.UTC_IE_RUN_DATE_TIME     AS UTC_IE_RUN_DATE_TIME,
       a.BREAK_INWIN       AS BREAK_INWIN,
       a.AWIN_START_DT       AS AWIN_START_DT,
       a.AWIN_END_DT       AS AWIN_END_DT,
       a.UTC_AWIN_START_DT      AS UTC_AWIN_START_DT,
       a.UTC_AWIN_END_DT      AS UTC_AWIN_END_DT,
       a.IE_SOURCE_ID       AS IE_SOURCE_ID,
       a.VIDEO_ID        AS VIDEO_ID,
       a.ASSET_DESC       AS ASSET_DESC,
       a.SPOT_DURATION       AS SPOT_DURATION,
       a.SPOT_NSTATUS       AS SPOT_NSTATUS,
       a.SPOT_CONFLICT_STATUS     AS SPOT_CONFLICT_STATUS,
       a.SPOT_ORDER       AS SPOT_ORDER,
       a.SPOT_RUN_DATE_TIME     AS SPOT_RUN_DATE_TIME,
       a.UTC_SPOT_RUN_DATE_TIME    AS UTC_SPOT_RUN_DATE_TIME,
       a.RUN_LENGTH       AS RUN_LENGTH,
       a.SPOT_SOURCE_ID      AS SPOT_SOURCE_ID,
       @UTCNow         AS UTC_SPOT_NSTATUS_UPDATE_TIME,
       @UTCNow         AS UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME,
       @UTCNow         AS UTC_IE_NSTATUS_UPDATE_TIME,
       @UTCNow         AS UTC_IE_CONFLICT_STATUS_UPDATE_TIME,
       @UTCNow         AS CreateDate
   FROM   #ImportIE_SPOT a
   JOIN   dbo.REGIONALIZED_IU riu WITH (NOLOCK) --We only care about zone names we recognize/have mapped
   ON    a.IU_ID         = riu.IU_ID
   LEFT JOIN  dbo.SDB_IESPOT b 
   ON    a.SDBSourceID       = b.SDBSourceID
   AND    a.SPOT_ID        = b.SPOT_ID
   AND    a.IE_ID         = b.IE_ID
   WHERE   b.SDB_IESPOTID       IS NULL
   AND    riu.REGIONID       = @RegionID
   AND    (
       a.SPOT_NSTATUS       = 1
       OR a.SPOT_NSTATUS      >= 6
       )
   AND    a.SPOT_RUN_DATE_TIME     IS NULL



   SET   @ErrorID = 0
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT Success Step'
  END TRY
  BEGIN CATCH
   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID = @ErrNum
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT Fail Step'
  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveConflict]'
GO
ALTER PROCEDURE [dbo].[SaveConflict]
  @SDBSourceID  INT,
  @SDBUTCOffset  INT,
  @ErrorID   INT = 0 OUTPUT
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
// Module:  dbo.SaveConflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Saves Conflict of the logical SDB.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveConflict.proc.sql 3225 2013-12-04 19:53:55Z tlew $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveConflict 
//        @SDBSourceID  = 1,
//        @SDBUTCOffset  = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//
*/ 
-- =============================================
BEGIN


  --SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;
  
  DECLARE    @RegionID  INT
  DECLARE    @NowSDBTime  DATETIME
  
  SELECT    @NowSDBTime  = DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
  SET     @ErrorID            = 1

  IF  ISNULL(OBJECT_ID('tempdb..#Conflict'), 0) > 0 
    DROP TABLE  #Conflict

  CREATE TABLE #Conflict 
      (
       ID INT Identity(1,1),
       SDBSourceID INT,
       IU_ID INT,
       SPOT_ID INT,
       ASSET_ID VARCHAR(32),
       ASSET_DESC VARCHAR(334),
       AWIN_END_DT DATETIME,
       SCHED_DATE_TIME DATETIME,
       SPOT_NSTATUS INT
      )


  SELECT    TOP 1 @RegionID           = RegionID
  FROM    dbo.SDBSource s (NOLOCK)
  JOIN    dbo.MDBSource m (NOLOCK)
  ON     s.MDBSourceID           = m.MDBSourceID
  WHERE    s.SDBSourceID           = @SDBSourceID     


  INSERT    #Conflict 
        (
         SDBSourceID,
         IU_ID,
         SPOT_ID,
         ASSET_ID,
         ASSET_DESC,
         AWIN_END_DT,
         SCHED_DATE_TIME,
         SPOT_NSTATUS
        )
  SELECT    @SDBSourceID           AS SDBSourceID,
       y.IU_ID,
       y.SPOT_ID,
       y.VIDEO_ID            AS ASSET_ID,
       y.ASSET_DESC,
       y.AWIN_END_DT,
       y.SCHED_DATE_TIME,
       y.SPOT_NSTATUS
  FROM    dbo.ChannelStatus w (NOLOCK)
  JOIN    #ImportIE_SPOT y 
  ON     w.SDBSourceID           = y.SDBSourceID
  AND     w.IU_ID             = y.IU_ID
  WHERE    w.SDBSourceID           = @SDBSourceID
  AND     y.SPOT_RUN_DATE_TIME         IS NULL
  AND     y.AWIN_END_DT           >= @NowSDBTime
  AND     (
        y.SPOT_NSTATUS          = 1 
       OR y.SPOT_NSTATUS          >= 6
       )


  --     Delete channels where the channel did NOT come back on the SDB import
  DELETE    a
  FROM    dbo.Conflict a
  LEFT JOIN   #ImportIE_SPOT b
  ON     a.SDBSourceID           = b.SDBSourceID
  AND     a.IU_ID             = b.IU_ID
  AND     a.SPOT_ID            = b.SPOT_ID
  WHERE    a.SDBSourceID           = @SDBSourceID
  AND     b.ImportIE_SPOTID          IS NULL


  DELETE    a
  FROM    dbo.Conflict a
  JOIN    #ImportIE_SPOT b 
  ON     a.SDBSourceID           = b.SDBSourceID
  AND     a.IU_ID             = b.IU_ID
  AND     a.SPOT_ID            = b.SPOT_ID
  WHERE    a.SDBSourceID           = @SDBSourceID
  AND     a.IU_ID             = b.IU_ID
  AND     a.SPOT_ID            = b.SPOT_ID
  AND     (
        b.SPOT_RUN_DATE_TIME        IS NOT NULL
       OR b.AWIN_END_DT          < @NowSDBTime
       OR b.SPOT_NSTATUS          BETWEEN 2 and 5
       OR               ((b.SPOT_NSTATUS = 1) AND (b.IE_NSTATUS = 4))
       )



  INSERT    dbo.Conflict 
        (
         SDBSourceID,
         IU_ID,
         SPOT_ID,
         Time,
         UTCTime,
         Asset_ID,
         Asset_Desc,
         Conflict_Code,
         Scheduled_Insertions,
         CreateDate,
         UpdateDate
        )
  SELECT     
       @SDBSourceID           AS SDBSourceID,
       a.IU_ID,
       a.SPOT_ID,
       a.SCHED_DATE_TIME          AS Time,
       DATEADD(HOUR,@SDBUTCOffset*(-1),a.SCHED_DATE_TIME)  AS UTCTime,
       a.Asset_ID            AS Asset_ID,
       a.ASSET_DESC           AS Asset_Desc,
       a.SPOT_NSTATUS           AS Conflict_Code,
       b.Scheduled_Insertions         AS Scheduled_Insertions,
       GETUTCDATE()           AS CreateDate,
       GETUTCDATE()           AS UpdateDate
  FROM    #Conflict a
  LEFT JOIN   (
         SELECT  Asset_ID, COUNT(1) AS Scheduled_Insertions
         FROM  #Conflict x
         GROUP BY Asset_ID
       ) b 
  ON     a.Asset_ID            = b.Asset_ID
  LEFT JOIN   dbo.Conflict c 
  ON     a.SDBSourceID           = c.SDBSourceID
  AND     a.IU_ID             = c.IU_ID
  AND     a.SPOT_ID            = c.SPOT_ID
  WHERE    c.ConflictID           IS NULL
  SET     @ErrorID            = 0  --SUCCESS

  DROP TABLE   #Conflict

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveChannelStatus]'
GO
ALTER PROCEDURE [dbo].[SaveChannelStatus]
		@RegionID			INT,
		@SDBSourceID		INT,
		@SDBUTCOffset		INT,
		@ErrorID			INT OUTPUT
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
// Module:  dbo.SaveChannelStatus
// Created: 2013-Nov-25
// Author:  Tony Lew
// 
// Purpose: 		Upsert the ChannelStatus table for the channels 
//					for a given region and SDB within the context of the executing job
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveChannelStatus.proc.sql 3562 2014-02-26 23:49:11Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveChannelStatus 
//								@RegionID			= 0,
//								@SDBSourceID		= 1,
//								@SDBUTCOffset		= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE			@Today DATE
		DECLARE			@NextDay DATE
		DECLARE			@NowSDBTime DATETIME

		DECLARE			@MTE_Conflicts_Window1 DATETIME
		DECLARE			@MTE_Conflicts_Window2 DATETIME
		DECLARE			@MTE_Conflicts_Window3 DATETIME
		
		SELECT			@NowSDBTime		= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )

		SELECT			@Today = CONVERT( DATE, @NowSDBTime ), @NextDay = CONVERT( DATE, DATEADD(DAY, 1, @NowSDBTime) )
		SET				@ErrorID = 1

		SELECT			@MTE_Conflicts_Window1					= DATEADD( HOUR, 4, @NowSDBTime),
						@MTE_Conflicts_Window2					= DATEADD( HOUR, 6, @NowSDBTime),
						@MTE_Conflicts_Window3					= DATEADD( HOUR, 8, @NowSDBTime)



		IF		ISNULL(OBJECT_ID('tempdb..#ChannelStatistics'), 0) > 0 
				DROP TABLE		#ChannelStatistics

				CREATE TABLE	#ChannelStatistics 
						(
							ID INT Identity(1,1),
							RUN_DATE DATE,
							IU_ID INT,
							ZONE_ID INT,
							ZONE_NAME VARCHAR(32),
							SDBSourceID INT,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday FLOAT,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay FLOAT,
							/* TOTAL DTM Insertions*/
							DTM_Total FLOAT,
							/* DTM Successfuly Insertions */
							DTM_Played FLOAT,
							/* DTM Failed Insertions */
							DTM_Failed FLOAT,
							/* DTM NoTone's */
							DTM_NoTone FLOAT,
							/* DTM mpeg errors */
							DTM_MpegError FLOAT,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy FLOAT,

							/* MTE Conflicts for Today */
							MTE_Conflicts FLOAT,
							/* MTE Conflicts for Window 1 */
							MTE_Conflicts_Window1 FLOAT,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window2 FLOAT,
							/* MTE Conflicts for Window 3 */
							MTE_Conflicts_Window3 FLOAT,

							/* MTE Conflicts for next day */
							MTE_ConflictsNextDay FLOAT,

							/* IC Provider Breakdown */
							ICTotal FLOAT,
							ICTotalNextDay FLOAT,
							DTM_ICTotal FLOAT,
							DTM_ICPlayed FLOAT,
							DTM_ICFailed FLOAT,
							DTM_ICNoTone FLOAT,
							DTM_ICMpegError FLOAT,
							DTM_ICMissingCopy FLOAT,

							MTE_ICConflicts FLOAT,
							MTE_ICConflicts_Window1 FLOAT,
							MTE_ICConflicts_Window2 FLOAT,
							MTE_ICConflicts_Window3 FLOAT,
							MTE_ICConflictsNextDay FLOAT,

							IC_LastSchedule_Load  [datetime],
							IC_NextDay_LastSchedule_Load [datetime],

							/* AT&T Breakdown */
							ATTTotal FLOAT,
							ATTTotalNextDay FLOAT,
							DTM_ATTTotal FLOAT,
							DTM_ATTPlayed FLOAT,
							DTM_ATTFailed FLOAT,
							DTM_ATTNoTone FLOAT,
							DTM_ATTMpegError FLOAT,
							DTM_ATTMissingCopy FLOAT,

							MTE_ATTConflicts FLOAT,
							MTE_ATTConflicts_Window1 FLOAT,
							MTE_ATTConflicts_Window2 FLOAT,
							MTE_ATTConflicts_Window3 FLOAT,
							MTE_ATTConflictsNextDay FLOAT,

							ATT_LastSchedule_Load [datetime],
							ATT_NextDay_LastSchedule_Load [datetime]
						)


		IF		ISNULL(OBJECT_ID('tempdb..#ChannelStatus'), 0) > 0 
				DROP TABLE		#ChannelStatus

				CREATE TABLE	#ChannelStatus 
						(
							ID INT Identity(1,1),
							ChannelStatusID INT,
							ChannelStats_ID INT,
							IU_ID INT,
							RegionID INT,
							RUN_DATE DATE,
							ZONE_MAP_ID INT,
							RegionalizedZoneID INT,
							ZoneID INT,
							ZONE_NAME VARCHAR(32),
							SDBSourceID INT,
							TSI VARCHAR(32),
							ICProvider VARCHAR(32),
							/* Calculated columns */
							DTM_Failed_Rate FLOAT,
							DTM_Run_Rate FLOAT,
							Forecast_Best_Run_Rate FLOAT,
							Forecast_Worst_Run_Rate FLOAT,
							NextDay_Forecast_Run_Rate FLOAT,
							DTM_NoTone_Rate FLOAT,
							DTM_NoTone_Count FLOAT,
							Consecutive_NoTone_Count FLOAT,
							Consecutive_Error_Count FLOAT,
							BreakCount INT,
							NextDay_BreakCount INT,
							Average_BreakCount INT,

							ATT_DTM_Failed_Rate	FLOAT,
							ATT_DTM_Run_Rate FLOAT,
							ATT_Forecast_Best_Run_Rate	FLOAT,
							ATT_Forecast_Worst_Run_Rate	FLOAT,
							ATT_NextDay_Forecast_Run_Rate FLOAT,
							ATT_DTM_NoTone_Rate	FLOAT,
							ATT_DTM_NoTone_Count FLOAT,
							ATT_BreakCount INT NULL,
							ATT_NextDay_BreakCount INT NULL,
							ATT_LastSchedule_Load [datetime] NULL,
							ATT_NextDay_LastSchedule_Load [datetime] NULL,

							IC_DTM_Failed_Rate	FLOAT,
							IC_DTM_Run_Rate	FLOAT,
							IC_Forecast_Best_Run_Rate	FLOAT,
							IC_Forecast_Worst_Run_Rate	FLOAT,
							IC_NextDay_Forecast_Run_Rate	FLOAT,
							IC_DTM_NoTone_Rate	FLOAT,
							IC_DTM_NoTone_Count	FLOAT,
							IC_BreakCount INT NULL,
							IC_NextDay_BreakCount INT NULL,
							IC_LastSchedule_Load  [datetime] NULL,
							IC_NextDay_LastSchedule_Load [datetime] NULL

						)


		INSERT		#ChannelStatistics 
						(
							RUN_DATE,
							IU_ID,
							ZONE_ID,
							ZONE_NAME,
							SDBSourceID,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay,
							/* TOTAL DTM Insertions*/
							DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy,

							/* MTE Confilcts for Today */
							MTE_Conflicts,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window1,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window2,
							/* MTE Conflicts for Window 3 */
							MTE_Conflicts_Window3,
							/* MTE Conflicts for next day */
							MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal,
							ICTotalNextDay,
							DTM_ICTotal,
							DTM_ICPlayed,
							DTM_ICFailed,
							DTM_ICNoTone,
							DTM_ICMpegError,
							DTM_ICMissingCopy,

							MTE_ICConflicts,
							MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3,
							MTE_ICConflictsNextDay,

							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load,

							/* AT&T Breakdown */
							ATTTotal,
							ATTTotalNextDay,
							DTM_ATTTotal,
							DTM_ATTPlayed,
							DTM_ATTFailed,
							DTM_ATTNoTone,
							DTM_ATTMpegError,
							DTM_ATTMissingCopy,

							MTE_ATTConflicts,
							MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3,
							MTE_ATTConflictsNextDay,

							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load
						)
		SELECT
							RUN_DATE							= @Today,
							IU.IU_ID,
							IU.ZONE,
							IU.ZONE_NAME,
							SDBSourceID							= @SDBSourceID,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday				= SUM(IESPOT.CNT),
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay				= SUM(IESPOTNextDay.CNT),
							/* TOTAL DTM Insertions*/
							DTM_Total							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) THEN IESPOT.CNT ELSE 0 END),
							/* DTM Successfuly Insertions */
							DTM_Played							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							/* DTM Failed Insertions */
							DTM_Failed							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							/* DTM NoTone's */
							DTM_NoTone							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							/* DTM mpeg errors */
							DTM_MpegError						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),

							/* MTE Conflicts for Today */
							MTE_Conflicts						= SUM( ISNULL(IESPOT.MTE_Conflicts_Total,0) ),
							MTE_Conflicts_Window1				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window1,0) ),
							MTE_Conflicts_Window2				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window2,0) ),
							MTE_Conflicts_Window3				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window3,0) ),
							/* MTE Conflicts for Next day */
							MTE_ConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_Conflicts_Total,0) ),

							/* IC Provider Breakdown */
							ICTotal								= SUM(CASE WHEN IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.CNT ELSE 0 END),
							ICTotalNextDay						= SUM(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 2 THEN IESPOTNextDay.CNT ELSE 0 END),
							DTM_ICTotal							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICPlayed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICFailed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							DTM_ICNoTone						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICMpegError						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							DTM_ICMissingCopy					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),
							MTE_ICConflicts						= SUM( ISNULL(IESPOT.MTE_ICConflicts_Total,0) ),
							MTE_ICConflicts_Window1				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window1,0) ),
							MTE_ICConflicts_Window2				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window2,0) ),
							MTE_ICConflicts_Window3				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window3,0) ),
							MTE_ICConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_ICConflicts_Total,0) ),
							IC_LastSchedule_Load				= MAX(CASE WHEN IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.LastSchedule_Load END),
							IC_NextDay_LastSchedule_Load		= MAX(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 2 THEN IESPOTNextDay.LastSchedule_Load END),

							/* AT&T Breakdown */
							ATTTotal							= SUM(CASE WHEN IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.CNT ELSE 0 END),
							ATTTotalNextDay						= SUM(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 1 THEN IESPOTNextDay.CNT ELSE 0 END),
							DTM_ATTTotal						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTPlayed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTFailed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTNoTone						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTMpegError					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTMissingCopy					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),
							MTE_ATTConflicts					= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Total,0) ),
							MTE_ATTConflicts_Window1			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window1,0) ),
							MTE_ATTConflicts_Window2			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window2,0) ),
							MTE_ATTConflicts_Window3			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window3,0) ),
							MTE_ATTConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_ATTConflicts_Total,0) ),

							ATT_LastSchedule_Load				= MAX(CASE WHEN IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.LastSchedule_Load END),
							ATT_NextDay_LastSchedule_Load		= MAX(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 1 THEN IESPOTNextDay.LastSchedule_Load END)

		FROM 
						(
							SELECT 
											a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS,
											LastSchedule_Load				= MAX(b.FILE_DATETIME),

											MTE_Conflicts_Total				= SUM(	CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) THEN 1 ELSE 0 END ),
											MTE_Conflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--IC conflict windows
											MTE_ICConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--ATT conflict windows
											MTE_ATTConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window1		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window2		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window3		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),


											COUNT(1) AS CNT
							FROM			#ImportIE_SPOT a
							LEFT JOIN		(
												SELECT		MAX(itb.FILE_DATETIME) AS FILE_DATETIME,
															IU_ID,
															SOURCE_ID,
															SCHED_DATE
												FROM		#ImportTB_REQUEST AS itb
												WHERE		itb.SCHED_DATE = @Today
												GROUP BY	IU_ID,
															SOURCE_ID,
															SCHED_DATE
											) AS b
							ON    			a.IU_ID							= b.IU_ID 
							AND				a.IE_SOURCE_ID					= b.SOURCE_ID
							WHERE			a.SCHED_DATE					= @Today
							AND				a.SCHED_DATE					= ISNULL(b.SCHED_DATE, a.SCHED_DATE)
							GROUP BY		a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS
						)	AS IESPOT
		FULL JOIN
						(
							SELECT 
											a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS,
											LastSchedule_Load				= MAX(b.FILE_DATETIME),


											MTE_Conflicts_Total				= SUM(	CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) THEN 1 ELSE 0 END ),
											MTE_Conflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--IC conflict windows
											MTE_ICConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--ATT conflict windows
											MTE_ATTConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window1		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window2		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window3		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),


											COUNT(1) AS CNT
							FROM			#ImportIE_SPOT a
							LEFT JOIN		(
												SELECT		MAX(itb.FILE_DATETIME) AS FILE_DATETIME,
															IU_ID,
															SOURCE_ID,
															SCHED_DATE
												FROM		#ImportTB_REQUEST AS itb
												WHERE		itb.SCHED_DATE = @NextDay
												GROUP BY	IU_ID,
															SOURCE_ID,
															SCHED_DATE
											) AS b
							ON				a.IU_ID							= b.IU_ID  
							AND				a.IE_SOURCE_ID					= b.SOURCE_ID
							WHERE			a.SCHED_DATE					= @NextDay
							AND				a.SCHED_DATE					= ISNULL(b.SCHED_DATE, a.SCHED_DATE)
							GROUP BY		a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS
						)  AS IESPOTNextDay
		ON				IESPOT.IU_ID															= IESPOTNextDay.IU_ID
		AND				IESPOT.IE_SOURCE_ID 													= IESPOTNextDay.IE_SOURCE_ID
		AND				IESPOT.IE_NSTATUS 														= IESPOTNextDay.IE_NSTATUS
		AND				IESPOT.IE_CONFLICT_STATUS 												= IESPOTNextDay.IE_CONFLICT_STATUS
		AND				IESPOT.SPOT_NSTATUS 													= IESPOTNextDay.SPOT_NSTATUS
		AND				IESPOT.SPOT_CONFLICT_STATUS 											= IESPOTNextDay.SPOT_CONFLICT_STATUS
		JOIN			dbo.REGIONALIZED_IU  IU (NOLOCK)
		ON				IESPOT.IU_ID															= IU.IU_ID
		OR				IESPOTNextDay.IU_ID														= IU.IU_ID
		WHERE			IU.RegionID																= @RegionID
		GROUP BY		IU.IU_ID,
						IU.CHANNEL,
						IU.CHAN_NAME,
						IU.ZONE_NAME,
						IU.ZONE
		ORDER BY		IU.CHANNEL,
						IU.CHAN_NAME,
						IU.ZONE_NAME,
						IU.ZONE,
						IU.IU_ID



		INSERT			#ChannelStatus 
						(
							ChannelStatusID,
							ChannelStats_ID,
							IU_ID,
							RegionID,
							RUN_DATE,
							ZONE_MAP_ID,
							RegionalizedZoneID,
							ZoneID,
							ZONE_NAME,
							SDBSourceID,

							DTM_Failed_Rate,
							DTM_Run_Rate,
							Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate,
							DTM_NoTone_Count,
							Consecutive_NoTone_Count,
							Consecutive_Error_Count,
							BreakCount,
							NextDay_BreakCount,
							Average_BreakCount,

							ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count,
							ATT_BreakCount,
							ATT_NextDay_BreakCount,
							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load,

							IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count,
							IC_BreakCount,
							IC_NextDay_BreakCount,
							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load

						)
		SELECT			
							cs.ChannelStatusID													AS ChannelStatusID,
							a.ID																AS ChannelStats_ID,
							a.IU_ID,
							@RegionID															AS RegionID,
							a.RUN_DATE,
							zm.ZONE_MAP_ID,
							z.REGIONALIZED_ZONE_ID												AS RegionalizedZoneID,
							a.ZONE_ID															AS ZoneID,
							a.ZONE_NAME															AS ZONE_NAME,
							a.SDBSourceID														AS SDBSourceID,

							CASE WHEN ISNULL(a.DTM_Total, 0) = 0 OR ISNULL((a.DTM_Total-a.DTM_NoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_Failed - a.DTM_NoTone) / a.DTM_Total) * 100.00
						   END                 AS DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_Total, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_Total-a.DTM_NoTone) = 0 THEN 100.00 
							 ELSE (a.DTM_Played / (a.DTM_Total-a.DTM_NoTone)) * 100.00
						   END                 AS DTM_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsToday, 0) = 0 THEN 100.00
								WHEN  (a.TotalInsertionsToday-a.DTM_NoTone) = 0 THEN 100.00
							 ELSE (( a.TotalInsertionsToday - a.DTM_Failed ) / (a.TotalInsertionsToday-a.DTM_NoTone)) * 100.00
						   END                 AS Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsToday, 0) = 0 THEN 100.00
								WHEN  (a.TotalInsertionsToday-a.DTM_NoTone) = 0 THEN 100.00 
							 ELSE (( a.TotalInsertionsToday - (a.DTM_Failed + a.MTE_Conflicts)) / (a.TotalInsertionsToday-a.DTM_NoTone)) * 100.00
						   END                 AS Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.TotalInsertionsNextDay - a.MTE_ConflictsNextDay ) / a.TotalInsertionsNextDay) * 100.00
						   END                 AS NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_Total, 0) = 0 THEN 0.00 
							 ELSE (a.DTM_NoTone / a.DTM_Total) * 100.00
						   END                 AS DTM_NoTone_Rate,
							a.DTM_NoTone														AS DTM_NoTone_Count,
							ISNULL(b.ConsecutiveNoTones, 0)										AS Consecutive_NoTone_Count,
							ISNULL(ce.ConsecutiveErrors, 0)										AS Consecutive_Error_Count,
							ISNULL(d.BREAK_COUNT_Today, 0)										AS BreakCount,
							ISNULL(d.BREAK_COUNT_NextDay, 0)									AS NextDay_BreakCount,
							ISNULL(c.BreakCountAVG, 0)											AS Average_BreakCount,

							CASE WHEN ISNULL(a.DTM_ATTTotal, 0) = 0 OR ISNULL((a.DTM_ATTTotal-a.DTM_ATTNoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_ATTFailed - a.DTM_ATTNoTone) / a.DTM_ATTTotal) * 100.00
						   END                 AS ATT_DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_ATTTotal, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100 
							 ELSE (a.DTM_ATTPlayed / (a.DTM_ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_DTM_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotal, 0) = 0 THEN 100.00
								WHEN (a.ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100 
							 ELSE (( a.ATTTotal - a.DTM_ATTFailed ) / (a.ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotal, 0) = 0 THEN 100.00
								WHEN (a.ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100  
							 ELSE (( a.ATTTotal - (a.DTM_ATTFailed + a.MTE_ATTConflicts)) / (a.ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotalNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.ATTTotalNextDay - a.MTE_ATTConflictsNextDay ) / a.ATTTotalNextDay) * 100.00
						   END                 AS ATT_NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_ATTTotal , 0)= 0 THEN 0.00 
							 ELSE (a.DTM_ATTNoTone / a.DTM_ATTTotal) * 100.00
						   END                 AS ATT_DTM_NoTone_Rate,
	   
							a.DTM_ATTNoTone														AS ATT_DTM_NoTone_Count,
							ISNULL(d.ATT_BREAK_COUNT_Today, 0)									AS ATT_BreakCount,
							ISNULL(d.ATT_BREAK_COUNT_NextDay, 0)								AS ATT_NextDay_BreakCount,
							a.ATT_LastSchedule_Load,
							a.ATT_NextDay_LastSchedule_Load,


							CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 OR ISNULL((a.DTM_ICTotal-a.DTM_ICNoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_ICFailed - a.DTM_ICNoTone) / a.DTM_ICTotal) * 100.00
						   END                 AS IC_DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_ICTotal-a.DTM_ICNoTone) = 0 THEN 100.00 
							 ELSE (a.DTM_ICPlayed / (a.DTM_ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_DTM_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotal, 0) = 0 THEN 100.00 
								WHEN (a.ICTotal-a.DTM_ICNoTone) = 0 THEN 100 
							 ELSE (( a.ICTotal - a.DTM_ICFailed ) / (a.ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotal, 0) = 0 THEN 100.00 
								WHEN (a.ICTotal-a.DTM_ICNoTone) = 0 THEN 100 
							 ELSE (( a.ICTotal - (a.DTM_ICFailed + a.MTE_ICConflicts)) / (a.ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotalNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.ICTotalNextDay - a.MTE_ICConflictsNextDay ) / a.ICTotalNextDay) * 100.00
						   END                 AS IC_NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 THEN 0.00 
							 ELSE (a.DTM_ICNoTone / a.DTM_ICTotal) * 100.00
						   END                 AS IC_DTM_NoTone_Rate,
							
							a.DTM_ICNoTone														AS IC_DTM_NoTone_Count,
							ISNULL(d.IC_BREAK_COUNT_Today, 0)									AS IC_BreakCount,
							ISNULL(d.IC_BREAK_COUNT_NextDay, 0)									AS IC_NextDay_BreakCount,
							a.IC_LastSchedule_Load,
							a.IC_NextDay_LastSchedule_Load

		FROM			#ChannelStatistics a
		JOIN			( 
							SELECT		IU_ID, @RegionID AS REGION_ID 
							FROM		dbo.REGIONALIZED_IU (NOLOCK) 
							WHERE		REGIONID = @RegionID
						) IU
		ON				a.IU_ID																	= IU.IU_ID
		JOIN			dbo.ZONE_MAP zm (NOLOCK)
		ON				a.ZONE_NAME																= zm.ZONE_NAME
		JOIN			dbo.REGIONALIZED_ZONE z (NOLOCK)
		ON				a.ZONE_NAME																= z.ZONE_NAME
		AND				IU.REGION_ID															= z.REGION_ID
		LEFT JOIN		dbo.ChannelStatus cs 
		ON				a.SDBSourceID															= cs.SDBSourceID
		AND				a.IU_ID																	= cs.IU_ID
		AND				z.REGIONALIZED_ZONE_ID													= cs.RegionalizedZoneID
		LEFT JOIN		
					(
						SELECT		IE.IU_ID,
									COUNT(DISTINCT IE.IE_ID)						AS ConsecutiveNoTones
						FROM
								( 
									 SELECT
												IU_ID,
												COALESCE(MAX(CASE WHEN IE_CONFLICT_STATUS != 110 THEN [SCHED_DATE_TIME] END),'19700101')  AS LatestGood
									 FROM		#ImportIE_SPOT x
									 WHERE		x.SPOT_RUN_DATE_TIME IS NOT NULL
									 GROUP BY	x.IU_ID
								)	g
						JOIN		#ImportIE_SPOT IE 
						ON			IE.IU_ID										= g.IU_ID
						AND			SCHED_DATE_TIME									> g.LatestGood
						WHERE		IE.IE_CONFLICT_STATUS							= 110
						AND			IE.SPOT_RUN_DATE_TIME							IS NOT NULL
						GROUP BY	IE.IU_ID
					)	b
		ON				a.IU_ID														= b.IU_ID
		LEFT JOIN		
					(
						SELECT		IE.IU_ID,
									COUNT(1)										AS ConsecutiveErrors
						FROM
								( 
									SELECT
												IU_ID,
												COALESCE(MAX(
																CASE	WHEN	(x.SPOT_NSTATUS NOT IN (6, 7) OR (x.SPOT_NSTATUS = 6 AND x.SPOT_CONFLICT_STATUS = 14))
																		THEN	[SPOT_RUN_DATE_TIME] 
																		END
															)  
														,'19700101')				AS LatestNonError
									FROM		#ImportIE_SPOT x
									GROUP BY	x.IU_ID
								)	g
						 JOIN		#ImportIE_SPOT IE 
						 ON			IE.IU_ID 										= g.IU_ID
						 AND		SPOT_RUN_DATE_TIME								> g.LatestNonError
						 WHERE		IE.IE_NSTATUS 									IN (10,11,12,13,14,24)
						 AND		IE.SPOT_RUN_DTAE_TIME							IS NOT NULL
						 GROUP BY	IE.IU_ID
					)	ce
		ON				a.IU_ID														= ce.IU_ID
		LEFT JOIN	
					(	--For the Break Count Average, we do NOT care about today and tomorrow, only historical
						SELECT		
									bc.IU_ID,
									AVG(bc.SUM_BREAK_COUNT)							AS BreakCountAVG
						FROM		(
										SELECT		x.IU_ID,
													SUM(x.BREAK_COUNT)				AS SUM_BREAK_COUNT
										FROM		#ImportIUBreakCount x
										WHERE		x.BREAK_DATE					< @Today
										GROUP BY	x.IU_ID, x.BREAK_DATE
									) bc
						GROUP BY	bc.IU_ID
					) c  
		ON				a.IU_ID														= c.IU_ID
		LEFT JOIN
					(
						SELECT		x.IU_ID, 
									SUM(ISNULL(x.BREAK_COUNT_Today, 0)) AS BREAK_COUNT_Today,
									SUM(ISNULL(x.BREAK_COUNT_NextDay, 0)) AS BREAK_COUNT_NextDay,
									SUM(ISNULL(x.ATT_BREAK_COUNT_Today, 0)) AS ATT_BREAK_COUNT_Today,
									SUM(ISNULL(x.ATT_BREAK_COUNT_Nextday, 0)) AS ATT_BREAK_COUNT_Nextday,
									SUM(ISNULL(x.IC_BREAK_COUNT_Today, 0)) AS IC_BREAK_COUNT_Today,
									SUM(ISNULL(x.IC_BREAK_COUNT_Nextday, 0)) AS IC_BREAK_COUNT_Nextday
						FROM		(
										SELECT 
													bc.BREAK_DATE								AS BREAK_DATE,
													bc.IU_ID,
													CASE	WHEN	bc.BREAK_DATE = @Today 
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS BREAK_COUNT_Today,
													CASE	WHEN	bc.BREAK_DATE = @NextDay 
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS BREAK_COUNT_NextDay,
													CASE	WHEN	bc.SOURCE_ID = 1 
															AND		bc.BREAK_DATE = @Today
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS ATT_BREAK_COUNT_Today,
													CASE 
															WHEN	bc.SOURCE_ID = 1 
															AND		bc.BREAK_DATE = @NextDay  
															THEN	SUM(bc.BREAK_COUNT)
													END												AS ATT_BREAK_COUNT_Nextday,
													CASE 
															WHEN	bc.SOURCE_ID = 2 
															AND		bc.BREAK_DATE = @Today
															THEN	SUM(bc.BREAK_COUNT)
													END												AS IC_BREAK_COUNT_Today,
													CASE 
															WHEN	bc.SOURCE_ID = 2 
															AND		bc.BREAK_DATE = @NextDay 
															THEN	SUM(bc.BREAK_COUNT)
													END												AS IC_BREAK_COUNT_Nextday
										FROM		#ImportIUBreakCount bc
										WHERE		bc.BREAK_DATE >= @Today 
										GROUP BY	bc.IU_ID, bc.BREAK_DATE, bc.SOURCE_ID 
									) x
						GROUP BY	x.IU_ID
					)	d
		ON				a.IU_ID														= d.IU_ID

		WHERE			IU.REGION_ID												= @RegionID


		UPDATE			dbo.ChannelStatus
		SET
							/* TOTAL Insertions for today*/
							TotalInsertionsToday									= b.TotalInsertionsToday,

							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay									= b.TotalInsertionsNextDay,

							/* TOTAL DTM Insertions*/	
							DTM_Total												= b.DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played												= b.DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed												= b.DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone												= b.DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError											= b.DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy											= b.DTM_MissingCopy,
							/* MTE Confilcts for Today */
							MTE_Conflicts											= b.MTE_Conflicts,
							MTE_Conflicts_Window1									= b.MTE_Conflicts_Window1,
							MTE_Conflicts_Window2									= b.MTE_Conflicts_Window2,
							MTE_Conflicts_Window3									= b.MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							ConflictsNextDay										= b.MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal													= b.ICTotal,
							ICTotalNextDay											= b.ICTotalNextDay,
							DTM_ICTotal												= b.DTM_ICTotal,
							DTM_ICPlayed											= b.DTM_ICPlayed,
							DTM_ICFailed											= b.DTM_ICFailed,
							DTM_ICNoTone											= b.DTM_ICNoTone,
							DTM_ICMpegError											= b.DTM_ICMpegError,
							DTM_ICMissingCopy										= b.DTM_ICMissingCopy,
							MTE_ICConflicts											= b.MTE_ICConflicts,
							MTE_ICConflicts_Window1									= b.MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2									= b.MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3									= b.MTE_ICConflicts_Window3,
							ICConflictsNextDay										= b.MTE_ICConflictsNextDay,

							/* AT&T Breakdown */
							ATTTotal												= b.ATTTotal,
							ATTTotalNextDay											= b.ATTTotalNextDay,
							DTM_ATTTotal											= b.DTM_ATTTotal,
							DTM_ATTPlayed											= b.DTM_ATTPlayed,
							DTM_ATTFailed											= b.DTM_ATTFailed,
							DTM_ATTNoTone											= b.DTM_ATTNoTone,
							DTM_ATTMpegError										= b.DTM_ATTMpegError,
							DTM_ATTMissingCopy										= b.DTM_ATTMissingCopy,
							MTE_ATTConflicts										= b.MTE_ATTConflicts,		
							MTE_ATTConflicts_Window1								= b.MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2								= b.MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3								= b.MTE_ATTConflicts_Window3,
							ATTConflictsNextDay										= b.MTE_ATTConflictsNextDay,		

							/* Calculated Columns */
							DTM_Failed_Rate											= a.DTM_Failed_Rate,
							DTM_Run_Rate											= a.DTM_Run_Rate,
							Forecast_Best_Run_Rate									= a.Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate									= a.Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate								= a.NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate											= a.DTM_NoTone_Rate,
							DTM_NoTone_Count										= a.DTM_NoTone_Count,
							Consecutive_NoTone_Count								= ISNULL(a.Consecutive_NoTone_Count, 0),
							Consecutive_Error_Count									= ISNULL(a.Consecutive_Error_Count, 0),
							BreakCount												= a.BreakCount,
							NextDay_BreakCount										= a.NextDay_BreakCount,
							Average_BreakCount										= a.Average_BreakCount,

							ATT_DTM_Failed_Rate										= a.ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate										= a.ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate								= a.ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate								= a.ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate							= a.ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate										= a.ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count									= a.ATT_DTM_NoTone_Count,
							ATT_BreakCount											= a.ATT_BreakCount,
							ATT_NextDay_BreakCount									= a.ATT_NextDay_BreakCount,
							ATT_LastSchedule_Load									= a.ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load							= a.ATT_NextDay_LastSchedule_Load,

							IC_DTM_Failed_Rate										= a.IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate											= a.IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate								= a.IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate								= a.IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate							= a.IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate										= a.IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count										= a.IC_DTM_NoTone_Count,
							IC_BreakCount											= a.IC_BreakCount,
							IC_NextDay_BreakCount									= a.IC_NextDay_BreakCount,
							IC_LastSchedule_Load									= a.IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load							= a.IC_NextDay_LastSchedule_Load,

							UpdateDate												= GETUTCDATE()
		FROM				#ChannelStatus a
		JOIN				#ChannelStatistics b
		ON					a.ChannelStats_ID										= b.ID
		WHERE				ChannelStatus.ChannelStatusID							= a.ChannelStatusID


		--				IF the Channel does NOT come through from the SDB table, then blank the values.
		UPDATE			dbo.ChannelStatus
		SET
							/* TOTAL Insertions for today*/
							TotalInsertionsToday									= 0,

							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay									= 0,

							/* TOTAL DTM Insertions*/	
							DTM_Total												= 0,
							/* DTM Successfuly Insertions */
							DTM_Played												= 0,
							/* DTM Failed Insertions */
							DTM_Failed												= 0,
							/* DTM NoTone's */
							DTM_NoTone												= 0,
							/* DTM mpeg errors */
							DTM_MpegError											= 0,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy											= 0,
							/* MTE Confilcts for Today */
							MTE_Conflicts											= 0,
							MTE_Conflicts_Window1									= 0,
							MTE_Conflicts_Window2									= 0,
							MTE_Conflicts_Window3									= 0,
							/* MTE Confilcts for next day */
							ConflictsNextDay										= 0,

							/* IC Provider Breakdown */
							ICTotal													= 0,
							ICTotalNextDay											= 0,
							DTM_ICTotal												= 0,
							DTM_ICPlayed											= 0,
							DTM_ICFailed											= 0,
							DTM_ICNoTone											= 0,
							DTM_ICMpegError											= 0,
							DTM_ICMissingCopy										= 0,
							MTE_ICConflicts											= 0,
							MTE_ICConflicts_Window1									= 0,
							MTE_ICConflicts_Window2									= 0,
							MTE_ICConflicts_Window3									= 0,
							ICConflictsNextDay										= 0,

							/* AT&T Breakdown */
							ATTTotal												= 0,
							ATTTotalNextDay											= 0,
							DTM_ATTTotal											= 0,
							DTM_ATTPlayed											= 0,
							DTM_ATTFailed											= 0,
							DTM_ATTNoTone											= 0,
							DTM_ATTMpegError										= 0,
							DTM_ATTMissingCopy										= 0,
							MTE_ATTConflicts										= 0,		
							MTE_ATTConflicts_Window1								= 0,
							MTE_ATTConflicts_Window2								= 0,
							MTE_ATTConflicts_Window3								= 0,
							ATTConflictsNextDay										= 0,		

							/* Calculated Columns */
							DTM_Failed_Rate											= 0,
							DTM_Run_Rate											= 0,
							Forecast_Best_Run_Rate									= 0,
							Forecast_Worst_Run_Rate									= 0,
							NextDay_Forecast_Run_Rate								= 0,
							DTM_NoTone_Rate											= 0,
							DTM_NoTone_Count										= 0,
							Consecutive_NoTone_Count								= 0,
							Consecutive_Error_Count									= 0,
							BreakCount												= 0,
							NextDay_BreakCount										= 0,
							Average_BreakCount										= 0,

							ATT_DTM_Failed_Rate										= 0,
							ATT_DTM_Run_Rate										= 0,
							ATT_Forecast_Best_Run_Rate								= 0,
							ATT_Forecast_Worst_Run_Rate								= 0,
							ATT_NextDay_Forecast_Run_Rate							= 0,
							ATT_DTM_NoTone_Rate										= 0,
							ATT_DTM_NoTone_Count									= 0,
							ATT_BreakCount											= 0,
							ATT_NextDay_BreakCount									= 0,
							ATT_LastSchedule_Load									= NULL,
							ATT_NextDay_LastSchedule_Load							= NULL,

							IC_DTM_Failed_Rate										= 0,
							IC_DTM_Run_Rate											= 0,
							IC_Forecast_Best_Run_Rate								= 0,
							IC_Forecast_Worst_Run_Rate								= 0,
							IC_NextDay_Forecast_Run_Rate							= 0,
							IC_DTM_NoTone_Rate										= 0,
							IC_DTM_NoTone_Count										= 0,
							IC_BreakCount											= 0,
							IC_NextDay_BreakCount									= 0,
							IC_LastSchedule_Load									= NULL,
							IC_NextDay_LastSchedule_Load							= NULL,

							UpdateDate												= GETUTCDATE()
		FROM				(
								SELECT		a.ChannelStatusID, a.IU_ID, a.SDBSourceID, a.RegionalizedZoneID 
								FROM		dbo.ChannelStatus a (NOLOCK)
								LEFT JOIN	#ChannelStatus b 
								ON			a.IU_ID									= b.IU_ID
								AND			a.SDBSourceID							= b.SDBSourceID
								AND			a.RegionalizedZoneID					= b.RegionalizedZoneID
								WHERE		b.ID									IS NULL
							) x
		WHERE				ChannelStatus.ChannelStatusID							= x.ChannelStatusID
		AND					ChannelStatus.SDBSourceID								= @SDBSourceID



		INSERT			dbo.ChannelStatus
						(
							IU_ID,
							RegionalizedZoneID,
							SDBSourceID,

							/* TOTAL Insertions for today*/
							TotalInsertionsToday,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay,

							/* TOTAL DTM Insertions*/
							DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy,
							/* MTE Confilcts for Today */
							MTE_Conflicts,
							MTE_Conflicts_Window1,
							MTE_Conflicts_Window2,
							MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal,
							ICTotalNextDay,
							DTM_ICTotal,
							DTM_ICPlayed,
							DTM_ICFailed,
							DTM_ICNoTone,
							DTM_ICMpegError,
							DTM_ICMissingCopy,

							MTE_ICConflicts,
							MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3,
							ICConflictsNextDay,

							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load,

							/* AT&T Breakdown */
							ATTTotal,
							ATTTotalNextDay,
							DTM_ATTTotal,
							DTM_ATTPlayed,
							DTM_ATTFailed,
							DTM_ATTNoTone,
							DTM_ATTMpegError,
							DTM_ATTMissingCopy,

							MTE_ATTConflicts,
							MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3,
							ATTConflictsNextDay,

							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load,

							/* Calculated Columns */
							DTM_Failed_Rate,
							DTM_Run_Rate,
							Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate,
							DTM_NoTone_Count,
							Consecutive_NoTone_Count,
							Consecutive_Error_Count,
							BreakCount,
							NextDay_BreakCount,
							Average_BreakCount,
							ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count,
							ATT_BreakCount,
							ATT_NextDay_BreakCount,

							IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count,
							IC_BreakCount,
							IC_NextDay_BreakCount,

							Enabled,
							CreateDate
						)
		SELECT			
							a.IU_ID,
							a.RegionalizedZoneID									AS RegionalizedZoneID,
							--a.ZONE_NAME												AS ZoneName,
							a.SDBSourceID											AS SDBSourceID,

							/* TOTAL Insertions for today*/
							b.TotalInsertionsToday,

							/* TOTAL Insertions for next day*/
							b.TotalInsertionsNextDay,


							/* TOTAL DTM Insertions*/
							b.DTM_Total,
							/* DTM Successfuly Insertions */
							b.DTM_Played,
							/* DTM Failed Insertions */
							b.DTM_Failed,
							/* DTM NoTone's */
							b.DTM_NoTone,
							/* DTM mpeg errors */
							b.DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							b.DTM_MissingCopy,
							/* MTE Confilcts for Today */
							b.MTE_Conflicts,
							b.MTE_Conflicts_Window1,
							b.MTE_Conflicts_Window2,
							b.MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							b.MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							b.ICTotal,
							b.ICTotalNextDay,
							b.DTM_ICTotal,
							b.DTM_ICPlayed,
							b.DTM_ICFailed,
							b.DTM_ICNoTone,
							b.DTM_ICMpegError,
							b.DTM_ICMissingCopy,
							b.MTE_ICConflicts,
							b.MTE_ICConflicts_Window1,
							b.MTE_ICConflicts_Window2,
							b.MTE_ICConflicts_Window3,
							b.MTE_ICConflictsNextDay,
							a.IC_LastSchedule_Load,
							a.IC_NextDay_LastSchedule_Load,


							/* AT&T Breakdown */
							b.ATTTotal,
							b.ATTTotalNextDay,
							b.DTM_ATTTotal,
							b.DTM_ATTPlayed,
							b.DTM_ATTFailed,
							b.DTM_ATTNoTone,
							b.DTM_ATTMpegError,
							b.DTM_ATTMissingCopy,
							b.MTE_ATTConflicts,
							b.MTE_ATTConflicts_Window1,
							b.MTE_ATTConflicts_Window2,
							b.MTE_ATTConflicts_Window3,
							b.MTE_ATTConflictsNextDay,
							a.ATT_LastSchedule_Load,
							a.ATT_NextDay_LastSchedule_Load,
							
							/* Calculated Columns */
							a.DTM_Failed_Rate,
							a.DTM_Run_Rate,
							a.Forecast_Best_Run_Rate,
							a.Forecast_Worst_Run_Rate,
							a.NextDay_Forecast_Run_Rate,
							a.DTM_NoTone_Rate,
							a.DTM_NoTone_Count,
							ISNULL(a.Consecutive_NoTone_Count,0)					AS Consecutive_NoTone_Count,
							ISNULL(a.Consecutive_Error_Count,0)						AS Consecutive_Error_Count,
							a.BreakCount,
							a.NextDay_BreakCount,
							a.Average_BreakCount,
							a.ATT_DTM_Failed_Rate,
							a.ATT_DTM_Run_Rate,
							a.ATT_Forecast_Best_Run_Rate,
							a.ATT_Forecast_Worst_Run_Rate,
							a.ATT_NextDay_Forecast_Run_Rate,
							a.ATT_DTM_NoTone_Rate,
							a.ATT_DTM_NoTone_Count,
							a.ATT_BreakCount,
							a.ATT_NextDay_BreakCount,

							a.IC_DTM_Failed_Rate,
							a.IC_DTM_Run_Rate,
							a.IC_Forecast_Best_Run_Rate,
							a.IC_Forecast_Worst_Run_Rate,
							a.IC_NextDay_Forecast_Run_Rate,
							a.IC_DTM_NoTone_Rate,
							a.IC_DTM_NoTone_Count,
							a.IC_BreakCount,
							a.IC_NextDay_BreakCount,

							1														AS Enabled,
							GETUTCDATE()											AS CreateDate
		FROM			#ChannelStatus a
		JOIN			#ChannelStatistics b
		ON				a.ChannelStats_ID											= b.ID
		LEFT JOIN		dbo.ChannelStatus c 
		ON				a.ChannelStatusID											= c.ChannelStatusID
		AND				a.SDBSourceID												= c.SDBSourceID
		WHERE			c.ChannelStatusID											IS NULL

		DROP TABLE		#ChannelStatistics
		DROP TABLE		#ChannelStatus
		SET				@ErrorID = 0		--SUCCESS


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveCacheStatus]'
GO
ALTER PROCEDURE [dbo].[SaveCacheStatus]
  @SDBSourceID  INT,
  @CacheType   VARCHAR(32),
  @ErrorID   INT = 0 OUTPUT
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
// Module:  dbo.SaveCacheStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Saves Cache Status of the logical SDB for the given cache type.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id$
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveCacheStatus 
//        @SDBSourceID  = 1,
//        @CacheType   = 'ChannelStatus'  --Two types: ChannelStatus, Conflict
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;

  DECLARE  @CacheStatusTypeID  INT
  SET   @ErrorID = 1
  
  SELECT  TOP 1 @CacheStatusTypeID     = CacheStatusTypeID   
  FROM  dbo.CacheStatusType a (NOLOCK)
  WHERE  a.Description        = @CacheType

  IF  ( @CacheStatusTypeID IS NULL ) RETURN

  IF  EXISTS (
       SELECT  TOP 1 1   
       FROM  dbo.CacheStatus a (NOLOCK)
       WHERE  a.SDBSourceID        = @SDBSourceID  
       AND   a.CacheStatusTypeID       = @CacheStatusTypeID
      )
  BEGIN
      UPDATE   dbo.CacheStatus 
      SET    UpdateDate         = b.LatestUpdateDate
      FROM   (
           SELECT  SDBSourceID, MAX(UpdateDate) AS LatestUpdateDate
           FROM  dbo.ChannelStatus 
           GROUP BY SDBSourceID
          ) b
      WHERE   CacheStatus.SDBSourceID      = b.SDBSourceID
      AND    CacheStatus.SDBSourceID      = @SDBSourceID
      AND    CacheStatusTypeID       = @CacheStatusTypeID
          
  END
  ELSE
  BEGIN
      INSERT   dbo.CacheStatus 
           (
            SDBSourceID,
            CacheStatusTypeID,
            CreateDate
           )
      SELECT   @SDBSourceID        AS SDBSourceID,
          @CacheStatusTypeID       AS CacheStatusTypeID,
          GETUTCDATE()        AS CreateDate
  END
  SET     @ErrorID            = 0  --SUCCESS

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ImportTrafficAndBillingData]'
GO
ALTER PROCEDURE [dbo].[ImportTrafficAndBillingData]
  @SDBUTCOffset   INT,
  @JobID     UNIQUEIDENTIFIER,
  @JobName    VARCHAR(100),
  @SDBSourceID   INT,
  @SDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.ImportTrafficAndBillingData
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:  Imports Traffic And Billing Data from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id$
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.ImportTrafficAndBillingData 
//        @SDBUTCOffset  = 0
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @SDBSourceID  = 1,
//        @SDBName   = 'SDBName',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;
  DECLARE  @CMD   NVARCHAR(4000)
  DECLARE  @LogIDReturn INT
  DECLARE  @ErrNum   INT
  DECLARE  @ErrMsg   VARCHAR(200)
  DECLARE  @EventLogStatusID INT

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @SDBSourceID,
       @DBComputerName  = @SDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT


  SET   @CMD   = 
  'INSERT  #ImportTB_REQUEST
     (
      SCHED_DATE,
      UTC_SCHED_DATE,
      FILENAME,
      FILE_DATETIME,
      UTC_FILE_DATETIME,
      PROCESSED,
      SOURCE_ID,
      STATUS,
      IU_ID,
      SDBSourceID
     )
  SELECT
      CONVERT(DATE,TB_DAYPART) AS SCHED_DATE,
      CONVERT( DATE, DATEADD(hour, ' + CAST(@SDBUTCOffset AS VARCHAR(50)) + ', TB_DAYPART)) AS UTC_SCHED_DATE,
      SUBSTRING(TBR.TB_FILE,CHARINDEX(''\SCH\'',TBR.TB_FILE,0)+5,12) AS FILENAME,
      TBR.TB_FILE_DATE AS [FILE_DATETIME],
      DATEADD( hour, ' + CAST(@SDBUTCOffset AS VARCHAR(50)) + ', TBR.TB_FILE_DATE ) AS UTC_FILE_DATETIME,
      TBR.TB_MACHINE_TS AS PROCESSED,
      TBR.SOURCE_ID,
      TBR.STATUS,
      TBR.IU_ID,
      ' + CAST(@SDBSourceID AS VARCHAR(25)) + ' AS SDBSourceID
  FROM   [' + @SDBName + '].mpeg.dbo.TB_REQUEST TBR WITH (NOLOCK) 
  WHERE   TBR.TB_MODE = 3 
  AND    TBR.TB_REQUEST = 2'

  BEGIN TRY
   EXECUTE  sp_executesql @CMD
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData Success Step'
  END TRY
  BEGIN CATCH
   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID = @ErrNum
  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ImportSDB]'
GO
ALTER PROCEDURE [dbo].[ImportSDB]
  @RegionID    INT,
  @SDBSourceID   INT,
  @JobRun     BIT = 0
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
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.ImportSDB.proc.sql 3207 2013-12-02 21:50:33Z tlew $
//    
//  Usage:
//
//    DECLARE @LogIDReturn INT
//    EXEC dbo.ImportSDB 
//       @RegionID    = 1,
//       @SDBSourceID   = 1,
//       @JobRun     = 0
//    
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;

  DECLARE  @CMD      NVARCHAR(1000)
  DECLARE  @LogIDReturn    INT
  DECLARE  @LogIDChannelStatsReturn INT
  DECLARE  @LogIDConflictsReturn  INT
  DECLARE  @JobID      UNIQUEIDENTIFIER
  DECLARE  @JobName     VARCHAR(100)
  DECLARE  @SDBName     VARCHAR(50)
  DECLARE  @ErrTotal     INT = 0
  DECLARE  @ErrNum      INT = 0
  DECLARE  @ErrMsg      VARCHAR(200)
  DECLARE  @EventLogStatusID   INT
  DECLARE  @TODAY      DATETIME = GETUTCDATE()
  DECLARE  @SDBUTCOffset    INT
  DECLARE  @Role      INT

  --TEMPORARY
  --SET @TODAY = '2013-09-20'

  SELECT  TOP 1 
     @JobID      = CASE WHEN @JobRun = 1  THEN b.JobID  ELSE NULL END,
     @JobName     = CASE WHEN @JobRun = 1  THEN b.JobName ELSE NULL END,
     @SDBName     = c.SDBComputerName,
     @Role      = c.Role
  FROM  dbo.MDBSource a (NOLOCK)
  JOIN  dbo.SDBSource b (NOLOCK)
  ON   a.MDBSourceID    = b.MDBSourceID
  JOIN  dbo.SDBSourceSystem c (NOLOCK)
  ON   b.SDBSourceID    = c.SDBSourceID
  WHERE  a.RegionID     = @RegionID
  AND   b.SDBSourceID    = @SDBSourceID 
  AND   c.Status     = 1
  AND   c.Enabled     = 1
  ORDER BY c.Role

  IF   ( ISNULL(@SDBSourceID, 0) = 0 ) RETURN

  EXEC  dbo.GetSDBUTCOffset 
       @SDBSourceID  = @SDBSourceID,
       @SDBComputerName = @SDBName, 
       @Role    = @Role, 
       @JobID    = @JobID,
       @JobName   = @JobName,
       @UTCOffset   = @SDBUTCOffset OUTPUT

  IF   ( @SDBUTCOffset IS NULL ) RETURN
  SET   @TODAY      = DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,   ----Started Step
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @SDBSourceID,
       @DBComputerName  = @SDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT


  IF  ISNULL(OBJECT_ID('tempdb..#ImportTB_REQUEST'), 0) > 0 
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

  IF  ISNULL(OBJECT_ID('tempdb..#ImportIUBreakCount'), 0) > 0 
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


  IF  ISNULL(OBJECT_ID('tempdb..#ImportIE_SPOT'), 0) > 0 
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



  EXEC   dbo.ImportBreakCountHistory 
       @SDBUTCOffset  = @SDBUTCOffset,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @SDBSourceID  = @SDBSourceID,
       @SDBName   = @SDBName,
       @JobRun    = @JobRun,
       @ErrorID   = @ErrNum OUTPUT
  SET    @ErrTotal    = @ErrTotal + ISNULL(@ErrNum, 0)

  EXEC   dbo.ImportChannelAndConflictStats 
       @SDBUTCOffset  = @SDBUTCOffset,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @SDBSourceID  = @SDBSourceID,
       @SDBName   = @SDBName,
       @Day    = @TODAY,
       @JobRun    = @JobRun,
       @ErrorID   = @ErrNum OUTPUT
  SET    @ErrTotal    = @ErrTotal + ISNULL(@ErrNum, 0)

  EXEC   dbo.ImportTrafficAndBillingData 
       @SDBUTCOffset  = @SDBUTCOffset,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @SDBSourceID  = @SDBSourceID,
       @SDBName   = @SDBName,
       @JobRun    = @JobRun,
       @ErrorID   = @ErrNum OUTPUT
  SET    @ErrTotal    = @ErrTotal + ISNULL(@ErrNum, 0)

  IF    ( @ErrTotal = 0 )
  BEGIN

  
      --Run the SaveSDB_IESPOT step (needs the ImportChannelAndConflictStats SP to populate the temp table)
       EXEC  dbo.SaveSDB_IESPOT 
           @JobID    = @JobID,
           @JobName   = @JobName,
           @SDBSourceID  = @SDBSourceID,
           @SDBName   = @SDBName,
           @JobRun    = @JobRun,
           @ErrorID   = @ErrNum OUTPUT

      --Run the SaveSDB_Market step (needs the ImportChannelAndConflictStats SP to populate the temp table)
       EXEC  dbo.SaveSDB_Market 
           @JobID    = @JobID,
           @JobName   = @JobName,
           @SDBSourceID  = @SDBSourceID,
           @SDBName   = @SDBName,
           @JobRun    = @JobRun,
           @ErrorID   = @ErrNum OUTPUT

      --TRY the SaveChannel step

      SELECT   TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus First Step'

       EXEC  dbo.LogEvent 
            @LogID    = NULL,
            @EventLogStatusID = @EventLogStatusID,   ----Started Step
            @JobID    = @JobID,
            @JobName   = @JobName,
            @DBID    = @SDBSourceID,
            @DBComputerName  = @SDBName,
            @LogIDOUT   = @LogIDChannelStatsReturn OUTPUT

      BEGIN TRY
       EXEC  dbo.SaveChannelStatus @RegionID  = @RegionID, @SDBSourceID = @SDBSourceID,  @SDBUTCOffset = @SDBUTCOffset, @ErrorID = @ErrNum OUTPUT   
       EXEC  dbo.SaveCacheStatus  @SDBSourceID = @SDBSourceID, @CacheType = 'Channel Status'
       SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus Success Step'
       EXEC  dbo.LogEvent @LogID = @LogIDChannelStatsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
      END TRY
      BEGIN CATCH
       SELECT  @ErrNum  = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
       SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus Fail Step'
       EXEC  dbo.LogEvent @LogID = @LogIDChannelStatsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
       SET   @ErrMsg = ''
      END CATCH


      --TRY the SaveConflicts step
      SELECT   TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict First Step'
       EXEC  dbo.LogEvent 
            @LogID    = NULL,
            @EventLogStatusID = @EventLogStatusID,   ----Started Step
            @JobID    = @JobID,
            @JobName   = @JobName,
            @DBID    = @SDBSourceID,
            @DBComputerName  = @SDBName,
            @LogIDOUT   = @LogIDConflictsReturn OUTPUT
      BEGIN TRY
       EXEC  dbo.SaveConflict  @SDBSourceID = @SDBSourceID, @SDBUTCOffset = @SDBUTCOffset, @ErrorID = @ErrNum OUTPUT
       EXEC  dbo.SaveCacheStatus  @SDBSourceID = @SDBSourceID, @CacheType = 'Media Status'
       SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict Success Step'
       EXEC  dbo.LogEvent @LogID = @LogIDConflictsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
      END TRY
      BEGIN CATCH
       SELECT  @ErrNum  = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
       SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict Fail Step'
       EXEC  dbo.LogEvent @LogID = @LogIDConflictsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
       SET   @ErrMsg = ''
      END CATCH
      SELECT   TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB Success Step'
  END
  ELSE   
      SELECT   TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB Fail Step'

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE  #ImportTB_REQUEST
  DROP TABLE  #ImportIUBreakCount
  DROP TABLE  #ImportIE_SPOT


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[PurgeSDB_IESPOT]'
GO
ALTER PROCEDURE [dbo].[PurgeSDB_IESPOT]
  @UTC_Cutoff_Day   DATE,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @MDBSourceID   INT = NULL,
  @MDBName    VARCHAR(50) = NULL,
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.PurgeSDB_IESPOT
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Deletes from the DINGODB.dbo.SDB_IESPOT table from @UTC_Cutoff_Day and before.
//   This value is set at the job level which calls this SP.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id$
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.PurgeSDB_IESPOT 
//        @UTC_Cutoff_Day  = '2013-10-07',
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @MDBSourceID  = 1,
//        @MDBName   = 'MSSNKNLMDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @LogIDReturn   INT
  DECLARE  @ErrNum     INT
  DECLARE  @ErrMsg     VARCHAR(200)
  DECLARE  @EventLogStatusID  INT = 0

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @MDBSourceID,
       @DBComputerName  = @MDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  BEGIN TRY
   DELETE  dbo.SDB_IESPOT
   WHERE  UTC_SCHED_DATE   <= @UTC_Cutoff_Day

   SET   @ErrorID = 0
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT Success Step'
  END TRY
  BEGIN CATCH
   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID    = @ErrNum
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT Fail Step'
   SET   @EventLogStatusID = ISNULL(@EventLogStatusID, @ErrorID)
  END CATCH

  EXEC   dbo.LogEvent @LogID  = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveIE_CONFLICT_STATUS]'
GO
ALTER PROCEDURE [dbo].[SaveIE_CONFLICT_STATUS]
  @RegionID    INT,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @MDBSourceID   INT,
  @MDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveIE_CONFLICT_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Upserts IE_CONFLICT_STATUS definition table to DINGODB and regionalizes the IE_CONFLICT_STATUS with a DINGODB IE_CONFLICT_STATUS ID.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveIE_CONFLICT_STATUS.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveIE_CONFLICT_STATUS 
//        @RegionID   = 1,
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @MDBSourceID  = 1,
//        @MDBName   = 'MSSNKNLMDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @CMD   NVARCHAR(4000)
  DECLARE  @LogIDReturn INT
  DECLARE  @ErrNum   INT
  DECLARE  @ErrMsg   VARCHAR(200)
  DECLARE  @EventLogStatusID INT = 16
  DECLARE  @TempTableCount INT
  DECLARE  @ZONECount  INT


  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_CONFLICT_STATUS First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @MDBSourceID,
       @DBComputerName  = @MDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  IF  ISNULL(OBJECT_ID('tempdb..#IE_CONFLICT_STATUS'), 0) > 0 
    DROP TABLE  #IE_CONFLICT_STATUS

  CREATE TABLE #IE_CONFLICT_STATUS 
      (
       ID INT Identity(1,1),
       RegionID int,
       NSTATUS int,
       VALUE varchar(200),
       CHECKSUM_VALUE int
      )

  SET   @CMD   = 
  'INSERT  #IE_CONFLICT_STATUS
     (
       RegionID,
       NSTATUS,
       VALUE,
       CHECKSUM_VALUE 
     )
  SELECT
       ' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
       NSTATUS,
       VALUE,
       CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
  FROM   '+ISNULL(@MDBName,'')+'.mpeg.dbo.IECONFLICT_STATUS s WITH (NOLOCK) '


  BEGIN TRY
   EXECUTE  sp_executesql @CMD

   UPDATE  dbo.REGIONALIZED_IE_CONFLICT_STATUS
   SET
      RegionID           = s.RegionID,
      NSTATUS            = s.NSTATUS,
      VALUE            = s.VALUE,
      CHECKSUM_VALUE           = s.CHECKSUM_VALUE

   FROM  #IE_CONFLICT_STATUS s
   WHERE  REGIONALIZED_IE_CONFLICT_STATUS.RegionID   = @RegionID
   AND   REGIONALIZED_IE_CONFLICT_STATUS.NSTATUS   = s.NSTATUS
   AND   REGIONALIZED_IE_CONFLICT_STATUS.CHECKSUM_VALUE <> s.CHECKSUM_VALUE

   
   INSERT  dbo.REGIONALIZED_IE_CONFLICT_STATUS
      (
        RegionID,
        NSTATUS,
        VALUE,
        CHECKSUM_VALUE
      )
   SELECT
        @RegionID AS RegionID,
        y.NSTATUS,
        y.VALUE,
        y.CHECKSUM_VALUE
   FROM    #IE_CONFLICT_STATUS y
   LEFT JOIN   (
          SELECT  NSTATUS
          FROM  dbo.REGIONALIZED_IE_CONFLICT_STATUS (NOLOCK)
          WHERE  RegionID = @RegionID
        ) z
   ON     y.NSTATUS = z.NSTATUS
   WHERE    z.NSTATUS IS NULL
   ORDER BY   y.ID

   SET   @ErrorID = 0
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_CONFLICT_STATUS Success Step'
  END TRY
  BEGIN CATCH
   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID = @ErrNum
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_CONFLICT_STATUS Fail Step'
  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE  #IE_CONFLICT_STATUS

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveIE_STATUS]'
GO
ALTER PROCEDURE [dbo].[SaveIE_STATUS]
  @RegionID    INT,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @MDBSourceID   INT,
  @MDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveIE_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Upserts IE_STATUS definition table to DINGODB and regionalizes the IE_STATUS with a DINGODB IE_STATUS ID.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveIE_STATUS.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveIE_STATUS 
//        @RegionID   = 1,
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @MDBSourceID  = 1,
//        @MDBName   = 'MSSNKNLMDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @CMD NVARCHAR(4000)
  DECLARE  @LogIDReturn INT
  DECLARE  @ErrNum   INT
  DECLARE  @ErrMsg   VARCHAR(200)
  DECLARE  @EventLogStatusID INT = 16
  DECLARE  @TempTableCount INT
  DECLARE  @ZONECount  INT

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_STATUS First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @MDBSourceID,
       @DBComputerName  = @MDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  IF  ISNULL(OBJECT_ID('tempdb..#IE_STATUS'), 0) > 0 
    DROP TABLE  #IE_STATUS

  CREATE TABLE #IE_STATUS 
      (
       ID INT Identity(1,1),
       RegionID int,
       NSTATUS int,
       VALUE varchar(200),
       CHECKSUM_VALUE int
      )

  SET   @CMD   = 
  'INSERT  #IE_STATUS
     (
       RegionID,
       NSTATUS,
       VALUE,
       CHECKSUM_VALUE 
     )
  SELECT
       ' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
       NSTATUS,
       VALUE,
       CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
  FROM   '+ISNULL(@MDBName,'')+'.mpeg.dbo.IE_STATUS s WITH (NOLOCK) '


  BEGIN TRY
   EXECUTE  sp_executesql @CMD

   UPDATE  dbo.REGIONALIZED_IE_STATUS
   SET
      RegionID        = s.RegionID,
      NSTATUS         = s.NSTATUS,
      VALUE         = s.VALUE,
      CHECKSUM_VALUE        = s.CHECKSUM_VALUE

   FROM  #IE_STATUS s
   WHERE  REGIONALIZED_IE_STATUS.RegionID  = @RegionID
   AND   REGIONALIZED_IE_STATUS.NSTATUS  = s.NSTATUS
   AND   REGIONALIZED_IE_STATUS.CHECKSUM_VALUE <> s.CHECKSUM_VALUE

   
   INSERT  dbo.REGIONALIZED_IE_STATUS
      (
        RegionID,
        NSTATUS,
        VALUE,
        CHECKSUM_VALUE
      )
   SELECT
        @RegionID AS RegionID,
        y.NSTATUS,
        y.VALUE,
        y.CHECKSUM_VALUE
   FROM    #IE_STATUS y
   LEFT JOIN   (
          SELECT  NSTATUS
          FROM  dbo.REGIONALIZED_IE_STATUS (NOLOCK)
          WHERE  RegionID = @RegionID
        ) z
   ON     y.NSTATUS = z.NSTATUS
   WHERE    z.NSTATUS IS NULL
   ORDER BY   y.ID
      
   SET   @ErrorID = 0
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_STATUS Success Step'
  END TRY
  BEGIN CATCH
   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID = @ErrNum
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_STATUS Fail Step'
  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE  #IE_STATUS

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveIU]'
GO
ALTER PROCEDURE [dbo].[SaveIU]
  @RegionID    INT,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @MDBSourceID   INT,
  @MDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveIU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Upserts and SPOT IU IDs to DINGODB and regionalizes the IU ID with a DINGODB IU ID.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveIU.proc.sql 3610 2014-03-05 19:22:53Z tlew $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveIU 
//        @RegionID   = 1,
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @MDBSourceID  = 1,
//        @MDBName   = 'MSSNKNLMDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @CMD      NVARCHAR(4000)
  DECLARE  @LogIDReturn    INT
  DECLARE  @ErrNum      INT
  DECLARE  @ErrMsg      VARCHAR(200)
  DECLARE  @EventLogStatusID   INT = 1  --Unidentified Step
  DECLARE  @TempTableCount    INT
  DECLARE  @ZONECount     INT
  DECLARE  @LastIUID     INT

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @MDBSourceID,
       @DBComputerName  = @MDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  IF  ISNULL(OBJECT_ID('tempdb..#DeletedIU'), 0) > 0 
    DROP TABLE  #DeletedIU

  CREATE TABLE #DeletedIU 
      (
       ID INT Identity(1,1),
       REGIONALIZED_IU_ID int NOT NULL,
       IU_ID int NOT NULL
      )



  IF  ISNULL(OBJECT_ID('tempdb..#IU'), 0) > 0 
    DROP TABLE  #IU

  CREATE TABLE #IU 
      (
       ID INT Identity(1,1),
       IU_ID int NOT NULL,
       REGIONID int NOT NULL,
       ZONE int NOT NULL,
       ZONE_NAME varchar(32) NOT NULL,
       CHANNEL varchar(12) NOT NULL,
       CHAN_NAME varchar(32) NOT NULL,
       CHANNEL_NAME varchar(200) NULL,
       DELAY int NOT NULL,
       START_TRIGGER char(5) NOT NULL,
       END_TRIGGER char(5) NOT NULL,
       AWIN_START int NULL,
       AWIN_END int NULL,
       VALUE int NULL,
       MASTER_NAME varchar(32) NULL,
       COMPUTER_NAME varchar(32) NULL,
       PARENT_ID int NULL,
       SYSTEM_TYPE int NULL,
       COMPUTER_PORT int NOT NULL,
       MIN_DURATION int NOT NULL,
       MAX_DURATION int NOT NULL,
       START_OF_DAY char(8) NOT NULL,
       RESCHEDULE_WINDOW int NOT NULL,
       IC_CHANNEL varchar(12) NULL,
       VSM_SLOT int NULL,
       DECODER_PORT int NULL,
       TC_ID int NULL,
       IGNORE_VIDEO_ERRORS int NULL,
       IGNORE_AUDIO_ERRORS int NULL,
       COLLISION_DETECT_ENABLED int NULL,
       TALLY_NORMALLY_HIGH int NULL,
       PLAY_OVER_COLLISIONS int NULL,
       PLAY_COLLISION_FUDGE int NULL,
       TALLY_COLLISION_FUDGE int NULL,
       TALLY_ERROR_FUDGE int NULL,
       LOG_TALLY_ERRORS int NULL,
       TBI_START [datetime] NULL,
       TBI_END [datetime] NULL,
       CONTINUOUS_PLAY_FUDGE int NULL,
       TONE_GROUP varchar(64) NULL,
       IGNORE_END_TONES int NULL,
       END_TONE_FUDGE int NULL,
       MAX_AVAILS int NULL,
       RESTART_TRIES int NULL,
       RESTART_BYTE_SKIP int NULL,
       RESTART_TIME_REMAINING int NULL,
       GENLOCK_FLAG int NULL,
       SKIP_HEADER int NULL,
       GPO_IGNORE int NULL,
       GPO_NORMAL int NULL,
       GPO_TIME int NULL,
       DECODER_SHARING int NULL,
       HIGH_PRIORITY int NULL,
       SPLICER_ID int NULL,
       PORT_ID int NULL,
       VIDEO_PID int NULL,
       SERVICE_PID int NULL,
       DVB_CARD int NULL,
       SPLICE_ADJUST int NOT NULL,
       POST_BLACK int NOT NULL,
       SWITCH_CNT int NULL,
       DECODER_CNT int NULL,
       DVB_CARD_CNT int NULL,
       DVB_PORTS_PER_CARD int NULL,
       DVB_CHAN_PER_PORT int NULL,
       USE_ISD int NULL,
       NO_NETWORK_VIDEO_DETECT int NULL,
       NO_NETWORK_PLAY int NULL,
       IP_TONE_THRESHOLD int NULL,
       USE_GIGE int NULL,
       GIGE_IP varchar(24) NULL,
       IS_ACTIVE_IND [bit] NOT NULL,
       msrepl_tran_version uniqueidentifier
      )

  SET   @CMD   = 
  'INSERT  #IU

      (
       IU_ID,
       REGIONID,
       ZONE,
       ZONE_NAME,
       CHANNEL,
       CHAN_NAME,
       DELAY,
       START_TRIGGER,
       END_TRIGGER,
       AWIN_START,
       AWIN_END,
       VALUE,
       MASTER_NAME,
       COMPUTER_NAME,
       PARENT_ID,
       SYSTEM_TYPE,
       COMPUTER_PORT,
       MIN_DURATION,
       MAX_DURATION,
       START_OF_DAY,
       RESCHEDULE_WINDOW,
       IC_CHANNEL,
       VSM_SLOT,
       DECODER_PORT,
       TC_ID,
       IGNORE_VIDEO_ERRORS,
       IGNORE_AUDIO_ERRORS,
       COLLISION_DETECT_ENABLED,
       TALLY_NORMALLY_HIGH,
       PLAY_OVER_COLLISIONS,
       PLAY_COLLISION_FUDGE,
       TALLY_COLLISION_FUDGE,
       TALLY_ERROR_FUDGE,
       LOG_TALLY_ERRORS,
       TBI_START,
       TBI_END,
       CONTINUOUS_PLAY_FUDGE,
       TONE_GROUP,
       IGNORE_END_TONES,
       END_TONE_FUDGE,
       MAX_AVAILS,
       RESTART_TRIES,
       RESTART_BYTE_SKIP,
       RESTART_TIME_REMAINING,
       GENLOCK_FLAG,
       SKIP_HEADER,
       GPO_IGNORE,
       GPO_NORMAL,
       GPO_TIME,
       DECODER_SHARING,
       HIGH_PRIORITY,
       SPLICER_ID,
       PORT_ID,
       VIDEO_PID,
       SERVICE_PID,
       DVB_CARD,
       SPLICE_ADJUST,
       POST_BLACK,
       SWITCH_CNT,
       DECODER_CNT,
       DVB_CARD_CNT,
       DVB_PORTS_PER_CARD,
       DVB_CHAN_PER_PORT,
       USE_ISD,
       NO_NETWORK_VIDEO_DETECT,
       NO_NETWORK_PLAY,
       IP_TONE_THRESHOLD,
       USE_GIGE,
       GIGE_IP,
       IS_ACTIVE_IND,
       msrepl_tran_version
      )

   SELECT  
       IU_ID,
       ' + CAST(@RegionID AS VARCHAR(50)) + ' AS REGIONID,
       ZONE,
       ZONE_NAME,
       CHANNEL,
       CHAN_NAME,
       DELAY,
       START_TRIGGER,
       END_TRIGGER,
       AWIN_START,
       AWIN_END,
       VALUE,
       MASTER_NAME,
       COMPUTER_NAME,
       PARENT_ID,
       SYSTEM_TYPE,
       COMPUTER_PORT,
       MIN_DURATION,
       MAX_DURATION,
       START_OF_DAY,
       RESCHEDULE_WINDOW,
       IC_CHANNEL,
       VSM_SLOT,
       DECODER_PORT,
       TC_ID,
       IGNORE_VIDEO_ERRORS,
       IGNORE_AUDIO_ERRORS,
       COLLISION_DETECT_ENABLED,
       TALLY_NORMALLY_HIGH,
       PLAY_OVER_COLLISIONS,
       PLAY_COLLISION_FUDGE,
       TALLY_COLLISION_FUDGE,
       TALLY_ERROR_FUDGE,
       LOG_TALLY_ERRORS,
       TBI_START,
       TBI_END,
       CONTINUOUS_PLAY_FUDGE,
       TONE_GROUP,
       IGNORE_END_TONES,
       END_TONE_FUDGE,
       MAX_AVAILS,
       RESTART_TRIES,
       RESTART_BYTE_SKIP,
       RESTART_TIME_REMAINING,
       GENLOCK_FLAG,
       SKIP_HEADER,
       GPO_IGNORE,
       GPO_NORMAL,
       GPO_TIME,
       DECODER_SHARING,
       HIGH_PRIORITY,
       SPLICER_ID,
       PORT_ID,
       VIDEO_PID,
       SERVICE_PID,
       DVB_CARD,
       SPLICE_ADJUST,
       POST_BLACK,
       SWITCH_CNT,
       DECODER_CNT,
       DVB_CARD_CNT,
       DVB_PORTS_PER_CARD,
       DVB_CHAN_PER_PORT,
       USE_ISD,
       NO_NETWORK_VIDEO_DETECT,
       NO_NETWORK_PLAY,
       IP_TONE_THRESHOLD,
       USE_GIGE,
       GIGE_IP,
       IS_ACTIVE_IND,
       msrepl_tran_version ' +
  'FROM   '+ISNULL(@MDBName,'')+'.mpeg.dbo.IU a WITH (NOLOCK) '

  --SELECT   @CMD




  BEGIN TRY
   EXECUTE  sp_executesql @CMD

   --   Identify the IDs from the REGIONALIZED_IU table to be deleted
   INSERT  #DeletedIU 
     (
      REGIONALIZED_IU_ID,
      IU_ID
     )
   SELECT  a.REGIONALIZED_IU_ID,
      a.IU_ID
   FROM  dbo.REGIONALIZED_IU a WITH (NOLOCK)
   LEFT JOIN #IU b
   ON   a.IU_ID          = b.IU_ID
   WHERE  a.RegionID         = @RegionID
   AND   b.ID          IS NULL


   --   Delete from the tables with FK constraints first
   DELETE  dbo.REGIONALIZED_NETWORK_IU_MAP
   FROM  #DeletedIU d
   WHERE  REGIONALIZED_NETWORK_IU_MAP.REGIONALIZED_IU_ID = d.REGIONALIZED_IU_ID


   DELETE  dbo.REGIONALIZED_IU
   FROM  #DeletedIU d
   WHERE  REGIONALIZED_IU.RegionID     = @RegionID
   AND   REGIONALIZED_IU.REGIONALIZED_IU_ID   = d.REGIONALIZED_IU_ID


   INSERT  dbo.REGIONALIZED_IU
      (
        RegionID,
        --SDBSourceID,
        IU_ID,
        ZONE,
        ZONE_NAME,
        CHANNEL,
        CHAN_NAME,
        CHANNEL_NAME,
        DELAY,
        START_TRIGGER,
        END_TRIGGER,
        AWIN_START,
        AWIN_END,
        VALUE,
        MASTER_NAME,
        COMPUTER_NAME,
        PARENT_ID,
        SYSTEM_TYPE,
        COMPUTER_PORT,
        MIN_DURATION,
        MAX_DURATION,
        START_OF_DAY,
        RESCHEDULE_WINDOW,
        IC_CHANNEL,
        VSM_SLOT,
        DECODER_PORT,
        TC_ID,
        IGNORE_VIDEO_ERRORS,
        IGNORE_AUDIO_ERRORS,
        COLLISION_DETECT_ENABLED,
        TALLY_NORMALLY_HIGH,
        PLAY_OVER_COLLISIONS,
        PLAY_COLLISION_FUDGE,
        TALLY_COLLISION_FUDGE,
        TALLY_ERROR_FUDGE,
        LOG_TALLY_ERRORS,
        TBI_START,
        TBI_END,
        CONTINUOUS_PLAY_FUDGE,
        TONE_GROUP,
        IGNORE_END_TONES,
        END_TONE_FUDGE,
        MAX_AVAILS,
        RESTART_TRIES,
        RESTART_BYTE_SKIP,
        RESTART_TIME_REMAINING,
        GENLOCK_FLAG,
        SKIP_HEADER,
        GPO_IGNORE,
        GPO_NORMAL,
        GPO_TIME,
        DECODER_SHARING,
        HIGH_PRIORITY,
        SPLICER_ID,
        PORT_ID,
        VIDEO_PID,
        SERVICE_PID,
        DVB_CARD,
        SPLICE_ADJUST,
        POST_BLACK,
        SWITCH_CNT,
        DECODER_CNT,
        DVB_CARD_CNT,
        DVB_PORTS_PER_CARD,
        DVB_CHAN_PER_PORT,
        USE_ISD,
        NO_NETWORK_VIDEO_DETECT,
        NO_NETWORK_PLAY,
        IP_TONE_THRESHOLD,
        USE_GIGE,
        GIGE_IP,
        IS_ACTIVE_IND,
        msrepl_tran_version,
        CreateDate
      )

   SELECT  
        @RegionID AS RegionID,
        --@SDBSourceID AS SDBSourceID,
        y.IU_ID,
        y.ZONE,
        y.ZONE_NAME,
        y.CHANNEL,
        y.CHAN_NAME,
        ISNULL(y.CHANNEL_NAME,''),
        y.DELAY,
        y.START_TRIGGER,
        y.END_TRIGGER,
        y.AWIN_START,
        y.AWIN_END,
        y.VALUE,
        y.MASTER_NAME,
        y.COMPUTER_NAME,
        y.PARENT_ID,
        y.SYSTEM_TYPE,
        y.COMPUTER_PORT,
        y.MIN_DURATION,
        y.MAX_DURATION,
        y.START_OF_DAY,
        y.RESCHEDULE_WINDOW,
        y.IC_CHANNEL,
        y.VSM_SLOT,
        y.DECODER_PORT,
        y.TC_ID,
        y.IGNORE_VIDEO_ERRORS,
        y.IGNORE_AUDIO_ERRORS,
        y.COLLISION_DETECT_ENABLED,
        y.TALLY_NORMALLY_HIGH,
        y.PLAY_OVER_COLLISIONS,
        y.PLAY_COLLISION_FUDGE,
        y.TALLY_COLLISION_FUDGE,
        y.TALLY_ERROR_FUDGE,
        y.LOG_TALLY_ERRORS,
        y.TBI_START,
        y.TBI_END,
        y.CONTINUOUS_PLAY_FUDGE,
        y.TONE_GROUP,
        y.IGNORE_END_TONES,
        y.END_TONE_FUDGE,
        y.MAX_AVAILS,
        y.RESTART_TRIES,
        y.RESTART_BYTE_SKIP,
        y.RESTART_TIME_REMAINING,
        y.GENLOCK_FLAG,
        y.SKIP_HEADER,
        y.GPO_IGNORE,
        y.GPO_NORMAL,
        y.GPO_TIME,
        y.DECODER_SHARING,
        y.HIGH_PRIORITY,
        y.SPLICER_ID,
        y.PORT_ID,
        y.VIDEO_PID,
        y.SERVICE_PID,
        y.DVB_CARD,
        y.SPLICE_ADJUST,
        y.POST_BLACK,
        y.SWITCH_CNT,
        y.DECODER_CNT,
        y.DVB_CARD_CNT,
        y.DVB_PORTS_PER_CARD,
        y.DVB_CHAN_PER_PORT,
        y.USE_ISD,
        y.NO_NETWORK_VIDEO_DETECT,
        y.NO_NETWORK_PLAY,
        y.IP_TONE_THRESHOLD,
        y.USE_GIGE,
        y.GIGE_IP,
        y.IS_ACTIVE_IND,
        y.msrepl_tran_version,
        GETUTCDATE()
   FROM    #IU y
   -- JOIN    dbo.ZONE_MAP zm with (NOLOCK)  --We only care about IUs whose zone names we know
   --ON     y.ZONE_NAME   = zm.ZONE_NAME 
   LEFT JOIN   (
          SELECT  IU_ID
          FROM  dbo.REGIONALIZED_IU (NOLOCK)
          WHERE  REGIONID = @RegionID
          --AND   SDBSourceID = @SDBSourceID
        ) z
   ON     y.IU_ID = z.IU_ID
   WHERE    z.IU_ID IS NULL
   ORDER BY   y.ID

   UPDATE  #IU
   SET   CHANNEL_NAME       = ISNULL(x.CCMS,'')
   FROM  (
         SELECT a.IU_ID, 
           --e.Name + '-' + c.NAME + '/' + SUBSTRING('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', ((CAST(a.CHANNEL AS INT) / 10) + 1), 1) +  CAST((CAST(a.CHANNEL AS INT) % 10) AS VARCHAR) +'-' + RIGHT('00000'+CAST((CASE WHEN ISNUMERIC(RIGHT(a.ZONE_NAME, 5)) = 1 THEN RIGHT(a.ZONE_NAME, 5) ELSE 0 END) AS VARCHAR(5)),5)
           --       AS CCMS
           e.Name + '-' + c.NAME + '/' + SUBSTRING('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', ((CAST(a.CHANNEL AS INT) / 10) + 1), 1) +  CAST((CAST(a.CHANNEL AS INT) % 10) AS VARCHAR) +'-' + RIGHT('00000'+CAST((CASE WHEN ISNUMERIC(RIGHT(a.ZONE_NAME, 5)) = 1 THEN RIGHT(a.ZONE_NAME, 5) ELSE e.ProfileID END) AS VARCHAR(5)),5)
                  AS CCMS
         FROM dbo.REGIONALIZED_IU AS a (NOLOCK)
         JOIN dbo.REGIONALIZED_NETWORK_IU_MAP AS b (NOLOCK) ON a.REGIONALIZED_IU_ID = b.REGIONALIZED_IU_ID
         JOIN dbo.REGIONALIZED_NETWORK AS c (NOLOCK) ON b.REGIONALIZED_NETWORK_ID = c.REGIONALIZED_NETWORK_ID
         JOIN dbo.ZONE_MAP AS d  (NOLOCK) ON a.ZONE_NAME = d.ZONE_NAME
         JOIN dbo.Market AS e  (NOLOCK) ON d.MarketID = e.MarketID
         WHERE a.REGIONID     = @RegionID
      ) x
   WHERE  #IU.IU_ID        = x.IU_ID


   UPDATE  dbo.REGIONALIZED_IU
   SET
      ZONE         = w.ZONE,
      ZONE_NAME        = w.ZONE_NAME,
      CHANNEL         = w.CHANNEL,
      CHAN_NAME        = w.CHAN_NAME,
      CHANNEL_NAME       = ISNULL(w.CHANNEL_NAME, ''),
      DELAY         = w.DELAY,
      START_TRIGGER       = w.START_TRIGGER,
      END_TRIGGER        = w.END_TRIGGER,
      AWIN_START        = w.AWIN_START,
      AWIN_END        = w.AWIN_END,
      VALUE         = w.VALUE,
      MASTER_NAME        = w.MASTER_NAME,
      COMPUTER_NAME       = w.COMPUTER_NAME,
      PARENT_ID        = w.PARENT_ID,
      SYSTEM_TYPE        = w.SYSTEM_TYPE,
      COMPUTER_PORT       = w.COMPUTER_PORT,
      MIN_DURATION       = w.MIN_DURATION,
      MAX_DURATION       = w.MAX_DURATION,
      START_OF_DAY       = w.START_OF_DAY,
      RESCHEDULE_WINDOW      = w.RESCHEDULE_WINDOW,
      IC_CHANNEL        = w.IC_CHANNEL,
      VSM_SLOT        = w.VSM_SLOT,
      DECODER_PORT       = w.DECODER_PORT,
      TC_ID         = w.TC_ID,
      IGNORE_VIDEO_ERRORS      = w.IGNORE_VIDEO_ERRORS,
      IGNORE_AUDIO_ERRORS      = w.IGNORE_AUDIO_ERRORS,
      COLLISION_DETECT_ENABLED    = w.COLLISION_DETECT_ENABLED,
      TALLY_NORMALLY_HIGH      = w.TALLY_NORMALLY_HIGH,
      PLAY_OVER_COLLISIONS     = w.PLAY_OVER_COLLISIONS,
      PLAY_COLLISION_FUDGE     = w.PLAY_COLLISION_FUDGE,
      TALLY_COLLISION_FUDGE     = w.TALLY_COLLISION_FUDGE,
      TALLY_ERROR_FUDGE      = w.TALLY_ERROR_FUDGE,
      LOG_TALLY_ERRORS      = w.LOG_TALLY_ERRORS,
      TBI_START        = w.TBI_START,
      TBI_END         = w.TBI_END,
      CONTINUOUS_PLAY_FUDGE     = w.CONTINUOUS_PLAY_FUDGE,
      TONE_GROUP        = w.TONE_GROUP,
      IGNORE_END_TONES      = w.IGNORE_END_TONES,
      END_TONE_FUDGE       = w.END_TONE_FUDGE,
      MAX_AVAILS        = w.MAX_AVAILS,
      RESTART_TRIES       = w.RESTART_TRIES,
      RESTART_BYTE_SKIP      = w.RESTART_BYTE_SKIP,
      RESTART_TIME_REMAINING     = w.RESTART_TIME_REMAINING,
      GENLOCK_FLAG       = w.GENLOCK_FLAG,
      SKIP_HEADER        = w.SKIP_HEADER,
      GPO_IGNORE        = w.GPO_IGNORE,
      GPO_NORMAL        = w.GPO_NORMAL,
      GPO_TIME        = w.GPO_TIME,
      DECODER_SHARING       = w.DECODER_SHARING,
      HIGH_PRIORITY       = w.HIGH_PRIORITY,
      SPLICER_ID        = w.SPLICER_ID,
      PORT_ID         = w.PORT_ID,
      VIDEO_PID        = w.VIDEO_PID,
      SERVICE_PID        = w.SERVICE_PID,
      DVB_CARD        = w.DVB_CARD,
      SPLICE_ADJUST       = w.SPLICE_ADJUST,
      POST_BLACK        = w.POST_BLACK,
      SWITCH_CNT        = w.SWITCH_CNT,
      DECODER_CNT        = w.DECODER_CNT,
      DVB_CARD_CNT       = w.DVB_CARD_CNT,
      DVB_PORTS_PER_CARD      = w.DVB_PORTS_PER_CARD,
      DVB_CHAN_PER_PORT      = w.DVB_CHAN_PER_PORT,
      USE_ISD         = w.USE_ISD,
      NO_NETWORK_VIDEO_DETECT     = w.NO_NETWORK_VIDEO_DETECT,
      NO_NETWORK_PLAY       = w.NO_NETWORK_PLAY,
      IP_TONE_THRESHOLD      = w.IP_TONE_THRESHOLD,
      USE_GIGE        = w.USE_GIGE,
      GIGE_IP         = w.GIGE_IP,
      IS_ACTIVE_IND       = w.IS_ACTIVE_IND,
      msrepl_tran_version      = w.msrepl_tran_version,
      UpdateDate        = GETUTCDATE()

   FROM  #IU w
   WHERE  REGIONALIZED_IU.REGIONID    = @RegionID
   AND   REGIONALIZED_IU.IU_ID     = w.IU_ID
   AND   (
      REGIONALIZED_IU.msrepl_tran_version  <> w.msrepl_tran_version
   OR   REGIONALIZED_IU.CHANNEL_NAME   = ''
   OR   REGIONALIZED_IU.CHANNEL_NAME   <> w.CHANNEL_NAME
      )

   SELECT    TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU Success Step'
   SET     @ErrorID = 0
  END TRY
  BEGIN CATCH
   SELECT    @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET     @ErrorID = @ErrNum
   SELECT    TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU Fail Step'
  END CATCH

  EXEC     dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE  #IU
  DROP TABLE  #DeletedIU

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveNetwork]'
GO
ALTER PROCEDURE [dbo].[SaveNetwork]
  @RegionID    INT,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @MDBSourceID   INT,
  @MDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveNetwork
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Upserts and SPOT Networks to DINGODB and regionalizes the network with a DINGODB network id.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveNetwork.proc.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveNetwork 
//        @RegionID   = 1,
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @MDBSourceID  = 1,
//        @MDBName   = 'MSSNKNLMDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @CMD NVARCHAR(4000)
  DECLARE  @LogIDReturn INT
  DECLARE  @ErrNum   INT
  DECLARE  @ErrMsg   VARCHAR(200)
  DECLARE  @EventLogStatusID INT
  DECLARE  @TempTableCount INT
  DECLARE  @ZONECount  INT

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @MDBSourceID,
       @DBComputerName  = @MDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  IF  ISNULL(OBJECT_ID('tempdb..#DeletedNetwork'), 0) > 0 
    DROP TABLE  #DeletedNetwork

  CREATE TABLE #DeletedNetwork
      (
       ID INT Identity(1,1),
       REGIONALIZED_NETWORK_ID int,
       NETWORKID int,
       Name varchar(32)
      )

  IF  ISNULL(OBJECT_ID('tempdb..#Network'), 0) > 0 
    DROP TABLE  #Network

  CREATE TABLE #Network
      (
       IncID INT Identity(1,1),
       ID int,
       Name varchar(32),
       Description varchar(255),
       msrepl_tran_version uniqueidentifier
      )


  SET   @CMD   = 
  'INSERT  #Network
     (
       ID,
       Name,
       Description,
       msrepl_tran_version
     )
  SELECT
       ID,
       Name,
       Description,
       msrepl_tran_version
  FROM   '+ISNULL(@MDBName,'')+'.mpeg.dbo.NETWORK n WITH (NOLOCK) '

  --SELECT   @CMD


  BEGIN TRY
   EXECUTE  sp_executesql @CMD


   --   Identify the IDs from the REGIONALIZED_NETWORK table to be deleted
   INSERT  #DeletedNetwork 
     (
      REGIONALIZED_NETWORK_ID,
      NETWORKID,
      Name
     )
   SELECT  a.REGIONALIZED_NETWORK_ID,
      a.NETWORKID,
      a.Name
   FROM  dbo.REGIONALIZED_NETWORK a WITH (NOLOCK)
   LEFT JOIN #Network b
   ON   a.NETWORKID         = b.ID
   WHERE  a.RegionID         = @RegionID
   AND   b.ID          IS NULL
   

   --   Delete from the tables with FK constraints first
   DELETE  dbo.REGIONALIZED_NETWORK_IU_MAP
   FROM  #DeletedNetwork d
   WHERE  REGIONALIZED_NETWORK_IU_MAP.REGIONALIZED_NETWORK_ID = d.REGIONALIZED_NETWORK_ID


   DELETE  dbo.REGIONALIZED_NETWORK
   FROM  #DeletedNetwork d
   WHERE  REGIONALIZED_NETWORK.RegionID    = @RegionID
   AND   REGIONALIZED_NETWORK.REGIONALIZED_NETWORK_ID = d.REGIONALIZED_NETWORK_ID


   UPDATE  dbo.REGIONALIZED_NETWORK
   SET
      Name          = n.Name,
      Description         = n.Description,
      msrepl_tran_version       = n.msrepl_tran_version,
      UpdateDate         = GETUTCDATE()
   FROM  #Network n
   WHERE  REGIONALIZED_NETWORK.RegionID    = @RegionID
   AND   REGIONALIZED_NETWORK.NETWORKID    = n.ID
   AND   REGIONALIZED_NETWORK.msrepl_tran_version <> n.msrepl_tran_version

   

   INSERT  dbo.REGIONALIZED_NETWORK
      (
        REGIONID,
        NETWORKID,
        NAME,
        DESCRIPTION,
        msrepl_tran_version,
        CreateDate
      )
   SELECT
        @RegionID AS REGIONID,
        a.ID AS NETWORKID,
        a.Name,
        a.Description,
        a.msrepl_tran_version,
        GETUTCDATE()
   FROM    #Network a
   LEFT JOIN   (
         SELECT  NETWORKID
         FROM  dbo.REGIONALIZED_NETWORK (NOLOCK)
         WHERE  REGIONID = @RegionID
        ) b
   ON     a.ID        = b.NETWORKID
   WHERE    b.NETWORKID       IS NULL
   ORDER BY   a.IncID

   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork Success Step'

  END TRY
  BEGIN CATCH

   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID = @ErrNum
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork Fail Step'

  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE  #Network
  DROP TABLE  #DeletedNetwork

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveNetwork_IU_Map]'
GO
ALTER PROCEDURE [dbo].[SaveNetwork_IU_Map]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
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
// Module:  dbo.SaveNetwork_IU_Map
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts a SPOT network id to IU id mapping table to DINGODB so that the mapping table is preserved.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveNetwork_IU_Map.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveNetwork_IU_Map 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD NVARCHAR(4000)
		DECLARE		@LogIDReturn INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#Network_IU_Mapped'), 0) > 0 
				DROP TABLE		#Network_IU_Mapped

		CREATE TABLE	#Network_IU_Mapped 
						(
							ID INT Identity(1,1),
							REGIONALIZED_NETWORK_IU_MAP_ID int,
							REGIONALIZED_NETWORK_ID int,
							REGIONALIZED_IU_ID int,
							NETWORK_ID int,
							IU_ID int,
							msrepl_tran_version uniqueidentifier
						)


		IF		ISNULL(OBJECT_ID('tempdb..#Network_IU_Map'), 0) > 0 
				DROP TABLE		#Network_IU_Map

		CREATE TABLE	#Network_IU_Map 
						(
							ID INT Identity(1,1),
							NETWORK_ID int,
							IU_ID int,
							msrepl_tran_version uniqueidentifier
						)



		SET			@CMD			= 
		'INSERT		#Network_IU_Map
					(
							NETWORK_ID,
							IU_ID,
							msrepl_tran_version
					)
		SELECT
							NETWORK_ID,
							IU_ID,
							msrepl_tran_version
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.NETWORK_IU_MAP a WITH (NOLOCK)  '

		--SELECT			@CMD
		EXECUTE		sp_executesql	@CMD


		INSERT		#Network_IU_Mapped ( REGIONALIZED_NETWORK_IU_MAP_ID, REGIONALIZED_NETWORK_ID, REGIONALIZED_IU_ID, NETWORK_ID, IU_ID, msrepl_tran_version )
		SELECT
					NM.REGIONALIZED_NETWORK_IU_MAP_ID,
					RN.REGIONALIZED_NETWORK_ID,
					RIU.REGIONALIZED_IU_ID,
					a.NETWORK_ID,
					a.IU_ID,
					a.msrepl_tran_version
		FROM		#Network_IU_Map a
		LEFT JOIN	(
							SELECT		REGIONALIZED_NETWORK_ID, NETWORKID AS NETWORK_ID
							FROM		dbo.REGIONALIZED_NETWORK (NOLOCK)
							WHERE		REGIONID				= @RegionID
					) RN
		ON			a.NETWORK_ID								= RN.NETWORK_ID
		LEFT JOIN	(
							SELECT		REGIONALIZED_IU_ID, IU_ID
							FROM		dbo.REGIONALIZED_IU (NOLOCK)
							WHERE		REGIONID				= @RegionID
					) RIU
		ON			a.IU_ID										= RIU.IU_ID
		LEFT JOIN	dbo.REGIONALIZED_NETWORK_IU_MAP NM (NOLOCK)
		ON			RN.REGIONALIZED_NETWORK_ID					= NM.REGIONALIZED_NETWORK_ID
		AND			RIU.REGIONALIZED_IU_ID						= NM.REGIONALIZED_IU_ID


		BEGIN TRY

			DELETE		dbo.REGIONALIZED_NETWORK_IU_MAP
			FROM		dbo.REGIONALIZED_NETWORK_IU_MAP a
			JOIN		dbo.REGIONALIZED_NETWORK (NOLOCK) b
			ON			a.REGIONALIZED_NETWORK_ID				= b.REGIONALIZED_NETWORK_ID
			JOIN		dbo.REGIONALIZED_IU (NOLOCK) c
			ON			a.REGIONALIZED_IU_ID					= c.REGIONALIZED_IU_ID
			LEFT JOIN	#Network_IU_Mapped TMap
			ON			b.NETWORKID								= TMap.NETWORK_ID
			AND			c.IU_ID									= TMap.IU_ID
			WHERE		b.REGIONID								= @RegionID
			AND			c.REGIONID								= @RegionID
			AND			TMap.REGIONALIZED_NETWORK_IU_MAP_ID		IS NULL

			UPDATE		dbo.REGIONALIZED_NETWORK_IU_MAP
			SET			
						REGIONALIZED_NETWORK_ID					= a.REGIONALIZED_NETWORK_ID,
						REGIONALIZED_IU_ID						= a.REGIONALIZED_IU_ID,
						msrepl_tran_version						= a.msrepl_tran_version,
						UpdateDate								= GETUTCDATE()
			FROM		#Network_IU_Mapped a
			JOIN		dbo.REGIONALIZED_NETWORK_IU_MAP b
			ON			a.REGIONALIZED_NETWORK_IU_MAP_ID		= b.REGIONALIZED_NETWORK_IU_MAP_ID
			WHERE		a.msrepl_tran_version					<> b.msrepl_tran_version

			INSERT		dbo.REGIONALIZED_NETWORK_IU_MAP
						(
								REGIONALIZED_NETWORK_ID,
								REGIONALIZED_IU_ID,
								msrepl_tran_version,
								CreateDate
						)
			SELECT
						a.REGIONALIZED_NETWORK_ID,
						a.REGIONALIZED_IU_ID,
						a.msrepl_tran_version,
						GETUTCDATE() 
			FROM		#Network_IU_Mapped a
			WHERE		a.REGIONALIZED_NETWORK_IU_MAP_ID		IS NULL
			AND			a.REGIONALIZED_NETWORK_ID				IS NOT NULL
			AND			a.REGIONALIZED_IU_ID					IS NOT NULL

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map Success Step'
			SET			@ErrorID = 0
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#Network_IU_Map

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveSPOT_CONFLICT_STATUS]'
GO
ALTER PROCEDURE [dbo].[SaveSPOT_CONFLICT_STATUS]
  @RegionID    INT,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @MDBSourceID   INT,
  @MDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveSPOT_CONFLICT_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Upserts SPOT_CONFLICT_STATUS definition table to DINGODB and regionalizes the SPOT_CONFLICT_STATUS with a DINGODB SPOT_CONFLICT_STATUS ID.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveSPOT_CONFLICT_STATUS.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveSPOT_CONFLICT_STATUS 
//        @RegionID   = 1,
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @MDBSourceID  = 1,
//        @MDBName   = 'MSSNKNLMDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @CMD   NVARCHAR(4000)
  DECLARE  @LogIDReturn INT
  DECLARE  @ErrNum   INT
  DECLARE  @ErrMsg   VARCHAR(200)
  DECLARE  @EventLogStatusID INT = 16
  DECLARE  @TempTableCount INT
  DECLARE  @ZONECount  INT


  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @MDBSourceID,
       @DBComputerName  = @MDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  IF  ISNULL(OBJECT_ID('tempdb..#SPOT_CONFLICT_STATUS'), 0) > 0 
    DROP TABLE  #SPOT_CONFLICT_STATUS

  CREATE TABLE #SPOT_CONFLICT_STATUS 
      (
       ID INT Identity(1,1),
       RegionID int,
       NSTATUS int,
       VALUE varchar(200),
       CHECKSUM_VALUE int
      )

  SET   @CMD   = 
  'INSERT  #SPOT_CONFLICT_STATUS
     (
       RegionID,
       NSTATUS,
       VALUE,
       CHECKSUM_VALUE 
     )
  SELECT
       ' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
       NSTATUS,
       VALUE,
       CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
  FROM   '+ISNULL(@MDBName,'')+'.mpeg.dbo.SPOTCONFLICT_STATUS s WITH (NOLOCK) '


  BEGIN TRY
   EXECUTE  sp_executesql @CMD

   UPDATE  dbo.REGIONALIZED_SPOT_CONFLICT_STATUS
   SET
      RegionID           = s.RegionID,
      NSTATUS            = s.NSTATUS,
      VALUE            = s.VALUE,
      CHECKSUM_VALUE           = s.CHECKSUM_VALUE

   FROM  #SPOT_CONFLICT_STATUS s
   WHERE  REGIONALIZED_SPOT_CONFLICT_STATUS.RegionID   = @RegionID
   AND   REGIONALIZED_SPOT_CONFLICT_STATUS.NSTATUS   = s.NSTATUS
   AND   REGIONALIZED_SPOT_CONFLICT_STATUS.CHECKSUM_VALUE <> s.CHECKSUM_VALUE

   
   INSERT  dbo.REGIONALIZED_SPOT_CONFLICT_STATUS
      (
        RegionID,
        NSTATUS,
        VALUE,
        CHECKSUM_VALUE
      )
   SELECT
        @RegionID AS RegionID,
        y.NSTATUS,
        y.VALUE,
        y.CHECKSUM_VALUE
   FROM    #SPOT_CONFLICT_STATUS y
   LEFT JOIN   (
          SELECT  NSTATUS
          FROM  dbo.REGIONALIZED_SPOT_CONFLICT_STATUS (NOLOCK)
          WHERE  RegionID = @RegionID
        ) z
   ON     y.NSTATUS = z.NSTATUS
   WHERE    z.NSTATUS IS NULL
   ORDER BY   y.ID

   SET   @ErrorID = 0
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS Success Step'
  END TRY
  BEGIN CATCH
   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID = @ErrNum
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS Fail Step'
  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE  #SPOT_CONFLICT_STATUS

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveSPOT_STATUS]'
GO
ALTER PROCEDURE [dbo].[SaveSPOT_STATUS]
  @RegionID    INT,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @MDBSourceID   INT,
  @MDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveSPOT_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Upserts SPOT_STATUS definition table to DINGODB and regionalizes the SPOT_STATUS with a DINGODB SPOT_STATUS ID.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveSPOT_STATUS.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveSPOT_STATUS 
//        @RegionID   = 1,
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @MDBSourceID  = 1,
//        @MDBName   = 'MSSNKNLMDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @CMD NVARCHAR(4000)
  DECLARE  @LogIDReturn INT
  DECLARE  @ErrNum   INT
  DECLARE  @ErrMsg   VARCHAR(200)
  DECLARE  @EventLogStatusID INT = 16
  DECLARE  @TempTableCount INT
  DECLARE  @ZONECount  INT

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_STATUS First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @MDBSourceID,
       @DBComputerName  = @MDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  IF  ISNULL(OBJECT_ID('tempdb..#SPOT_STATUS'), 0) > 0 
    DROP TABLE  #SPOT_STATUS

  CREATE TABLE #SPOT_STATUS 
      (
       ID INT Identity(1,1),
       RegionID int,
       NSTATUS int,
       VALUE varchar(200),
       CHECKSUM_VALUE int
      )

  SET   @CMD   = 
  'INSERT  #SPOT_STATUS
     (
       RegionID,
       NSTATUS,
       VALUE,
       CHECKSUM_VALUE 
     )
  SELECT
       ' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
       NSTATUS,
       VALUE,
       CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
  FROM   '+ISNULL(@MDBName,'')+'.mpeg.dbo.SPOT_STATUS s WITH (NOLOCK) '


  BEGIN TRY
   EXECUTE  sp_executesql @CMD

   UPDATE  dbo.REGIONALIZED_SPOT_STATUS
   SET
      RegionID        = s.RegionID,
      NSTATUS         = s.NSTATUS,
      VALUE         = s.VALUE,
      CHECKSUM_VALUE        = s.CHECKSUM_VALUE

   FROM  #SPOT_STATUS s
   WHERE  REGIONALIZED_SPOT_STATUS.RegionID  = @RegionID
   AND   REGIONALIZED_SPOT_STATUS.NSTATUS  = s.NSTATUS
   AND   REGIONALIZED_SPOT_STATUS.CHECKSUM_VALUE <> s.CHECKSUM_VALUE

   
   INSERT  dbo.REGIONALIZED_SPOT_STATUS
      (
        RegionID,
        NSTATUS,
        VALUE,
        CHECKSUM_VALUE
      )
   SELECT
        @RegionID AS RegionID,
        y.NSTATUS,
        y.VALUE,
        y.CHECKSUM_VALUE
   FROM    #SPOT_STATUS y
   LEFT JOIN   (
          SELECT  NSTATUS
          FROM  dbo.REGIONALIZED_SPOT_STATUS (NOLOCK)
          WHERE  RegionID = @RegionID
        ) z
   ON     y.NSTATUS = z.NSTATUS
   WHERE    z.NSTATUS IS NULL
   ORDER BY   y.ID
      
   SET   @ErrorID = 0
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_STATUS Success Step'
  END TRY
  BEGIN CATCH
   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID = @ErrNum
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_STATUS Fail Step'
  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE  #SPOT_STATUS

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[SaveZone]'
GO
ALTER PROCEDURE [dbo].[SaveZone]
  @RegionID    INT,
  @JobID     UNIQUEIDENTIFIER = NULL,
  @JobName    VARCHAR(100) = NULL,
  @MDBSourceID   INT,
  @MDBName    VARCHAR(50),
  @JobRun     BIT = 0,
  @ErrorID    INT OUTPUT
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
// Module:  dbo.SaveZone
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:    Upserts a SPOT Zone to DINGODB and regionalizes the zone by assigning a DINGODB zone id.
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.SaveZone.proc.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//  Usage:
//
//    DECLARE  @ErrNum   INT
//    EXEC  dbo.SaveZone 
//        @RegionID   = 1,
//        @JobID    = 'JobID',
//        @JobName   = 'JobName',
//        @MDBSourceID  = 1,
//        @MDBName   = 'MSSNKNLMDB001P',
//        @JobRun    = 0,
//        @ErrorID   = @ErrNum OUTPUT
//    SELECT  @ErrNum
//    
//
*/ 
-- =============================================
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;


  DECLARE  @CMD      NVARCHAR(4000)
  DECLARE  @LogIDReturn    INT
  DECLARE  @ErrNum      INT
  DECLARE  @ErrMsg      VARCHAR(200)
  DECLARE  @EventLogStatusID   INT = 1  --Unidentified Step
  DECLARE  @TempTableCount    INT
  DECLARE  @ZONECount     INT

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = @MDBSourceID,
       @DBComputerName  = @MDBName,
       @LogIDOUT   = @LogIDReturn OUTPUT

  IF  ISNULL(OBJECT_ID('tempdb..#DeletedZone'), 0) > 0 
    DROP TABLE  #DeletedZone

  CREATE TABLE #DeletedZone
      (
       ID INT Identity(1,1),
       REGIONALIZED_ZONE_ID int,
       Zone_ID int,
       Zone_Name varchar(32)
      )


  IF  ISNULL(OBJECT_ID('tempdb..#Zones'), 0) > 0 
    DROP TABLE  #Zones

  CREATE TABLE #Zones 
      (
       ID INT Identity(1,1),
       ZONE_ID int,
       ZONE_NAME varchar(32),
       DATABASE_SERVER_NAME varchar(32),
       DB_ID int,
       SCHEDULE_RELOADED int,
       MAX_DAYS int,
       MAX_ROWS int,
       TB_TYPE int,
       LOAD_TTL int,
       LOAD_TOD datetime,
       ASRUN_TTL int,
       ASRUN_TOD datetime,
       IC_ZONE_ID int,
       PRIMARY_BREAK int,
       SECONDARY_BREAK int,
       msrepl_tran_version uniqueidentifier
      )

  SET   @CMD   = 
  'INSERT  #Zones
     (
       ZONE_ID,
       ZONE_NAME,
       DATABASE_SERVER_NAME,
       DB_ID,
       SCHEDULE_RELOADED,
       MAX_DAYS,
       MAX_ROWS,
       TB_TYPE,
       LOAD_TTL,
       LOAD_TOD,
       ASRUN_TTL,
       ASRUN_TOD,
       IC_ZONE_ID,
       PRIMARY_BREAK,
       SECONDARY_BREAK,
       msrepl_tran_version
     )
  SELECT
       ZONE_ID,
       LTRIM(RTRIM(ZONE_NAME)),
       DATABASE_SERVER_NAME,
       DB_ID,
       SCHEDULE_RELOADED,
       MAX_DAYS,
       MAX_ROWS,
       TB_TYPE,
       LOAD_TTL,
       LOAD_TOD,
       ASRUN_TTL,
       ASRUN_TOD,
       IC_ZONE_ID,
       PRIMARY_BREAK,
       SECONDARY_BREAK,
       msrepl_tran_version
  FROM   '+ISNULL(@MDBName,'')+'.mpeg.dbo.ZONE z WITH (NOLOCK) '

  --SELECT   @CMD

  BEGIN TRY
   EXECUTE  sp_executesql @CMD

   --   Identify the IDs from the REGIONALIZED_ZONE table to be deleted
   INSERT  #DeletedZone 
     (
      REGIONALIZED_ZONE_ID,
      Zone_ID,
      Zone_Name
     )
   SELECT  a.REGIONALIZED_ZONE_ID,
      a.Zone_ID,
      a.Zone_Name
   FROM  REGIONALIZED_ZONE a WITH (NOLOCK)
   LEFT JOIN #Zones b
   ON   a.ZONE_NAME         = b.ZONE_NAME
   WHERE  a.Region_ID         = @RegionID
   AND   b.ID          IS NULL
   

   --   Delete from the tables with FK constraints first
   DELETE  dbo.ChannelStatus
   FROM  #DeletedZone d
   WHERE  ChannelStatus.RegionalizedZoneID   = d.REGIONALIZED_ZONE_ID


   DELETE  dbo.REGIONALIZED_ZONE
   FROM  #DeletedZone d
   WHERE  REGIONALIZED_ZONE.REGION_ID    = @RegionID
   AND   REGIONALIZED_ZONE.REGIONALIZED_ZONE_ID = d.REGIONALIZED_ZONE_ID


   UPDATE  dbo.REGIONALIZED_ZONE
   SET
      ZONE_ID         = z.ZONE_ID,
      DATABASE_SERVER_NAME     = z.DATABASE_SERVER_NAME,
      DB_ID         = z.DB_ID,
      SCHEDULE_RELOADED      = z.SCHEDULE_RELOADED,
      MAX_DAYS        = z.MAX_DAYS,
      MAX_ROWS        = z.MAX_ROWS,
      TB_TYPE         = z.TB_TYPE,
      LOAD_TTL        = z.LOAD_TTL,
      LOAD_TOD        = z.LOAD_TOD,
      ASRUN_TTL        = z.ASRUN_TTL,
      ASRUN_TOD        = z.ASRUN_TOD,
      IC_ZONE_ID        = z.IC_ZONE_ID,
      PRIMARY_BREAK       = z.PRIMARY_BREAK,
      SECONDARY_BREAK       = z.SECONDARY_BREAK,
      msrepl_tran_version      = z.msrepl_tran_version,
      UpdateDate        = GETUTCDATE()
   FROM  #Zones z
   WHERE  REGIONALIZED_ZONE.ZONE_NAME    = z.ZONE_NAME
   AND   REGIONALIZED_ZONE.REGION_ID    = @RegionID
   AND   REGIONALIZED_ZONE.msrepl_tran_version <> z.msrepl_tran_version

   
   INSERT  dbo.REGIONALIZED_ZONE
      (
        REGION_ID,
        ZONE_MAP_ID,
        ZONE_ID,
        ZONE_NAME,
        DATABASE_SERVER_NAME,
        DB_ID,
        SCHEDULE_RELOADED,
        MAX_DAYS,
        MAX_ROWS,
        TB_TYPE,
        LOAD_TTL,
        LOAD_TOD,
        ASRUN_TTL,
        ASRUN_TOD,
        IC_ZONE_ID,
        PRIMARY_BREAK,
        SECONDARY_BREAK,
        msrepl_tran_version,
        CreateDate
      )
   SELECT
        @RegionID AS RegionID,
        z.ZONE_MAP_ID,
        y.ZONE_ID,
        y.ZONE_NAME,
        y.DATABASE_SERVER_NAME,
        y.DB_ID,
        y.SCHEDULE_RELOADED,
        y.MAX_DAYS,
        y.MAX_ROWS,
        y.TB_TYPE,
        y.LOAD_TTL,
        y.LOAD_TOD,
        y.ASRUN_TTL,
        y.ASRUN_TOD,
        y.IC_ZONE_ID,
        y.PRIMARY_BREAK,
        y.SECONDARY_BREAK,
        y.msrepl_tran_version,
        GETUTCDATE()
   FROM    #Zones y
   --JOIN    dbo.ZONE_MAP x (NOLOCK)
   --ON     y.ZONE_NAME = x.ZONE_NAME
   LEFT JOIN   (
          SELECT  b.ZONE_NAME, b.ZONE_MAP_ID
          FROM  dbo.REGIONALIZED_ZONE b (NOLOCK)
          WHERE  b.REGION_ID  = @RegionID
        ) z
   ON     y.ZONE_NAME = z.ZONE_NAME
   WHERE    z.ZONE_NAME IS NULL
   ORDER BY   y.ID
      
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone Success Step'
  END TRY
  BEGIN CATCH
   SELECT  @ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
   SET   @ErrorID = @ErrNum
   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone Fail Step'
  END CATCH

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE  #Zones
  DROP TABLE  #DeletedZone

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[UpdateRegionalInfo]'
GO
ALTER PROCEDURE dbo.UpdateRegionalInfo
  @JobOwnerLoginName NVARCHAR(100),
  @JobOwnerLoginPWD NVARCHAR(100),
  @UTC_Cutoff_Day  DATE = '2000-01-01',
  @JobRun    TINYINT = 1
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
// Module:  dbo.UpdateRegionalInfo
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:    Updates the regional definition tables.
//
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.UpdateRegionalInfo.proc.sql 3054 2013-11-12 18:41:17Z tlew $
//    
//  Usage:
//
//    EXEC  dbo.UpdateRegionalInfo 
//        @JobOwnerLoginName = N'MCC2-LAILAB\\nbrownett',
//        @JobOwnerLoginPWD = N'PF_ds0tm!',
//        @UTC_Cutoff_Day  = '2013-10-07',
//        @JobRun = 1
//    
//
*/ 
-- =============================================
BEGIN


  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET NOCOUNT ON;

  DECLARE  @RegionID     INT
  DECLARE  @MDBNodeID     INT
  DECLARE  @MDBSourceID    INT
  DECLARE  @EventLogStatusID   INT
  DECLARE  @JobID      UNIQUEIDENTIFIER
  DECLARE  @JobName     NVARCHAR(200)
  DECLARE  @MDBNameResult    VARCHAR(50)
  --DECLARE  @MDBNameSDBListResult  VARCHAR(50)
  DECLARE  @MDBNamePrimaryIn   VARCHAR(32)
  DECLARE  @MDBNameSecondaryIn   VARCHAR(32)
  DECLARE  @TotalRegions    INT
  DECLARE  @i       INT = 1
  DECLARE  @ErrNum      INT
  DECLARE  @ErrMsg      NVARCHAR(200)
  DECLARE  @LogIDReturn    INT
  DECLARE  @ErrNumTotal    INT
  DECLARE  @LogIDConflictsReturn  INT


  SELECT  TOP 1 
     @JobID      = a.job_id,
     @JobName     = 'Update Regional Info'
  FROM  msdb.dbo.sysjobs a (NOLOCK)
  WHERE  a.name      LIKE 'Update Regional Info'

  SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'UpdateRegionalInfo First Step'

  EXEC  dbo.LogEvent 
       @LogID    = NULL,
       @EventLogStatusID = @EventLogStatusID,   ----Started Step
       @JobID    = @JobID,
       @JobName   = @JobName,
       @DBID    = NULL,
       @DBComputerName  = NULL,
       @LogIDOUT   = @LogIDReturn OUTPUT



  IF OBJECT_ID('tempdb..#ResultsALLMDB') IS NOT NULL
   DROP TABLE #ResultsALLMDB
  CREATE TABLE #ResultsALLMDB ( ID INT IDENTITY(1,1), MDBSourceID INT, RegionID INT )

  --Clean up local tables
  EXEC  dbo.PurgeSDB_IESPOT 
      @UTC_Cutoff_Day  = @UTC_Cutoff_Day,
      @JobID    = @JobID,
      @JobName   = @JobName,
      @MDBSourceID  = @MDBSourceID,
      @MDBName   = @MDBNameResult,
      @JobRun    = @JobRun,
      @ErrorID   = @ErrNum OUTPUT
  SELECT   @ErrNumTotal  = @ErrNum

  INSERT   #ResultsALLMDB ( MDBSourceID, RegionID )
  SELECT   a.MDBSourceID, a.RegionID
  FROM   dbo.MDBSource a (NOLOCK)
  JOIN   (
        SELECT  MDBSourceID
        FROM  dbo.MDBSourceSystem (NOLOCK)
        WHERE  Enabled   = 1
        GROUP BY MDBSourceID
      ) b
  ON     a.MDBSourceID   = b.MDBSourceID
  ORDER BY  a.MDBSourceID
  SELECT   @TotalRegions = SCOPE_IDENTITY()

  WHILE   ( @i <= @TotalRegions )
  BEGIN

      SELECT   @MDBSourceID   = a.MDBSourceID,
          @RegionID    = a.RegionID
      FROM   #ResultsALLMDB a 
      WHERE    a.ID     = @i

      EXEC   dbo.GetActiveMDB 
           @MDBSourceID   = @MDBSourceID,
           @JobID     = @JobID,
           @JobName    = @JobName,
           @MDBNameActive   = @MDBNameResult OUTPUT


      IF    ( @MDBNameResult IS NOT NULL ) 
      BEGIN

          EXEC   dbo.AddNewSDBNode 
               @MDBName   = @MDBNameResult,
               @RegionID   = @RegionID,
               @JobOwnerLoginName = @JobOwnerLoginName,
               @JobOwnerLoginPWD = @JobOwnerLoginPWD

          EXEC   dbo.SaveZone 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

          EXEC   dbo.SaveIU 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

          EXEC   dbo.SaveNetwork 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

          EXEC   dbo.SaveNetwork_IU_Map 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

          EXEC   dbo.SaveIU 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

          EXEC   dbo.SaveSPOT_CONFLICT_STATUS 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

          EXEC   dbo.SaveSPOT_STATUS 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

          EXEC   dbo.SaveIE_CONFLICT_STATUS 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

          EXEC   dbo.SaveIE_STATUS 
               @RegionID   = @RegionID,
               @JobID    = @JobID,
               @JobName   = @JobName,
               @MDBSourceID  = @MDBSourceID,
               @MDBName   = @MDBNameResult,
               @JobRun    = @JobRun,
               @ErrorID   = @ErrNum OUTPUT
          SELECT   @ErrNumTotal   = @ErrNumTotal + @ErrNum

      END

      SET    @i = @i + 1

  END

  SELECT   TOP 1 @EventLogStatusID = EventLogStatusID 
  FROM   dbo.EventLogStatus (NOLOCK) 
  WHERE   SP = ( CASE WHEN ISNULL(@ErrNumTotal, 0) = 0 THEN 'UpdateRegionalInfo Success Step' ELSE 'UpdateRegionalInfo Fail Step' END )

  EXEC   dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

  DROP TABLE #ResultsALLMDB


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[MaintenanceBackupFull]'
GO
ALTER PROCEDURE [dbo].[MaintenanceBackupFull]
		@BackUpPathName			VARCHAR(100) = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\',
		@ErrorID				INT = NULL OUTPUT
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
// Module:  dbo.MaintenanceBackupFull
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Perform Full Backup of DINGODB Database to BackUpPathName Supplied.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.MaintenanceBackupFull.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/
BEGIN


			DECLARE		@BackUpDestination	VARCHAR(100)
			DECLARE		@UTCNow				DATETIME = GETUTCDATE()
			DECLARE		@UTCNowYear			CHAR(4)
			DECLARE		@UTCNowMonth		CHAR(2)
			DECLARE		@UTCNowDay			CHAR(2)
			DECLARE		@UTCNowMinute		CHAR(2)

			DECLARE		@CMD 										NVARCHAR(1000)
			DECLARE		@EventLogStatusID							INT
			DECLARE		@LogIDReturn								INT

			SELECT		@ErrorID					= 1
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupFull First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= NULL,
								@DBComputerName		= NULL,	
								@LogIDOUT			= @LogIDReturn OUTPUT

			SELECT		@UTCNowYear			= DATEPART(Year, @UTCNow),
						@UTCNowMonth		= DATEPART(Month, @UTCNow),
						@UTCNowDay			= DATEPART(Day, @UTCNow),
						@UTCNowMinute		= DATEPART(Minute, @UTCNow)
			SELECT		@UTCNowMonth		= CASE WHEN LEN(@UTCNowMonth) = 1 THEN '0' + @UTCNowMonth ELSE @UTCNowMonth END,
						@UTCNowDay			= CASE WHEN LEN(@UTCNowDay) = 1 THEN '0' + @UTCNowDay ELSE @UTCNowDay END,
						@UTCNowMinute		= CASE WHEN LEN(@UTCNowMinute) = 1 THEN '0' + @UTCNowMinute ELSE @UTCNowMinute END

			SELECT		@BackUpDestination	= @BackUpPathName + 'DINGODB.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'

			BACKUP DATABASE DINGODB
				TO DISK						= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			DECLARE @DeleteDate DATETIME = DATEADD(D, -7, GETDATE())
			EXECUTE master.dbo.xp_delete_file 0, @BackUpPathName, N'Full.bak', @DeleteDate, 1


			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupFull Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL
			SELECT		@ErrorID					= 0


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[MaintenanceBackupTransactionLog]'
GO
ALTER PROCEDURE [dbo].[MaintenanceBackupTransactionLog]
		@BackUpPathName			VARCHAR(100) = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\',
		@ErrorID				INT = NULL OUTPUT
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
// Module:  dbo.MaintenanceBackupTransactionLog
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Perform Backup of DINGODB Log to BackUpPathName Supplied.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.MaintenanceBackupTransactionLog.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/
BEGIN
			DECLARE		@BackUpDestination	VARCHAR(100)
			DECLARE		@UTCNow				DATETIME = GETUTCDATE()
			DECLARE		@UTCNowYear			CHAR(4)
			DECLARE		@UTCNowMonth		CHAR(2)
			DECLARE		@UTCNowDay			CHAR(2)
			DECLARE		@UTCNowHour			CHAR(2)
			DECLARE		@UTCNowMinute		CHAR(2)


			DECLARE		@CMD 										NVARCHAR(1000)
			DECLARE		@EventLogStatusID							INT
			DECLARE		@LogIDReturn								INT

			SELECT		@ErrorID					= 1
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupTransactionLog First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= NULL,
								@DBComputerName		= NULL,	
								@LogIDOUT			= @LogIDReturn OUTPUT

			SELECT		@UTCNowYear			= DATEPART(Year, @UTCNow),
						@UTCNowMonth		= DATEPART(Month, @UTCNow),
						@UTCNowDay			= DATEPART(Day, @UTCNow),
						@UTCNowHour			= DATEPART(Hour, @UTCNow),
						@UTCNowMinute		= DATEPART(Minute, @UTCNow)
			SELECT		@UTCNowMonth		= CASE WHEN LEN(@UTCNowMonth) = 1 THEN '0' + @UTCNowMonth ELSE @UTCNowMonth END,
						@UTCNowDay			= CASE WHEN LEN(@UTCNowDay) = 1 THEN '0' + @UTCNowDay ELSE @UTCNowDay END,
						@UTCNowHour			= CASE WHEN LEN(@UTCNowHour) = 1 THEN '0' + @UTCNowHour ELSE @UTCNowHour END,
						@UTCNowMinute		= CASE WHEN LEN(@UTCNowMinute) = 1 THEN '0' + @UTCNowMinute ELSE @UTCNowMinute END
			SELECT		@BackUpDestination	= @BackUpPathName + 'DINGODB.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'

			BACKUP LOG DINGODB
				TO DISK						= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			DECLARE @DeleteDate DATETIME = DATEADD(D, -2, GETDATE())
			EXECUTE master.dbo.xp_delete_file 0, @BackUpPathName, N'Log.bak', @DeleteDate, 1

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupTransactionLog Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL
			SELECT		@ErrorID					= 0


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[MaintenanceCleanup]'
GO
ALTER PROCEDURE [dbo].[MaintenanceCleanup]
		@ErrorID				INT = NULL OUTPUT
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
// Module:  dbo.MaintenanceCleanup
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Perform regular tasks that need to be performed on an ongoing basis.
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.MaintenanceCleanup.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN


			DECLARE		@EventLogStatusID							INT
			DECLARE		@LogIDReturn								INT

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceCleanup First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= NULL,
								@DBComputerName		= NULL,	
								@LogIDOUT			= @LogIDReturn OUTPUT

			DELETE FROM EVENTLOG WHERE StartDate <= CAST(DATEADD(D, -2, GETUTCDATE()) AS DATE)

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceCleanup Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[MaintenanceDBIntegrity]'
GO
ALTER PROCEDURE [dbo].[MaintenanceDBIntegrity]
  @ErrorID    INT = NULL OUTPUT
AS
-- =============================================
-- Author:  TXL
-- Create date: 2013-10-01
-- Description: Checks DB Integrity.  Use EXEC xp_readerrorlog to see the results.
--    
--    DECLARE  @ErrNum   INT
--    EXEC  dbo.MaintenanceDBIntegrity 
--        @ErrorID   = @ErrNum OUTPUT
--    SELECT  @ErrNum
--
-- Updates:
-- =============================================
BEGIN


   DECLARE  @CMD           NVARCHAR(1000)
   DECLARE  @EventLogStatusID       INT
   DECLARE  @LogIDReturn        INT

   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity First Step'
   EXEC  dbo.LogEvent 
        @LogID    = NULL,
        @EventLogStatusID = @EventLogStatusID,   
        @JobID    = NULL,
        @JobName   = NULL,
        @DBID    = NULL,
        @DBComputerName  = NULL, 
        @LogIDOUT   = @LogIDReturn OUTPUT

   DBCC CHECKDB ('DINGODB') 

   SELECT  TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity Success Step'
   EXEC  dbo.LogEvent 
        @LogID    = @LogIDReturn, 
        @EventLogStatusID = @EventLogStatusID, 
        @Description  = NULL



END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[CreateMaintenanceJobs]'
GO
ALTER PROCEDURE [dbo].[CreateMaintenanceJobs]
  @JobOwnerLoginName   NVARCHAR(100) = NULL,
  @JobOwnerLoginPWD   NVARCHAR(100) = NULL,
  @BackUpPathNameFull   NVARCHAR(100) = NULL,
  @BackUpPathNameTranLog  NVARCHAR(100) = NULL

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
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates DB Maintenance Jobs
//    
//
//   Current revision:
//     Release:   1.1.1
//     Revision:  $Id: DINGODB.dbo.CreateMaintenanceJobs.proc.sql 3162 2013-11-22 18:50:10Z tlew $
//    
//  Usage:
//
//    EXEC DINGODB.dbo.CreateMaintenanceJobs 
//        @JobOwnerLoginName = N'',
//        @JobOwnerLoginPWD = N'',
//        @BackUpPathNameFull = NULL,
//        @BackUpPathNameTranLog = NULL
//
*/ 
-- =============================================
BEGIN


  SET NOCOUNT ON;
  DECLARE @StepName NVARCHAR(100)
  DECLARE @StepCommand NVARCHAR(500)
  DECLARE @ReturnCode INT
  DECLARE @jobId BINARY(16)

  DECLARE @JobNameMaintenanceBackupFull     NVARCHAR(100) = N'MaintenanceBackupFull'
  DECLARE @JobNameMaintenanceBackupTransactionLog   NVARCHAR(100) = N'MaintenanceBackupTransactionLog'
  DECLARE @JobNameMaintenanceCleanup      NVARCHAR(100) = N'MaintenanceCleanup'
  DECLARE @JobNameMaintenanceDBIntegrity     NVARCHAR(100) = N'MaintenanceDBIntegrity'
  DECLARE @JobNameMaintenanceRebuildIndex     NVARCHAR(100) = N'MaintenanceRebuildIndex'
  DECLARE @JobCategoryMaintenanceName      NVARCHAR(100) = N'Maintenance'



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

    SELECT  @StepName        = N'Step 1', 
       @StepCommand       = N'EXEC DINGODB.dbo.MaintenanceBackupFull ' + ISNULL('@BackUpPathName = ''' + @BackUpPathNameFull + ''' ','')

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

    SELECT  @StepName        = N'Step 1', 
       @StepCommand       = N'EXEC DINGODB.dbo.MaintenanceBackupTransactionLog ' + ISNULL('@BackUpPathName = ''' + @BackUpPathNameTranLog + ''' ',''),
       @jobId        = NULL

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


    SELECT  @StepName        = N'Step 1', 
       @StepCommand       = N'EXEC DINGODB.dbo.MaintenanceCleanup ',
       @jobId        = NULL


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


    SELECT  @StepName        = N'Step 1', 
       @StepCommand       = N'EXEC DINGODB.dbo.MaintenanceDBIntegrity ',
       @jobId        = NULL


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


    SELECT  @StepName        = N'Step 1', 
       @StepCommand       = N'EXEC DINGODB.dbo.MaintenanceRebuildIndex ',
       @jobId        = NULL



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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [NC_CacheStatus_SDBSourceID_CacheStatusTypeID_iUpdateDate] on [dbo].[CacheStatus]'
GO
CREATE NONCLUSTERED INDEX [NC_CacheStatus_SDBSourceID_CacheStatusTypeID_iUpdateDate] ON [dbo].[CacheStatus] ([SDBSourceID], [CacheStatusTypeID]) INCLUDE ([UpdateDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [NC_Conflict_SDBSourceID_UTCTime_i] on [dbo].[Conflict]'
GO
CREATE NONCLUSTERED INDEX [NC_Conflict_SDBSourceID_UTCTime_i] ON [dbo].[Conflict] ([SDBSourceID], [UTCTime]) INCLUDE ([Asset_Desc], [Asset_ID], [CreateDate], [IU_ID], [Scheduled_Insertions], [SPOT_ID], [Time], [UpdateDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [NC_Conflict_UTCTime_SDBSourceID_i] on [dbo].[Conflict]'
GO
CREATE NONCLUSTERED INDEX [NC_Conflict_UTCTime_SDBSourceID_i] ON [dbo].[Conflict] ([UTCTime], [SDBSourceID]) INCLUDE ([Asset_Desc], [Asset_ID], [CreateDate], [IU_ID], [Scheduled_Insertions], [SPOT_ID], [Time], [UpdateDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[SDB_Market]'
GO
ALTER TABLE [dbo].[SDB_Market] ADD CONSTRAINT [FK_SDB_Market_MarketID_-->_Market_MarketID] FOREIGN KEY ([MarketID]) REFERENCES [dbo].[Market] ([MarketID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ZONE_MAP]'
GO
ALTER TABLE [dbo].[ZONE_MAP] ADD CONSTRAINT [FK_ZONE_MAP_MarketID_-->_Market_MarketID] FOREIGN KEY ([MarketID]) REFERENCES [dbo].[Market] ([MarketID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ChannelStatus]'
GO
ALTER TABLE [dbo].[ChannelStatus] ADD CONSTRAINT [FK_ChannelStatus_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY ([SDBSourceID]) REFERENCES [dbo].[SDBSource] ([SDBSourceID])
ALTER TABLE [dbo].[ChannelStatus] ADD CONSTRAINT [FK_ChannelStatus_RegionalizedZoneID_-->_REGIONALIZED_ZONE_REGIONALIZED_ZONE_ID] FOREIGN KEY ([RegionalizedZoneID]) REFERENCES [dbo].[REGIONALIZED_ZONE] ([REGIONALIZED_ZONE_ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering extended properties'
GO
EXEC sp_updateextendedproperty N'MS_Description', N'ATT Moment-to-end insertion conflicts', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_ATTConflicts'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_updateextendedproperty N'MS_Description', N'Moment-to-end insertion conflicts', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_Conflicts'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_updateextendedproperty N'MS_Description', N'IC Moment-to-end insertion conflicts', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_ICConflicts'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating extended properties'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ATT Moment-to-end insertion conflicts in time window1', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_ATTConflicts_Window1'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'ATT Moment-to-end insertion conflicts in time window2', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_ATTConflicts_Window2'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'ATT Moment-to-end insertion conflicts in time window3', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_ATTConflicts_Window3'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'Moment-to-end insertion conflicts in time window1', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_Conflicts_Window1'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'Moment-to-end insertion conflicts in time window2', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_Conflicts_Window2'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'Moment-to-end insertion conflicts in time window3', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_Conflicts_Window3'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'IC Moment-to-end insertion conflicts in time window1', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_ICConflicts_Window1'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'IC Moment-to-end insertion conflicts in time window2', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_ICConflicts_Window2'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'IC Moment-to-end insertion conflicts in time window3', 'SCHEMA', N'dbo', 'TABLE', N'ChannelStatus', 'COLUMN', N'MTE_ICConflicts_Window3'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'CLLI code for a market', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'CILLI'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'CreateDate'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the City and 2-character state identifier for a market', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'Description'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'DINGODB Unique Identifier for a market', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'MarketID'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'CLLI code for a market', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'Name'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'ProfileID for a market', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'ProfileID'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update', 'SCHEMA', N'dbo', 'TABLE', N'Market', 'COLUMN', N'UpdateDate'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
--Change	DBInfo
UPDATE [dbo].[DBInfo] SET DESCRIPTION = N'1.1.1.4044.3800' WHERE NAME = N'Version'

PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
-- Update Lookup Tables
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

PRINT(N'Drop constraint FK_ZONE_MAP_MarketID_-->_Market_MarketID from [dbo].[ZONE_MAP]')
GO
ALTER TABLE [dbo].[ZONE_MAP] DROP CONSTRAINT [FK_ZONE_MAP_MarketID_-->_Market_MarketID]

PRINT(N'Update rows in [dbo].[Market]')
GO
UPDATE [dbo].[Market] SET [Name]='TUKRGV', [ProfileID]='00700' WHERE [MarketID]=1
UPDATE [dbo].[Market] SET [Name]='AUS2TX', [ProfileID]='01400' WHERE [MarketID]=2
UPDATE [dbo].[Market] SET [Name]='BTRGLA', [ProfileID]='03900' WHERE [MarketID]=3
UPDATE [dbo].[Market] SET [Name]='BRHMAL', [ProfileID]='02900' WHERE [MarketID]=4
UPDATE [dbo].[Market] SET [Name]='BKF2CA', [ProfileID]='04800' WHERE [MarketID]=5
UPDATE [dbo].[Market] SET [Name]='CICRIL', [ProfileID]='00100' WHERE [MarketID]=6
UPDATE [dbo].[Market] SET [Name]='CLMASC', [ProfileID]='04100' WHERE [MarketID]=7
UPDATE [dbo].[Market] SET [Name]='BCVLOH', [ProfileID]='01700' WHERE [MarketID]=8
UPDATE [dbo].[Market] SET [Name]='DCTRIL', [ProfileID]='05000' WHERE [MarketID]=9
UPDATE [dbo].[Market] SET [Name]='CLMBOH', [ProfileID]='02000' WHERE [MarketID]=10
UPDATE [dbo].[Market] SET [Name]='CHRLNC', [ProfileID]='02400' WHERE [MarketID]=11
UPDATE [dbo].[Market] SET [Name]='RCSNTX', [ProfileID]='00200' WHERE [MarketID]=12
UPDATE [dbo].[Market] SET [Name]='CNTMOH', [ProfileID]='03300' WHERE [MarketID]=13
UPDATE [dbo].[Market] SET [Name]='LIVNMI', [ProfileID]='00500' WHERE [MarketID]=14
UPDATE [dbo].[Market] SET [Name]='FRS2CA', [ProfileID]='03000' WHERE [MarketID]=15
UPDATE [dbo].[Market] SET [Name]='FYVLAR', [ProfileID]='04400' WHERE [MarketID]=16
UPDATE [dbo].[Market] SET [Name]='OSHKWI', [ProfileID]='02700' WHERE [MarketID]=17
UPDATE [dbo].[Market] SET [Name]='GDRPMI', [ProfileID]='01900' WHERE [MarketID]=18
UPDATE [dbo].[Market] SET [Name]='GNVLSC', [ProfileID]='03100' WHERE [MarketID]=19
UPDATE [dbo].[Market] SET [Name]='WLFRCT', [ProfileID]='01300' WHERE [MarketID]=20
UPDATE [dbo].[Market] SET [Name]='HSTNTX', [ProfileID]='00300' WHERE [MarketID]=21
UPDATE [dbo].[Market] SET [Name]='IPLSIN', [ProfileID]='00800' WHERE [MarketID]=22
UPDATE [dbo].[Market] SET [Name]='JCSNMS', [ProfileID]='04000' WHERE [MarketID]=23
UPDATE [dbo].[Market] SET [Name]='JCVLFL', [ProfileID]='02200' WHERE [MarketID]=24
UPDATE [dbo].[Market] SET [Name]='MSSNKV', [ProfileID]='02500' WHERE [MarketID]=25
UPDATE [dbo].[Market] SET [Name]='IRV2CA', [ProfileID]='00400' WHERE [MarketID]=26
UPDATE [dbo].[Market] SET [Name]='LNNGMI', [ProfileID]='04600' WHERE [MarketID]=27
UPDATE [dbo].[Market] SET [Name]='LTRKAR', [ProfileID]='02800' WHERE [MarketID]=28
UPDATE [dbo].[Market] SET [Name]='LSVLKY', [ProfileID]='03800' WHERE [MarketID]=29
UPDATE [dbo].[Market] SET [Name]='MDS2WI', [ProfileID]='04200' WHERE [MarketID]=30
UPDATE [dbo].[Market] SET [Name]='MMPHTN', [ProfileID]='03200' WHERE [MarketID]=31
UPDATE [dbo].[Market] SET [Name]='MIAMFL', [ProfileID]='01100' WHERE [MarketID]=32
UPDATE [dbo].[Market] SET [Name]='MIL2WI', [ProfileID]='01600' WHERE [MarketID]=33
UPDATE [dbo].[Market] SET [Name]='MOBLAL', [ProfileID]='03500' WHERE [MarketID]=34
UPDATE [dbo].[Market] SET [Name]='MTRYCA', [ProfileID]='04500' WHERE [MarketID]=35
UPDATE [dbo].[Market] SET [Name]='NWORLA', [ProfileID]='02600' WHERE [MarketID]=36
UPDATE [dbo].[Market] SET [Name]='NSVLTN', [ProfileID]='02300' WHERE [MarketID]=37
UPDATE [dbo].[Market] SET [Name]='OKCYOK', [ProfileID]='03700' WHERE [MarketID]=38
UPDATE [dbo].[Market] SET [Name]='DYBHFL', [ProfileID]='01800' WHERE [MarketID]=39
UPDATE [dbo].[Market] SET [Name]='RENONV', [ProfileID]='04900' WHERE [MarketID]=40
UPDATE [dbo].[Market] SET [Name]='RLGHNC', [ProfileID]='03600' WHERE [MarketID]=41
UPDATE [dbo].[Market] SET [Name]='FROKCA', [ProfileID]='00900' WHERE [MarketID]=42
UPDATE [dbo].[Market] SET [Name]='SGN2MI', [ProfileID]='03400' WHERE [MarketID]=43
UPDATE [dbo].[Market] SET [Name]='SNANTX', [ProfileID]='01500' WHERE [MarketID]=44
UPDATE [dbo].[Market] SET [Name]='SND3CA', [ProfileID]='01000' WHERE [MarketID]=45
UPDATE [dbo].[Market] SET [Name]='SNTCCA', [ProfileID]='00600' WHERE [MarketID]=46
UPDATE [dbo].[Market] SET [Name]='STL2MO', [ProfileID]='01200' WHERE [MarketID]=47
UPDATE [dbo].[Market] SET [Name]='TOLDOH', [ProfileID]='04700' WHERE [MarketID]=48
UPDATE [dbo].[Market] SET [Name]='WCH2KS', [ProfileID]='04300' WHERE [MarketID]=49
UPDATE [dbo].[Market] SET [Name]='WEPBFL', [ProfileID]='02100' WHERE [MarketID]=50
PRINT(N'Operation applied to 50 rows out of 50')
GO

PRINT(N'Add constraint FK_ZONE_MAP_MarketID_-->_Market_MarketID to [dbo].[ZONE_MAP]')
GO
ALTER TABLE [dbo].[ZONE_MAP] WITH NOCHECK ADD CONSTRAINT [FK_ZONE_MAP_MarketID_-->_Market_MarketID] FOREIGN KEY ([MarketID]) REFERENCES [dbo].[Market] ([MarketID])
COMMIT TRANSACTION
GO
