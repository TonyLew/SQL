
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.CreateSDBPushSubscription'), 0) > 0 
	DROP PROCEDURE dbo.CreateSDBPushSubscription
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


			SET NOCOUNT ON;

			-- This script uses sqlcmd scripting variables. They are in the form
			-- $(MyVariable). For information about how to use scripting variables  
			-- on the command line and in SQL Server Management Studio, see the 
			-- "Executing Replication Scripts" section in the topic
			-- "Programming Replication Using System Stored Procedures".

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
				


			--BEGIN TRY
							
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

			--END TRY
			--BEGIN CATCH

			--				SELECT		@ERROR										= @@ERROR,
			--							@ErrNum										= ERROR_NUMBER(), 
			--							@ErrMsg										= ERROR_MESSAGE()

			--END CATCH

			IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPushSubscription Success Step'
			ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBPushSubscription Fail Step'
			
			SET				@Msg			= 'Last Step -- > ' + @LastStepName + ': ' + ISNULL(@ErrMsg , '')

			EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg


END



GO
