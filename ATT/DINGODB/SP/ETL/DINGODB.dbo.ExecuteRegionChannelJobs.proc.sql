

Use DINGODB
GO


IF ISNULL(OBJECT_ID('dbo.ExecuteRegionChannelJobs'), 0) > 0 
	DROP PROCEDURE dbo.ExecuteRegionChannelJobs
GO

CREATE PROCEDURE [dbo].[ExecuteRegionChannelJobs]
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
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ExecuteRegionChannelJobs.proc.sql 3786 2014-03-20 20:17:04Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.ExecuteRegionChannelJobs	
//								@RegionID = 1 
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@i 									INT
		DECLARE		@JobID 								UNIQUEIDENTIFIER
		DECLARE		@JobName 							VARCHAR(100)
		DECLARE		@ErrNum 							INT
		DECLARE		@JobCurrentStatus 					INT
		DECLARE		@CMD 								NVARCHAR(1000)
		DECLARE		@MDBSourceID						INT
		DECLARE		@MDBName							VARCHAR(32)
		DECLARE		@MDBNamePrimaryIn 					VARCHAR(32)
		DECLARE		@MDBNameSecondaryIn 				VARCHAR(32)
		DECLARE		@MDBNameActiveResult 				VARCHAR(32)
		DECLARE		@SDBTotalRowsResult					INT
		DECLARE		@EventLogStatusID					INT
		DECLARE		@LogIDReturn						INT
		DECLARE		@SDBDelete							UDT_Int
		DECLARE		@SDBDeleteCount						INT


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


		SELECT			TOP 1	
						@MDBSourceID					= a.MDBSourceID,
						@JobID							= a.JobID,
						@JobName						= a.JobName
		FROM			dbo.MDBSource a (NOLOCK)	 
		WHERE 			a.RegionID						= @RegionID


		EXEC			dbo.GetActiveMDB 
							@MDBSourceID				= @MDBSourceID,
							@JobID						= @JobID,
							@JobName					= @JobName,
							@MDBNameActive				= @MDBNameActiveResult OUTPUT
		IF				( @MDBNameActiveResult IS NULL )	RETURN

		EXEC			dbo.GetSDBList	
								@MDBNameActive			= @MDBNameActiveResult,
								@TotalRows				= @SDBTotalRowsResult OUTPUT
		IF				( ISNULL(@SDBTotalRowsResult, 0) = 0) RETURN

		INSERT			#ResultsAll ( SDBSourceID, SDBComputerName, Role, Status, SoftwareVersion )
		SELECT			a.SDBSourceID, b.SDBComputerName, b.Role, b.Status, b.SoftwareVersion
		FROM			dbo.SDBSourceSystem a (NOLOCK)
		JOIN			(
								SELECT		PrimaryComputerName AS SDBComputerName, PRoleValue AS Role, PStatusValue AS Status, PSoftwareVersion AS SoftwareVersion
								FROM		#ResultsALLSDBLogical x
								UNION
								SELECT		BackupComputerName AS SDBComputerName, BRoleValue AS Role, BStatusValue AS Status, BSoftwareVersion AS SoftwareVersion
								FROM		#ResultsALLSDBLogical y
						) b
		ON				a.SDBComputerName = b.SDBComputerName

		UPDATE			dbo.SDBSourceSystem 
		SET				Status = a.Status
		FROM			#ResultsAll a
		WHERE			SDBSourceSystem.SDBComputerName = a.SDBComputerName

		UPDATE			dbo.SDBSource 
		SET				SDBStatus						= CASE WHEN a.Role = 1 THEN 1 ELSE 5 END
		FROM			dbo.SDBSourceSystem a	
		WHERE			SDBSource.SDBSourceID			= a.SDBSourceID
		AND				a.Enabled						= 1
		AND				a.Status						= 1

		INSERT INTO		#JobCurrentStatus 
		EXEC			MASTER.dbo.xp_sqlagent_enum_jobs 1, ''

		--				Identify SDB nodes that need to be deleted 
		INSERT			@SDBDelete ( Value )
		SELECT			a.SDBSourceID AS Value
		FROM			dbo.SDBSource a (NOLOCK)
		LEFT JOIN		(
								SELECT		x.SDBSourceID, x.SoftwareVersion, COUNT(1) AS Nodes
								FROM		#ResultsAll x
								GROUP BY	x.SDBSourceID, x.SoftwareVersion
						) b
		ON				a.SDBSourceID					= b.SDBSourceID
		WHERE			a.MDBSourceID					= @MDBSourceID					--Make sure this applies to ONLY this region
		AND				(	b.SDBSourceID				IS NULL
							OR (b.SoftwareVersion = '' AND b.Nodes > 1)
						)
		SELECT			@SDBDeleteCount					= @@ROWCOUNT

		IF				( @SDBDeleteCount > 0 )
		BEGIN

						EXEC	dbo.DeleteSDB 
										@SDBSourceID	= @SDBDelete,
										@JobID			= @JobID,
										@JobName		= @JobName,
										@ErrorID		= @ErrNum OUTPUT

		END


		INSERT			#ResultsActive ( SDBSourceID, SDBComputerName )
		SELECT			
						a.SDBSourceID,
						(
							SELECT		TOP 1 x.SDBComputerName 
							FROM		#ResultsAll x 
							WHERE		x.SDBSourceID	= a.SDBSourceID
							AND			x.Status = 1
							ORDER BY	x.Role
						)	AS SDBComputerName
		FROM			dbo.SDBSource a (NOLOCK)
		JOIN			dbo.MDBSource b (NOLOCK)
		ON				a.MDBSourceID					= b.MDBSourceID
		JOIN			#JobCurrentStatus c
		ON				a.JobID							= c.Job_ID
		WHERE			c.Running						<> 1
		AND				b.RegionID						= @RegionID

		SELECT			TOP 1 @i = a.ID FROM #ResultsActive a ORDER BY a.ID DESC

		WHILE			( @i > 0 )
		BEGIN
		
						SELECT TOP 1	@JobName  = b.JobName
						FROM			#ResultsActive a 
						JOIN			dbo.SDBSource b (NOLOCK) 
						ON				a.SDBSourceID	= b.SDBSourceID
						WHERE			a.ID = @i

						EXEC			msdb.dbo.sp_start_job @job_name = @JobName

						SET				@i = @i - 1

		END

		DROP TABLE #ResultsALLSDBLogical
		DROP TABLE #ResultsAll
		DROP TABLE #ResultsActive
		DROP TABLE #ResultsDelete
		DROP TABLE #JobCurrentStatus

END


GO


