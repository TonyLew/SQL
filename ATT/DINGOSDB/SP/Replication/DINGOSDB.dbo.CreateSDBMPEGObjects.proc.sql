
Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.CreateSDBMPEGObjects'), 0) > 0 
	DROP PROCEDURE dbo.CreateSDBMPEGObjects
GO


CREATE PROCEDURE [dbo].[CreateSDBMPEGObjects]
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
// Module:  dbo.CreateSDBMPEGObjects
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates an SDB's MPEG DB objects.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.CreateSDBMPEGObjects.proc.sql 3246 2013-12-09 19:42:44Z tlew $
//    
//	 Usage:
//
//				DECLARE	@Err INT
//				EXEC	DINGOSDB.dbo.CreateSDBMPEGObjects	
//								@ReplicationClusterID					= 1,
//								@SDBSystemID							= 1,
//								@SDBMPEGDBName							= N'',
//								@ERROR									= @Err OUTPUT
//				SELECT	@Err
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@CMDImportBreakCountHistory				NVARCHAR(500)
				DECLARE			@CMDImportTrafficAndBillingData			NVARCHAR(500)
				DECLARE			@CMDImportChannelAndConflictStats		NVARCHAR(500)
				DECLARE			@CMDImportBreakCountHistorySP			NVARCHAR(2000)
				DECLARE			@CMDImportTrafficAndBillingDataSP		NVARCHAR(2000)
				DECLARE			@CMDImportChannelAndConflictStatsSP		NVARCHAR(2000)
				DECLARE			@LastStepName							VARCHAR(50)
				DECLARE			@EventLogStatusID						INT
				DECLARE			@LogIDReturn							INT
				DECLARE			@ERRNum									INT
				DECLARE			@ErrMsg									VARCHAR(100)
				DECLARE			@Msg									VARCHAR(200)
				DECLARE			@UseStatement							NVARCHAR(100)
				DECLARE			@ExecStatment							NVARCHAR(500)
				DECLARE			@ParamStatement							NVARCHAR(100)

				DECLARE			@ResultsMPEGArticle						UDT_Int
				DECLARE			@CMDPreSP								NVARCHAR(2000) 
				DECLARE			@CMDSP									NVARCHAR(MAX) 
				DECLARE			@TotalSP								INT
				DECLARE			@i										INT = 1
				DECLARE			@CurrentSPName							NVARCHAR(200) 

				SELECT			@UseStatement							=	N'Use ' + @SDBMPEGDBName + CHAR(13)+CHAR(10) + '; ' 
				SELECT			@ExecStatment							=	N'EXEC '+ @SDBMPEGDBName +'.dbo.SP_EXECUTESQL @SQLString '
				SELECT			@ParamStatement							=	N'@SQLString nvarchar(MAX)'

				--				This portion "can" be replaced by the general SSRS SP creation statements
				--				However, for the purpose of distinction, the statements are separated (ETL vs SSRS)
				SELECT			@CMDImportBreakCountHistory				=	@UseStatement + 'IF ( ISNULL(OBJECT_ID('''+ @SDBMPEGDBName +'.dbo.ImportBreakCountHistory''), 0) > 0 ) DROP PROCEDURE dbo.ImportBreakCountHistory; ' + @ExecStatment
				SELECT			@CMDImportBreakCountHistorySP			=	CMD FROM dbo.MPEGArticle (NOLOCK) WHERE CMDType = 'SP' and Name = 'ImportBreakCountHistory'
				SELECT			@CMDImportChannelAndConflictStats		=	@UseStatement + 'IF ( ISNULL(OBJECT_ID('''+ @SDBMPEGDBName +'.dbo.ImportChannelAndConflictStats''), 0) > 0 ) DROP PROCEDURE dbo.ImportChannelAndConflictStats; ' + @ExecStatment
				SELECT			@CMDImportChannelAndConflictStatsSP		=	CMD  FROM dbo.MPEGArticle (NOLOCK) WHERE CMDType = 'SP' and Name = 'ImportChannelAndConflictStats'
				SELECT			@CMDImportTrafficAndBillingData			=	@UseStatement + 'IF ( ISNULL(OBJECT_ID('''+ @SDBMPEGDBName +'.dbo.ImportTrafficAndBillingData''), 0) > 0 ) DROP PROCEDURE dbo.ImportTrafficAndBillingData; ' + @ExecStatment
				SELECT			@CMDImportTrafficAndBillingDataSP		=	CMD  FROM dbo.MPEGArticle (NOLOCK) WHERE CMDType = 'SP' and Name = 'ImportTrafficAndBillingData'

				
				SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGObjects First Step'

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
				IF				EXISTS(SELECT TOP 1 1 FROM sys.databases WHERE name = ISNULL(@SDBMPEGDBName, name))
				BEGIN

								--				ETL SPs
								SELECT			@LastStepName = 'Create ImportBreakCountHistory SP: '
								--EXEC			( @CMDImportBreakCountHistory )
								EXEC			sp_executesql  @CMDImportBreakCountHistory, @ParamStatement, @SQLString=@CMDImportBreakCountHistorySP
								SELECT			@ERROR					= @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()

								SELECT			@LastStepName = 'Create ImportChannelAndConflict SP: '
								--EXEC			( @CMDImportChannelAndConflictStats )
								EXEC			sp_executesql  @CMDImportChannelAndConflictStats, @ParamStatement, @SQLString=@CMDImportChannelAndConflictStatsSP
								SELECT			@ERROR					= @ERROR + @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()

								SELECT			@LastStepName = 'Create ImportTrafficAndBillingData SP: '
								--EXEC			( @CMDImportTrafficAndBillingData )
								EXEC			sp_executesql  @CMDImportTrafficAndBillingData, @ParamStatement, @SQLString=@CMDImportTrafficAndBillingDataSP
								SELECT			@ERROR					= @ERROR + @@ERROR,
												@ErrNum					= ERROR_NUMBER(), 
												@ErrMsg					= ERROR_MESSAGE()
								IF				(ISNULL(@ERROR, 0) = 0)	SELECT @ERROR = 0


								--				OTHER SPs
								INSERT			@ResultsMPEGArticle (Value)
								SELECT			a.MPEGArticleID 
								FROM			DINGOSDB.dbo.MPEGArticle a
								WHERE			a.CMDType				= 'SP'
								AND				a.Name					NOT IN ('sp_MSupd_IE','sp_MSupd_SPOT','ImportBreakCountHistory','ImportChannelAndConflictStats','ImportTrafficAndBillingData')

								SELECT			TOP 1 @TotalSP			= a.ID
								FROM			@ResultsMPEGArticle a
								ORDER BY		a.ID DESC

								WHILE			( @i <= @TotalSP )
								BEGIN

												SELECT	TOP 1 
														@CurrentSPName	=	a.Name,
														@CMDSP			=	a.CMD 
												FROM	DINGOSDB.dbo.MPEGArticle a (NOLOCK)
												JOIN	@ResultsMPEGArticle b
												ON		a.MPEGArticleID	= b.Value
												WHERE	b.ID			= @i

												SELECT	@CMDPreSP		=	@UseStatement + 'IF ( ISNULL(OBJECT_ID('''+ @SDBMPEGDBName +'.dbo.'+@CurrentSPName+'''), 0) > 0 ) DROP PROCEDURE dbo.'+@CurrentSPName+'; ' + @ExecStatment
												EXEC	sp_executesql	@CMDPreSP, @ParamStatement, @SQLString=@CMDSP
												SET		@i				= @i + 1

								END


				END
				ELSE			SELECT			@ERROR			= 0

				IF (ISNULL(@ERRNum,0) = 0)	SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGObjects Success Step'
				ELSE						SELECT TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'CreateSDBMPEGObjects Fail Step'
				
				SET				@Msg			= 'Last Step -- > ' + @LastStepName + ISNULL(@ErrMsg, '')

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @Msg
				

END

GO

