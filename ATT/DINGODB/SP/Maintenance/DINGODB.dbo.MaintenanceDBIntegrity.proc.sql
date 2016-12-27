Use DINGODB
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
//     Revision:  $Id: DINGODB.dbo.MaintenanceDBIntegrity.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN


			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			DBCC CHECKDB ('DINGOCT') 
			DBCC CHECKDB ('DINGODB') 
			DBCC CHECKDB ('DINGODW') 
			DBCC CHECKDB ('DINGOMTI') 

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL



END



GO





