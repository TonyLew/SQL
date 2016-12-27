
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.GetSDBInfo'), 0) > 0 
	DROP PROCEDURE dbo.GetSDBInfo
GO

CREATE PROCEDURE [dbo].[GetSDBInfo]
				@ReplicationClusterID						INT
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
// Module:  dbo.GetSDBInfo
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the latest SDB info from DINGODB.  SDBStatus as well as NEW SDB systems.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.GetSDBInfo.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				EXEC		DINGOSDB.dbo.GetSDBInfo	
//								@ReplicationClusterID						= 1
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@i 											INT = 1
				DECLARE			@SQLCMD										NVARCHAR(500)
				DECLARE			@Results									TABLE (id int identity(1,1), SDBSourceSystemID int, SDBState int, NewNode int)

				INSERT			@Results ( SDBSourceSystemID, SDBState, NewNode )
				SELECT			SDBSourceSystemID							= b.SDBSourceSystemID,
								SDBState									= a.SDBStatus,
								NewNode										= CASE WHEN c.SDBSystemID IS NULL THEN 1 ELSE 0 END
				FROM			[DINGODB_HOST].DINGODB.dbo.SDBSource a WITH (NOLOCK)
				JOIN			[DINGODB_HOST].DINGODB.dbo.SDBSourceSystem b WITH (NOLOCK)
				ON				a.SDBSourceID								= b.SDBSourceID
				LEFT JOIN		dbo.SDBSystem c WITH (NOLOCK)
				ON				b.SDBSourceSystemID							= c.SDBSourceSystemID
				WHERE			a.ReplicationClusterID						= @ReplicationClusterID
				AND				b.Enabled									= 1
				AND				c.Enabled									= 1


				--				Update the dbo.SDBSystem table with the latest value of SDBState (1 or 5)
				UPDATE			dbo.SDBSystem
				SET				SDBState									= r.SDBState,
								UpdateDate									= GETUTCDATE()
				FROM			@Results r
				WHERE			SDBSystem.SDBSourceSystemID					= r.SDBSourceSystemID
				AND				r.NewNode									= 0


				--				Insert any new nodes into the dbo.SDBSystem table
				INSERT			dbo.SDBSystem 
							(
								SDBSourceID,
								SDBSourceSystemID,
								SDBSourceName,
								SDBSourceSystemName,
								SDBState,
								Role,
								MPEGDBName,
								Description,
								DBExistence,
								IEExistence,
								Subscribed,
								SubscriptionType,
								Enabled,
								CreateDate,
								UpdateDate
							)
				--OUTPUT			INSERTED.SDBSourceSystemID,
				--				INSERTED.SDBSourceSystemName,
				--				INSERTED.SDBState,
				--				INSERTED.Role,
				--				INSERTED.MPEGDBName
				--INTO			#NewSDBSystems
				SELECT			
								SDBSourceID									= a.SDBSourceID,
								SDBSourceSystemID							= b.SDBSourceSystemID,
								SDBSourceName								= a.SDBComputerNamePrefix,
								SDBSourceSystemName							= b.SDBComputerName,
								SDBState									= 1,	--Since this is a new SDB node, Primary will be the active SDB
								Role										= b.Role,
								MPEGDBName									= 'MPEG' + CAST( b.SDBSourceSystemID AS VARCHAR(50) ),
								Description									= 'MPEG' + CAST( b.SDBSourceSystemID AS VARCHAR(50) ) + ' database entry.',
								DBExistence									= 0,
								IEExistence									= CASE WHEN b.Role = 1 THEN 1 ELSE 0 END,	--The primary is ready to go on NEW nodes
								Subscribed									= 0,
								SubscriptionType							= CASE WHEN b.Role = 1 THEN 'Push' ELSE 'Pull' END,
								Enabled										= b.Enabled,
								CreateDate									= GETUTCDATE(),
								UpdateDate									= GETUTCDATE()
				FROM			[DINGODB_HOST].DINGODB.dbo.SDBSource a WITH (NOLOCK)
				JOIN			[DINGODB_HOST].DINGODB.dbo.SDBSourceSystem b WITH (NOLOCK)
				ON				a.SDBSourceID								= b.SDBSourceID
				JOIN			@Results r
				ON				b.SDBSourceSystemID							= r.SDBSourceSystemID
				WHERE			a.ReplicationClusterID						= @ReplicationClusterID
				AND				r.NewNode									= 1

END


GO
