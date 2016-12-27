
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.CreateSDBMPEGDB'), 0) > 0 
	DROP PROCEDURE dbo.CreateSDBMPEGDB
GO


CREATE PROCEDURE [dbo].[CreateSDBMPEGDB]
		@ReplicationClusterID		INT,
		@SDBSystemID				INT,
		@SDBMPEGDBName				NVARCHAR(100),
		@ERROR						INT OUTPUT
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
// Module:  dbo.CreateSDBMPEGDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates an SDB's MPEG DB.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateSDBMPEGDB.proc.sql 3246 2013-12-09 19:42:44Z tlew $
//    
//	 Usage:
//
//				DECLARE	@Err INT
//				EXEC	DINGOSDB.dbo.CreateSDBMPEGDB	
//								@ReplicationClusterID					= 1,
//								@SDBSystemID							= 1,
//								@SDBMPEGDBName							= N'',
//								@ERROR									= @Err OUTPUT
//				SELECT	@Err
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@cmd									NVARCHAR(500)
				DECLARE			@LastStepName							VARCHAR(50)
				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@Err									INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@Msg									VARCHAR(200)

				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGDB First Step'

				IF				( @EventLogStatusID IS NOT NULL )
								EXEC	dbo.LogEvent 
													@LogID				= NULL,
													@EventLogStatusID	= @EventLogStatusID,			----Started Step
													@JobID				= NULL,
													@JobName			= N'Check SDB Replication',
													@DBID				= @ReplicationClusterID,
													@DBComputerName		= @@SERVERNAME,
													@LogIDOUT			= @LogIDReturn OUTPUT


				SELECT			@LastStepName							= 'Check ' + @SDBMPEGDBName + ' database existence: '
				IF				NOT EXISTS(SELECT TOP 1 1 FROM sys.databases WHERE name = ISNULL(@SDBMPEGDBName, name))
				BEGIN

								SELECT			@LastStepName = 'Create ' + @SDBMPEGDBName + ' database: '
								SET				@cmd =	N'CREATE DATABASE [' + CAST(@SDBMPEGDBName AS NVARCHAR(100)) + '] ' +
														N'CONTAINMENT = NONE ' +
														N'ON  PRIMARY ' +
														N'( NAME = N''' + @SDBMPEGDBName + '_data'', FILENAME = N''D:\Data\' + @SDBMPEGDBName + '_data.mdf'' , SIZE = 1GB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%) ' +
														N'LOG ON ' +
														N'( NAME = N''' + @SDBMPEGDBName + '_log'', FILENAME = N''D:\Logs\' + @SDBMPEGDBName + '_log.ldf'' , SIZE = 500MB , MAXSIZE = 2048GB , FILEGROWTH = 10%); ' +
														--N'GO ' +

														N'ALTER DATABASE ' + @SDBMPEGDBName + ' ' +
														N'SET READ_COMMITTED_SNAPSHOT ON; ' +
														--N'GO ' +

														N'ALTER DATABASE ' + @SDBMPEGDBName + ' ' +
														N'SET ALLOW_SNAPSHOT_ISOLATION ON; ' +
														--N'GO '

														N'EXEC ' + @SDBMPEGDBName + '.sys.sp_cdc_enable_db '
														--N'GO '

								EXEC			( @cmd )
								SELECT			@ERROR					= @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()
				END
				ELSE			SELECT			@ERROR			= 0

				IF				EXISTS(SELECT TOP 1 1 FROM sys.databases WHERE name = @SDBMPEGDBName)
								EXEC	DINGOSDB.dbo.CreateSDBMPEGObjects	
												@ReplicationClusterID					= @ReplicationClusterID,
												@SDBSystemID							= @SDBSystemID,
												@SDBMPEGDBName							= @SDBMPEGDBName,
												@ERROR									= @Err OUTPUT



				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGDB Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGDB Fail Step'
				
				SET				@Msg			= 'Last Step -- > ' + @LastStepName + ISNULL(@ErrMsg, '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg
				

END

GO

/*


USE [master]
GO

CREATE DATABASE [mpegn]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'mpeg_data', FILENAME = N'D:\SQLData\mpeg1_data.mdf' , SIZE = 3903744KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'mpeg_log', FILENAME = N'D:\SQLLog\mpeg1_log.ldf' , SIZE = 307200KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [mpegn] SET COMPATIBILITY_LEVEL = 100
GO


*/