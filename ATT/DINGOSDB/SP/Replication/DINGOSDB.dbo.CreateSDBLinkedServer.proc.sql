
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.CreateSDBLinkedServer'), 0) > 0 
	DROP PROCEDURE dbo.CreateSDBLinkedServer
GO


CREATE PROCEDURE [dbo].[CreateSDBLinkedServer]
		@ReplicationClusterID		INT,
		@SDBSystemName				NVARCHAR(100),
		@LoginName					NVARCHAR(100) = NULL,
		@LoginPWD					NVARCHAR(100) = NULL,
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
// Module:  dbo.CreateSDBLinkedServer
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Linked Server for each physical SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateSDBLinkedServer.proc.sql 3246 2013-12-09 19:42:44Z tlew $
//    
//	 Usage:
//
//				DECLARE	@Err INT
//				EXEC	DINGOSDB.dbo.CreateSDBLinkedServer	
//								@ReplicationClusterID		= 1,
//								@SDBSystemName				= N'',
//								@LoginName					= N'nbrownett@mcc2-lailab',
//								@LoginPWD					= '',
//								@ERROR						= @Err OUTPUT
//				SELECT	@Err
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@datasource								NVARCHAR(100) = @SDBSystemName --+ N'\MSSQLSERVER'
				DECLARE			@LastStepName							VARCHAR(50)
				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@Msg									VARCHAR(200)


				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBLinkedServer First Step'

				IF				( @EventLogStatusID IS NOT NULL )
								EXEC	dbo.LogEvent 
													@LogID				= NULL,
													@EventLogStatusID	= @EventLogStatusID,			----Started Step
													@JobID				= NULL,
													@JobName			= N'Check SDB Replication',
													@DBID				= @ReplicationClusterID,
													@DBComputerName		= @@SERVERNAME,
													@LogIDOUT			= @LogIDReturn OUTPUT

				SELECT			@LastStepName							= 'Check ' + @SDBSystemName + ' linked server existence: '

				IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @SDBSystemName)
				BEGIN

								SELECT		@LastStepName				= 'Create ' + @SDBSystemName + ' linked server: '
								EXEC		sp_addlinkedserver			
													@server				= @SDBSystemName, 
													@srvproduct			= N'', 
													@provider			= N'SQLNCLI', 
													@datasrc			= @datasource,
													@catalog			= N'mpeg'
								SELECT		@ERROR						= @@ERROR,
											@ERRNum						= @@ERROR

								SELECT		@LastStepName				= 'Create ' + @SDBSystemName + ' linked server login: '
								EXEC		sp_addlinkedsrvlogin 
													@rmtsrvname			= @SDBSystemName, 
													@locallogin			= N'sa', 
													@useself			= N'False', 
													@rmtuser			= @LoginName, 
													@rmtpassword		= @LoginPWD
								SELECT		@ERROR						= @ERROR + @@ERROR,
											@ERRNum						= @ERRNum + @@ERROR

								SELECT		@LastStepName				= 'Set ' + @SDBSystemName + ' linked server rpc to true: '
								EXEC		sp_serveroption 
													@server				= @SDBSystemName, 
													@optname			= N'rpc', 
													@optvalue			= N'true'
								SELECT		@ERROR						= @ERROR + @@ERROR,
											@ERRNum						= @ERRNum + @@ERROR

								SELECT		@LastStepName				= 'Create ' + @SDBSystemName + ' linked server rpc out to true: '
								EXEC		sp_serveroption	
													@server				= @SDBSystemName, 
													@optname			= N'rpc out', 
													@optvalue			= N'true'
								SELECT		@ERROR						= @ERROR + @@ERROR,
											@ERRNum						= @ERRNum + @@ERROR

								SELECT		@LastStepName				= 'Create ' + @SDBSystemName + ' linked server data access to true: '
								EXEC		sp_serveroption	
													@server				= @SDBSystemName, 
													@optname			= N'DATA ACCESS', 
													@optvalue			= N'true'
								SELECT		@ERROR						= @ERROR + @@ERROR,
											@ERRNum						= @ERRNum + @@ERROR

				END
				ELSE
								SELECT		@ERROR						= 0

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBLinkedServer Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBLinkedServer Fail Step'
				
				SET				@Msg			= 'Last Step -- > ' + @LastStepName + ISNULL(@ErrMsg, '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg

END

GO
