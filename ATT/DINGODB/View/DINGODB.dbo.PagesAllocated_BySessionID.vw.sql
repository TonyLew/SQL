USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.PagesAllocated_BySessionID'), 0) > 0 
	DROP VIEW dbo.PagesAllocated_BySessionID
GO

CREATE VIEW dbo.PagesAllocated_BySessionID 
AS
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
// Module:  dbo.PagesAllocated_BySessionID
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Provides page allocation and lock information by sessionid (SPID).
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.PagesAllocated_BySessionID.vw.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

	SELECT s.session_id    AS 'SessionId',
		   s.login_name    AS 'Login',
		   COALESCE(s.host_name, c.client_net_address) AS 'Host',
		   s.program_name  AS 'Application',
		   t.task_state    AS 'TaskState',
		   r.start_time    AS 'TaskStartTime',
		   r.[status] AS 'TaskStatus',
		   r.wait_type     AS 'TaskWaitType',
		   r.blocking_session_id AS 'blocking_session_id',
		   TSQL.[text] AS 'TSQL',
		   (
			   tsu.user_objects_alloc_page_count - tsu.user_objects_dealloc_page_count
		   ) +(
			   tsu.internal_objects_alloc_page_count - tsu.internal_objects_dealloc_page_count
		   )               AS 'TotalPagesAllocated'
	FROM   sys.dm_exec_sessions s
		   LEFT  JOIN sys.dm_exec_connections c
				ON  s.session_id = c.session_id
		   LEFT JOIN sys.dm_db_task_space_usage tsu
				ON  tsu.session_id = s.session_id
		   LEFT JOIN sys.dm_os_tasks t
				ON  t.session_id = tsu.session_id
				AND t.request_id = tsu.request_id
		   LEFT JOIN sys.dm_exec_requests r
				ON  r.session_id = tsu.session_id
				AND r.request_id = tsu.request_id
		   OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) TSQL
	WHERE  (
			   tsu.user_objects_alloc_page_count - tsu.user_objects_dealloc_page_count
		   ) +(
			   tsu.internal_objects_alloc_page_count - tsu.internal_objects_dealloc_page_count
		   ) > 0;
