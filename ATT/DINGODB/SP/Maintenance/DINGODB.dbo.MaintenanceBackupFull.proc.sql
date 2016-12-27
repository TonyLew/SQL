
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.MaintenanceBackupFull'), 0) > 0 
	DROP PROCEDURE dbo.MaintenanceBackupFull
GO

CREATE PROCEDURE [dbo].[MaintenanceBackupFull]
		@BackUpPathName			VARCHAR(100) = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\',
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
// Module:  dbo.MaintenanceBackupFull
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Perform Full Backup of DINGODB Database to BackUpPathName Supplied.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MaintenanceBackupFull.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/
BEGIN


			DECLARE		@BackUpDestination			VARCHAR(100)
			DECLARE		@UTCNow						DATETIME = GETUTCDATE()
			DECLARE		@UTCNowYear					CHAR(4)
			DECLARE		@UTCNowMonth				CHAR(2)
			DECLARE		@UTCNowDay					CHAR(2)
			DECLARE		@UTCNowMinute				CHAR(2)

			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		@ErrorID					= 1
			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupFull First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			SELECT		@UTCNowYear					= DATEPART(Year, @UTCNow),
						@UTCNowMonth				= DATEPART(Month, @UTCNow),
						@UTCNowDay					= DATEPART(Day, @UTCNow),
						@UTCNowMinute				= DATEPART(Minute, @UTCNow)
			SELECT		@UTCNowMonth				= CASE WHEN LEN(@UTCNowMonth) = 1 THEN '0' + @UTCNowMonth ELSE @UTCNowMonth END,
						@UTCNowDay					= CASE WHEN LEN(@UTCNowDay) = 1 THEN '0' + @UTCNowDay ELSE @UTCNowDay END,
						@UTCNowMinute				= CASE WHEN LEN(@UTCNowMinute) = 1 THEN '0' + @UTCNowMinute ELSE @UTCNowMinute END


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOCT.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'
			BACKUP DATABASE DINGOCT
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGODB.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'
			BACKUP DATABASE DINGODB
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGODW.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'
			BACKUP DATABASE DINGODW
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOMTI.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'
			BACKUP DATABASE DINGOMTI
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			DECLARE @DeleteDate DATETIME			= DATEADD(D, -7, GETDATE())
			EXECUTE master.dbo.xp_delete_file		0, @BackUpPathName, N'Full.bak', @DeleteDate, 1


			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupFull Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL
			SELECT		@ErrorID					= 0


END




GO





