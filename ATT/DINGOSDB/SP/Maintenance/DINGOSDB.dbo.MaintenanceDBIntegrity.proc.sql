

Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.MaintenanceDBIntegrity'), 0) > 0 
	DROP PROCEDURE dbo.MaintenanceDBIntegrity
GO


CREATE PROCEDURE [dbo].[MaintenanceDBIntegrity]
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
// Module:  dbo.MaintenanceDBIntegrity
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Checks DB Integrity.  Use EXEC xp_readerrorlog to see the results.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.MaintenanceDBIntegrity.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN


			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity First Step'
			EXEC		DINGODB.dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			DBCC CHECKDB ('DINGOSDB') 

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity Success Step'
			EXEC		DINGODB.dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL



END



GO




