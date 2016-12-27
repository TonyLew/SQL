Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.ImportTrafficAndBillingData'), 0) > 0 
	DROP PROCEDURE dbo.ImportTrafficAndBillingData
GO

CREATE PROCEDURE [dbo].[ImportTrafficAndBillingData]
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
// Module:  dbo.ImportTrafficAndBillingData
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 	Imports Traffic And Billing Data from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ImportTrafficAndBillingData.proc.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.ImportTrafficAndBillingData 
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
		DECLARE		@CMD						NVARCHAR(4000)
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						VARCHAR(200)
		DECLARE		@EventLogStatusID			INT
		DECLARE		@ReplicationClusterName		NVARCHAR(50)
		DECLARE		@MPEGDBName					NVARCHAR(25)

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		SELECT		@ReplicationClusterName		= Name 
		FROM		dbo.ReplicationCluster a 
		JOIN		dbo.SDBSource b 
		ON			a.ReplicationClusterID		= b.ReplicationClusterID 
		WHERE		b.SDBSourceID				= @SDBSourceID

		SELECT		@MPEGDBName					= 'MPEG' + CAST(SDBSourceSystemID AS NVARCHAR(50)) 
		FROM		dbo.SDBSourceSystem 
		WHERE		SDBComputerName				= @SDBName


		SET			@CMD			= 
											N'INSERT		#ImportTB_REQUEST ' +
														N'( ' +
															N'SCHED_DATE, ' +
															N'UTC_SCHED_DATE, ' +
															N'FILENAME, ' +
															N'FILE_DATETIME, ' +
															N'UTC_FILE_DATETIME, ' +
															N'PROCESSED, ' +
															N'SOURCE_ID, ' +
															N'STATUS, ' +
															N'IU_ID, ' +
															N'SDBSourceID ' +
														N') ' +
											N'SELECT ' +
															N'CONVERT(DATE,TB_DAYPART) AS SCHED_DATE, ' +
															N'CONVERT( DATE, DATEADD(hour, ' + CAST(@SDBUTCOffset AS NVARCHAR(50)) + N', TB_DAYPART)) AS UTC_SCHED_DATE, ' +
															N'SUBSTRING(TBR.TB_FILE,CHARINDEX(''\SCH\'',TBR.TB_FILE,0)+5,12) AS FILENAME, ' +
															N'TBR.TB_FILE_DATE AS [FILE_DATETIME], ' +
															N'DATEADD( hour, ' + CAST(@SDBUTCOffset AS NVARCHAR(50)) + N', TBR.TB_FILE_DATE ) AS UTC_FILE_DATETIME, ' +
															N'TBR.TB_MACHINE_TS AS PROCESSED, ' +
															N'TBR.SOURCE_ID, ' +
															N'TBR.STATUS, ' +
															N'TBR.IU_ID, ' +
															CAST(@SDBSourceID AS NVARCHAR(25)) + N' AS SDBSourceID ' +
											N'FROM			[' + @ReplicationClusterName + '].' + @MPEGDBName + N'.dbo.TB_REQUEST TBR WITH (NOLOCK) ' +
											N'WHERE			TBR.TB_MODE = 3 ' +
											N'AND			TBR.TB_REQUEST = 2'

		BEGIN TRY
			EXECUTE		sp_executesql	@CMD
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

END

GO

