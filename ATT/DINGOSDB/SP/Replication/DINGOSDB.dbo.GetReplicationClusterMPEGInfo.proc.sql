
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.GetReplicationClusterMPEGInfo'), 0) > 0 
	DROP PROCEDURE dbo.GetReplicationClusterMPEGInfo
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
