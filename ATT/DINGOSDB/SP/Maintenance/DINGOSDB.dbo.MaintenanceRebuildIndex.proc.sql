Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.MaintenanceRebuildIndex'), 0) > 0 
	DROP PROCEDURE dbo.MaintenanceRebuildIndex
GO

CREATE PROCEDURE [dbo].[MaintenanceRebuildIndex]
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
// Module:  dbo.MaintenanceRebuildIndex
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Rebuilds indices for all tables so that they are contiguous.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.MaintenanceRebuildIndex.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN

			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SET NOCOUNT ON;

			DECLARE		@TableName										VARCHAR(255)
			DECLARE		@CMD											NVARCHAR(500)
			DECLARE		@fillfactor										INT = 80
			DECLARE		@LogIDReturn									INT
			DECLARE		@ErrNum											INT
			DECLARE		@ErrMsg											VARCHAR(200)
			DECLARE		@EventLogStatusID								INT
			DECLARE		@ParmDefinition									NVARCHAR(500)
			DECLARE		@DatabaseID										INT
			--DECLARE		TableCursor					CURSOR FOR
			--SELECT		OBJECT_SCHEMA_NAME([object_id])+'.'+name AS TableName
			--FROM		sys.tables
			DECLARE		TableCursor										CURSOR FOR
			SELECT		'DINGOSDB.' + OBJECT_SCHEMA_NAME( [object_id], DB_ID('DINGOSDB') )+'.'+name AS TableName, *
			FROM		DINGOSDB.sys.tables

			SELECT		@DatabaseID										= DB_ID()

			OPEN		TableCursor
			FETCH NEXT FROM TableCursor INTO @TableName
			WHILE		@@FETCH_STATUS = 0
			BEGIN
						SELECT			TOP 1 @EventLogStatusID			= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceRebuildIndex First Step'

						EXEC			DINGODB.dbo.LogEvent 
											@LogID						= NULL,
											@EventLogStatusID			= @EventLogStatusID,
											@JobID						= NULL,
											@JobName					= NULL,
											@DBID						= @DatabaseID,
											@DBComputerName				= @@SERVERNAME,
											@LogIDOUT					= @LogIDReturn OUTPUT

						SET				@CMD							= 'ALTER INDEX ALL ON ' + @TableName + ' REBUILD WITH ( FILLFACTOR = ' + CONVERT(VARCHAR(3),@fillfactor) + ', ONLINE = ON ) '
						EXECUTE			sp_executesql					@CMD
						SELECT			TOP 1 @EventLogStatusID			= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceRebuildIndex Success Step'
						EXEC			DINGODB.dbo.LogEvent @LogID		= @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @CMD

						FETCH NEXT FROM TableCursor INTO @TableName
			END
			CLOSE		TableCursor
			DEALLOCATE	TableCursor

END

GO


