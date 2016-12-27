Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.PurgeSDB_IESPOT'), 0) > 0 
	DROP PROCEDURE dbo.PurgeSDB_IESPOT
GO

CREATE PROCEDURE [dbo].[PurgeSDB_IESPOT]
		@UTC_Cutoff_Day			DATE,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT = NULL,
		@MDBName				VARCHAR(50) = NULL,
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
// Module:  dbo.PurgeSDB_IESPOT
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Deletes from the DINGODB.dbo.SDB_IESPOT table from @UTC_Cutoff_Day and before.
//			This value is set at the job level which calls this SP.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.PurgeSDB_IESPOT.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.PurgeSDB_IESPOT 
//								@UTC_Cutoff_Day		= '2013-10-07',
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@LogIDReturn			INT
		DECLARE		@ErrNum					INT
		DECLARE		@ErrMsg					VARCHAR(200)
		DECLARE		@EventLogStatusID		INT = 0

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		BEGIN TRY
			DELETE		dbo.SDB_IESPOT
			WHERE		UTC_SCHED_DATE			<= @UTC_Cutoff_Day

			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID				= @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT Fail Step'
			SET			@EventLogStatusID = ISNULL(@EventLogStatusID, @ErrorID)
		END CATCH

		EXEC			dbo.LogEvent @LogID		= @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END



GO


