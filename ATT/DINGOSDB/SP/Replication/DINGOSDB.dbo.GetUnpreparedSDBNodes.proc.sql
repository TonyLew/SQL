
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.GetUnpreparedSDBNodes'), 0) > 0 
	DROP PROCEDURE dbo.GetUnpreparedSDBNodes
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
				AND				(
									(
										a.SDBState																	= 1 
										AND	a.Role																	= 1
									)
								OR
									(
										a.SDBState																	= 5 
										AND	a.Role																	= 2
									)
								)


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
