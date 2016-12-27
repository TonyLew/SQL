Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveSPOT_CONFLICT_STATUS'), 0) > 0 
	DROP PROCEDURE dbo.SaveSPOT_CONFLICT_STATUS
GO

CREATE PROCEDURE [dbo].[SaveSPOT_CONFLICT_STATUS]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
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
// Module:  dbo.SaveSPOT_CONFLICT_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts SPOT_CONFLICT_STATUS definition table to DINGODB and regionalizes the SPOT_CONFLICT_STATUS with a DINGODB SPOT_CONFLICT_STATUS ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveSPOT_CONFLICT_STATUS.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveSPOT_CONFLICT_STATUS 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@LogIDReturn	INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT = 16
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT


		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#SPOT_CONFLICT_STATUS'), 0) > 0 
				DROP TABLE		#SPOT_CONFLICT_STATUS

		CREATE TABLE	#SPOT_CONFLICT_STATUS 
						(
							ID INT Identity(1,1),
							RegionID int,
							NSTATUS int,
							VALUE varchar(200),
							CHECKSUM_VALUE int
						)

		SET			@CMD			= 
		'INSERT		#SPOT_CONFLICT_STATUS
					(
							RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM_VALUE 
					)
		SELECT
							' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.SPOTCONFLICT_STATUS s WITH (NOLOCK) '


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			UPDATE		dbo.REGIONALIZED_SPOT_CONFLICT_STATUS
			SET
						RegionID											= s.RegionID,
						NSTATUS												= s.NSTATUS,
						VALUE												= s.VALUE,
						CHECKSUM_VALUE 										= s.CHECKSUM_VALUE

			FROM		#SPOT_CONFLICT_STATUS s
			WHERE		REGIONALIZED_SPOT_CONFLICT_STATUS.RegionID			= @RegionID
			AND			REGIONALIZED_SPOT_CONFLICT_STATUS.NSTATUS			= s.NSTATUS
			AND			REGIONALIZED_SPOT_CONFLICT_STATUS.CHECKSUM_VALUE	<> s.CHECKSUM_VALUE

			
			INSERT		dbo.REGIONALIZED_SPOT_CONFLICT_STATUS
						(
								RegionID,
								NSTATUS,
								VALUE,
								CHECKSUM_VALUE
						)
			SELECT
								@RegionID AS RegionID,
								y.NSTATUS,
								y.VALUE,
								y.CHECKSUM_VALUE
			FROM				#SPOT_CONFLICT_STATUS y
			LEFT JOIN			(
										SELECT		NSTATUS
										FROM		dbo.REGIONALIZED_SPOT_CONFLICT_STATUS (NOLOCK)
										WHERE		RegionID = @RegionID
								) z
			ON					y.NSTATUS = z.NSTATUS
			WHERE				z.NSTATUS IS NULL
			ORDER BY			y.ID

			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#SPOT_CONFLICT_STATUS

END



GO


