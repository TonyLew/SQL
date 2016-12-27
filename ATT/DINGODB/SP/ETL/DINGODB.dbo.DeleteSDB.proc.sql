USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.DeleteSDB'), 0) > 0 
	DROP PROCEDURE dbo.DeleteSDB
GO

CREATE PROCEDURE dbo.DeleteSDB 
		@SDBSourceID			UDT_Int READONLY,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT

AS
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
// Module:  dbo.DeleteSDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populates a parent SPs temp table named #ResultsALLSDBLogical with all
//					SDBs of the given region's HAdb tables.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DeleteSDB.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				DECLARE		@SDBSourceID_IN UDT_Int
//				INSERT		@SDBSourceID_IN ( Value ) VALUES ( 4 )
//				INSERT		@SDBSourceID_IN ( Value ) VALUES ( 5 )
//				INSERT		@SDBSourceID_IN ( Value ) VALUES ( 6 )
//				EXEC		dbo.DeleteSDB	
//								@SDBSourceID		= @SDBSourceID_IN,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
BEGIN

				DECLARE		@LogIDReturn		INT
				DECLARE		@ErrNum				INT
				DECLARE		@ErrMsg				VARCHAR(200)
				DECLARE		@EventLogStatusID	INT
				DECLARE		@SDBDeleteID		INT
				DECLARE		@CurrentJobName		NVARCHAR(200)
				DECLARE		@CurrentSDBSourceID	INT

				SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB First Step'

				EXEC		dbo.LogEvent 
									@LogID				= NULL,
									@EventLogStatusID	= @EventLogStatusID,
									@JobID				= @JobID,
									@JobName			= @JobName,
									@LogIDOUT			= @LogIDReturn OUTPUT

				--			This is simply as an identification.
				UPDATE		dbo.SDBSourceSystem
				SET			Enabled			= 2
				FROM		@SDBSourceID a
				WHERE		SDBSourceSystem.SDBSourceID	= a.Value

				SELECT		TOP 1 @SDBDeleteID			= a.ID 
				FROM		@SDBSourceID a
				ORDER BY	a.ID DESC

				WHILE		( @SDBDeleteID > 0)
				BEGIN

							SELECT		@CurrentJobName	= b.JobName
							FROM		@SDBSourceID a
							JOIN		dbo.SDBSource b (NOLOCK)
							ON			a.Value			= b.SDBSourceID
							WHERE		a.ID			= @SDBDeleteID
							
							IF			( @CurrentJobName IS NOT NULL )
										EXEC		msdb.dbo.sp_delete_job	@job_name = @CurrentJobName
							SELECT		@SDBDeleteID	= @SDBDeleteID - 1,
										@CurrentJobName	= NULL
							
				END

				BEGIN TRY


							IF			( @SDBDeleteID IS NOT NULL )
							BEGIN
										BEGIN TRAN


													DELETE		dbo.SDB_IESPOT
													FROM		@SDBSourceID a
													WHERE		SDB_IESPOT.SDBSourceID			= a.Value

													DELETE		dbo.SDB_Market
													FROM		@SDBSourceID a
													WHERE		SDB_Market.SDBSourceID			= a.Value

													DELETE		dbo.CacheStatus
													FROM		@SDBSourceID a
													WHERE		CacheStatus.SDBSourceID			= a.Value

													DELETE		dbo.ChannelStatus
													FROM		@SDBSourceID a
													WHERE		ChannelStatus.SDBSourceID		= a.Value

													DELETE		dbo.Conflict
													FROM		@SDBSourceID a
													WHERE		Conflict.SDBSourceID			= a.Value

													DELETE		dbo.SDBSourceSystem
													FROM		@SDBSourceID a
													WHERE		SDBSourceSystem.SDBSourceID		= a.Value

													DELETE		dbo.SDBSource
													FROM		@SDBSourceID a
													WHERE		SDBSource.SDBSourceID			= a.Value
							

										COMMIT
							END

							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB Success Step'

				END TRY
				BEGIN CATCH

							SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
							SET			@ErrorID = @ErrNum
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB Fail Step'
							ROLLBACK

				END CATCH

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END

GO
