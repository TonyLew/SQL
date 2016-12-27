

Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.CheckRegionalJob'), 0) > 0 
	DROP PROCEDURE dbo.CheckRegionalJob
GO

CREATE PROCEDURE dbo.CheckRegionalJob
		@RegionalJobName	NVARCHAR(50),
		@StatusID			INT OUTPUT
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
// Module:  dbo.RemoveMDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Checks status of Update Regional Job.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.RemoveMDB.proc.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//	 Usage:
//
//				DECLARE	@StatusID		INT
//				EXEC	dbo.CheckRegionalJob	
//								@RegionalJobName	= '',
//								@StatusID			= @StatusID OUTPUT
//
*/ 
-- =============================================
BEGIN


		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		IF	NOT EXISTS	(
							SELECT			TOP 1 1
							FROM			msdb.dbo.sysjobs a 
							WHERE			name			= @RegionalJobName
						)
						RETURN

		--				DISABLE the Regional Update Job
		EXEC			msdb.dbo.sp_update_job
								@job_name				= @RegionalJobName,
								@enabled				= 0 

		IF OBJECT_ID('tempdb..#JobCurrentStatus') IS NOT NULL
			DROP TABLE #JobCurrentStatus
		CREATE TABLE #JobCurrentStatus
						( 
							Job_ID uniqueidentifier, 
							Last_Run_Date int, 
							Last_Run_Time int, 
							Next_Run_Date int, 
							Next_Run_Time int, 
							Next_Run_Schedule_ID int, 
							Requested_To_Run int, 
							Request_Source int, 
							Request_Source_ID varchar(100), 
							Running int, 
							Current_Step int, 
							Current_Retry_Attempt int, 
							State int 
						)       

		INSERT INTO		#JobCurrentStatus 
		EXEC			MASTER.dbo.xp_sqlagent_enum_jobs 1, ''


		SELECT			@StatusID						= CASE WHEN b.Running <> 1 THEN 0 ELSE 1 END
		FROM			msdb.dbo.sysjobs a 
		JOIN			#JobCurrentStatus b
		ON				a.Job_ID = b.Job_ID
		WHERE			a.name							= @RegionalJobName
		AND				b.Running						<> 1

		SELECT			@StatusID						= ISNULL(@StatusID, 0)

		--				ENABLE the Regional Update Job if it is currently running
		IF				( @StatusID <> 0 )
						EXEC	msdb.dbo.sp_update_job
									@job_name			= @RegionalJobName,
									@enabled			= 1 

		DROP TABLE #JobCurrentStatus


END
GO
