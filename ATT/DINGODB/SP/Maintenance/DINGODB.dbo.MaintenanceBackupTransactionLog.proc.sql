

Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.MaintenanceBackupTransactionLog'), 0) > 0 
	DROP PROCEDURE dbo.MaintenanceBackupTransactionLog
GO


CREATE PROCEDURE [dbo].[MaintenanceBackupTransactionLog]
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
// Module:  dbo.MaintenanceBackupTransactionLog
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Perform Backup of DINGODB Log to BackUpPathName Supplied.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MaintenanceBackupTransactionLog.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/
BEGIN
			DECLARE		@BackUpDestination			VARCHAR(100)
			DECLARE		@UTCNow						DATETIME = GETUTCDATE()
			DECLARE		@UTCNowYear					CHAR(4)
			DECLARE		@UTCNowMonth				CHAR(2)
			DECLARE		@UTCNowDay					CHAR(2)
			DECLARE		@UTCNowHour					CHAR(2)
			DECLARE		@UTCNowMinute				CHAR(2)

			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		@ErrorID					= 1
			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupTransactionLog First Step'
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
						@UTCNowHour					= DATEPART(Hour, @UTCNow),
						@UTCNowMinute				= DATEPART(Minute, @UTCNow)
			SELECT		@UTCNowMonth				= CASE WHEN LEN(@UTCNowMonth) = 1 THEN '0' + @UTCNowMonth ELSE @UTCNowMonth END,
						@UTCNowDay					= CASE WHEN LEN(@UTCNowDay) = 1 THEN '0' + @UTCNowDay ELSE @UTCNowDay END,
						@UTCNowHour					= CASE WHEN LEN(@UTCNowHour) = 1 THEN '0' + @UTCNowHour ELSE @UTCNowHour END,
						@UTCNowMinute				= CASE WHEN LEN(@UTCNowMinute) = 1 THEN '0' + @UTCNowMinute ELSE @UTCNowMinute END


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOCT.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'
			BACKUP LOG DINGOCT
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGODB.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'
			BACKUP LOG DINGODB
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGODW.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'
			BACKUP LOG DINGODW
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOMTI.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'
			BACKUP LOG DINGOMTI
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			DECLARE @DeleteDate DATETIME			= DATEADD(D, -2, GETDATE())
			EXECUTE master.dbo.xp_delete_file		0, @BackUpPathName, N'Log.bak', @DeleteDate, 1

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupTransactionLog Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL
			SELECT		@ErrorID					= 0


END




GO