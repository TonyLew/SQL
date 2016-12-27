
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.UpsertReplicationJob'), 0) > 0 
	DROP PROCEDURE dbo.UpsertReplicationJob
GO

CREATE PROCEDURE [dbo].[UpsertReplicationJob]
		@SDBSystemID				INT,
		@SDBName					VARCHAR(100),
		@ReplicationJobTypeID		INT,
		@JOBID						UNIQUEIDENTIFIER, 
		@JOBName					VARCHAR(200), 
		@ERROR						INT OUTPUT
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
// Module:  dbo.UpsertReplicationJob
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Saves the job information for a given SDB node and replication type job. 
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.UpsertReplicationJob.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE	@ERROROUT INT
//				EXEC	DINGOSDB.dbo.UpsertReplicationJob	
//								@SDBSystemID				= 1,
//								@SDBName					= 'MSSNKNLSDB001B', 
//								@ReplicationJobTypeID		= 1,
//								@JOBID						= '',
//								@JOBName					= '',
//								@ERROR						= @ERROROUT OUTPUT
//
*/ 
-- =============================================
BEGIN


			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			SET NOCOUNT ON;
							
			IF			EXISTS( SELECT TOP 1 1 FROM dbo.SDBSystem WHERE SDBSystemID = @SDBSystemID )
			BEGIN

						MERGE			dbo.ReplicationJob						AS target
						USING		(	SELECT 
													@SDBSystemID,
													@SDBName,
													@ReplicationJobTypeID,
													@JOBID, 
													@JOBName, 
													GETUTCDATE(),
													GETUTCDATE()
									)											AS	source 
									(
													SDBSystemID,
													JobServer,
													ReplicationJobTypeID,
													JobID,
													JobName,
													CreateDate,
													UpdateDate
									)
						ON			(
										target.SDBSystemID						= source.SDBSystemID
										AND target.ReplicationJobTypeID			= source.ReplicationJobTypeID
									)
						WHEN MATCHED THEN UPDATE 
										SET JobServer							= source.JobServer,
											ReplicationJobTypeID				= source.ReplicationJobTypeID,
											JobID								= source.JobID,
											JobName								= source.JobName,
											UpdateDate							= source.UpdateDate

						WHEN NOT MATCHED THEN INSERT 
									(
											SDBSystemID,
											JobServer,
											ReplicationJobTypeID,
											JobID,
											JobName,
											CreateDate,
											UpdateDate
									)
						VALUES	
									(
											source.SDBSystemID,	
											source.JobServer,
											source.ReplicationJobTypeID,
											source.JobID,
											source.JobName,
											source.CreateDate,
											source.UpdateDate
									);

			END

			SET			@ERROR								= 0



END



GO
