
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.ImportChannelAndConflictStats'), 0) > 0 
	DROP PROCEDURE dbo.ImportChannelAndConflictStats
GO


CREATE PROCEDURE [dbo].[ImportChannelAndConflictStats]
		@SDBUTCOffset			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				VARCHAR(100),
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
		@Day					DATETIME = NULL,
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
// Module:  dbo.ImportChannelAndConflictStats
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 	Imports Channel And Conflict Stats from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ImportChannelAndConflictStats.proc.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.ImportChannelAndConflictStats 
//								@SDBUTCOffset		= 0
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'SDBName',
//								@Day				= '2013-01-01',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD						NVARCHAR(4000)
		DECLARE		@StartDay					DATE
		DECLARE		@EndDay						DATE
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						VARCHAR(200)
		DECLARE		@EventLogStatusID			INT
		DECLARE		@ReplicationClusterName		NVARCHAR(50)
		DECLARE		@MPEGDBName					NVARCHAR(25)

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		SELECT		@StartDay					= ISNULL(@Day, DATEADD(HOUR, @SDBUTCOffset, GETUTCDATE()) ),
					@EndDay						= DATEADD(DAY, 2, @StartDay)


		SELECT		@ReplicationClusterName		= Name 
		FROM		dbo.ReplicationCluster a 
		JOIN		dbo.SDBSource b 
		ON			a.ReplicationClusterID		= b.ReplicationClusterID 
		WHERE		b.SDBSourceID				= @SDBSourceID

		SELECT		@MPEGDBName					= 'MPEG' + CAST(SDBSourceSystemID AS NVARCHAR(50)) 
		FROM		dbo.SDBSourceSystem 
		WHERE		SDBComputerName				= @SDBName


		SET			@CMD			= 
										N'INSERT		#ImportIE_SPOT ' +
													N'( ' +
														N'SPOT_ID, ' +
														N'IE_ID, ' +
														N'IU_ID, ' +
														N'SCHED_DATE, ' +
														N'SCHED_DATE_TIME, ' +
														N'AWIN_END_DT, ' +
														N'IE_NSTATUS, ' +
														N'IE_CONFLICT_STATUS, ' +
														N'IE_SOURCE_ID, ' +
														N'VIDEO_ID, ' +
														N'ASSET_DESC, ' +
														N'SPOT_ORDER, ' +
														N'SPOT_NSTATUS, ' +
														N'SPOT_CONFLICT_STATUS, ' +
														N'SPOT_RUN_DATE_TIME, ' +
														N'SDBSourceID ' +
													N') ' +
										N'SELECT	 ' +
														N'SPOT.SPOT_ID, ' +
														N'IE.IE_ID, ' +
														N'IE.IU_ID, ' +
														N'CONVERT(DATE, IE.SCHED_DATE_TIME), ' +
														N'IE.SCHED_DATE_TIME, ' +
														N'IE.AWIN_END_DT WINDOW_CLOSE, ' +
														N'IE.NSTATUS, ' +
														N'IE.CONFLICT_STATUS, ' +
														N'IE.SOURCE_ID, ' +
														N'SPOT.VIDEO_ID, ' +
														N'SPOT.TITLE + '' - '' + SPOT.CUSTOMER	AS ASSET_DESC, ' +
														N'SPOT.SPOT_ORDER, ' +
														N'SPOT.NSTATUS, ' +
														N'SPOT.CONFLICT_STATUS, ' +
														N'SPOT.RUN_DATE_TIME, ' +
														CAST(@SDBSourceID AS NVARCHAR(50)) + N' AS SDBSourceID ' +
										N'FROM			['+@ReplicationClusterName+'].' + @MPEGDBName + N'.dbo.IE IE WITH (NOLOCK) ' +
										N'JOIN			['+@ReplicationClusterName+'].' + @MPEGDBName + N'.dbo.SPOT SPOT WITH (NOLOCK) ' +
										N'ON				IE.IE_ID = SPOT.IE_ID ' +
										N'WHERE			IE.SCHED_DATE_TIME  >= ''' + CAST( @StartDay AS NVARCHAR(12)) + '''' +
										N'AND			IE.SCHED_DATE_TIME < ''' + CAST( @EndDay AS NVARCHAR(12)) + ''''


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE()
			SET			@ErrorID = @ErrNum
		END CATCH
		
		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

END
GO



