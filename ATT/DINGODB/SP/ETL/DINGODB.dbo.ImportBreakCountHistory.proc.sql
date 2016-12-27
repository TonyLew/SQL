
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.ImportBreakCountHistory'), 0) > 0 
	DROP PROCEDURE dbo.ImportBreakCountHistory
GO


CREATE PROCEDURE [dbo].[ImportBreakCountHistory]
		@SDBUTCOffset			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				VARCHAR(100),
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
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
// Module:  dbo.ImportBreakCountHistory
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 	Imports Break Count History from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ImportBreakCountHistory.proc.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.ImportBreakCountHistory 
//								@SDBUTCOffset		= 0
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'SDBName',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD						NVARCHAR(1000)
		DECLARE		@StartDay					DATE
		DECLARE		@EndDay						DATE
		DECLARE		@NowSDBTime					DATETIME
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						VARCHAR(200)
		DECLARE		@EventLogStatusID			INT
		DECLARE		@ReplicationClusterName		NVARCHAR(50)
		DECLARE		@MPEGDBName					NVARCHAR(25)

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportBreakCountHistory First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		SELECT		@NowSDBTime					= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
		SELECT		@StartDay					= DATEADD( DAY, -6, @NowSDBTime ),
					@EndDay						= DATEADD( DAY, 2, @NowSDBTime )

		SELECT		@ReplicationClusterName		= Name 
		FROM		dbo.ReplicationCluster a 
		JOIN		dbo.SDBSource b 
		ON			a.ReplicationClusterID		= b.ReplicationClusterID 
		WHERE		b.SDBSourceID				= @SDBSourceID

		SELECT		@MPEGDBName					= 'MPEG' + CAST(SDBSourceSystemID AS NVARCHAR(50)) 
		FROM		dbo.SDBSourceSystem 
		WHERE		SDBComputerName				= @SDBName


		SET			@CMD			= 
										N'INSERT		#ImportIUBreakCount ' +
													N'( ' +
														N'BREAK_DATE, ' +
														N'IU_ID, ' +
														N'SOURCE_ID, ' +
														N'BREAK_COUNT, ' +
														N'SDBSourceID ' +
													N') ' +
										N'SELECT		IU_BREAKS.BREAK_DATE, ' +
														N'IU_BREAKS.IU_ID AS IU_ID, ' +
														N'IU_BREAKS.SOURCE_ID AS SOURCE_ID, ' +
														N'IU_BREAKS.BREAK_COUNT, ' +
														CAST(@SDBSourceID AS NVARCHAR(25)) + N' AS SDBSourceID ' +
										N'FROM ' +
													N'( ' +
														N'SELECT  ' +
															N'CONVERT( DATE, IE.SCHED_DATE_TIME ) AS BREAK_DATE, ' +
															N'IE.IU_ID AS IU_ID, ' +
															N'IE.SOURCE_ID, ' +
															N'COUNT(1) AS BREAK_COUNT ' +
														N'FROM [' + @ReplicationClusterName + '].' + @MPEGDBName + N'.dbo.IE IE WITH (NOLOCK) ' +
														N'WHERE	IE.SCHED_DATE_TIME  >= ''' + CAST(  @StartDay AS NVARCHAR(12) ) + N''' ' +
														N'AND	IE.SCHED_DATE_TIME < ''' + CAST( @EndDay AS NVARCHAR(12) ) + N''' ' +
														N'GROUP BY CONVERT( DATE, IE.SCHED_DATE_TIME ), IE.IU_ID, IE.SOURCE_ID  ' +
													N')		AS IU_BREAKS '


		--Previously, this query was only retrieving the break counts for the last 6 days (dateadd (-6) to dateadd (-1)).
		--Now, we will include today and tomorrow  (dateadd (-6) to dateadd (1))
		BEGIN TRY
			EXECUTE		sp_executesql	@CMD
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportBreakCountHistory Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE()
			SET			@ErrorID = @ErrNum
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END


GO


