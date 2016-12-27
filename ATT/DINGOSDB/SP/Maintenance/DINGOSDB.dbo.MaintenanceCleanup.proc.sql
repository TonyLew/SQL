

Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.MaintenanceCleanup'), 0) > 0 
	DROP PROCEDURE dbo.MaintenanceCleanup
GO

CREATE PROCEDURE [dbo].[MaintenanceCleanup]
		@ErrorID				INT = NULL OUTPUT
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
// Module:  dbo.MaintenanceCleanup
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Perform regular tasks that need to be performed on an ongoing basis.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.MaintenanceCleanup.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN


			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

/*

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceCleanup First Step'
			EXEC		DINGODB.dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			DELETE FROM EVENTLOG WHERE StartDate <= CAST(DATEADD(D, -2, GETUTCDATE()) AS DATE)

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM DINGODB.dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceCleanup Success Step'
			EXEC		DINGODB.dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL

*/

END

GO





