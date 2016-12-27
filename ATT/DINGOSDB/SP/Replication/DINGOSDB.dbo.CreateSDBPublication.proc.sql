
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.CreateSDBPublication'), 0) > 0 
	DROP PROCEDURE dbo.CreateSDBPublication
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
