
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.CreateSDBPullSubscription'), 0) > 0 
	DROP PROCEDURE dbo.CreateSDBPullSubscription
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

				DECLARE			@SQLCMDDropSubscription					NVARCHAR(1000)
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


				SELECT			@SQLCMDDropSubscription					=	N'EXEC @Status			= [' + @SDBName + '].mpeg.sys.sp_dropsubscription ' +
																			N'@publication			= N''' + @publication + ''', ' +
																			N'@article				= N''all'', ' +
																			N'@subscriber			= N''' + @subscriber + ''' '

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
																

																SET				@ParmDefinition			= N'@Status INT OUTPUT'
																SELECT			@LastStepName			= 'Drop a Subscriber'
																EXECUTE			sp_executesql	
																					@SQLCMDDropSubscription, 
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
