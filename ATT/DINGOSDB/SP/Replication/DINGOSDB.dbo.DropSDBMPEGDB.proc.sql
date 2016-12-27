
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.DropSDBMPEGDB'), 0) > 0 
	DROP PROCEDURE dbo.DropSDBMPEGDB
GO


CREATE PROCEDURE [dbo].[DropSDBMPEGDB]
		@ReplicationClusterID		INT,
		@SDBSystemID				INT,
		@SDBMPEGDBName				NVARCHAR(100),
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
// Module:  dbo.DropSDBMPEGDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Drops an SDB's MPEG DB subscription partner.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.DropSDBMPEGDB.proc.sql 3246 2013-12-09 19:42:44Z tlew $
//    
//	 Usage:
//
//				DECLARE	@Err INT
//				EXEC	DINGOSDB.dbo.DropSDBMPEGDB	
//								@ReplicationClusterID		= 1,
//								@SDBSystemID				= 1,
//								@SDBMPEGDBName				= N'',
//								@ERROR						= @Err OUTPUT
//				SELECT	@Err
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@spid									INT
				DECLARE			@i										INT
				DECLARE			@totalspids								INT
				DECLARE			@spids									UDT_Int
				DECLARE			@cmd									NVARCHAR(100)
				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@LastStepName							VARCHAR(50)
				DECLARE			@Msg									VARCHAR(200)


				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'DropSDBMPEGDB First Step'

				IF				( @EventLogStatusID IS NOT NULL )
								EXEC	dbo.LogEvent 
													@LogID				= NULL,
													@EventLogStatusID	= @EventLogStatusID,			----Started Step
													@JobID				= NULL,
													@JobName			= N'Check SDB Replication',
													@DBID				= @ReplicationClusterID,
													@DBComputerName		= @@SERVERNAME,
													@LogIDOUT			= @LogIDReturn OUTPUT

				SELECT			@LastStepName							= 'Check ' + @SDBMPEGDBName + ' database existence: '
				INSERT			@spids (Value)
				SELECT			spid			--, hostname, [program_name], open_tran, hostprocess, cmd
				FROM			master.dbo.sysprocesses 
				WHERE			dbid									= db_id(@SDBMPEGDBName)
				SELECT			@totalspids								= @@ROWCOUNT,
								@i										= 1


				IF				EXISTS(SELECT TOP 1 1 FROM sys.databases WHERE name = @SDBMPEGDBName)
				BEGIN

								SELECT			@LastStepName							= 'Kill ' + @SDBMPEGDBName + ' database connections (if any): '
								--				For each new node, create the associated job.
								WHILE			( @i <= @totalspids )
								BEGIN

												SELECT		@spid		= x.Value 
												FROM		@spids x
												WHERE		x.id		= @i
												SET			@cmd = N'kill ' + cast(@spid as varchar(50))
												EXEC		( @cmd )

												SET			@i			= @i + 1

								END
								SET				@cmd = N'DROP DATABASE ' + @SDBMPEGDBName

								SELECT			@LastStepName = 'Drop ' + @SDBMPEGDBName + ' database: '
								EXEC			( @cmd )
								SELECT			@ERROR					= @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()

				END
				ELSE			SELECT			@ERROR			= 0

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'DropSDBMPEGDB Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'DropSDBMPEGDB Fail Step'
				
				SET				@Msg			= 'Last Step -- > ' + @LastStepName + ISNULL(@ErrMsg, '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg
				

END

GO

