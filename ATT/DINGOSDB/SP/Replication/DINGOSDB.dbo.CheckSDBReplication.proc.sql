
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.CheckSDBReplication'), 0) > 0 
	DROP PROCEDURE dbo.CheckSDBReplication
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
																SET			IEExistence								= 0,
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
																BEGIN TRY

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

																END TRY
																BEGIN CATCH
																				
																				SELECT			@LastStepName						= 'Start Job failed for SDB System: ' + @CurrentSDBSourceSystemName

																END CATCH



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
