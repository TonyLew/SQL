

Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.AddNewSDBNode'), 0) > 0 
	DROP PROCEDURE dbo.AddNewSDBNode
GO

CREATE PROCEDURE dbo.AddNewSDBNode
		@MDBName			NVARCHAR(50),
		@RegionID			INT,
		@LoginName			NVARCHAR(100),
		@LoginPWD			NVARCHAR(100)
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
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.AddNewSDBNode.proc.sql 4578 2014-07-15 21:37:46Z tlew $
//    
//	 Usage:
//
//				EXEC	dbo.AddNewSDBNode	
//								@MDBName = 'MSSNKNLMDB001P',
//								@RegionID = 1,
//								@LoginName = N'nbrownett@mcc2-lailab',
//								@LoginPWD = N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE		@i INT
				DECLARE		@NodeID INT
				DECLARE		@MDBNodeID INT
				DECLARE		@MDBSourceID INT
				DECLARE		@SDBSourceID INT
				DECLARE		@SDBComputerNamePrefix VARCHAR(50)
				DECLARE		@SDBRegionName VARCHAR(100)
				DECLARE		@SDBTotalRowsResult INT
				DECLARE		@NewSDBTotalRowsResult INT
				DECLARE		@TotalReplicationClusters INT

				IF OBJECT_ID('tempdb..#ReplClusterNodes') IS NOT NULL
					DROP TABLE #ReplClusterNodes
				CREATE TABLE #ReplClusterNodes	
							(
								ID INT IDENTITY(1,1), 
								ReplicationClusterID INT, 
								ReplicationClusterName VARCHAR(50),
								ReplicationClusterVIP VARCHAR(50),
								ModuloValue INT
							)
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


				SELECT			@MDBSourceID										= MDBSourceID,
								@MDBNodeID											= a.NodeID,
								@SDBRegionName										= b.Name
				FROM			dbo.MDBSource a (NOLOCK)
				JOIN			dbo.Region b (NOLOCK)
				ON				a.RegionID											= b.RegionID
				WHERE 			a.RegionID											= @RegionID


				--				Get all the existent SDB systems for this Region
				EXEC			dbo.GetSDBList	
										@MDBNameActive								= @MDBName,
										@TotalRows									= @SDBTotalRowsResult OUTPUT
				IF	( ISNULL(@SDBTotalRowsResult, 0) = 0) RETURN


				--				Identify the new SDB systems
				INSERT			#ResultsNew	( SDBComputerNamePrefix, SDBComputerName, Role, Status )
				SELECT			SDBComputerNamePrefix								= CASE	WHEN a.Role = 1 THEN dbo.DeriveDBPrefix ( a.SDBComputerName, 'P' )
																							ELSE dbo.DeriveDBPrefix ( a.SDBComputerName, 'B' )
																						END,
								SDBComputerName										= a.SDBComputerName,
								a.Role,
								a.Status
				FROM			(
										SELECT		PrimaryComputerName AS SDBComputerName, PRoleValue AS Role, PStatusValue AS Status
										FROM		#ResultsALLSDBLogical x
										UNION
										SELECT		BackupComputerName AS SDBComputerName, BRoleValue AS Role, BStatusValue AS Status
										FROM		#ResultsALLSDBLogical y
								) a
				LEFT JOIN		dbo.SDBSourceSystem b (NOLOCK)
				ON				a.SDBComputerName									= b.SDBComputerName
				WHERE			b.SDBSourceSystemID									IS NULL
				SELECT			@NewSDBTotalRowsResult								= @@ROWCOUNT


				SELECT			@TotalReplicationClusters							= COUNT(1) 
				FROM			dbo.ReplicationCluster a (NOLOCK)
				WHERE			a.Enabled											= 1

				IF				( @TotalReplicationClusters > 0 AND @NewSDBTotalRowsResult > 0 ) 
				BEGIN
								BEGIN TRAN

												--				If new SDB systems exist, first insert all new logical SDB nodes
												INSERT			dbo.SDBSource
															(
																MDBSourceID,
																SDBComputerNamePrefix,
																NodeID,
																JobName,
																ReplicationClusterID,
																SDBStatus
															)
												SELECT			MDBSourceID							= @MDBSourceID,
																SDBComputerNamePrefix				= a.SDBComputerNamePrefix,
																NodeID								= SUBSTRING( a.SDBComputerNamePrefix, LEN(a.SDBComputerNamePrefix)-2, LEN(a.SDBComputerNamePrefix)),
																JobName								= @SDBRegionName + ' ' + a.SDBComputerNamePrefix + ' MPEG Import',
																ReplicationClusterID				= 0,
																SDBStatus							= 1	--This is a new SDB logical node so primary is assumed to be ready.
												FROM			(
																		SELECT		SDBComputerNamePrefix
																		FROM		#ResultsNew
																		GROUP BY	SDBComputerNamePrefix
																) a


												--				Define the ReplicationCluster that will accomodate the logical SDB nodes
												UPDATE			dbo.SDBSource
												SET				ReplicationClusterID				= rc.ReplicationClusterID + 1
												FROM			dbo.ReplicationCluster rc (NOLOCK)
												WHERE			SDBSource.ReplicationClusterID		= 0
												AND				rc.ModuloValue						= SDBSourceID % @TotalReplicationClusters


												--				Now insert physical SDB systems
												INSERT			dbo.SDBSourceSystem
															(
																SDBSourceID,
																SDBComputerName,
																Role,
																Status,
																Enabled
															)
												SELECT			
																SDBSourceID							= b.SDBSourceID,
																SDBComputerName						= a.SDBComputerName,
																a.Role,
																a.Status,
																Enabled								= 1
												FROM			#ResultsNew a
												JOIN			dbo.SDBSource b (NOLOCK)
												ON				a.SDBComputerNamePrefix				= b.SDBComputerNamePrefix

								COMMIT

				END


				--				For each new node pair, prepare to create the job.
				INSERT			#ResultsNewNode ( SDBSourceID, SDBComputerNamePrefix )
				SELECT			a.SDBSourceID, a.SDBComputerNamePrefix
				FROM			dbo.SDBSource a (NOLOCK)
				WHERE			a.JobID IS NULL

				SELECT			TOP 1 @i = a.ID FROM #ResultsNewNode a ORDER BY a.ID DESC

				--				For each new node, create the associated job.
				WHILE			( @i > 0 )
				BEGIN

								SELECT TOP 1	@SDBSourceID					= SDBSourceID, 
												@SDBComputerNamePrefix			= a.SDBComputerNamePrefix
								FROM			#ResultsNewNode a 
								WHERE			a.ID = @i

								EXEC			dbo.CreateSDBJob	
														@RegionID				= @RegionID, 
														@SDBSourceID			= @SDBSourceID, 
														@SDBName				= @SDBComputerNamePrefix,
														@JobOwnerLoginName		= @LoginName,
														@JobOwnerLoginPWD		= LoginPWD

								EXEC			dbo.CreateSDBLinkedServer	
														@SDBSourceID			= @SDBSourceID, 
														@JobOwnerLoginName		= @LoginName,
														@JobOwnerLoginPWD		= @LoginPWD

								SET				@i = @i - 1

				END


				DROP TABLE #ResultsALLSDBLogical
				DROP TABLE #ResultsALLSDB
				DROP TABLE #ResultsNew
				DROP TABLE #ResultsNewNode


END


GO
