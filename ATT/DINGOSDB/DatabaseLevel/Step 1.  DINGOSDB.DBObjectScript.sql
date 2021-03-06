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
// Module:  DINGOSDB database creation script.
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Database creation and objects.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 

USE [master]
GO

EXEC sp_serveroption @server=N'DINGODB_HOST', @optname=N'data access', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'DINGODB_HOST', @optname=N'rpc', @optvalue=N'true'				
GO

EXEC sp_serveroption @server=N'DINGODB_HOST', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'DINGODB_HOST', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'DINGODB_HOST', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  Database [DINGOSDB]    Script Date: 11/1/2013 9:34:11 PM ******/
ALTER DATABASE [DINGOSDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
ALTER DATABASE [DINGOSDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DINGOSDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DINGOSDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DINGOSDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DINGOSDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DINGOSDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DINGOSDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DINGOSDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DINGOSDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DINGOSDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DINGOSDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DINGOSDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DINGOSDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DINGOSDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DINGOSDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DINGOSDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DINGOSDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DINGOSDB] SET DISABLE_BROKER 
GO
ALTER DATABASE [DINGOSDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DINGOSDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DINGOSDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DINGOSDB] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE [DINGOSDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DINGOSDB] SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE [DINGOSDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DINGOSDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DINGOSDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DINGOSDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DINGOSDB] SET FILESTREAM ( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DINGOSDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DINGOSDB', N'ON'
GO
ALTER DATABASE [DINGOSDB] SET READ_WRITE 
GO
ALTER DATABASE [DINGOSDB] SET MULTI_USER 
GO
USE [DINGOSDB]
GO

/****** Object:  UserDefinedTableType [dbo].[INTTable]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[INTTable] AS TABLE(
	[ID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UDT_Int]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[UDT_Int] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UDT_VarChar50]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[UDT_VarChar50] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](50) NULL
)
GO





/****** Object:  Table [dbo].[DBInfo]    Script Date: 11/8/2013 12:19:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DBInfo](
	[DBInfoID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DBInfo] PRIMARY KEY CLUSTERED 
(
	[DBInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[DBInfo] ADD  CONSTRAINT [DF_DBInfo_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[DBInfo] ADD  CONSTRAINT [DF_DBInfo_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB DBInfo identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'DBInfoID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual DBInfo Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual DBInfo Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


--Change	DBInfo
Insert		dbo.DBInfo ( Name, Description )
Select		'Version' AS Name, '2.0.0.4598' AS Description
GO


USE [DINGOSDB]
GO

/****** Object:  StoredProcedure [dbo].[AddNewDINGODBNode]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.AddNewDINGODBNode
		@DINGODBAlias				NVARCHAR(50) = N'DINGODB_HOST',
		@DINGODBComputerName		NVARCHAR(50)
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
// Module:  dbo.AddNewDINGODBNode
// Created: 2014-Aug-01
// Author:  Tony Lew
// 
// Purpose: Adds a new DINGODB node.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.AddNewDINGODBNode.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	dbo.AddNewDINGODBNode	
//								@DINGODBAlias				= N'DINGODB_HOST',
//								@DINGODBComputerName		= N'MSSNKNLMDB001P'
//
*/ 
-- =============================================
BEGIN


			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SET NOCOUNT ON;

			IF			NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @DINGODBAlias) 
			BEGIN

						EXEC		sp_addlinkedserver  
											@server					= @DINGODBAlias,  
											@provider				= N'SQLNCLI', -- sql native client.
											@srvproduct				= N'MSDASQL',
											@dataSrc				= @DINGODBComputerName 

						EXEC		sp_serveroption					@server=@DINGODBAlias, @optname=N'data access', @optvalue=N'true'

						EXEC		sp_serveroption 				@server=@DINGODBAlias, @optname=N'rpc', @optvalue=N'true'

						EXEC		sp_serveroption 				@server=@DINGODBAlias, @optname=N'rpc out', @optvalue=N'true'

						EXEC		sp_serveroption 				@server=@DINGODBAlias, @optname=N'use remote collation', @optvalue=N'true'

						EXEC		sp_serveroption 				@server=@DINGODBAlias, @optname=N'remote proc transaction promotion', @optvalue=N'true'

			END


END


GO



USE [DINGOSDB]
GO

/****** Object:  StoredProcedure [dbo].[CheckSDBReplication]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckSDBReplication]
		@LoginName					NVARCHAR(100) = NULL,
		@LoginPWD					NVARCHAR(100) = NULL
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
// Module:  dbo.CheckSDBReplication
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Checks for the existence and state of replication components on the existing and enabled replication cluster.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CheckSDBReplication.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGOSDB.dbo.CheckSDBReplication	
//							@LoginName						= NULL,
//							@LoginPWD						= NULL
//
*/ 
-- =============================================
BEGIN


				--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET				NOCOUNT ON;

				DECLARE			@TotalERRNum								INT
				DECLARE			@ERRNum										INT
				DECLARE			@TotalRows									INT
				DECLARE			@i 											INT = 1
				DECLARE			@SQLCMD										NVARCHAR(500)
				DECLARE			@SQLCMDStartJob								NVARCHAR(500)
				DECLARE			@SQLCMDCurrentStartJob						NVARCHAR(500)
				DECLARE			@ReplicationClusterID						INT
				DECLARE			@ReplicationClusterName						VARCHAR(50)
				DECLARE			@ReplicationClusterNameFQ					VARCHAR(100)
				DECLARE			@ReplicationClusterVIP						VARCHAR(50)
				DECLARE			@ModuloValue								INT
				DECLARE			@LatestSDBSystemID							INT
				DECLARE			@TotalSDBSystems							INT
				DECLARE			@CurrentSDBSystemID							INT
				DECLARE			@CurrentSDBSourceSystemID					INT
				DECLARE			@CurrentSDBSourceSystemName					VARCHAR(50)
				DECLARE			@CurrentSDBState							INT
				DECLARE			@CurrentRole								INT
				DECLARE			@CurrentMPEGDBName							VARCHAR(50)
				DECLARE			@CurrentJobID								UNIQUEIDENTIFIER
				DECLARE			@CurrentJobName								VARCHAR(500)
				DECLARE			@CurrentJobType								INT
				DECLARE			@CurrentReplicationJobTypeID				INT
				DECLARE			@CurrentReason								VARCHAR(50)
				DECLARE			@PullReplicationJobTypeID					INT
				DECLARE			@LogReaderReplicationJobTypeID				INT 
				DECLARE			@PublicationReplicationJobTypeID			INT
				DECLARE			@PushReplicationJobTypeID					INT
				DECLARE			@LogIDReturn								INT
				DECLARE			@JobID										UNIQUEIDENTIFIER
				DECLARE			@ErrMsg										VARCHAR(200)
				DECLARE			@EventLogStatusID							INT
				DECLARE			@LastStepName								VARCHAR(50)

				SELECT			@SQLCMDStartJob								= 'EXEC	[TOKEN].msdb.dbo.sp_start_job  @job_name = N''@JobName'' '

				SELECT			@LogReaderReplicationJobTypeID				= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description									= 'Log Reader Agent'

				SELECT			@PublicationReplicationJobTypeID			= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description									= 'Publication Agent'

				SELECT			@PullReplicationJobTypeID					= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description									= 'Pull Distribution Agent'

				SELECT			@PushReplicationJobTypeID					= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description									= 'Push Distribution Agent'


				IF				( (@LogReaderReplicationJobTypeID + @PublicationReplicationJobTypeID + @PullReplicationJobTypeID + @PushReplicationJobTypeID) IS NULL ) RETURN

				IF OBJECT_ID('tempdb..#UnpreparedSDBSystems') IS NOT NULL
					DROP TABLE #UnpreparedSDBSystems
				CREATE TABLE #UnpreparedSDBSystems	(
															id int identity(1,1),
															SDBSystemID int,
															SDBSourceSystemID int,
															SDBSourceSystemName varchar(50),
															SDBState int,
															JobID uniqueidentifier, 
															JobName varchar(200),
															JobType int,
															Role int,
															MPEGDBName varchar(50),
															Reason varchar(50)
													)



				SELECT			TOP 1 
								@ReplicationClusterID																= a.ReplicationClusterID,
								@ReplicationClusterName																= a.Name,
								@ReplicationClusterNameFQ															= a.NameFQ,
								@ReplicationClusterVIP																= a.VIP
				FROM			[DINGODB_HOST].DINGODB.dbo.ReplicationCluster a WITH (NOLOCK)
				WHERE			a.Name																				= @@SERVERNAME
				AND				a.Enabled																			= 1
				AND				a.ReplicationClusterID																> 0

				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CheckSDBReplication First Step'

				IF				( @EventLogStatusID IS NOT NULL )
								EXEC	dbo.LogEvent 
													@LogID				= NULL,
													@EventLogStatusID	= @EventLogStatusID,			----Started Step
													@JobID				= NULL,
													@JobName			= N'Check SDB Replication',
													@DBID				= @ReplicationClusterID,
													@DBComputerName		= @ReplicationClusterName,
													@LogIDOUT			= @LogIDReturn OUTPUT

				IF				( @ReplicationClusterID IS NULL )
								SELECT				@ERRNum															= 1, 
													@ErrMsg															= 'Replication Cluster Node ' + @ReplicationClusterVIP + ' Nonexistent OR Disabled.'
				ELSE
				BEGIN


								--				This SP populates the dbo.SDBSystem table with the latest value of SDBState.  Also insert new SDB nodes.
								EXEC			dbo.GetSDBInfo						@ReplicationClusterID			= @ReplicationClusterID

								--				Update the dbo.SDBSystem table with information about each replication partner's MPEG db.
								EXEC			dbo.GetReplicationClusterMPEGInfo	@ReplicationClusterID			= @ReplicationClusterID

								--				Call child SP to populate the parent temp table with the SDBs that need to be changed to be in proper state
								EXEC			dbo.GetUnpreparedSDBNodes

								--				Get the total number of unprepared SDB nodes.
								SELECT			TOP 1 @TotalSDBSystems												= a.id
								FROM			#UnpreparedSDBSystems a
								ORDER BY		a.id DESC


				END

				IF				( ISNULL(@TotalSDBSystems, 0) > 0 AND ISNULL(@ReplicationClusterID, 0) > 0 )
				BEGIN

								--				For each new node, create the associated job.
								WHILE			( @i <= @TotalSDBSystems )
								BEGIN

												SELECT			TOP 1	
																@CurrentSDBSystemID									= a.SDBSystemID,
																@CurrentSDBSourceSystemID							= a.SDBSourceSystemID, 
																@CurrentSDBSourceSystemName							= a.SDBSourceSystemName,
																@CurrentSDBState									= a.SDBState,
																@CurrentJobID										= a.JobID,
																@CurrentJobName										= a.JobName,
																@CurrentJobType										= a.JobType,
																@CurrentRole										= a.Role,
																@CurrentMPEGDBName									= a.MPEGDBName,
																@CurrentReason										= a.Reason
												FROM			#UnpreparedSDBSystems a 
												WHERE			a.ID												= @i

												--				Get ready for next node.
												SET				@i													= @i + 1

												IF				( @CurrentReason = 'Create MPEG DB' )
												BEGIN
																EXEC		dbo.CreateSDBMPEGDB		
																						@ReplicationClusterID		= @ReplicationClusterID,
																						@SDBSystemID				= @CurrentSDBSystemID, 
																						@SDBMPEGDBName				= @CurrentMPEGDBName,
																						@ERROR						= @ERRNum OUTPUT
																SELECT		@ERRNum									= ERROR_NUMBER(), 
																			@ErrMsg									= ERROR_MESSAGE()

																UPDATE		dbo.SDBSystem
																SET			DBExistence								= 1,
																			IEExistence								= 0
																WHERE		SDBSystemID								= @CurrentSDBSystemID

												END
												ELSE IF			( @CurrentReason = 'Clean MPEG DB' )
												BEGIN
																EXEC		dbo.DropSDBMPEGDB		
																						@ReplicationClusterID		= @ReplicationClusterID,
																						@SDBSystemID				= @CurrentSDBSystemID, 
																						@SDBMPEGDBName				= @CurrentMPEGDBName,
																						@ERROR						= @ERRNum OUTPUT
																SELECT		@ERRNum									= ERROR_NUMBER(), 
																			@ErrMsg									= ERROR_MESSAGE()

																UPDATE		dbo.SDBSystem
																SET			DBExistence								= 0,
																			IEExistence								= 0
																WHERE		SDBSystemID								= @CurrentSDBSystemID

																EXEC		dbo.CreateSDBMPEGDB		
																				@ReplicationClusterID				= @ReplicationClusterID,
																				@SDBSystemID						= @CurrentSDBSystemID, 
																				@SDBMPEGDBName						= @CurrentMPEGDBName,
																				@ERROR								= @ERRNum OUTPUT
																SELECT		@ERRNum									= ERROR_NUMBER(), 
																			@ErrMsg									= ERROR_MESSAGE()

																--			Mark the MPEG DB as available for use
																UPDATE		dbo.SDBSystem
																SET			DBExistence								= 1,
																			IEExistence								= 0
																WHERE		SDBSystemID								= @CurrentSDBSystemID

												END
												ELSE IF			( @CurrentReason = 'Deactivate SDB' )
												BEGIN

																IF			( @CurrentRole = 2 )
																BEGIN

																			SELECT		@CurrentJobName				= a.JobName 
																			FROM		dbo.ReplicationJob a (NOLOCK)
																			JOIN		dbo.ReplicationJobType b (NOLOCK)
																			ON			a.ReplicationJobTypeID		= b.ReplicationJobTypeID
																			WHERE		a.SDBSystemID				= @CurrentSDBSystemID
																			AND			a.ReplicationJobTypeID		= @PullReplicationJobTypeID

																			IF			(@CurrentJobName IS NOT NULL)
																			EXEC		msdb.dbo.sp_delete_job		
																								@job_name			= @CurrentJobName

																END

																--			Delete the name of the replication components
																DELETE		dbo.ReplicationJob 
																WHERE		SDBSystemID								= @CurrentSDBSystemID

																--			Mark the standby MPEG DB as available (standby)
																--			thereby cleaning the MPEG DB of the standby system
																UPDATE		dbo.SDBSystem
																SET			IEExistence								= 1,
																			Subscribed								= 0
																WHERE		SDBSystemID								= @CurrentSDBSystemID
																AND			NOT EXISTS 
																					(
																						SELECT TOP 1 1 
																						FROM	dbo.ReplicationJob b (NOLOCK)
																						WHERE	SDBSystemID			= @CurrentSDBSystemID
																					)

												END
												ELSE IF			( @CurrentReason = 'Activate SDB' )
												BEGIN

																----			Placeholder
																SELECT			@CurrentReason						= 'Activate SDB'

												END
												ELSE IF			( @CurrentReason = 'Create SDB Replication Components' )
												BEGIN

																EXEC			dbo.CreateSDBLinkedServer	
																						@ReplicationClusterID		= @ReplicationClusterID,
																						@SDBSystemName				= @CurrentSDBSourceSystemName, 
																						@LoginName					= @LoginName,
																						@LoginPWD					= @LoginPWD,
																						@ERROR						= @ERRNum OUTPUT
																SELECT			@TotalERRNum						= @ERRNum,
																				@ErrMsg								= ERROR_MESSAGE()

																EXEC			dbo.CreateSDBMPEGDB	
																						@ReplicationClusterID		= @ReplicationClusterID,
																						@SDBSystemID				= @CurrentSDBSystemID, 
																						@SDBMPEGDBName				= @CurrentMPEGDBName,
																						@ERROR						= @ERRNum OUTPUT
																SELECT			@TotalERRNum						= @TotalERRNum + @ERRNum,
																				@ErrMsg								= ERROR_MESSAGE()


																--				Make sure the subscription db exists before any replication is setup
																IF				( @TotalERRNum = 0 )
																				IF				( @CurrentRole = 1 )	--Primary
																				--				One assumption here is that the publication already exists.
																				--				We are just creating the push subscription to DINGOSDB system
																				--				Also, the publication name is the same for all new nodes: namely "Spot+mpegPublication"
																				BEGIN

																								EXEC dbo.CreateSDBPushSubscription
																										@ReplicationClusterID		= @ReplicationClusterID,
																										@SDBSystemID				= @CurrentSDBSystemID,
																										@SDBName					= @CurrentSDBSourceSystemName, 
																										@publication				= N'Spot+mpegPublication',
																										@subscriber					= @ReplicationClusterNameFQ,
																										@subscriptionDB				= @CurrentMPEGDBName,
																										@JobOwnerLoginName			= @LoginName,
																										@JobOwnerLoginPWD			= @LoginPWD,
																										@ERROR						= @ERRNum OUTPUT
																								SELECT	@ErrMsg						= ERROR_MESSAGE()

																				END
																				ELSE --IF			( @CurrentRole = 2 )	--Backup
																				BEGIN
												
																								EXEC dbo.CreateSDBPublication
																										@ReplicationClusterID		= @ReplicationClusterID,
																										@SDBSystemID				= @CurrentSDBSystemID,
																										@SDBName					= @CurrentSDBSourceSystemName, 
																										@publication				= N'Spot+mpegPublication Backup',
																										@ERROR						= @ERRNum OUTPUT
																								SELECT	@ErrMsg						= ERROR_MESSAGE()

																								EXEC dbo.CreateSDBPullSubscription
																										@ReplicationClusterID		= @ReplicationClusterID,
																										@SDBSystemID				= @CurrentSDBSystemID,
																										@SDBName					= @CurrentSDBSourceSystemName, 
																										@publication				= N'Spot+mpegPublication Backup',
																										@subscriber					= @ReplicationClusterNameFQ,
																										@subscriptionDB				= @CurrentMPEGDBName,
																										@JobOwnerLoginName			= @LoginName,
																										@JobOwnerLoginPWD			= @LoginPWD,
																										@ERROR						= @ERRNum OUTPUT
																								SELECT	@ErrMsg						= ERROR_MESSAGE()

																				END

												END			
												ELSE IF			( @CurrentReason = 'Start Replication Job Components' )
												BEGIN
																SELECT			@LastStepName										= 'Start Job for SDB System: ' + @CurrentSDBSourceSystemName

																-- This Try-Catch is simply to resume after errors.
																--BEGIN TRY

																				IF		( @CurrentJobType IN ( @PushReplicationJobTypeID, @LogReaderReplicationJobTypeID ) )	--Remote
																				BEGIN

																						SELECT			@SQLCMDCurrentStartJob		= REPLACE(@SQLCMDStartJob, 'TOKEN', @CurrentSDBSourceSystemName ) 
																						SELECT			@SQLCMDCurrentStartJob		= REPLACE(@SQLCMDCurrentStartJob, '@JobName', @CurrentJobName )
																						SELECT			@LastStepName				= 'Start Job for SDB System: ' + @CurrentSDBSourceSystemName
																						EXECUTE			sp_executesql				@SQLCMDCurrentStartJob

																				END
																				ELSE IF	( @CurrentJobType IN ( @PullReplicationJobTypeID ) )									--Local
																				BEGIN

																						IF				(@CurrentJobName IS NOT NULL)
																						EXEC			msdb.dbo.sp_start_job  @job_name = @CurrentJobName

																				END

																--END TRY
																--BEGIN CATCH
																				
																--				SELECT			@LastStepName						= 'Start Job failed for SDB System: ' + @CurrentSDBSourceSystemName

																--END CATCH



												END


								END



				END

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CheckSDBReplication Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CheckSDBReplication Fail Step'

				IF				( @EventLogStatusID IS NOT NULL )
				BEGIN
								SELECT			@ErrMsg		= ISNULL(@ErrMsg, @LastStepName)
								EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
				END

				DROP TABLE #UnpreparedSDBSystems



END




GO

/****** Object:  StoredProcedure [dbo].[CreateSDBLinkedServer]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CreateSDBLinkedServer]
		@ReplicationClusterID		INT,
		@SDBSystemName				NVARCHAR(100),
		@LoginName					NVARCHAR(100) = NULL,
		@LoginPWD					NVARCHAR(100) = NULL,
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
// Module:  dbo.CreateSDBLinkedServer
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Linked Server for each physical SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateSDBLinkedServer.proc.sql 3246 2013-12-09 19:42:44Z tlew $
//    
//	 Usage:
//
//				DECLARE	@Err INT
//				EXEC	DINGOSDB.dbo.CreateSDBLinkedServer	
//								@ReplicationClusterID		= 1,
//								@SDBSystemName				= N'',
//								@LoginName					= N'nbrownett@mcc2-lailab',
//								@LoginPWD					= '',
//								@ERROR						= @Err OUTPUT
//				SELECT	@Err
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@datasource								NVARCHAR(100) = @SDBSystemName --+ N'\MSSQLSERVER'
				DECLARE			@LastStepName							VARCHAR(50)
				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@Msg									VARCHAR(200)


				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBLinkedServer First Step'

				IF				( @EventLogStatusID IS NOT NULL )
								EXEC	dbo.LogEvent 
													@LogID				= NULL,
													@EventLogStatusID	= @EventLogStatusID,			----Started Step
													@JobID				= NULL,
													@JobName			= N'Check SDB Replication',
													@DBID				= @ReplicationClusterID,
													@DBComputerName		= @@SERVERNAME,
													@LogIDOUT			= @LogIDReturn OUTPUT

				SELECT			@LastStepName							= 'Check ' + @SDBSystemName + ' linked server existence: '

				IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @SDBSystemName)
				BEGIN

								SELECT		@LastStepName				= 'Create ' + @SDBSystemName + ' linked server: '
								EXEC		sp_addlinkedserver			
													@server				= @SDBSystemName, 
													@srvproduct			= N'', 
													@provider			= N'SQLNCLI', 
													@datasrc			= @datasource,
													@catalog			= N'mpeg'
								SELECT		@ERROR						= @@ERROR,
											@ERRNum						= @@ERROR

								SELECT		@LastStepName				= 'Create ' + @SDBSystemName + ' linked server login: '
								EXEC		sp_addlinkedsrvlogin 
													@rmtsrvname			= @SDBSystemName, 
													@locallogin			= N'sa', 
													@useself			= N'False', 
													@rmtuser			= @LoginName, 
													@rmtpassword		= @LoginPWD
								SELECT		@ERROR						= @ERROR + @@ERROR,
											@ERRNum						= @ERRNum + @@ERROR

								SELECT		@LastStepName				= 'Set ' + @SDBSystemName + ' linked server rpc to true: '
								EXEC		sp_serveroption 
													@server				= @SDBSystemName, 
													@optname			= N'rpc', 
													@optvalue			= N'true'
								SELECT		@ERROR						= @ERROR + @@ERROR,
											@ERRNum						= @ERRNum + @@ERROR

								SELECT		@LastStepName				= 'Create ' + @SDBSystemName + ' linked server rpc out to true: '
								EXEC		sp_serveroption	
													@server				= @SDBSystemName, 
													@optname			= N'rpc out', 
													@optvalue			= N'true'
								SELECT		@ERROR						= @ERROR + @@ERROR,
											@ERRNum						= @ERRNum + @@ERROR

								SELECT		@LastStepName				= 'Create ' + @SDBSystemName + ' linked server data access to true: '
								EXEC		sp_serveroption	
													@server				= @SDBSystemName, 
													@optname			= N'DATA ACCESS', 
													@optvalue			= N'true'
								SELECT		@ERROR						= @ERROR + @@ERROR,
											@ERRNum						= @ERRNum + @@ERROR

				END
				ELSE
								SELECT		@ERROR						= 0

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBLinkedServer Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBLinkedServer Fail Step'
				
				SET				@Msg			= 'Last Step -- > ' + @LastStepName + ISNULL(@ErrMsg, '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg

END

GO

/****** Object:  StoredProcedure [dbo].[CreateSDBMPEGDB]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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

/****** Object:  StoredProcedure [dbo].[CreateSDBMPEGObjects]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CreateSDBMPEGObjects]
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
// Module:  dbo.CreateSDBMPEGObjects
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates an SDB's MPEG DB objects.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateSDBMPEGObjects.proc.sql 3246 2013-12-09 19:42:44Z tlew $
//    
//	 Usage:
//
//				DECLARE	@Err INT
//				EXEC	DINGOSDB.dbo.CreateSDBMPEGObjects	
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

				DECLARE			@CMDImportBreakCountHistory				NVARCHAR(500)
				DECLARE			@CMDImportTrafficAndBillingData			NVARCHAR(500)
				DECLARE			@CMDImportChannelAndConflictStats		NVARCHAR(500)
				DECLARE			@CMDImportBreakCountHistorySP			NVARCHAR(2000)
				DECLARE			@CMDImportTrafficAndBillingDataSP		NVARCHAR(2000)
				DECLARE			@CMDImportChannelAndConflictStatsSP		NVARCHAR(2000)
				DECLARE			@LastStepName							VARCHAR(50)
				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@Msg									VARCHAR(200)
				DECLARE			@UseStatement							NVARCHAR(100)
				DECLARE			@ExecStatment							NVARCHAR(500)
				DECLARE			@ParamStatement							NVARCHAR(100)

				DECLARE			@ResultsMPEGArticle						UDT_Int
				DECLARE			@CMDPreSP								NVARCHAR(2000) 
				DECLARE			@CMDSP									NVARCHAR(MAX) 
				DECLARE			@TotalSP								INT
				DECLARE			@i										INT = 1
				DECLARE			@CurrentSPName							NVARCHAR(200) 

				SELECT			@UseStatement							=	N'Use ' + @SDBMPEGDBName + CHAR(13)+CHAR(10) + '; ' 
				SELECT			@ExecStatment							=	N'EXEC '+ @SDBMPEGDBName +'.dbo.SP_EXECUTESQL @SQLString '
				SELECT			@ParamStatement							=	N'@SQLString nvarchar(MAX)'

				--				This portion "can" be replaced by the general SSRS SP creation statements
				--				However, for the purpose of distinction, the statements are separated (ETL vs SSRS)
				SELECT			@CMDImportBreakCountHistory				=	@UseStatement + 'IF ( ISNULL(OBJECT_ID('''+ @SDBMPEGDBName +'.dbo.ImportBreakCountHistory''), 0) > 0 ) DROP PROCEDURE dbo.ImportBreakCountHistory; ' + @ExecStatment
				SELECT			@CMDImportBreakCountHistorySP			=	CMD FROM dbo.MPEGArticle (NOLOCK) WHERE CMDType = 'SP' and Name = 'ImportBreakCountHistory'
				SELECT			@CMDImportChannelAndConflictStats		=	@UseStatement + 'IF ( ISNULL(OBJECT_ID('''+ @SDBMPEGDBName +'.dbo.ImportChannelAndConflictStats''), 0) > 0 ) DROP PROCEDURE dbo.ImportChannelAndConflictStats; ' + @ExecStatment
				SELECT			@CMDImportChannelAndConflictStatsSP		=	CMD  FROM dbo.MPEGArticle (NOLOCK) WHERE CMDType = 'SP' and Name = 'ImportChannelAndConflictStats'
				SELECT			@CMDImportTrafficAndBillingData			=	@UseStatement + 'IF ( ISNULL(OBJECT_ID('''+ @SDBMPEGDBName +'.dbo.ImportTrafficAndBillingData''), 0) > 0 ) DROP PROCEDURE dbo.ImportTrafficAndBillingData; ' + @ExecStatment
				SELECT			@CMDImportTrafficAndBillingDataSP		=	CMD  FROM dbo.MPEGArticle (NOLOCK) WHERE CMDType = 'SP' and Name = 'ImportTrafficAndBillingData'

				
				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGObjects First Step'

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
				IF				EXISTS(SELECT TOP 1 1 FROM sys.databases WHERE name = ISNULL(@SDBMPEGDBName, name))
				BEGIN

								--				ETL SPs
								SELECT			@LastStepName = 'Create ImportBreakCountHistory SP: '
								--EXEC			( @CMDImportBreakCountHistory )
								EXEC			sp_executesql  @CMDImportBreakCountHistory, @ParamStatement, @SQLString=@CMDImportBreakCountHistorySP
								SELECT			@ERROR					= @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()

								SELECT			@LastStepName = 'Create ImportChannelAndConflict SP: '
								--EXEC			( @CMDImportChannelAndConflictStats )
								EXEC			sp_executesql  @CMDImportChannelAndConflictStats, @ParamStatement, @SQLString=@CMDImportChannelAndConflictStatsSP
								SELECT			@ERROR					= @ERROR + @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()

								SELECT			@LastStepName = 'Create ImportTrafficAndBillingData SP: '
								--EXEC			( @CMDImportTrafficAndBillingData )
								EXEC			sp_executesql  @CMDImportTrafficAndBillingData, @ParamStatement, @SQLString=@CMDImportTrafficAndBillingDataSP
								SELECT			@ERROR					= @ERROR + @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()
								IF				(ISNULL(@ERROR, 0) = 0)	SELECT @ERROR = 0


								--				SSRS SPs
								INSERT			@ResultsMPEGArticle (Value)
								SELECT			a.MPEGArticleID 
								FROM			DINGOSDB.dbo.MPEGArticle a
								WHERE			a.CMDType				= 'SP'
								AND				a.Name					NOT IN ('sp_MSupd_IE','sp_MSupd_SPOT','ImportBreakCountHistory','ImportChannelAndConflictStats','ImportTrafficAndBillingData')

								SELECT			TOP 1 @TotalSP			= a.ID
								FROM			@ResultsMPEGArticle a
								ORDER BY		a.ID DESC

								WHILE			( @i <= @TotalSP )
								BEGIN

												SELECT	TOP 1 
														@CurrentSPName	=	a.Name,
														@CMDSP			=	a.CMD 
												FROM	DINGOSDB.dbo.MPEGArticle a (NOLOCK)
												JOIN	@ResultsMPEGArticle b
												ON		a.MPEGArticleID	= b.Value
												WHERE	b.ID			= @i

												SELECT	@CMDPreSP		=	@UseStatement + 'IF ( ISNULL(OBJECT_ID('''+ @SDBMPEGDBName +'.dbo.'+@CurrentSPName+'''), 0) > 0 ) DROP PROCEDURE dbo.'+@CurrentSPName+'; ' + @ExecStatment
												EXEC	sp_executesql	@CMDPreSP, @ParamStatement, @SQLString=@CMDSP
												SET		@i				= @i + 1

								END


				END
				ELSE			SELECT			@ERROR			= 0

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGObjects Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGObjects Fail Step'
				
				SET				@Msg			= 'Last Step -- > ' + @LastStepName + ISNULL(@ErrMsg, '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg
				

END


GO
/****** Object:  StoredProcedure [dbo].[CreateSDBPublication]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateSDBPublication]
		@ReplicationClusterID		INT,
		@SDBSystemID				INT,
		@SDBName					VARCHAR(100),
		@publication				sysname,
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
// Module:  dbo.CreateSDBPublication
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a publication for the specified backup SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateSDBPublication.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @ERROROUT INT
//				EXEC	DINGOSDB.dbo.CreateSDBPublication	
//								@ReplicationClusterID	= 1,
//								@SDBSystemID			= 1,
//								@SDBName				= N'MSSNTC4SDB001B', 
//								@publication			= N'Spot+mpegPublication Backup',
//								@JobOwnerLoginName		= N'',
//								@JobOwnerLoginPWD		= N'',
//								@ERROR					= @ERROROUT OUTPUT
//
*/ 
-- =============================================
BEGIN


			SET NOCOUNT ON;

			DECLARE			@EventLogStatusID							INT
			DECLARE			@LogIDReturn								INT
			DECLARE			@ERRNum										INT
			DECLARE			@ErrMsg										VARCHAR(100)
			DECLARE			@Msg										VARCHAR(200)
			DECLARE			@LastStepName								VARCHAR(50)

			DECLARE			@ParmDefinition								NVARCHAR(100)
			DECLARE			@ParmDefinitionGetLogReaderJob				NVARCHAR(100)
			DECLARE			@ParmDefinitionGetPublicationStatus			NVARCHAR(100)
			DECLARE			@ParmDefinitionGetPublicationJob			NVARCHAR(100)
			DECLARE			@SQLCMDAddReplOption						NVARCHAR(500)
			DECLARE			@SQLCMDAddLogReader_Agent 					NVARCHAR(500)
			DECLARE			@SQLCMDAddPublication 						NVARCHAR(500)
			DECLARE			@SQLCMDAddPublication_Snapshot 				NVARCHAR(500)
			DECLARE			@SQLCMDGetLogReaderJob						NVARCHAR(500)


			DECLARE			@SQLCMDGetPublicationStatus					NVARCHAR(500)
			DECLARE			@SQLCMDGetPublicationStatusPrimary			NVARCHAR(500)
			DECLARE			@SQLCMDGetPublicationStatusBackup			NVARCHAR(500)
			DECLARE			@SQLCMDGetPublicationJob					NVARCHAR(500)
			DECLARE			@SQLCMDEnableLogReaderJob					NVARCHAR(500)
			DECLARE			@SQLCMDEnablePublicationJob					NVARCHAR(500)
			DECLARE			@SQLCMDStartSnapshotJob						NVARCHAR(500)
			DECLARE			@SQLCMDGetMPEGTableNames					NVARCHAR(500)
			DECLARE			@SQLCMDType									VARCHAR(50)
			DECLARE			@SQLCMD										NVARCHAR(MAX)
			DECLARE			@SQLCMDsp									NVARCHAR(MAX)
			DECLARE			@SQLCMDAddArticle							NVARCHAR(MAX)
			DECLARE			@SQLCMDChecksp_MSupd_IE						NVARCHAR(500)
			DECLARE			@SQLCMDChecksp_MSupd_SPOT					NVARCHAR(500)
			DECLARE			@SQLCMDResultsp_MSupd_IE					INT = 0
			DECLARE			@SQLCMDResultsp_MSupd_SPOT					INT = 0
			DECLARE			@SQLCMDName									VARCHAR(50) 
			DECLARE			@LogReaderJobID								UNIQUEIDENTIFIER
			DECLARE			@PublicationJobID 							UNIQUEIDENTIFIER
			DECLARE			@LogReaderJobName							VARCHAR(200) = ''
			DECLARE			@PublicationJobName 						VARCHAR(200) = ''
			DECLARE			@PublicationStatus 							INT
			DECLARE			@ReturnCode									INT = 0
			DECLARE			@i 											INT = 1
			DECLARE			@TotalRows									INT = 0
			DECLARE			@TableExists								INT
			DECLARE			@LogReaderReplicationJobTypeID				INT
			DECLARE			@SnapshotReplicationJobTypeID				INT
			DECLARE			@PublicationReplicationJobTypeID			INT


			SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPublication First Step'

			IF				( @EventLogStatusID IS NOT NULL )
							EXEC	dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusID,			----Started Step
												@JobID				= NULL,
												@JobName			= N'Check SDB Replication',
												@DBID				= @ReplicationClusterID,
												@DBComputerName		= @@SERVERNAME,
												@LogIDOUT			= @LogIDReturn OUTPUT

			IF OBJECT_ID('tempdb..#MPEGTable') IS NOT NULL
				DROP TABLE #MPEGTable
			CREATE TABLE #MPEGTable	(
											id int identity(1,1),
											MPEGTableName varchar(100)
										)


			SELECT			@LogReaderReplicationJobTypeID				= ReplicationJobTypeID 
			FROM			dbo.ReplicationJobType (NOLOCK)
			WHERE			Description									= 'Log Reader Agent'

			SELECT			@SnapshotReplicationJobTypeID				= ReplicationJobTypeID 
			FROM			dbo.ReplicationJobType (NOLOCK)
			WHERE			Description									= 'Snapshot Agent' 

			SELECT			@PublicationReplicationJobTypeID			= ReplicationJobTypeID 
			FROM			dbo.ReplicationJobType (NOLOCK)
			WHERE			Description									= 'Publication Agent' --AKA transactional publication


			SELECT			@SQLCMDAddReplOption						=	N'EXEC @Status = [' + @SDBName + '].mpeg.dbo.sp_replicationdboption ' +
																			N'@dbname=N''mpeg'', ' + 
																			N'@optname=N''publish'', ' +
																			N'@value = N''true'' ',
							@SQLCMDAddLogReader_Agent 					=	N'EXEC @Status = [' + @SDBName + '].mpeg.dbo.sp_addlogreader_agent ' +
																			N'@publisher_security_mode = 1 ',
							@SQLCMDAddPublication 						=	N'EXEC @Status = [' + @SDBName + '].mpeg.dbo.sp_addpublication ' +
																			N'@publication = N''' + @publication + ''', ' +
																			N'@description	= N''Spot+ Transactional publication of mpeg database from Publisher ' + @SDBName + ''', ' +
																			N'@sync_method	= ''concurrent_c'', ' +
																			N'@repl_freq = N''continuous'', ' +
																			N'@status=N''active'', ' + 
																			N'@allow_push = N''true'', ' + 
																			N'@allow_pull = N''true'', ' +
																			N'@immediate_sync = N''true'', ' + 
																			N'@allow_anonymous = N''true'', ' + 
																			N'@independent_agent = N''true'' ',
							@SQLCMDAddPublication_Snapshot 				=	N'EXEC @Status = [' + @SDBName + '].mpeg.dbo.sp_addpublication_snapshot ' +
																			N'@publication = N''' + @publication + ''', ' +
																			N'@publisher_security_mode = 1 ',

							@SQLCMDGetLogReaderJob						=	N'SELECT @LogReaderJobID = a.job_id, @LogReaderJobName = a.name ' +
																			N'FROM [' + @SDBName + '].msdb.dbo.sysjobs a WITH (NOLOCK) ' + 
																			N'WHERE category_id = 13 ' +
																			N'AND name LIKE ''' + @SDBName + '-mpeg%'' ',

							@SQLCMDGetPublicationStatus					=	N'SELECT @PublicationStatus = a.status ' +
																			N'FROM [' + @SDBName + '].mpeg.dbo.syspublications a WITH (NOLOCK) ' + 
																			N'WHERE a.name = ''' + @publication + ''' ',

							@SQLCMDGetPublicationStatusPrimary			=	N'SELECT @PublicationStatus = a.status ' +
																			N'FROM [' + @SDBName + '].mpeg.dbo.syspublications a WITH (NOLOCK) ' + 
																			N'WHERE a.name = ''Spot+mpegPublication'' ',

							@SQLCMDGetPublicationStatusBackup			=	N'SELECT @PublicationStatus = a.status ' +
																			N'FROM [' + @SDBName + '].mpeg.dbo.syspublications a WITH (NOLOCK) ' + 
																			N'WHERE a.name = ''Spot+mpegPublication Backup'' ',

							@SQLCMDGetPublicationJob					=	N'SELECT @PublicationJobID = a.job_id, @PublicationJobName = a.name ' +
																			N'FROM [' + @SDBName + '].msdb.dbo.sysjobs a WITH (NOLOCK) ' + 
																			N'WHERE category_id = 15 ' +
																			N'AND name LIKE ''%' + @SDBName + '-mpeg%Backup%'' ',
																			
							@SQLCMDEnableLogReaderJob					=	N'EXEC [' + @SDBName + '].msdb.dbo.sp_update_job ' + 
																			N'@job_name =  ''TOKEN'', ' +
																			N'@enabled = 1 ',

							@SQLCMDEnablePublicationJob					=	N'EXEC [' + @SDBName + '].msdb.dbo.sp_update_job ' + 
																			N'@job_name =  ''TOKEN'', ' +
																			N'@enabled = 1 ',
							@SQLCMDGetMPEGTableNames					=	N'INSERT	#MPEGTable ( MPEGTableName ) ' +
																			N'SELECT	name ' +
																			N'FROM		[' + @SDBName + '].mpeg.sys.tables a WITH (NOLOCK) ' +
																			N'ORDER BY	name ',

							@SQLCMDStartSnapshotJob						=	N'EXEC 			[' + @SDBName + '].msdb.dbo.sp_start_job @job_name =  ''TOKEN'' ',
	
							@ParmDefinition								=	N'@Status INT OUTPUT',
							@ParmDefinitionGetLogReaderJob				=	N'@LogReaderJobID UNIQUEIDENTIFIER OUTPUT, @LogReaderJobName NVARCHAR(200) OUTPUT',
							@ParmDefinitionGetPublicationStatus			=	N'@PublicationStatus INT OUTPUT',
							@ParmDefinitionGetPublicationJob			=	N'@PublicationJobID UNIQUEIDENTIFIER OUTPUT, @PublicationJobName NVARCHAR(200) OUTPUT',
							@SQLCMDChecksp_MSupd_IE						=	N'SELECT TOP 1 @Status = 1 FROM [' + @SDBName + '].mpeg.dbo.sysobjects WITH (NOLOCK) WHERE name = ''sp_MSupd_IE'' AND xtype = ''P''',
							@SQLCMDChecksp_MSupd_SPOT					=	N'SELECT TOP 1 @Status = 1 FROM [' + @SDBName + '].mpeg.dbo.sysobjects WITH (NOLOCK) WHERE name = ''sp_MSupd_SPOT'' AND xtype = ''P'''


							--Check to see if these SPs already exist in the MPEG DB.  If so, skip.
							EXECUTE			sp_executesql	@SQLCMDChecksp_MSupd_IE, @ParmDefinition, @Status = @SQLCMDResultsp_MSupd_IE OUTPUT
							EXECUTE			sp_executesql	@SQLCMDChecksp_MSupd_SPOT, @ParmDefinition, @Status = @SQLCMDResultsp_MSupd_SPOT OUTPUT


							--Check to see if the Log Reader Job already exists.  If so, skip creation of Log Reader.
							EXECUTE			sp_executesql	@SQLCMDGetLogReaderJob, @ParmDefinitionGetLogReaderJob, @LogReaderJobID = @LogReaderJobID OUTPUT, @LogReaderJobName = @LogReaderJobName OUTPUT
							IF				( @LogReaderJobID IS NOT NULL )
											EXEC			dbo.UpsertReplicationJob	
															@SDBSystemID				= @SDBSystemID,
															@SDBName					= @SDBName, 
															@ReplicationJobTypeID		= @LogReaderReplicationJobTypeID,
															@JOBID						= @LogReaderJobID,
															@JOBName					= @LogReaderJobName,
															@ERROR						= @ERROR OUTPUT

							--Check to see if the Publication already exists for the MPEG DB.  If so, skip creation of publication.
							--Need to TRY-CATCH because sometimes the table MPEG.dbo.syspublications may not exist 
							BEGIN TRY
											EXECUTE			sp_executesql	@SQLCMDGetPublicationStatus, @ParmDefinitionGetPublicationStatus, @PublicationStatus = @PublicationStatus OUTPUT
							END TRY
							BEGIN CATCH
											SELECT			@PublicationStatus			= NULL
							END CATCH

							--Check to see if the Publication Job already exists.  If so, skip creation of Publication.
							EXECUTE			sp_executesql	@SQLCMDGetPublicationJob, @ParmDefinitionGetPublicationJob, @PublicationJobID = @PublicationJobID OUTPUT, @PublicationJobName = @PublicationJobName OUTPUT
							IF				( @PublicationJobID IS NOT NULL )
											EXEC			dbo.UpsertReplicationJob	
															@SDBSystemID				= @SDBSystemID,
															@SDBName					= @SDBName, 
															@ReplicationJobTypeID		= @SnapshotReplicationJobTypeID,
															@JOBID						= @PublicationJobID,
															@JOBName					= @PublicationJobName,
															@ERROR						= @ERROR OUTPUT



			--BEGIN TRANSACTION
							--select 
							--			@LogReaderJobID,
							--			@PublicationJobID,
							--			@LogReaderJobName,
							--			@PublicationJobName,
							--			@PublicationStatus
							--return

							--SELECT			@SQLCMDAddReplOption
							--SELECT			@SQLCMDAddLogReader_Agent
							--SELECT			@SQLCMDAddPublication
							--SELECT			@SQLCMDAddPublication_Snapshot
							--SELECT			@SQLCMDGetLogReaderJob
							--SELECT			@SQLCMDGetPublicationJob
							--SELECT			@SQLCMDEnableLogReaderJob
							--SELECT			@SQLCMDEnablePublicationJob
							--SELECT			@ParmDefinition					


							--				Add the replication option
							SELECT			@LastStepName												= '@SQLCMDAddReplOption'
							EXECUTE			sp_executesql	@SQLCMDAddReplOption , @ParmDefinition, @Status = @ReturnCode OUTPUT
							SELECT			@ERROR														= @@ERROR
							--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

							--				Add the Log Reader Agent if it doesn't already exist
							IF				( @LogReaderJobID IS NULL )
							BEGIN
											SELECT			@LastStepName								= 'Add a Log Reader Agent'
											EXECUTE			sp_executesql	@SQLCMDAddLogReader_Agent, @ParmDefinition, @Status = @ReturnCode OUTPUT
											SELECT			@ERROR										= @@ERROR,
															@ErrNum										= ERROR_NUMBER(), 
															@ErrMsg										= ERROR_MESSAGE()

											IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
											EXECUTE			sp_executesql	@SQLCMDGetLogReaderJob, @ParmDefinitionGetLogReaderJob, @LogReaderJobID = @LogReaderJobID OUTPUT, @LogReaderJobName = @LogReaderJobName OUTPUT
											SELECT			@ERROR										= @@ERROR
											IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
											--				Save the job information
											EXEC			dbo.UpsertReplicationJob	
																			@SDBSystemID				= @SDBSystemID,
																			@SDBName					= @SDBName, 
																			@ReplicationJobTypeID		= @LogReaderReplicationJobTypeID,
																			@JOBID						= @LogReaderJobID,
																			@JOBName					= @LogReaderJobName,
																			@ERROR						= @ERROR OUTPUT


											--Generate script to enable the publication jobs.
											SELECT			@SQLCMDEnableLogReaderJob					=	REPLACE( @SQLCMDEnableLogReaderJob, 'TOKEN', @LogReaderJobName )

											--Enable the job
											SELECT			@LastStepName								= 'Enable Log Reader Agent'
											EXECUTE			sp_executesql	@SQLCMDEnableLogReaderJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
											SELECT			@ERROR										= @@ERROR,
															@ErrNum										= ERROR_NUMBER(), 
															@ErrMsg										= ERROR_MESSAGE()
											IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback


							END

							--				Add the publication if it doesn't already exist
							IF				( @PublicationStatus IS NULL )
							BEGIN
											SELECT			@LastStepName								= 'Add Publication'
											EXECUTE			sp_executesql	@SQLCMDAddPublication, @ParmDefinition, @Status = @ReturnCode OUTPUT
											SELECT			@ERROR										= @@ERROR,
															@ErrNum										= ERROR_NUMBER(), 
															@ErrMsg										= ERROR_MESSAGE()
											IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
							END

							--				Add the Publication Snapshot Agent if it doesn't already exist
							IF				( @PublicationJobID IS NULL )
							BEGIN

											SELECT			@LastStepName								= 'Add Publication Snapshot'
											EXECUTE			sp_executesql	@SQLCMDAddPublication_Snapshot, @ParmDefinition, @Status = @ReturnCode OUTPUT
											SELECT			@ERROR										= @@ERROR,
															@ErrNum										= ERROR_NUMBER(), 
															@ErrMsg										= ERROR_MESSAGE()
											IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
											EXECUTE			sp_executesql	@SQLCMDGetPublicationJob, @ParmDefinitionGetPublicationJob, @PublicationJobID = @PublicationJobID OUTPUT, @PublicationJobName = @PublicationJobName OUTPUT
											SELECT			@ERROR										= @@ERROR
											IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
											--				Save the job information
											EXEC			dbo.UpsertReplicationJob	
																			@SDBSystemID				= @SDBSystemID,
																			@SDBName					= @SDBName, 
																			@ReplicationJobTypeID		= @SnapshotReplicationJobTypeID,
																			@JOBID						= @PublicationJobID,
																			@JOBName					= @PublicationJobName,
																			@ERROR						= @ERROR OUTPUT

											--Generate script to Enable the publication jobs.
											SELECT			@SQLCMDEnablePublicationJob	=	REPLACE( @SQLCMDEnablePublicationJob, 'TOKEN', @PublicationJobName )

											--Enable the job
											SELECT			@LastStepName								= 'Enable Publication Snapshot Job'
											EXECUTE			sp_executesql	@SQLCMDEnablePublicationJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
											SELECT			@ERROR										= @@ERROR,
															@ErrNum										= ERROR_NUMBER(), 
															@ErrMsg										= ERROR_MESSAGE()
											IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

											--Start the job
											SELECT			@SQLCMDStartSnapshotJob						= REPLACE(@SQLCMDStartSnapshotJob, 'TOKEN', @PublicationJobName )
											SELECT			@LastStepName								= 'Start Publication Snapshot Job'
											EXECUTE			sp_executesql	@SQLCMDStartSnapshotJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
											SELECT			@ERROR										= @@ERROR,
															@ErrNum										= ERROR_NUMBER(), 
															@ErrMsg										= ERROR_MESSAGE()
											IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback


							END


							SELECT			TOP 1 @TotalRows = MPEGArticleID FROM  dbo.MPEGArticle WITH (NOLOCK) ORDER BY MPEGArticleID DESC

							IF				( @PublicationStatus IS NULL )
							BEGIN

											SELECT			@LastStepName				= 'Create Publication Articles'

											--				Get the articles to publish
											EXECUTE			sp_executesql	@SQLCMDGetMPEGTableNames --, @ParmDefinition, @Status = @ReturnCode OUTPUT
											--SELECT			@ERROR										= @@ERROR
											--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

											WHILE			( @i <= @TotalRows )
											BEGIN
															SELECT			@SQLCMD						= CMD,
																			@SQLCMDType					= CMDType,
																			@SQLCMDName					= Name,
																			@TableExists				= b.id
															FROM			dbo.MPEGArticle a WITH (NOLOCK) 
															LEFT JOIN		#MPEGTable b
															ON				a.Name						= b.MPEGTableName
															WHERE			MPEGArticleID				= @i
															SELECT			@SQLCMD						= REPLACE( @SQLCMD, 'token', @SDBName )

															--				Add articles to publication
															IF				( @SQLCMDType = 'CMD' )
															BEGIN
																			IF				( @TableExists IS NOT NULL )
																			BEGIN
																							EXECUTE			sp_executesql	@SQLCMD, @ParmDefinition, @Status = @ReturnCode OUTPUT
																							SELECT			@ERROR		= @@ERROR
																							IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
																			END
															END
															--				Create Stored Procedure[s] involved with replication articles
															ELSE
															BEGIN

																			IF				( 
																								(@SQLCMDName = 'sp_MSupd_IE' AND @SQLCMDResultsp_MSupd_IE = 0 )
																							OR	(@SQLCMDName = 'sp_MSupd_SPOT' AND @SQLCMDResultsp_MSupd_SPOT = 0 )
																							)
																			SET				@SQLCMDsp	= N'EXEC ( ''' + @SQLCMD + ''' )  AT ' + @SDBName
																			EXECUTE			( @SQLCMDsp )
																			SELECT			@ERROR		= @@ERROR,
																							@ErrNum		= ERROR_NUMBER(), 
																							@ErrMsg		= ERROR_MESSAGE()
																			--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

															END

															SET		@i = @i + 1
											END

							END

							SET				@ERROR										= 0

			--COMMIT TRANSACTION

			GOTO EndSave
			QuitWithRollback:
				IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
			EndSave:

			IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPublication Success Step'
			ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPublication Fail Step'
			
			SET				@Msg			= 'Last Step -- > ' + @LastStepName + ': ' + ISNULL(@ErrMsg , '')

			EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg
			

END



GO
/****** Object:  StoredProcedure [dbo].[CreateSDBPullSubscription]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateSDBPullSubscription]
		@ReplicationClusterID		INT,
		@SDBSystemID				INT,
		@SDBName					VARCHAR(100),
		@publication				sysname,
		@subscriber					sysname,
		@subscriptionDB				sysname,
		@JobOwnerLoginName			SYSNAME = NULL,
		@JobOwnerLoginPWD			SYSNAME = NULL,
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
// Module:  dbo.CreateSDBPullSubscription
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Pull Subscription for the specified backup SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateSDBPullSubscription.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @ERROROUT INT
//				EXEC	DINGOSDB.dbo.CreateSDBPullSubscription	
//								@ReplicationClusterID	= 1,
//								@SDBSystemID			= 1,
//								@SDBName				= N'MSSNKNLSDB001', 
//								@publication			= N'',
//								@subscriber				= N'',
//								@subscriptionDB			= N'',
//								@JobOwnerLoginName		= N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD		= '',
//								@ERROR					= @ERROROUT OUTPUT
//
*/ 
-- =============================================
BEGIN


				SET NOCOUNT ON;

				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@Msg									VARCHAR(200)
				DECLARE			@LastStepName							VARCHAR(50)

				DECLARE			@SQLCMDAddSubscription					NVARCHAR(1000)
				DECLARE			@SQLCMDSubscriptionJob					NVARCHAR(1000)
				DECLARE			@SQLCMDGetSubscription					NVARCHAR(1000)
				DECLARE			@SQLCMDGetSubscriptionJob				NVARCHAR(1000)
				DECLARE			@SQLCMDDropPullSubscription				NVARCHAR(1000)
				DECLARE			@SQLCMDAddPullSubscription				NVARCHAR(1000)
				DECLARE			@SQLCMDAddPullSubscriptionAgent			NVARCHAR(1000)
				DECLARE			@ParmDefinition							NVARCHAR(500)
				DECLARE			@SubscriptionJobID						UNIQUEIDENTIFIER
				DECLARE			@SubscriptionJobName					NVARCHAR(500)
				DECLARE			@JobEnabled								BIT
				DECLARE			@SubscriptionType						INT
				DECLARE			@PullReplicationJobTypeID				INT

				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPullSubscription First Step'

				IF				( @EventLogStatusID IS NOT NULL )
								EXEC	dbo.LogEvent 
													@LogID				= NULL,
													@EventLogStatusID	= @EventLogStatusID,			----Started Step
													@JobID				= NULL,
													@JobName			= N'Check SDB Replication',
													@DBID				= @ReplicationClusterID,
													@DBComputerName		= @@SERVERNAME,
													@LogIDOUT			= @LogIDReturn OUTPUT

				SELECT			@PullReplicationJobTypeID				= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Pull Distribution Agent'


				SELECT			@SQLCMDAddSubscription					=	N'EXEC @Status			= [' + @SDBName + '].mpeg.sys.sp_addsubscription ' +
																			N'@publication			= N''' + @publication + ''', ' +
																			N'@article				= N''all'', ' +
																			N'@subscriber			= N''' + @subscriber + ''', ' +
																			N'@destination_db		= N''' + @subscriptionDB + ''', ' +
																			N'@subscription_type	= N''pull'' ',
								@SQLCMDGetSubscription					=	N'SELECT @SubscriptionType = a.type ' +
																			N'FROM [' + @SDBName + '].distribution.dbo.MSsubscriber_info a WITH (NOLOCK) ' + 
																			N'WHERE a.subscriber	LIKE ''' + SUBSTRING(@subscriber, 1, 10) + '%'' '

				SELECT			@SQLCMDDropPullSubscription				=	N'EXEC @Status			= ' + @subscriptionDB + '.sys.sp_droppullsubscription ' +
																			N'@publisher			= N''' + @SDBName + ''', ' +
																			N'@publication			= N''' + @publication + ''', ' +
																			N'@publisher_db			= N''MPEG'' '

				SELECT			@SQLCMDAddPullSubscription				=	N'EXEC @Status			= ' + @subscriptionDB + '.sys.sp_addpullsubscription ' +
																			N'@publisher			= N''' + @SDBName + ''', ' +
																			N'@publication			= N''' + @publication + ''', ' +
																			N'@publisher_db			= N''MPEG'' '

				SELECT			@SQLCMDAddPullSubscriptionAgent			=	N'EXEC @Status			= ' + @subscriptionDB + '.sys.sp_addpullsubscription_agent ' +
																			N'@publisher			= N''' + @SDBName + ''', ' +
																			N'@publication			= N''' + @publication + ''', ' +
																			N'@publisher_db			= N''MPEG'', ' +
																			N'@distributor			= N''' + @SDBName + ''' '

				IF				( @JobOwnerLoginName IS NOT NULL) 
				SELECT			@SQLCMDAddPullSubscriptionAgent			=	@SQLCMDAddPullSubscriptionAgent + ', ' +
																			N'@job_login			= N''' + @JobOwnerLoginName + ''', ' +
																			N'@job_password			= N''' + @JobOwnerLoginPWD + ''' '

																			
				--				Check publisher for the existence of a subscription for this replication cluster node.
				SET				@ParmDefinition							= N'@SubscriptionType INT OUTPUT'
				EXECUTE			sp_executesql	
									@SQLCMDGetSubscription, 
									@ParmDefinition, 
									@SubscriptionType					= @SubscriptionType OUTPUT
				SELECT			@ERROR									= @@ERROR

				--				Check for the existence of pull subscription.
				SELECT			@SubscriptionJobID						= j.job_ID, 
								@SubscriptionJobName					= j.name, 
								@JobEnabled								= j.enabled
				FROM			msdb.dbo.sysjobs j WITH (NOLOCK) 
				JOIN			msdb.dbo.syscategories b WITH (NOLOCK) 
				ON				j.category_id							= b.category_id
				WHERE			b.name									LIKE 'REPL%'
				AND				j.name									LIKE @SDBName + '%Spot+mpeg%'

				IF				( @SubscriptionJobName IS NOT NULL )
				BEGIN
								EXEC		dbo.UpsertReplicationJob	
													@SDBSystemID										= @SDBSystemID,
													@SDBName											= @SDBName, 
													@ReplicationJobTypeID								= @PullReplicationJobTypeID,
													@JOBID												= @SubscriptionJobID,
													@JOBName											= @SubscriptionJobName,
													@ERROR												= @ERROR OUTPUT

				END

				
				BEGIN TRY

								IF				( @SubscriptionJobName IS NULL )
								BEGIN

												--				Part of pull subscription done at subscriber.
												IF				( @SubscriptionType IS NOT NULL )
												BEGIN

																SET				@ParmDefinition			= N'@Status INT OUTPUT'
																SELECT			@LastStepName			= 'Drop a Pull Subscription'
																EXECUTE			sp_executesql	
																					@SQLCMDDropPullSubscription, 
																					@ParmDefinition, 
																					@Status				= @ERROR OUTPUT
																SELECT			@ERROR					= @@ERROR,
																				@ErrNum					= ERROR_NUMBER(), 
																				@ErrMsg					= ERROR_MESSAGE()
																
												END

												SET				@ParmDefinition							= N'@Status INT OUTPUT'
												SELECT			@LastStepName							= 'Add a Pull Subscription'
												EXECUTE			sp_executesql	
																	@SQLCMDAddPullSubscription, 
																	@ParmDefinition, 
																	@Status								= @ERROR OUTPUT
												SELECT			@ERROR									= @@ERROR,
																@ErrNum									= ERROR_NUMBER(), 
																@ErrMsg									= ERROR_MESSAGE()


												SET				@ParmDefinition							= N'@Status INT OUTPUT'
												SELECT			@LastStepName							= 'Add a Pull Subscription Agent'
												EXECUTE			sp_executesql	
																	@SQLCMDAddPullSubscriptionAgent, 
																	@ParmDefinition, 
																	@Status								= @ERROR OUTPUT
												SELECT			@ERROR									= @@ERROR,
																@ErrNum									= ERROR_NUMBER(), 
																@ErrMsg									= ERROR_MESSAGE()

								END

								--				Part of pull subscription done at publisher.
								--				Anonymous subscriptions do not need to use this stored procedure.
								IF				( @SubscriptionType IS NULL )
								BEGIN
												SET				@ParmDefinition							= N'@Status INT OUTPUT'
												SELECT			@LastStepName							= 'Add a subscription'
												EXECUTE			sp_executesql	
																	@SQLCMDAddSubscription, 
																	@ParmDefinition, 
																	@Status								= @ERROR OUTPUT
												SELECT			@ERROR									= @@ERROR,
																@ErrNum									= ERROR_NUMBER(), 
																@ErrMsg									= ERROR_MESSAGE()
								END

								--				Get the job information for the pull subscription.
								SELECT			@SubscriptionJobID						= j.job_ID, 
												@SubscriptionJobName					= j.name, 
												@JobEnabled								= j.enabled
								FROM			msdb.dbo.sysjobs j WITH (NOLOCK) 
								JOIN			msdb.dbo.syscategories b WITH (NOLOCK) 
								ON				j.category_id							= b.category_id
								WHERE			b.name									LIKE 'REPL%'
								AND				j.name									LIKE @SDBName + '%Spot+mpeg%'

								IF				( @SubscriptionJobName IS NOT NULL )
								BEGIN

												--			Save the Job information
												EXEC		dbo.UpsertReplicationJob	
																	@SDBSystemID				= @SDBSystemID,
																	@SDBName					= @subscriber, 
																	@ReplicationJobTypeID		= @PullReplicationJobTypeID,
																	@JOBID						= @SubscriptionJobID,
																	@JOBName					= @SubscriptionJobName,
																	@ERROR						= @ERROR OUTPUT

												--			Enable the Pull subscription job.
												SELECT		@LastStepName						= 'Enable pull subscription job'
												EXEC		msdb.dbo.sp_update_job
															@job_name							= @SubscriptionJobName,
															@enabled							= 1 
												SELECT		@ERROR								= @@ERROR

												--			Start the Pull subscription job.
												EXEC		msdb.dbo.sp_start_job
															@job_name							= @SubscriptionJobName


								END

								SET				@ERROR											= 0

				END TRY
				BEGIN CATCH

								SELECT			@ERROR											= @@ERROR,
												@ErrNum											= ERROR_NUMBER(), 
												@ErrMsg											= ERROR_MESSAGE()

				END CATCH


				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPullSubscription Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPullSubscription Fail Step'
			
				SET				@Msg			= 'Last Step -- > ' + @LastStepName + ': ' + ISNULL(@ErrMsg , '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg
				

END



GO

/****** Object:  StoredProcedure [dbo].[CreateSDBPushSubscription]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateSDBPushSubscription]
		@ReplicationClusterID		INT,
		@SDBSystemID				INT,
		@SDBName					VARCHAR(100),
		@publication				SYSNAME,
		@subscriber					SYSNAME,
		@subscriptionDB				SYSNAME,
		@JobOwnerLoginName			SYSNAME = NULL,
		@JobOwnerLoginPWD			SYSNAME = NULL,
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
// Module:  dbo.CreateSDBPushSubscription
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Push Subscription for the specified primary SDB server. 
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateSDBPushSubscription.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE	@ERROROUT INT
//				EXEC	DINGOSDB.dbo.CreateSDBPushSubscription	
//								@ReplicationClusterID	= 1,
//								@SDBSystemID			= 1,
//								@SDBName				= 'MSSNKNLSDB001', 
//								@publication			=	'',
//								@subscriber				=	'',
//								@subscriptionDB			=	'',
//								@JobOwnerLoginName		= N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD		= '',
//								@ERROR					= @ERROROUT OUTPUT
//
*/ 
-- =============================================
BEGIN


			SET				NOCOUNT ON;

			DECLARE			@EventLogStatusID						INT
			DECLARE			@LogIDReturn							INT
			DECLARE			@ERRNum									INT
			DECLARE			@ErrMsg									VARCHAR(100)
			DECLARE			@Msg									VARCHAR(200)
			DECLARE			@LastStepName							VARCHAR(50)

			DECLARE			@SQLCMDSubscription						NVARCHAR(1000)
			DECLARE			@SQLCMDSubscriptionAgent				NVARCHAR(1000)
			DECLARE			@SQLCMDChangeJobOwner					NVARCHAR(1000)
			DECLARE			@SQLCMDSubscriptionJob					NVARCHAR(1000)
			DECLARE			@SQLCMDGetSubscription					NVARCHAR(1000)
			DECLARE			@SQLCMDGetSubscriptionJob				NVARCHAR(1000)
			DECLARE			@SQLCMDGetSnapshotJob					NVARCHAR(1000)
			DECLARE			@SQLCMDStopSubscriptionAgentJob			NVARCHAR(1000)
			DECLARE			@SQLCMDStartSubscriptionAgentJob		NVARCHAR(1000)
			DECLARE			@SQLCMDStartSnapshotJob					NVARCHAR(1000)

			DECLARE			@ParmDefinition							NVARCHAR(500)
			DECLARE			@SubscriptionJobID						UNIQUEIDENTIFIER
			DECLARE			@SubscriptionJobName					VARCHAR(200)
			DECLARE			@SnapshotJobID							UNIQUEIDENTIFIER
			DECLARE			@SnapshotJobName						VARCHAR(200)
			DECLARE			@JobEnabled								INT
			DECLARE			@SubscriptionType						INT
			DECLARE			@PushReplicationJobTypeID				INT
			DECLARE			@SnapshotReplicationJobTypeID			INT

			SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPushSubscription First Step'

			IF				( @EventLogStatusID IS NOT NULL )
							EXEC	dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusID,			----Started Step
												@JobID				= NULL,
												@JobName			= N'Check SDB Replication',
												@DBID				= @ReplicationClusterID,
												@DBComputerName		= @@SERVERNAME,
												@LogIDOUT			= @LogIDReturn OUTPUT


			SELECT			@PushReplicationJobTypeID				= ReplicationJobTypeID 
			FROM			dbo.ReplicationJobType (NOLOCK)
			WHERE			Description								= 'Push Distribution Agent'

			SELECT			@SnapshotReplicationJobTypeID			= ReplicationJobTypeID 
			FROM			dbo.ReplicationJobType (NOLOCK)
			WHERE			Description								= 'Snapshot Agent'

			SELECT			@SQLCMDSubscription						=	N'EXEC [' + @SDBName + '].mpeg.sys.sp_addsubscription ' +
																		N'@publication			= N''' + @publication + ''', ' +
																		N'@article				= N''all'', ' +
																		N'@subscriber			= N''' + @subscriber + ''', ' +
																		N'@destination_db		= N''' + @subscriptionDB + ''', ' +
																		N'@subscription_type	= N''push'' ',
							@SQLCMDSubscriptionAgent				=	N'EXEC [' + @SDBName + '].mpeg.sys.sp_addpushsubscription_agent ' +
																		N'@publication			= N''' + @publication + ''', ' +
																		N'@subscriber			= N''' + @subscriber + ''', ' +
																		N'@subscriber_db		= N''' + @subscriptionDB + ''', ' +
																		N'@subscriber_login		= N''' + @JobOwnerLoginName + ''', ' +
																		N'@subscriber_password	= N''' + @JobOwnerLoginPWD + ''', ' +
																		N'@job_login			= N''' + @JobOwnerLoginName + ''', ' +
																		N'@job_password			= N''' + @JobOwnerLoginPWD + ''' ' ,
							@SQLCMDChangeJobOwner					=	N'EXEC [' + @SDBName + '].msdb.dbo.sp_update_job @job_name = ''TOKEN'',  ' +
																		N'@owner_login_name		= ''' + @JobOwnerLoginName + ''' ',
							@SQLCMDGetSubscription					=	N'SELECT @SubscriptionType = a.type ' +
																		N'FROM [' + @SDBName + '].distribution.dbo.MSsubscriber_info a WITH (NOLOCK) ' + 
																		N'WHERE a.subscriber = ''' + @@SERVERNAME + ''' ',
							@SQLCMDGetSubscriptionJob				=	N'SELECT		@SubscriptionJobID = j.job_ID, @SubscriptionJobName = j.name, @JobEnabled = j.enabled, @SubscriptionType = b.subscription_type ' +
																		N'FROM			[' + @SDBName + '].msdb.dbo.sysjobs j WITH (NOLOCK) ' +
																		N'LEFT JOIN		[' + @SDBName + '].distribution.dbo.MSdistribution_agents b WITH (NOLOCK) ' +
																		N'ON			j.job_id	= b.job_id ' +
																		N'WHERE			j.name	LIKE ''%' + @@SERVERNAME + '%'' ',
							@SQLCMDGetSnapshotJob					=	N'SELECT		@SnapshotJobID = j.job_ID, @SnapshotJobName = j.name, @JobEnabled = j.enabled ' +
																		N'FROM			[' + @SDBName + '].msdb.dbo.sysjobs j WITH (NOLOCK) ' +
																		N'LEFT JOIN		[' + @SDBName + '].msdb.dbo.syscategories a WITH (NOLOCK) ' +
																		N'ON			j.category_id	= a.category_id ' +
																		N'WHERE			j.name	LIKE ''%' + @publication + '%'' ' +
																		N'AND			a.name = ''REPL-Snapshot'' ',
							@SQLCMDStopSubscriptionAgentJob			=	N'EXEC 			[' + @SDBName + '].msdb.dbo.sp_stop_job @job_name =  ''TOKEN'' ',
							@SQLCMDStartSubscriptionAgentJob		=	N'EXEC 			[' + @SDBName + '].msdb.dbo.sp_start_job @job_name =  ''TOKEN'' ',
							@SQLCMDStartSnapshotJob					=	N'EXEC 			[' + @SDBName + '].msdb.dbo.sp_start_job @job_name =  ''TOKEN'' '


				--				Check publisher for the existence of a subscription for this replication cluster node.
				SET				@ParmDefinition							= N'@SubscriptionType INT OUTPUT'
				EXECUTE			sp_executesql	
									@SQLCMDGetSubscription, 
									@ParmDefinition, 
									@SubscriptionType					= @SubscriptionType OUTPUT
				SELECT			@ERROR									= @@ERROR

				--				Check for the existence of push subscription.
				SET				@ParmDefinition							= N'@SubscriptionJobID UNIQUEIDENTIFIER OUTPUT, @SubscriptionJobName VARCHAR(200) OUTPUT, @JobEnabled INT OUTPUT, @SubscriptionType INT OUTPUT'
				EXECUTE			sp_executesql	
									@SQLCMDGetSubscriptionJob, 
									@ParmDefinition, 
									@SubscriptionJobID					= @SubscriptionJobID OUTPUT,
									@SubscriptionJobName				= @SubscriptionJobName OUTPUT,
									@JobEnabled							= @JobEnabled OUTPUT,
									@SubscriptionType					= @SubscriptionType OUTPUT
				SELECT			@ERROR									= @@ERROR

				IF				( @SubscriptionJobName IS NOT NULL )
				BEGIN

								EXEC		dbo.UpsertReplicationJob	
													@SDBSystemID				= @SDBSystemID,
													@SDBName					= @SDBName, 
													@ReplicationJobTypeID		= @PushReplicationJobTypeID,
													@JOBID						= @SubscriptionJobID,
													@JOBName					= @SubscriptionJobName,
													@ERROR						= @ERROR OUTPUT

				END
				
							
				IF				( @SubscriptionType IS NULL )
				BEGIN
							--Add a push subscription to a transactional publication.
							SELECT			@LastStepName							= 'Add a push subscription'
							EXECUTE			sp_executesql	@SQLCMDSubscription --, @ParmDefinition, @Status = @ReturnCode OUTPUT
							SELECT			@ERROR									= @@ERROR,
											@ErrNum									= ERROR_NUMBER(), 
											@ErrMsg									= ERROR_MESSAGE()
							--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				END


				--Get the Snapshot Agent Job info in order to manually initiate a snapshot.
				SELECT			@LastStepName							= 'Get the Snapshot Agent Job info'
				SET				@ParmDefinition							=	N'@SnapshotJobID UNIQUEIDENTIFIER OUTPUT, @SnapshotJobName VARCHAR(200) OUTPUT, @JobEnabled INT OUTPUT'
				EXECUTE			sp_executesql	
									@SQLCMDGetSnapshotJob, 
									@ParmDefinition, 
									@SnapshotJobID						= @SnapshotJobID OUTPUT,
									@SnapshotJobName					= @SnapshotJobName OUTPUT,
									@JobEnabled							= @JobEnabled OUTPUT
				SELECT			@ERROR									= @@ERROR

				IF				( @SnapshotJobName IS NOT NULL )
				BEGIN

								EXEC	dbo.UpsertReplicationJob	
												@SDBSystemID			= @SDBSystemID,
												@SDBName				= @SDBName, 
												@ReplicationJobTypeID	= @SnapshotReplicationJobTypeID,
												@JOBID					= @SnapshotJobID,
												@JOBName				= @SnapshotJobName,
												@ERROR					= @ERROR OUTPUT

				END


				IF				( @SubscriptionJobName IS NULL AND ISNULL(@ERROR, 0) = 0 )
				BEGIN

							--Add an agent job to synchronize the push subscription.
							SELECT			@LastStepName							= 'Add a push subscription agent job'
							EXECUTE			sp_executesql	@SQLCMDSubscriptionAgent --, @ParmDefinition, @Status = @ReturnCode OUTPUT
							SELECT			@ERROR									= @@ERROR,
											@ErrNum									= ERROR_NUMBER(), 
											@ErrMsg									= ERROR_MESSAGE()
							--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

							SET				@ParmDefinition							=	N'@SubscriptionJobID UNIQUEIDENTIFIER OUTPUT, @SubscriptionJobName VARCHAR(200) OUTPUT, @JobEnabled INT OUTPUT, @SubscriptionType INT OUTPUT'
							EXECUTE			sp_executesql	
												@SQLCMDGetSubscriptionJob, 
												@ParmDefinition, 
												@SubscriptionJobID					= @SubscriptionJobID OUTPUT,
												@SubscriptionJobName				= @SubscriptionJobName OUTPUT,
												@JobEnabled							= @JobEnabled OUTPUT,
												@SubscriptionType					= @SubscriptionType OUTPUT
							SELECT			@ERROR									= @@ERROR

							IF		( @SubscriptionJobName IS NOT NULL )
							BEGIN

										EXEC			dbo.UpsertReplicationJob	
															@SDBSystemID			= @SDBSystemID,
															@SDBName				= @SDBName, 
															@ReplicationJobTypeID	= @PushReplicationJobTypeID,
															@JOBID					= @SubscriptionJobID,
															@JOBName				= @SubscriptionJobName,
															@ERROR					= @ERROR OUTPUT

										--SELECT			@SQLCMDChangeJobOwner		= REPLACE(@SQLCMDChangeJobOwner, 'TOKEN', @SubscriptionJobName )
										--SELECT			@SQLCMDStopSubscriptionAgentJob = REPLACE(@SQLCMDStopSubscriptionAgentJob, 'TOKEN', @SubscriptionJobName )
										--SELECT			@SQLCMDStartSubscriptionAgentJob = REPLACE(@SQLCMDStartSubscriptionAgentJob, 'TOKEN', @SubscriptionJobName )
										SELECT			@SQLCMDStartSnapshotJob		= REPLACE(@SQLCMDStartSnapshotJob, 'TOKEN', @SnapshotJobName )

										--SELECT			@LastStepName				= 'Stop the subscription agent job'
										--EXECUTE			sp_executesql				@SQLCMDStopSubscriptionAgentJob
										--SELECT			@ERROR						= @@ERROR

										--SELECT			@LastStepName				= 'Change the subscription agent job owner'
										--EXECUTE			sp_executesql				@SQLCMDChangeJobOwner
										--SELECT			@ERROR						= @@ERROR

										--SELECT			@LastStepName				= 'Start the subscription agent job'
										--EXECUTE			sp_executesql				@SQLCMDStartSubscriptionAgentJob
										--SELECT			@ERROR						= @@ERROR

										SELECT			@LastStepName				= 'Start the snapshot agent job'
										EXECUTE			sp_executesql				@SQLCMDStartSnapshotJob
										SELECT			@ERROR						= @@ERROR

							END

				END

							SET			@ERROR										= 0


			IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPushSubscription Success Step'
			ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPushSubscription Fail Step'
			
			SET				@Msg			= 'Last Step -- > ' + @LastStepName + ': ' + ISNULL(@ErrMsg , '')

			EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg


END

GO
/****** Object:  StoredProcedure [dbo].[DropSDBMPEGDB]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[DropSDBMPEGDB]
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
// Module:  dbo.DropSDBMPEGDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Drops an SDB's MPEG DB subscription partner.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.DropSDBMPEGDB.proc.sql 3246 2013-12-09 19:42:44Z tlew $
//    
//	 Usage:
//
//				DECLARE	@Err INT
//				EXEC	DINGOSDB.dbo.DropSDBMPEGDB	
//								@ReplicationClusterID		= 1,
//								@SDBSystemID				= 1,
//								@SDBMPEGDBName				= N'',
//								@ERROR						= @Err OUTPUT
//				SELECT	@Err
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@spid									INT
				DECLARE			@i										INT
				DECLARE			@totalspids								INT
				DECLARE			@spids									UDT_Int
				DECLARE			@cmd									NVARCHAR(100)
				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@LastStepName							VARCHAR(50)
				DECLARE			@Msg									VARCHAR(200)


				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'DropSDBMPEGDB First Step'

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
				INSERT			@spids (Value)
				SELECT			spid			--, hostname, [program_name], open_tran, hostprocess, cmd
				FROM			master.dbo.sysprocesses 
				WHERE			dbid									= db_id(@SDBMPEGDBName)
				SELECT			@totalspids								= @@ROWCOUNT,
								@i										= 1


				IF				EXISTS(SELECT TOP 1 1 FROM sys.databases WHERE name = @SDBMPEGDBName)
				BEGIN

								SELECT			@LastStepName							= 'Kill ' + @SDBMPEGDBName + ' database connections (if any): '
								--				For each new node, create the associated job.
								WHILE			( @i <= @totalspids )
								BEGIN

												SELECT		@spid		= x.Value 
												FROM		@spids x
												WHERE		x.id		= @i
												SET			@cmd = N'kill ' + cast(@spid as varchar(50))
												EXEC		( @cmd )

												SET			@i			= @i + 1

								END
								SET				@cmd = N'DROP DATABASE ' + @SDBMPEGDBName

								SELECT			@LastStepName = 'Drop ' + @SDBMPEGDBName + ' database: '
								EXEC			( @cmd )
								SELECT			@ERROR					= @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()

				END
				ELSE			SELECT			@ERROR			= 0

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'DropSDBMPEGDB Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'DropSDBMPEGDB Fail Step'
				
				SET				@Msg			= 'Last Step -- > ' + @LastStepName + ISNULL(@ErrMsg, '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg
				

END


GO
/****** Object:  StoredProcedure [dbo].[GetReplicationClusterMPEGInfo]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetReplicationClusterMPEGInfo]
				@ReplicationClusterID									INT
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
// Module:  dbo.GetReplicationClusterMPEGInfo
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets info about replication for SDB systems with incomplete information.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.GetReplicationClusterMPEGInfo.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGOSDB.dbo.GetReplicationClusterMPEGInfo	
//
*/ 
-- =============================================
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET				NOCOUNT ON;

				DECLARE			@LogIDReturn							INT
				DECLARE			@JobID									UNIQUEIDENTIFIER
				DECLARE			@ErrMsg									VARCHAR(200)
				DECLARE			@EventLogStatusID						INT
				
				DECLARE			@sql									NVARCHAR(MAX)
				DECLARE			@SQLReplication_JobStatus				NVARCHAR(1000)
				DECLARE			@SQLCurrent_Replication_JobStatus		NVARCHAR(1000)
				DECLARE			@MaxMPEGIEExistentID					INT
				DECLARE			@LastMPEGID								INT
				DECLARE			@TotalSDBSystemsNeedingAttention		INT
				DECLARE			@LogReaderReplicationJobTypeID			INT
				DECLARE			@PublicationReplicationJobTypeID		INT
				DECLARE			@PullReplicationJobTypeID				INT
				DECLARE			@PushReplicationJobTypeID				INT
				DECLARE			@TotalSDBSystems						INT
				DECLARE			@CurrentSDBID							INT = 1
				DECLARE			@CurrentSDBSystemID						INT 
				DECLARE			@CurrentSDBSourceSystemID				INT
				DECLARE			@CurrentSDBSourceSystemName				VARCHAR(50)
				DECLARE			@CurrentRole							INT
				DECLARE			@CurrentMPEGDBName						VARCHAR(50)
				DECLARE			@CurrentJobID							UNIQUEIDENTIFIER
				DECLARE			@CurrentJobName							VARCHAR(500)
				DECLARE			@LastStepName							VARCHAR(500)
				DECLARE			@ERRNum									INT = 0


				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'GetReplicationClusterMPEGInfo First Step'

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

				SELECT			@PublicationReplicationJobTypeID		= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Publication Agent'

				SELECT			@PullReplicationJobTypeID				= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Pull Distribution Agent'

				SELECT			@PushReplicationJobTypeID				= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Push Distribution Agent'


				SELECT			@SQLReplication_JobStatus				=	N'INSERT INTO	#JobCurrentStatus ( Job_ID, Running ) ' +      
																			N'SELECT	JobID	= x.JobID, ' +
																			N'			Running = MAX(x.Running) ' +
																			N'FROM ( ' +
																			N'SELECT		a.JobID, ' +
																			N'				Running =	CASE	WHEN (sja.start_execution_date IS NOT NULL AND sja.stop_execution_date IS NOT NULL) ' +
																			N'									OR	(sja.start_execution_date IS NULL) ' +
																			N'									THEN 0 ' +
																			N'									WHEN sj.job_id IS NULL ' +		--Job does not exist
																			N'									THEN -1 ' +
																			N'									ELSE 1 ' + 
																			N'							END ' + 
																			N'FROM			DINGOSDB.dbo.ReplicationJob a WITH (NOLOCK) ' +
																			N'JOIN			DINGOSDB.dbo.ReplicationJobType b WITH (NOLOCK) ON a.ReplicationJobTypeID =  b.ReplicationJobTypeID ' +
																			N'LEFT JOIN		[TOKEN].msdb.dbo.sysjobs AS sj WITH (NOLOCK) ON a.JobID = sj.job_id ' +
																			N'LEFT JOIN		[TOKEN].msdb.dbo.sysjobactivity AS sja WITH (NOLOCK) ON sj.job_id = sja.job_id ' +
																			N'WHERE			a.ReplicationJobTypeID IN ('+CAST( @PushReplicationJobTypeID AS NVARCHAR(50))+', '+CAST( @LogReaderReplicationJobTypeID AS NVARCHAR(50))+') ' +
																			N'AND			a.JobID = sj.job_id ' +
																			N'			) x ' +
																			N'GROUP BY		x.JobID '


				IF OBJECT_ID('tempdb..#SDBJobStatus') IS NOT NULL
					DROP TABLE #SDBJobStatus
				CREATE TABLE	#SDBJobStatus 
										(
											id int identity(1,1),
											SDBSystemID int,
											TotalJobs int
										)


				IF OBJECT_ID('tempdb..#MPEGtbl') IS NOT NULL
					DROP TABLE #MPEGtbl
				CREATE TABLE	#MPEGtbl 
										(
											id int identity(1,1),
											SDBSystemID int,
											SDBSourceSystemID int,
											DBID int,
											DBName varchar(100),
											DBExists bit,
											StandbyRole bit,
											Role int
											--ReplicationJobID int,
											--ReplicationJobTypeID int
										)

				IF OBJECT_ID('tempdb..#IEtbl') IS NOT NULL
					DROP TABLE #IEtbl
				CREATE TABLE	#IEtbl 
										(
											id int identity(1,1),
											DBName varchar(100)
										)

				IF OBJECT_ID('tempdb..#SDBSystemJob') IS NOT NULL
					DROP TABLE #SDBSystemJob
				CREATE TABLE	#SDBSystemJob 
										(
											id int identity(1,1),
											SDBSystemID int,
											SDBSourceSystemID int,
											SDBSourceSystemName varchar(50),
											JobID uniqueidentifier, 
											JobName varchar(200),
											MPEGDBName varchar(100),
											Role int
										)

				IF OBJECT_ID('tempdb..#MPEGSubscriptionInfo') IS NOT NULL
					DROP TABLE #MPEGSubscriptionInfo
				CREATE TABLE	#MPEGSubscriptionInfo 
										(
											id int identity(1,1),
											SDBSystemID int,
											SDBSourceSystemID int,
											MPEGDBName varchar(100),
											DBExistent bit,
											IEExistent bit,
											Subscribed bit NULL,
											SubscriptionType int NULL,
											JobName varchar(200) NULL,
											JobEnabled bit NULL
										)


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


				--				Get the job names and SDB systems whose replication jobs run on the SDBs.
				INSERT			#SDBSystemJob 
										(
											SDBSystemID,
											SDBSourceSystemID,
											SDBSourceSystemName,
											JobID,
											JobName,
											MPEGDBName,
											Role
										)
				SELECT			a.SDBSystemID,
								a.SDBSourceSystemID,
								a.SDBSourceSystemName,
								b.JobID,
								b.JobName,
								a.MPEGDBName,
								a.Role

				FROM			(
									SELECT SDBSystemID, SDBSourceSystemID, SDBSourceSystemName, MPEGDBName, Role
									FROM dbo.SDBSystem (NOLOCK)
									WHERE Role = CASE WHEN SDBState = 1 THEN 1 WHEN SDBState = 5 THEN 2 END
								) a
				JOIN			dbo.ReplicationJob b (NOLOCK)
				ON				a.SDBSystemID									= b.SDBSystemID
				WHERE			b.ReplicationJobTypeID							IN (@PushReplicationJobTypeID, @LogReaderReplicationJobTypeID)

				--				Get the total number of unprepared SDB nodes.
				SELECT			TOP 1 @TotalSDBSystems							= a.id
				FROM			#SDBSystemJob a
				ORDER BY		a.id DESC
				
				--				For each new node, create the associated job.
				WHILE			( @CurrentSDBID <= @TotalSDBSystems )
				BEGIN

								SELECT			TOP 1	
												@CurrentSDBSystemID							= a.SDBSystemID,
												@CurrentSDBSourceSystemID					= a.SDBSourceSystemID, 
												@CurrentSDBSourceSystemName					= a.SDBSourceSystemName,
												@CurrentJobID								= a.JobID,
												@CurrentJobName								= a.JobName,
												@CurrentMPEGDBName							= a.MPEGDBName,
												@CurrentRole								= a.Role
								FROM			#SDBSystemJob a 
								WHERE			a.ID										= @CurrentSDBID

								SELECT			@SQLCurrent_Replication_JobStatus			= REPLACE( @SQLReplication_JobStatus, 'TOKEN', @CurrentSDBSourceSystemName )
								SELECT			@LastStepName								= 'Get Replication Job Execution Status for SDB System: ' + @CurrentSDBSourceSystemName
								EXECUTE			sp_executesql								@SQLCurrent_Replication_JobStatus
								SELECT			@CurrentSDBID								= @CurrentSDBID + 1

				END


				--				Get the job state of the pull agent jobs that run locally.
				INSERT INTO		#JobCurrentStatus 
				EXEC			master.dbo.xp_sqlagent_enum_jobs 1, ''



				--SET				@sql = N'select database_id as databaseid, name as dbname, 0 as IEROWS from master.sys.databases where name like ''MPEG%'' ';
				--SELECT			@sql = @sql +	N'union all select ' + cast(database_id as nvarchar(10)) + N' as databaseid, ' + quotename(name,'''')+ N' as dbname, ISNULL(p.rows, 0) AS IEROWS ' + 
				--								N'from ' + quotename(name) + N'.sys.partitions p JOIN ' + quotename(name) + '.sys.indexes i ON p.object_id = i.object_id AND p.index_id = i.index_id ' + 
				--								N'where name = ''PK_IE'' '
				--FROM			sys.databases 
				--WHERE			database_id										> 1
				--AND				state											= 0
				--AND				user_access										= 0
				--AND				name like 'MPEG%'
				--SELECT			@sql = N'Select databaseid, dbname, MAX(IEROWS) as IEROWS From ( ' + @sql + N' ) x GROUP BY databaseid, dbname '

				--				Get all SDBSystems and check for the existence of MPEG[x] subscriber DB.  Also save the state or whether SDBSystem is in standby role
				INSERT			#MPEGtbl ( SDBSystemID, SDBSourceSystemID, DBID, DBName, DBExists, StandbyRole, Role )
				SELECT			SDBSystemID										= a.SDBSystemID,
								SDBSourceSystemID								= a.SDBSourceSystemID,
								DBID											= d.database_id,
								DBName											= a.MPEGDBName,
								DBExists										=	CASE	WHEN d.database_id IS NULL THEN 0 ELSE 1 END,
								StandbyRole										=	CASE	WHEN ( a.SDBState = 1 AND a.Role = 2 ) OR ( a.SDBState = 5 AND a.Role = 1 ) --MPEG IE table exists and should not
																							THEN 1
																							ELSE 0 
																					END,
								Role											= a.Role
				FROM			dbo.SDBSystem a (NOLOCK) 
				LEFT JOIN		master.sys.databases d (NOLOCK)
				ON				a.MPEGDBName									= d.name
				WHERE			a.Enabled										= 1		--SDB system enabled


				--				Update the SDBSystem table to reflect the most current information about 
				--				mpeg[x] existence
				UPDATE			dbo.SDBSystem 
				SET				DBExistence										= m.DBExists
				FROM			#MPEGtbl m
				WHERE			SDBSystem.SDBSystemID							= m.SDBSystemID 


				UPDATE			dbo.SDBSystem 
				SET				IEExistence										=	CASE	
																						WHEN SDBState = 1 AND Role = 1 AND IEExistence = 0 THEN 1
																						WHEN SDBState = 5 AND Role = 2 AND IEExistence = 0 THEN 1
																						ELSE 0
																					END
				WHERE			Enabled											= 1
				AND				(
									(
										SDBState								= 1 
										AND	Role								= 1
										AND	IEExistence							= 0
									)
								OR
									(
										SDBState								= 5 
										AND	Role								= 2
										AND	IEExistence							= 0
									)
								)


				INSERT				#SDBJobStatus ( SDBSystemID,TotalJobs )
				SELECT				SDBSystemID,
									TotalJobs									= 0
				FROM				dbo.SDBSystem WITH (NOLOCK)


				UPDATE				#SDBJobStatus
				SET					TotalJobs									= b.TotalJobs
				FROM			(
									SELECT		SDBSystemID						= x.SDBSystemID,
												TotalJobs						= COUNT(y.SDBSystemID)
									FROM		dbo.SDBSystem x
									JOIN		dbo.ReplicationJob y (NOLOCK)
									ON			x.SDBSystemID					= y.SDBSystemID
									GROUP BY	x.SDBSystemID
								) b
				WHERE			#SDBJobStatus.SDBSystemID						= b.SDBSystemID


				--				Update the SDBSystem table to reflect the status of replication in general
				UPDATE			dbo.SDBSystem 
				SET				Subscribed										=	CASE	
																						WHEN SubscriptionType = 'Push' AND b.TotalJobs >= 2 THEN 1 
																						WHEN SubscriptionType = 'Pull' AND b.TotalJobs >= 3 THEN 1 
																						WHEN b.SDBSystemID IS NULL THEN 0
																						ELSE 0 
																					END
				FROM			#SDBJobStatus b
				--FROM			(
				--					SELECT		SDBSystemID						= x.SDBSystemID,
				--								TotalJobs						= COUNT(y.SDBSystemID)
				--					FROM		dbo.SDBSystem x
				--					LEFT JOIN	dbo.ReplicationJob y (NOLOCK)
				--					ON			x.SDBSystemID					= y.SDBSystemID
				--					--WHERE		y.ReplicationJobTypeID			IS NOT NULL
				--					GROUP BY	x.SDBSystemID
				--				) b
				WHERE			SDBSystem.SDBSystemID							= b.SDBSystemID 


				--				Update the SDBSystem table to reflect the status of replication in general
				UPDATE			dbo.ReplicationJob 
				SET				JobExecutionStatus								= x.Running
				FROM			(
									SELECT		a.ReplicationJobID, a.JobID, c.Running
									FROM		dbo.ReplicationJob a (NOLOCK)
									JOIN		#JobCurrentStatus c
									ON			a.JobID							= c.Job_ID
									WHERE		a.ReplicationJobTypeID			IN ( @PushReplicationJobTypeID, @PullReplicationJobTypeID, @LogReaderReplicationJobTypeID )
								) x
				WHERE			ReplicationJob.ReplicationJobID					= x.ReplicationJobID

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'GetReplicationClusterMPEGInfo Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'GetReplicationClusterMPEGInfo Fail Step'

				IF				( @EventLogStatusID IS NOT NULL )
				BEGIN
								EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @LastStepName
				END				
			

/*

				--				Check for the existence of table mpeg[x].dbo.IE for mpeg[x] databases that should be empty
				SELECT			@sql =			N'select ' + quotename(m.DBName,'''') + N' as DBName ' + 
												N'from ' + quotename(m.DBName) + N'.sys.tables WITH (NOLOCK) ' + 
												N'where name = ''IE'' ' +
												CASE WHEN m.id = @LastMPEGID THEN N'' ELSE N' UNION ALL ' END
				FROM			#MPEGtbl m -- ( DBID, DBName, DBExists, StandbyRole ) dbo.SDBSystem a (NOLOCK) 
				WHERE			m.DBExists										= 1
				AND				m.StandbyRole									= 1
				ORDER BY		m.id

				--				Check for the existence of table mpeg[x].dbo.IE for existing standby mpeg[x] databases
				INSERT			#IEtbl
				EXEC			sp_executesql @sql



				SELECT			TOP 1 @LastMPEGID								= m.id
				FROM			#MPEGtbl m
				WHERE			m.DBExists										= 1
				AND				m.StandbyRole									= 1
				ORDER BY		m.id DESC


				--				Check for the existence of table mpeg[x].dbo.IE for mpeg[x] databases that should be empty
				SELECT			@sql =			N'select ' + quotename(m.DBName,'''') + N' as DBName ' + 
												N'from ' + quotename(m.DBName) + N'.sys.tables WITH (NOLOCK) ' + 
												N'where name = ''IE'' ' +
												CASE WHEN m.id = @LastMPEGID THEN N'' ELSE N' UNION ALL ' END
				FROM			#MPEGtbl m -- ( DBID, DBName, DBExists, StandbyRole ) dbo.SDBSystem a (NOLOCK) 
				WHERE			m.DBExists										= 1
				AND				m.StandbyRole									= 1
				ORDER BY		m.id

				--				Check for the existence of table mpeg[x].dbo.IE for existing standby mpeg[x] databases
				INSERT			#IEtbl
				EXEC			sp_executesql @sql



				--				Insert the SDBSystems whose MPEG IE table exists and should not
				INSERT			#SDBSystems ( SDBSystemID, SDBSourceSystemID, MPEGDBName, DBExists, Role )
				SELECT			SDBSystemID										= a.SDBSystemID,
								SDBSourceSystemID								= a.SDBSourceSystemID,
								MPEGDBName										= a.DBName,
								DBExists										= 1,
								Role											= a.Role
				FROM			#MPEGtbl a 
				LEFT JOIN		#IEtbl b
				ON				a.DBName										= b.DBName
				WHERE			a.DBExists										= 1
				AND				b.id											IS NOT NULL


				--				This is actually being used to get the last ID in temp table #SDBSystems because
				--				using SCOPE_IDENTITY() will yield a value of 1 when NOTHING gets inserted in a table.
				SELECT			@MaxMPEGIEExistentID							= @@ROWCOUNT		


				--				Insert the backup SDBSystems who have missing replication elements
				INSERT			#SDBSystems ( SDBSystemID, SDBSourceSystemID, MPEGDBName, DBExists, Role )
				SELECT			SDBSystemID										= a.SDBSystemID,
								SDBSourceSystemID								= a.SDBSourceSystemID,
								MPEGDBName										= a.DBName,
								DBExists										= a.DBExists,
								Role											= a.Role
				FROM			#MPEGtbl a
				LEFT JOIN		(
									SELECT		SDBSystemID						= x.SDBSystemID,
												TotalJobs						= COUNT(1)
									FROM		dbo.ReplicationJob x (NOLOCK)
									GROUP BY	x.SDBSystemID
								) b
				ON				a.SDBSystemID									= b.SDBSystemID
				WHERE			a.Role											= 2
				AND			(
									a.DBExists									= 0			--mpeg db doesn't exist
								OR	b.ReplicationJobID 							IS NULL		--subscription doesn't exist
								OR	c.name 										IS NULL		--subscription job doesn't exist
							)
				SELECT			@TotalSDBSystemsNeedingAttention				= @MaxMPEGIEExistentID + @@ROWCOUNT


				IF				( ISNULL(@TotalSDBSystemsNeedingAttention, 0) > 0 )
				BEGIN

								INSERT			#MPEGSubscriptionInfo 
											(
												SDBSystemID,
												SDBSourceSystemID,
												MPEGDBName,
												DBExistent,
												IEExistent,
												Subscribed,
												SubscriptionType
												--JobName,
												--JobEnabled
											)
								SELECT			
												SDBSystemID										= s.SDBSystemID,
												SDBSourceSystemID								= s.SDBSourceSystemID,
												MPEGDBName										= s.MPEGDBName,
												DBExistent										= s.DBExists,
												IEExistent										= CASE WHEN s.id <= @MaxMPEGIEExistentID THEN 1 ELSE 0 END,
												Subscribed										= CASE WHEN b.SDBSystemID IS NOT NULL THEN 1 ELSE 0 END,
												SubscriptionType								= s.Role
												--JobName											= c.name,
												--JobEnabled										= c.enabled
								FROM			#SDBSystems s
								LEFT JOIN		dbo.ReplicationJob b (NOLOCK)
								ON				s.SDBSystemID									= b.SDBSystemID
								--LEFT JOIN		msdb.dbo.sysjobs c (NOLOCK)
								--ON				b.JobID											= c.job_id

								UPDATE			dbo.SDBSystem 
								SET				--DBExistence										= r.DBExistent,
												IEExistence										= r.IEExistent,
												Subscribed										= r.Subscribed,
												SubscriptionType								= CASE WHEN r.SubscriptionType = 1 THEN 'Push' ELSE 'Pull' END
								FROM			#MPEGSubscriptionInfo r
								WHERE			SDBSystem.SDBSourceSystemID						= r.SDBSourceSystemID
								AND				SDBSystem.MPEGDBName							= r.MPEGDBName

				END


*/

				DROP TABLE #SDBJobStatus
				DROP TABLE #MPEGtbl
				DROP TABLE #IEtbl
				DROP TABLE #SDBSystemJob
				DROP TABLE #MPEGSubscriptionInfo

				

END



GO


/****** Object:  StoredProcedure [dbo].[GetSDBInfo]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSDBInfo]
				@ReplicationClusterID						INT
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
// Module:  dbo.GetSDBInfo
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the latest SDB info from DINGODB.  SDBStatus as well as NEW SDB systems.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.GetSDBInfo.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				EXEC		DINGOSDB.dbo.GetSDBInfo	
//								@ReplicationClusterID						= 1
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@i 											INT = 1
				DECLARE			@SQLCMD										NVARCHAR(500)
				DECLARE			@Results									TABLE (id int identity(1,1), SDBSourceSystemID int, SDBState int, NewNode int)

				INSERT			@Results ( SDBSourceSystemID, SDBState, NewNode )
				SELECT			SDBSourceSystemID							= b.SDBSourceSystemID,
								SDBState									= a.SDBStatus,
								NewNode										= CASE WHEN c.SDBSystemID IS NULL THEN 1 ELSE 0 END
				FROM			[DINGODB_HOST].DINGODB.dbo.SDBSource a WITH (NOLOCK)
				JOIN			[DINGODB_HOST].DINGODB.dbo.SDBSourceSystem b WITH (NOLOCK)
				ON				a.SDBSourceID								= b.SDBSourceID
				LEFT JOIN		dbo.SDBSystem c WITH (NOLOCK)
				ON				b.SDBSourceSystemID							= c.SDBSourceSystemID
				WHERE			a.ReplicationClusterID						= @ReplicationClusterID
				AND				b.Enabled									= 1
				--AND				c.Enabled									= 1


				--				Update the dbo.SDBSystem table with the latest value of SDBState (1 or 5)
				UPDATE			dbo.SDBSystem
				SET				SDBState									= r.SDBState,
								UpdateDate									= GETUTCDATE()
				FROM			@Results r
				WHERE			SDBSystem.SDBSourceSystemID					= r.SDBSourceSystemID
				AND				r.NewNode									= 0


				--				Insert any new nodes into the dbo.SDBSystem table
				INSERT			dbo.SDBSystem 
							(
								SDBSourceID,
								SDBSourceSystemID,
								SDBSourceName,
								SDBSourceSystemName,
								SDBState,
								Role,
								MPEGDBName,
								Description,
								DBExistence,
								IEExistence,
								Subscribed,
								SubscriptionType,
								Enabled,
								CreateDate,
								UpdateDate
							)
				--OUTPUT			INSERTED.SDBSourceSystemID,
				--				INSERTED.SDBSourceSystemName,
				--				INSERTED.SDBState,
				--				INSERTED.Role,
				--				INSERTED.MPEGDBName
				--INTO			#NewSDBSystems
				SELECT			
								SDBSourceID									= a.SDBSourceID,
								SDBSourceSystemID							= b.SDBSourceSystemID,
								SDBSourceName								= a.SDBComputerNamePrefix,
								SDBSourceSystemName							= b.SDBComputerName,
								SDBState									= 1,	--Since this is a new SDB node, Primary will be the active SDB
								Role										= b.Role,
								MPEGDBName									= 'MPEG' + CAST( b.SDBSourceSystemID AS VARCHAR(50) ),
								Description									= 'MPEG' + CAST( b.SDBSourceSystemID AS VARCHAR(50) ) + ' database entry.',
								DBExistence									= 0,
								IEExistence									= CASE WHEN b.Role = 1 THEN 1 ELSE 0 END,	--The primary is ready to go on NEW nodes
								Subscribed									= 0,
								SubscriptionType							= CASE WHEN b.Role = 1 THEN 'Push' ELSE 'Pull' END,
								Enabled										= b.Enabled,
								CreateDate									= GETUTCDATE(),
								UpdateDate									= GETUTCDATE()
				FROM			[DINGODB_HOST].DINGODB.dbo.SDBSource a WITH (NOLOCK)
				JOIN			[DINGODB_HOST].DINGODB.dbo.SDBSourceSystem b WITH (NOLOCK)
				ON				a.SDBSourceID								= b.SDBSourceID
				JOIN			@Results r
				ON				b.SDBSourceSystemID							= r.SDBSourceSystemID
				WHERE			a.ReplicationClusterID						= @ReplicationClusterID
				AND				r.NewNode									= 1

END



GO
/****** Object:  StoredProcedure [dbo].[GetUnpreparedSDBNodes]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUnpreparedSDBNodes]
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
// Module:  dbo.GetUnpreparedSDBNodes
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the nodes from the dbo.SDBSystem table that need to be realigned with the proper state.
//			Populates a parent temp table called #UnpreparedSDBSystems
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.GetUnpreparedSDBNodes.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGOSDB.dbo.GetUnpreparedSDBNodes	
//
*/ 
-- =============================================
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET				NOCOUNT ON;

				DECLARE			@LogReaderReplicationJobTypeID			INT
				DECLARE			@PullReplicationJobTypeID				INT
				DECLARE			@PushReplicationJobTypeID				INT


				SELECT			@LogReaderReplicationJobTypeID			= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Log Reader Agent'

				SELECT			@PullReplicationJobTypeID				= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Pull Distribution Agent'

				SELECT			@PushReplicationJobTypeID				= ReplicationJobTypeID 
				FROM			dbo.ReplicationJobType (NOLOCK)
				WHERE			Description								= 'Push Distribution Agent'



				--				Populate temp table with the SDBs that have replication jobs but whose destination subscription db does not exist
				INSERT			#UnpreparedSDBSystems
							(	
								SDBSystemID,
								SDBSourceSystemID,
								SDBSourceSystemName,
								SDBState,
								Role,
								MPEGDBName,
								Reason
							)
				SELECT			
								a.SDBSystemID,
								a.SDBSourceSystemID,
								a.SDBSourceSystemName,
								a.SDBState,						--This is a field that can change at any time
								a.Role,
								a.MPEGDBName,
								'Create MPEG DB'
				FROM			dbo.SDBSystem a (NOLOCK)
				WHERE			a.Enabled																			= 1
				AND				a.DBExistence																		= 0


				--				Populate temp table with the SDBs whose MPEG DBs need to be dropped and recreated because they are now in a standby state
				INSERT			#UnpreparedSDBSystems
							(	
								SDBSystemID,
								SDBSourceSystemID,
								SDBSourceSystemName,
								SDBState,
								Role,
								MPEGDBName,
								Reason
							)
				SELECT			
								a.SDBSystemID,
								a.SDBSourceSystemID,
								a.SDBSourceSystemName,
								a.SDBState,
								a.Role,
								a.MPEGDBName,
								'Clean MPEG DB'
				FROM			dbo.SDBSystem a (NOLOCK)
				JOIN			(
									SELECT		SDBSourceID,
												TotalActiveSDBs														= COUNT(1)
									FROM		dbo.SDBSystem x (NOLOCK)
									WHERE		x.IEExistence														= 1
									GROUP BY	x.SDBSourceID
									HAVING		COUNT(1)															= 2
								) b
				ON				a.SDBSourceID																		= b.SDBSourceID
				WHERE			a.Enabled																			= 1
				AND				a.DBExistence																		= 1
				AND				a.IEExistence																		= 1				--IE table exists
				AND				(
									(
										a.SDBState																	= 1 
										AND	a.Role																	= 2
									)
								OR
									(
										a.SDBState																	= 5 
										AND	a.Role																	= 1
									)
								)


				--				Populate temp table with the SDBs that have replication jobs but whose SDB state are now in the standby state
				INSERT			#UnpreparedSDBSystems
							(	
								SDBSystemID,
								SDBSourceSystemID,
								SDBSourceSystemName,
								SDBState,
								Role,
								MPEGDBName,
								Reason
							)
				SELECT			
								a.SDBSystemID,
								a.SDBSourceSystemID,
								a.SDBSourceSystemName,
								a.SDBState,
								a.Role,
								a.MPEGDBName,
								'Deactivate SDB'
				FROM			dbo.SDBSystem a (NOLOCK)
				WHERE			a.Enabled																			= 1
				AND				a.Role																				= CASE WHEN a.SDBState = 1 THEN 2 WHEN a.SDBState = 5 THEN 1 END
				AND				a.Subscribed																		= 1


				--				Populate temp table with the backup SDBs that DO NOT have replication jobs but whose SDB state is in active state
				INSERT			#UnpreparedSDBSystems
							(	
								SDBSystemID,
								SDBSourceSystemID,
								SDBSourceSystemName,
								SDBState,
								Role,
								MPEGDBName,
								Reason
							)
				SELECT			
								a.SDBSystemID,
								a.SDBSourceSystemID,
								a.SDBSourceSystemName,
								a.SDBState,
								a.Role,
								a.MPEGDBName,
								'Activate SDB'
				FROM			dbo.SDBSystem a (NOLOCK)
				WHERE			a.Enabled																			= 1
				AND				a.Role																				= CASE WHEN a.SDBState = 1 THEN 1 WHEN a.SDBState = 5 THEN 2 END
				AND				a.Subscribed																		= 0


				--				Populate temp table with new SDBs that need either the entire replication installed or simply a component
				INSERT			#UnpreparedSDBSystems
							(	
								SDBSystemID,
								SDBSourceSystemID,
								SDBSourceSystemName,
								SDBState,
								Role,
								MPEGDBName,
								Reason
							)
				SELECT			
								a.SDBSystemID,
								a.SDBSourceSystemID,
								a.SDBSourceSystemName,
								a.SDBState,
								a.Role,
								a.MPEGDBName,
								'Create SDB Replication Components'
				FROM			dbo.SDBSystem a (NOLOCK)
				WHERE			a.Enabled																			= 1
				AND				a.Role																				= CASE WHEN a.SDBState = 1 THEN 1 WHEN a.SDBState = 5 THEN 2 END
				AND				a.Subscribed																		= 0

				--				Populate temp table with SDBs that have replication jobs but need to be [re]started.
				INSERT			#UnpreparedSDBSystems
							(	
								SDBSystemID,
								SDBSourceSystemID,
								SDBSourceSystemName,
								SDBState,
								JobID,
								JobName,
								JobType,
								Role,
								MPEGDBName,
								Reason
							)
				SELECT			
								a.SDBSystemID,
								a.SDBSourceSystemID,
								a.SDBSourceSystemName,
								a.SDBState,
								b.JobID,
								b.JobName,
								b.ReplicationJobTypeID AS JobType,
								a.Role,
								a.MPEGDBName,
								'Start Replication Job Components'
				FROM			dbo.SDBSystem a (NOLOCK)
				JOIN			dbo.ReplicationJob b (NOLOCK)
				ON				a.SDBSystemID																		= b.SDBSystemID
				WHERE			a.Enabled																			= 1
				AND				a.Subscribed																		= 1
				AND				b.JobExecutionStatus																= 0
				AND				b.ReplicationJobTypeID																IN ( @PushReplicationJobTypeID, @PullReplicationJobTypeID, @LogReaderReplicationJobTypeID )


END



GO
/****** Object:  StoredProcedure [dbo].[SetBackupSDBReplication]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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

				----				Set the Publication Job.
				--IF				( @SQLCMDSetPublicationJob IS NOT NULL)
				--BEGIN
				--				EXECUTE			sp_executesql	@SQLCMDSetPublicationJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
				--				SELECT			@ERROR					= @@ERROR,
				--								@LastStepName			= 'Publication Job - ' + CASE WHEN @EnabledValue = 1 THEN 'Enable' ELSE 'Disable' END,
				--								@ErrNum					= ERROR_NUMBER(), 
				--								@ErrMsg					= ERROR_MESSAGE()
				--				--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				--END

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







				--				THIS SECTION HAS BEEN DISABLED DUE TO AN ISSUE WITH LINKED SERVER CONFIGURATION AND TRANSACTIONS
				--				"...unable to begin a distributed transaction.."

				--				Attempt to stop jobs ONLY if Backup SDB role is backup
				--				Also, get the information job status information in order to stop jobs.
				IF				( @EnabledValue = 0 AND 1 = 0 )
				BEGIN

								EXECUTE			sp_executesql	@SQLCMDGetCurrentJobStatus
								SELECT			@LastStepName							= '@SQLCMDSetPublicationJob'

								INSERT INTO		#JobCurrentStatus 
								EXEC			master.dbo.xp_sqlagent_enum_jobs 1, ''


								SELECT			@LogReaderJobStatus						= a.Running
								FROM			#JobCurrentStatus a
								WHERE			Job_ID									= @LogReaderJobID

								SELECT			@PublicationJobStatus					= a.Running
								FROM			#JobCurrentStatus a
								WHERE			Job_ID									= @PublicationJobID

								SELECT			@PullJobStatus							= a.Running
								FROM			#JobCurrentStatus a
								WHERE			Job_ID									= @PullDistributionJobID

								--				Stop the Log Reader Job.
								IF				( @SQLCMDStopLogReaderJob IS NOT NULL AND @LogReaderJobStatus = 1)
								BEGIN
												EXECUTE			sp_executesql	@SQLCMDStopLogReaderJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
												SELECT			@ERROR				= @@ERROR,
																@LastStepName		= '@SQLCMDStopLogReaderJob'
												--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
								END

								--				Stop the Publication Job.
								IF				( @SQLCMDStopPublicationJob IS NOT NULL AND @PublicationJobStatus = 1)
								BEGIN
												EXECUTE			sp_executesql	@SQLCMDStopPublicationJob, @ParmDefinition, @Status = @ReturnCode OUTPUT
												SELECT			@ERROR				= @@ERROR,
																@LastStepName		= '@SQLCMDStopPublicationJob'
												--IF				(@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
								END

								--				Stop the Pull Distribution Job.
								IF				( @PullDistributionJobName IS NOT NULL AND @PullJobStatus = 1)
								BEGIN
												EXEC			msdb.dbo.sp_stop_job
																	@job_name		= @PullDistributionJobName
												SELECT			@ERROR				= @@ERROR,
																@LastStepName		= '@SQLCMDStopPullDistributionJobJob'
								END
				END

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'SetBackupSDBReplication Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'SetBackupSDBReplication Fail Step'
				
				SET				@Msg			= @LastStepName + ': ' + ISNULL(@ErrMsg , '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg

				DROP TABLE		#JobCurrentStatus

END




GO
/****** Object:  StoredProcedure [dbo].[UpsertReplicationJob]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpsertReplicationJob]
		@SDBSystemID				INT,
		@SDBName					VARCHAR(100),
		@ReplicationJobTypeID		INT,
		@JOBID						UNIQUEIDENTIFIER, 
		@JOBName					VARCHAR(200), 
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
// Module:  dbo.UpsertReplicationJob
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Saves the job information for a given SDB node and replication type job. 
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.UpsertReplicationJob.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE	@ERROROUT INT
//				EXEC	DINGOSDB.dbo.UpsertReplicationJob	
//								@SDBSystemID				= 1,
//								@SDBName					= 'MSSNKNLSDB001B', 
//								@ReplicationJobTypeID		= 1,
//								@JOBID						= '',
//								@JOBName					= '',
//								@ERROR						= @ERROROUT OUTPUT
//
*/ 
-- =============================================
BEGIN


			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			SET NOCOUNT ON;
							
			IF			EXISTS( SELECT TOP 1 1 FROM dbo.SDBSystem WHERE SDBSystemID = @SDBSystemID )
			BEGIN

						MERGE			dbo.ReplicationJob						AS target
						USING		(	SELECT 
													@SDBSystemID,
													@SDBName,
													@ReplicationJobTypeID,
													@JOBID, 
													@JOBName, 
													GETUTCDATE(),
													GETUTCDATE()
									)											AS	source 
									(
													SDBSystemID,
													JobServer,
													ReplicationJobTypeID,
													JobID,
													JobName,
													CreateDate,
													UpdateDate
									)
						ON			(
										target.SDBSystemID						= source.SDBSystemID
										AND target.ReplicationJobTypeID			= source.ReplicationJobTypeID
									)
						WHEN MATCHED THEN UPDATE 
										SET JobServer							= source.JobServer,
											ReplicationJobTypeID				= source.ReplicationJobTypeID,
											JobID								= source.JobID,
											JobName								= source.JobName,
											UpdateDate							= source.UpdateDate

						WHEN NOT MATCHED THEN INSERT 
									(
											SDBSystemID,
											JobServer,
											ReplicationJobTypeID,
											JobID,
											JobName,
											CreateDate,
											UpdateDate
									)
						VALUES	
									(
											source.SDBSystemID,	
											source.JobServer,
											source.ReplicationJobTypeID,
											source.JobID,
											source.JobName,
											source.CreateDate,
											source.UpdateDate
									);

			END

			SET			@ERROR								= 0



END

GO



/****** Object:  UserDefinedFunction [dbo].[DeriveDBPrefix]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LogEvent]
		@LogID					INT					= NULL,
		@EventLogStatusID		INT					= NULL,
		@JobID					UNIQUEIDENTIFIER	= NULL,
		@JobName				VARCHAR(200)		= NULL,
		@DBID					INT					= NULL,
		@DBComputerName			VARCHAR(50)			= NULL,
		@Description			VARCHAR(200)		= NULL,
		@LogIDOUT				INT					= NULL OUTPUT
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
// Created: 2014-Jul-20
// Author:  Tony Lew
// 
// Purpose: Interface to the DINGOSDB EventLog for universal logging.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.LogEvent.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @LogIDReturn INT
//				EXEC	dbo.LogEvent 
//							@LogID					= NULL,
//							@EventLogStatusID		= 1,
//							@JobID					= NULL,
//							@JobName				= NULL,
//							@DBID					= NULL,
//							@DBComputerName			= NULL,
//							@LogIDOUT				= @LogIDReturn OUTPUT
//				
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@ComputerName	VARCHAR(50)

		IF (@EventLogStatusID IS NULL AND @LogID IS NULL) RETURN	--Nothing to log

		IF (@LogID IS NULL)
		BEGIN
					INSERT		dbo.EventLog
								(
									EventLogStatusID,
									JobID,
									JobName,
									DBID,
									DBComputerName,
									StartDate
								)
					SELECT 
									@EventLogStatusID		AS EventLogStatusID,
									@JobID					AS JobID,
									@JobName				AS JobName,
									@DBID					AS DBID,
									@DBComputerName			AS DBComputerName,
									GETUTCDATE()			AS StartDate

					SELECT		@LogIDOUT = @@IDENTITY
		END		
		ELSE
		BEGIN
					UPDATE		dbo.EventLog
					SET			FinishDate					= GETUTCDATE(),
								EventLogStatusID			= ISNULL(@EventLogStatusID, EventLogStatusID),
								Description					= @Description
					WHERE		EventLogID					= @LogID
		END


END

GO


/****** Object:  UserDefinedFunction [dbo].[DeriveDBPrefix]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[DeriveDBPrefix] ( @str VARCHAR(50), @token VARCHAR(5) )
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
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DeriveDBPrefix.fn.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//	 Usage:
//				DECLARE			@str VARCHAR(50) = 'MSSNKNSDBP033'
//				DECLARE			@token VARCHAR(5) = 'p'
//				SELECT			dbo.DeriveDBPrefix	( @str, @token )
//
*/ 
BEGIN

		DECLARE		@strret VARCHAR(50)
		DECLARE		@ipos INT = CHARINDEX(@token,REVERSE(@str),1)
		SELECT		@strret = SUBSTRING(@str, 1, LEN(@str)- @ipos) +  CAST( SUBSTRING(@str, LEN(@str)-@ipos+2, LEN(@str) ) AS VARCHAR(50) ) 
		RETURN		(@strret)

END
GO






/****** Object:  StoredProcedure [dbo].[MaintenanceBackupFull]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceBackupFull]
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
// Purpose: Perform Full Backup of DINGOSDB Database to BackUpPathName Supplied.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.MaintenanceBackupFull.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/
BEGIN


			DECLARE		@BackUpDestination			VARCHAR(100)
			DECLARE		@UTCNow						DATETIME = GETUTCDATE()
			DECLARE		@UTCNowYear					CHAR(4)
			DECLARE		@UTCNowMonth				CHAR(2)
			DECLARE		@UTCNowDay					CHAR(2)
			DECLARE		@UTCNowMinute				CHAR(2)
			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		@ErrorID					= 1
			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupFull First Step'
			EXEC		DINGOSDB.dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			SELECT		@UTCNowYear					= DATEPART(Year, @UTCNow),
						@UTCNowMonth				= DATEPART(Month, @UTCNow),
						@UTCNowDay					= DATEPART(Day, @UTCNow),
						@UTCNowMinute				= DATEPART(Minute, @UTCNow)
			SELECT		@UTCNowMonth				= CASE WHEN LEN(@UTCNowMonth) = 1 THEN '0' + @UTCNowMonth ELSE @UTCNowMonth END,
						@UTCNowDay					= CASE WHEN LEN(@UTCNowDay) = 1 THEN '0' + @UTCNowDay ELSE @UTCNowDay END,
						@UTCNowMinute				= CASE WHEN LEN(@UTCNowMinute) = 1 THEN '0' + @UTCNowMinute ELSE @UTCNowMinute END

			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOSDB.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'

			BACKUP DATABASE DINGOSDB
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			DECLARE @DeleteDate DATETIME 			= DATEADD(D, -7, GETDATE())
			EXECUTE master.dbo.xp_delete_file		0, @BackUpPathName, N'Full.bak', @DeleteDate, 1


			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupFull Success Step'
			EXEC		DINGOSDB.dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL
			SELECT		@ErrorID					= 0


END




GO
/****** Object:  StoredProcedure [dbo].[MaintenanceBackupTransactionLog]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceBackupTransactionLog]
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
// Purpose: Perform Backup of DINGOSDB Log to BackUpPathName Supplied.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.MaintenanceBackupTransactionLog.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/
BEGIN
			DECLARE		@BackUpDestination			VARCHAR(100)
			DECLARE		@UTCNow						DATETIME = GETUTCDATE()
			DECLARE		@UTCNowYear					CHAR(4)
			DECLARE		@UTCNowMonth				CHAR(2)
			DECLARE		@UTCNowDay					CHAR(2)
			DECLARE		@UTCNowHour					CHAR(2)
			DECLARE		@UTCNowMinute				CHAR(2)


			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		@ErrorID					= 1
			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupTransactionLog First Step'
			EXEC		DINGOSDB.dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			SELECT		@UTCNowYear					= DATEPART(Year, @UTCNow),
						@UTCNowMonth				= DATEPART(Month, @UTCNow),
						@UTCNowDay					= DATEPART(Day, @UTCNow),
						@UTCNowHour					= DATEPART(Hour, @UTCNow),
						@UTCNowMinute				= DATEPART(Minute, @UTCNow)
			SELECT		@UTCNowMonth				= CASE WHEN LEN(@UTCNowMonth) = 1 THEN '0' + @UTCNowMonth ELSE @UTCNowMonth END,
						@UTCNowDay					= CASE WHEN LEN(@UTCNowDay) = 1 THEN '0' + @UTCNowDay ELSE @UTCNowDay END,
						@UTCNowHour					= CASE WHEN LEN(@UTCNowHour) = 1 THEN '0' + @UTCNowHour ELSE @UTCNowHour END,
						@UTCNowMinute				= CASE WHEN LEN(@UTCNowMinute) = 1 THEN '0' + @UTCNowMinute ELSE @UTCNowMinute END
			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOSDB.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'

			BACKUP LOG DINGOSDB
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			DECLARE @DeleteDate DATETIME 			= DATEADD(D, -2, GETDATE())
			EXECUTE master.dbo.xp_delete_file		0, @BackUpPathName, N'Log.bak', @DeleteDate, 1

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupTransactionLog Success Step'
			EXEC		DINGOSDB.dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL
			SELECT		@ErrorID					= 0


END




GO
/****** Object:  StoredProcedure [dbo].[MaintenanceCleanup]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceCleanup]
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
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.MaintenanceCleanup.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN


			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

/*

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceCleanup First Step'
			EXEC		DINGOSDB.dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			DELETE FROM EVENTLOG WHERE StartDate <= CAST(DATEADD(D, -2, GETUTCDATE()) AS DATE)

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceCleanup Success Step'
			EXEC		DINGOSDB.dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL

*/

END




GO
/****** Object:  StoredProcedure [dbo].[MaintenanceDBIntegrity]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceDBIntegrity]
		@ErrorID				INT OUTPUT
AS
-- =============================================
-- Author:		TXL
-- Create date: 2013-10-01
-- Description:	Checks DB Integrity.  Use EXEC xp_readerrorlog to see the results.
--				
--				DECLARE		@ErrNum			INT
--				EXEC		dbo.MaintenanceDBIntegrity 
--								@ErrorID			= @ErrNum OUTPUT
--				SELECT		@ErrNum
--
-- Updates:
-- =============================================
BEGIN


			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity First Step'
			EXEC		DINGOSDB.dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			DBCC CHECKDB ('DINGOSDB') 

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity Success Step'
			EXEC		DINGOSDB.dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL



END



GO
/****** Object:  StoredProcedure [dbo].[MaintenanceRebuildIndex]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceRebuildIndex]
		@ErrorID				INT OUTPUT
AS
-- =============================================
-- Author:		TXL
-- Create date: 2013-10-01
-- Description:	Rebuilds indices for all tables so that they are contiguous.
--
--				Use the following in order to see the results.
--				SELECT 'FULL', 'ON', 
--					MAX([Log Record Length]), 
--					SUM([Log Record Length]), 
--					COUNT(*), 
--					(SELECT COUNT(*) FROM fn_dblog(null, null) WHERE [Log Record Length]  > 8000) 
--					FROM fn_dblog(null, null); 
--				
--				DECLARE		@ErrNum			INT
--				EXEC		dbo.MaintenanceRebuildIndex 
--								@ErrorID			= @ErrNum OUTPUT
--				SELECT		@ErrNum
--
-- Updates:
-- =============================================
BEGIN

			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SET NOCOUNT ON;

			DECLARE		@TableName										VARCHAR(255)
			DECLARE		@CMD											NVARCHAR(500)
			DECLARE		@fillfactor										INT = 80
			DECLARE		@LogIDReturn									INT
			DECLARE		@ErrNum											INT
			DECLARE		@ErrMsg											VARCHAR(200)
			DECLARE		@EventLogStatusID								INT
			DECLARE		@ParmDefinition									NVARCHAR(500)
			DECLARE		@DatabaseID										INT
			--DECLARE		TableCursor					CURSOR FOR
			--SELECT		OBJECT_SCHEMA_NAME([object_id])+'.'+name AS TableName
			--FROM		sys.tables
			DECLARE		TableCursor										CURSOR FOR
			SELECT		'DINGOSDB.' + OBJECT_SCHEMA_NAME( [object_id], DB_ID('DINGOSDB') )+'.'+name AS TableName, *
			FROM		DINGOSDB.sys.tables

			SELECT		@DatabaseID										= DB_ID()

			OPEN		TableCursor
			FETCH NEXT FROM TableCursor INTO @TableName
			WHILE		@@FETCH_STATUS = 0
			BEGIN
						SELECT			TOP 1 @EventLogStatusID			= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceRebuildIndex First Step'

						EXEC			DINGOSDB.dbo.LogEvent 
											@LogID						= NULL,
											@EventLogStatusID			= @EventLogStatusID,
											@JobID						= NULL,
											@JobName					= NULL,
											@DBID						= @DatabaseID,
											@DBComputerName				= @@SERVERNAME,
											@LogIDOUT					= @LogIDReturn OUTPUT

						SET				@CMD							= 'ALTER INDEX ALL ON ' + @TableName + ' REBUILD WITH ( FILLFACTOR = ' + CONVERT(VARCHAR(3),@fillfactor) + ', ONLINE = ON ) '
						EXECUTE			sp_executesql					@CMD
						SELECT			TOP 1 @EventLogStatusID			= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceRebuildIndex Success Step'
						EXEC			DINGOSDB.dbo.LogEvent @LogID		= @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @CMD

						FETCH NEXT FROM TableCursor INTO @TableName
			END
			CLOSE		TableCursor
			DEALLOCATE	TableCursor

END

GO




/****** Object:  StoredProcedure [dbo].[CreateMaintenanceJobs]    Script Date: 11/25/2013 7:34:11 PM ******/

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
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates DB Maintenance Jobs
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateMaintenanceJobs.proc.sql 4049 2014-04-29 15:50:41Z nbrownett $
//    
//	 Usage:
//
//				EXEC	DINGOSDB.dbo.CreateMaintenanceJobs	
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
							@StepCommand 						= N'EXEC	DINGOSDB.dbo.MaintenanceBackupFull ' + ISNULL('@BackUpPathName = ''' + @BackUpPathNameFull + ''' ','')

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
							@StepCommand 						= N'EXEC	DINGOSDB.dbo.MaintenanceBackupTransactionLog ' + ISNULL('@BackUpPathName = ''' + @BackUpPathNameTranLog + ''' ',''),
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
							@StepCommand 						= N'EXEC	DINGOSDB.dbo.MaintenanceCleanup ',
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
							@StepCommand 						= N'EXEC	DINGOSDB.dbo.MaintenanceDBIntegrity ',
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
							@StepCommand 						= N'EXEC	DINGOSDB.dbo.MaintenanceRebuildIndex ',
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



CREATE TABLE [dbo].[EventLogStatusType](
	[EventLogStatusTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EventLogStatusType] PRIMARY KEY CLUSTERED 
(
	[EventLogStatusTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'EventLogStatusTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of status type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[EventLogStatusType] ADD  CONSTRAINT [DF_EventLogStatusType_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[EventLogStatusType] ADD  CONSTRAINT [DF_EventLogStatusType_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO



CREATE TABLE [dbo].[EventLogStatus](
	[EventLogStatusID] [int] IDENTITY(1,1) NOT NULL,
	[EventLogStatusTypeID] [int] NOT NULL,
	[SP] [varchar](100) NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EventLogStatus] PRIMARY KEY CLUSTERED 
(
	[EventLogStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'EventLogStatusID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'FK to EventLogStatusType table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'EventLogStatusTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

--ALTER TABLE [dbo].[EventLogStatus]  DROP  CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID]
ALTER TABLE [dbo].[EventLogStatus]  WITH CHECK ADD  CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID] FOREIGN KEY([EventLogStatusTypeID])
REFERENCES [dbo].[EventLogStatusType] ([EventLogStatusTypeID])
GO

ALTER TABLE [dbo].[EventLogStatus] CHECK CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID]
GO

ALTER TABLE [dbo].[EventLogStatus] ADD  CONSTRAINT [DF_EventLogStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[EventLogStatus] ADD  CONSTRAINT [DF_EventLogStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO




CREATE TABLE [dbo].[EventLog](
	[EventLogID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [uniqueidentifier] NULL,
	[JobName] [varchar](200) NULL,
	[DBID] [int] NULL,
	[DBComputerName] [varchar](32) NULL,
	[EventLogStatusID] [int] NOT NULL,
	[Description] [varchar](200) NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishDate] [datetime] NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[EventLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for an event.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'EventLogID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL Job Unique Identifier.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'JobID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL Job name.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'Jobname'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB database ID.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'DBID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB database computer name.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'DBComputerName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Event log status identifier.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'EventLogStatusID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Event log event description.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', 
				@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'StartDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', 
				@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'FinishDate'
GO

--ALTER TABLE [dbo].[EventLog]  DROP  CONSTRAINT [FK_EventLog_EventLogStatusID_-->_EventLogStatus_EventLogStatusID] 
ALTER TABLE [dbo].[EventLog]  WITH CHECK ADD  CONSTRAINT [FK_EventLog_EventLogStatusID_-->_EventLogStatus_EventLogStatusID] FOREIGN KEY([EventLogStatusID])
REFERENCES [dbo].[EventLogStatus] ([EventLogStatusID])
GO

ALTER TABLE [dbo].[EventLog] CHECK CONSTRAINT [FK_EventLog_EventLogStatusID_-->_EventLogStatus_EventLogStatusID]
GO






/****** Object:  Table [dbo].[MPEGArticle]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[MPEGArticle](
	[MPEGArticleID] [int] IDENTITY(1,1) NOT NULL,
	[CMD] [nvarchar](max) NOT NULL,
	[CMDType] [varchar](100) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[MPEGArticle] ADD [CMDParam] [varchar](500) NULL
 CONSTRAINT [PK_MPEGArticle] PRIMARY KEY CLUSTERED 
(
	[MPEGArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ReplicationJob]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ReplicationJob](
	[ReplicationJobID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSystemID] [int] NOT NULL,
	[JobServer] [varchar](200) NOT NULL,
	[ReplicationJobTypeID] [int] NOT NULL,
	[JobID] [uniqueidentifier] NULL,
	[JobName] [varchar](200) NULL,
	[JobEnabled] [bit] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[JobExecutionStatus] [int] NULL,
 CONSTRAINT [PK_ReplicationJob] PRIMARY KEY CLUSTERED 
(
	[ReplicationJobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ReplicationJobType]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReplicationJobType](
	[ReplicationJobTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ReplicationJobType] PRIMARY KEY CLUSTERED 
(
	[ReplicationJobTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SDBSystem]    Script Date: 3/31/2014 7:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SDBSystem](
	[SDBSystemID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBSourceSystemID] [int] NOT NULL,
	[SDBSourceName] [varchar](50) NOT NULL,
	[SDBSourceSystemName] [varchar](50) NOT NULL,
	[SDBState] [int] NOT NULL,
	[Role] [int] NOT NULL,
	[MPEGDBName] [varchar](50) NOT NULL,
	[DBExistence] [bit] NOT NULL,
	[IEExistence] [bit] NOT NULL,
	[Subscribed] [bit] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[SDBSystem] ADD [SubscriptionType] [varchar](10) NULL
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[SDBSystem] ADD [Description] [varchar](200) NULL
ALTER TABLE [dbo].[SDBSystem] ADD [Enabled] [bit] NOT NULL
ALTER TABLE [dbo].[SDBSystem] ADD [CreateDate] [datetime] NOT NULL
ALTER TABLE [dbo].[SDBSystem] ADD [UpdateDate] [datetime] NOT NULL
 CONSTRAINT [PK_SDBSystem] PRIMARY KEY CLUSTERED 
(
	[SDBSystemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [UNC_ReplicationJob_SDBSystemID_ReplicationJobTypeID]    Script Date: 3/31/2014 7:25:09 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ReplicationJob_SDBSystemID_ReplicationJobTypeID] ON [dbo].[ReplicationJob]
(
	[SDBSystemID] ASC,
	[ReplicationJobTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_SDBSystem_SDBSourceSystemID]    Script Date: 3/31/2014 7:25:09 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_SDBSystem_SDBSourceSystemID] ON [dbo].[SDBSystem]
(
	[SDBSourceSystemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_SDBSystem_SDBSourceSystemName]    Script Date: 3/31/2014 7:25:09 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_SDBSystem_SDBSourceSystemName] ON [dbo].[SDBSystem]
(
	[SDBSourceSystemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MPEGArticle] ADD  CONSTRAINT [DF_MPEGArticle_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[MPEGArticle] ADD  CONSTRAINT [DF_MPEGArticle_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ReplicationJob] ADD  CONSTRAINT [DF_ReplicationJob_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ReplicationJob] ADD  CONSTRAINT [DF_ReplicationJob_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ReplicationJobType] ADD  CONSTRAINT [DF_ReplicationJobType_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ReplicationJobType] ADD  CONSTRAINT [DF_ReplicationJobType_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_DBExistence]  DEFAULT ((0)) FOR [DBExistence]
GO
ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_IEExistence]  DEFAULT ((0)) FOR [IEExistence]
GO
ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_Subscribed]  DEFAULT ((0)) FOR [Subscribed]
GO
ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ReplicationJob]  WITH CHECK ADD  CONSTRAINT [FK_ReplicationJob_ReplicationJobTypeID_-->_ReplicationJobType_ReplicationJobTypeID] FOREIGN KEY([ReplicationJobTypeID])
REFERENCES [dbo].[ReplicationJobType] ([ReplicationJobTypeID])
GO
ALTER TABLE [dbo].[ReplicationJob] CHECK CONSTRAINT [FK_ReplicationJob_ReplicationJobTypeID_-->_ReplicationJobType_ReplicationJobTypeID]
GO
ALTER TABLE [dbo].[ReplicationJob]  WITH CHECK ADD  CONSTRAINT [FK_ReplicationJob_SDBSystemID_-->_SDBSystem_SDBSystemID] FOREIGN KEY([SDBSystemID])
REFERENCES [dbo].[SDBSystem] ([SDBSystemID])
GO
ALTER TABLE [dbo].[ReplicationJob] CHECK CONSTRAINT [FK_ReplicationJob_SDBSystemID_-->_SDBSystem_SDBSystemID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for a MPEGArticle' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'MPEGArticleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Command to execute.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'CMD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of object to create' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'CMDType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Normally used for stored procedure names.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for a ReplicationJob.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'ReplicationJobID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for an SDB system.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'SDBSystemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of system where the job runs.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobServer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Function of job used in the replication process.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'ReplicationJobTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sql Server assigned unique identifier for a job.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of job.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'State of job.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobEnabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJobType', @level2type=N'COLUMN',@level2name=N'ReplicationJobTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of replication job type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJobType', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJobType', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJobType', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for a SDBSystem' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSystemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDBSourceID from DINGOSDB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDBSourceSystemID from DINGOSDB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceSystemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB Logical Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB Physical Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceSystemName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Determines if logical SDB node is using Primary = 1 or Backup = 5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Determines if system is Primary = 1 or Backup = 2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MPEG database name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'MPEGDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Flag used to determine if the MPEG database has been created.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'DBExistence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to determine if MPEG.dbo.IE table exists.  This should not exist for stand by SDB systems.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'IEExistence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Flag to indicate whether a subscription job exists.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'Subscribed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of subscription (0 = push or 1 = pull)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SubscriptionType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description for a SDBSystem' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manual setting for availability of a SDBSystem' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'Enabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


USE [msdb]
GO

/****** Object:  Job [Check SDB Replication]    Script Date: 7/16/2014 3:41:43 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[SDB]]]    Script Date: 7/16/2014 3:41:44 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[SDB]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[SDB]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Check SDB Replication', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[SDB]', 
		--@owner_login_name=N'domain\username', 
		@job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run SP CheckSDBReplication]    Script Date: 7/16/2014 3:41:44 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run SP CheckSDBReplication', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC	DINGOSDB.dbo.CheckSDBReplication ', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


USE [master]
GO
ALTER DATABASE [DINGOSDB] SET  READ_WRITE 
GO



