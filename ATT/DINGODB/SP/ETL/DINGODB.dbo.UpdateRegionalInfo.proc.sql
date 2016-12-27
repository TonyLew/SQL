

Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.UpdateRegionalInfo'), 0) > 0 
	DROP PROCEDURE dbo.UpdateRegionalInfo
GO

CREATE PROCEDURE dbo.UpdateRegionalInfo
		@JobOwnerLoginName	NVARCHAR(100),
		@JobOwnerLoginPWD	NVARCHAR(100),
		@UTC_Cutoff_Day		DATE = '2000-01-01',
		@JobRun				TINYINT = 1
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
// Module:  dbo.UpdateRegionalInfo
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 			Updates the regional definition tables.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.UpdateRegionalInfo.proc.sql 4584 2014-07-15 23:51:02Z tlew $
//    
//	 Usage:
//
//				EXEC		dbo.UpdateRegionalInfo 
//								@JobOwnerLoginName	= N'MCC2-LAILAB\\nbrownett',
//								@JobOwnerLoginPWD	= N'PF_ds0tm!',
//								@UTC_Cutoff_Day		= '2013-10-07',
//								@JobRun = 1
//				
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@RegionID					INT
		DECLARE		@MDBNodeID					INT
		DECLARE		@MDBSourceID				INT
		DECLARE		@EventLogStatusID			INT
		DECLARE		@JobID						UNIQUEIDENTIFIER
		DECLARE		@JobName					NVARCHAR(200)
		DECLARE		@MDBNameResult				VARCHAR(50)
		--DECLARE		@MDBNameSDBListResult		VARCHAR(50)
		DECLARE		@MDBNamePrimaryIn			VARCHAR(32)
		DECLARE		@MDBNameSecondaryIn			VARCHAR(32)
		DECLARE		@TotalRegions				INT
		DECLARE		@i							INT = 1
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						NVARCHAR(200)
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNumTotal				INT
		DECLARE		@LogIDConflictsReturn		INT
		DECLARE		@TotalReplicationClusters INT


		SELECT		@TotalReplicationClusters	= COUNT(1)
		FROM		dbo.ReplicationCluster WITH (NOLOCK)
		WHERE		Enabled = 1


		SELECT		TOP 1 
					@JobID						= a.job_id,
					@JobName					= 'Update Regional Info'
		FROM		msdb.dbo.sysjobs a (NOLOCK)
		WHERE		a.name						LIKE 'Update Regional Info'

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'UpdateRegionalInfo First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,			----Started Step
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= NULL,
							@DBComputerName		= NULL,
							@LogIDOUT			= @LogIDReturn OUTPUT



		IF OBJECT_ID('tempdb..#ResultsALLMDB') IS NOT NULL
			DROP TABLE #ResultsALLMDB
		CREATE TABLE #ResultsALLMDB ( ID INT IDENTITY(1,1), MDBSourceID INT, RegionID INT )

		--Clean up local tables
		EXEC		dbo.PurgeSDB_IESPOT 
						@UTC_Cutoff_Day		= @UTC_Cutoff_Day,
						@JobID				= @JobID,
						@JobName			= @JobName,
						@MDBSourceID		= @MDBSourceID,
						@MDBName			= @MDBNameResult,
						@JobRun				= @JobRun,
						@ErrorID			= @ErrNum OUTPUT
		SELECT			@ErrNumTotal		= @ErrNum

		INSERT			#ResultsALLMDB ( MDBSourceID, RegionID )
		SELECT			a.MDBSourceID, a.RegionID
		FROM			dbo.MDBSource a (NOLOCK)
		JOIN			(
								SELECT		MDBSourceID
								FROM		dbo.MDBSourceSystem (NOLOCK)
								WHERE		Enabled			= 1
								GROUP BY	MDBSourceID
						) b
		ON 				a.MDBSourceID			= b.MDBSourceID
		ORDER BY		a.MDBSourceID
		SELECT			@TotalRegions = SCOPE_IDENTITY()

		WHILE			( @i <= @TotalRegions )
		BEGIN

						SELECT			@MDBSourceID			= a.MDBSourceID,
										@RegionID				= a.RegionID
						FROM			#ResultsALLMDB a 
						WHERE 			a.ID					= @i


						UPDATE				dbo.SDBSource
						SET					ReplicationClusterID		= ( SDBSourceID % @TotalReplicationClusters ) + 1
						WHERE				MDBSourceID					= @MDBSourceID
						AND					ReplicationClusterID		= 0


						EXEC			dbo.GetActiveMDB 
											@MDBSourceID			= @MDBSourceID,
											@JobID					= @JobID,
											@JobName				= @JobName,
											@MDBNameActive			= @MDBNameResult OUTPUT


						IF				( @MDBNameResult IS NOT NULL ) 
						BEGIN

										EXEC			dbo.AddNewSDBNode 
															@MDBName			= @MDBNameResult,
															@RegionID			= @RegionID,
															@LoginName			= @JobOwnerLoginName,
															@LoginPWD			= @JobOwnerLoginPWD


										EXEC			dbo.SaveZone 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveIU 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveNetwork 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveNetwork_IU_Map 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveIU 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveSPOT_CONFLICT_STATUS 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveSPOT_STATUS 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveIE_CONFLICT_STATUS 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveIE_STATUS 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum


						END

						SET				@i = @i + 1

		END

		SELECT			TOP 1 @EventLogStatusID = EventLogStatusID 
		FROM			dbo.EventLogStatus (NOLOCK) 
		WHERE			SP = ( CASE WHEN ISNULL(@ErrNumTotal, 0) = 0 THEN 'UpdateRegionalInfo Success Step' ELSE 'UpdateRegionalInfo Fail Step' END )

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE #ResultsALLMDB


END


GO
