



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLAllSpotExecute'), 0) > 0 
	DROP PROCEDURE dbo.ETLAllSpotExecute
GO

CREATE PROCEDURE dbo.ETLAllSpotExecute 
				@ParentProcID		INT,
				@SPParamValues		UDT_VarChar500 READONLY,
				@SDBID				UDT_Int READONLY
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
// Module:  dbo.ETLAllSpotExecute
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Traverse all SDBs and execute the command given.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLAllSpotExecute.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				DECLARE		@SDBIDIN UDT_Int 
//				INSERT		@SDBIDIN (value ) values ( 1 )
//				DECLARE		@parametervaluesIN UDT_VarChar50 
//				INSERT		@parametervaluesIN (value ) values ( '5000' )
//				EXEC			dbo.ETLAllSpotExecute	
//									@ParentProcID		= 123,
//									@SPParamValues		= @parametervaluesIN,
//									@SDBID				= @SDBIDIN
//
//
//				SELECT CMD = '', CMDParam = '', CMDType = 'INSERT-EXEC', Name = 'ReportAllSpotReport'

*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				IF				OBJECT_ID('tempdb..#CMDTable') IS NOT NULL DROP TABLE #CMDTable
				CREATE TABLE	#CMDTable		(
													id int identity(1,1),
													RegionID int,  
													SDBSourceID int,  
													SDBSourceSystemID int, 
													SDBSourceSystemName varchar(200), 
													MPEGDBName varchar(200), 
													CurrentCMD nvarchar(MAX)
												)

				IF				OBJECT_ID('tempdb..#ParameterIN') IS NOT NULL DROP TABLE #ParameterIN
				CREATE TABLE	#ParameterIN	(
													id int identity(1,1), 
													Name varchar(256), 
													Type varchar(256), 
													ParameterID int 
												)


				DECLARE			@parentSPName							VARCHAR(100)
				DECLARE			@CMD									NVARCHAR(4000)
				DECLARE			@CMDParam								NVARCHAR(4000)
				DECLARE			@FinalCMD								NVARCHAR(4000)
				DECLARE			@CurrentCMD								NVARCHAR(4000)
				DECLARE			@TotalSDB								INT
				DECLARE			@CurrentSDBID							INT = 1
				DECLARE			@TotalParams							INT
				DECLARE			@i										INT = 1
				DECLARE			@CMDparamsIN							NVARCHAR(MAX)
				DECLARE			@currentparameter						VARCHAR(256)
				DECLARE			@currenttype							VARCHAR(256)
				DECLARE			@currentvalue							VARCHAR(500)
				DECLARE			@currenttypetest						INT
				DECLARE			@TotalSDBID								INT

				DECLARE			@ParmDefinition							NVARCHAR(2000) = N' @CMD NVARCHAR(2000) OUTPUT, @CMDParam NVARCHAR(2000) OUTPUT '
				DECLARE			@ReplicationClusterName					VARCHAR(50)


				SELECT			TOP 1 @TotalSDBID						= r.ID
				FROM			@SDBID r
				ORDER BY		r.ID DESC
				SELECT			@TotalSDBID								= ISNULL(@TotalSDBID, 0)

				SELECT			@parentSPName							= OBJECT_NAME(@ParentProcID)
				IF				(@parentSPName IS NULL) return
				--select			@parentSPName


				INSERT			#ParameterIN ( Name , Type , ParameterID )
				SELECT			b.name, c.name, b.parameter_id 
				FROM			sys.procedures a (NOLOCK)
				JOIN			sys.parameters b (NOLOCK)				ON a.object_id = b.object_id
				--JOIN			sys.systypes c (NOLOCK)					ON b.system_type_id = c.xusertype
				JOIN			sys.types c (NOLOCK)					ON b.user_type_id = c.user_type_id
				WHERE			a.name									= @parentSPName
				AND				b.parameter_id							> 4
				ORDER BY		b.parameter_id
				SELECT			@TotalParams							= SCOPE_IDENTITY()

				--SELECT			@CMD									= CMD, 
				--				@CMDParam								= CMDParam 
				--FROM			[DINGOSDB_HOST].DINGOSDB.dbo.MPEGArticle with (NOLOCK)
				--WHERE			CMDType									= 'INSERT-EXEC' 
				--AND				Name									= @parentSPName

				SELECT			TOP 1 @ReplicationClusterName			= Name 
				FROM			DINGODB.dbo.ReplicationCluster WITH (NOLOCK)
				WHERE			Enabled = 1
				AND				ReplicationClusterID					> 0

				SELECT			@CurrentCMD								=	N'SELECT	@CMD		= CMD,		' +
																			N'			@CMDParam	= CMDParam	' + 
																			N'FROM		['+@ReplicationClusterName+'].DINGOSDB.dbo.MPEGArticle with (NOLOCK) ' +
																			N'WHERE		CMDType		= ''INSERT-EXEC''  ' +
																			N'AND		Name		= ''' + @parentSPName + ''' '
				EXECUTE			sys.sp_executesql						@CurrentCMD, @ParmDefinition, @CMD=@CMD OUTPUT, @CMDParam=@CMDParam OUTPUT


				WHILE			(@i <= @TotalParams AND @i > 0)
				BEGIN


								SELECT		@currentparameter			= a.name,
											@currenttype				= a.type 
								FROM		#ParameterIN a
								WHERE		a.id						= @i

								SELECT		@currentvalue				= ISNULL(a.value , 'Null')
								FROM		@SPParamValues a
								WHERE		a.id						= @i

								SELECT		@currenttypetest			=	CASE 
																				WHEN @currentvalue = 'Null' THEN 3
																				WHEN @currenttype IN ('char','date','datetime','datetime2','datetimeoffset','nchar','ntext','nvarchar','smalldatetime','sysname','time','timestamp','uniqueidentifier','varbinary','varchar') THEN 2
																				WHEN @currenttype IN ('bigint') AND  TRY_PARSE( @currentvalue as bigint ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('bit') THEN 1
																				WHEN @currenttype IN ('date') AND  TRY_PARSE( @currentvalue as date ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('datetime') AND  TRY_PARSE( @currentvalue as datetime ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('datetime2') AND  TRY_PARSE( @currentvalue as datetime2 ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('datetimeoffset') AND  TRY_PARSE( @currentvalue as datetimeoffset ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('decimal') AND  TRY_PARSE( @currentvalue as decimal ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('float') AND  TRY_PARSE( @currentvalue as float ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('int') AND  TRY_PARSE( @currentvalue as int ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('money') AND  TRY_PARSE( @currentvalue as money ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('numeric') AND  TRY_PARSE( @currentvalue as numeric ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('real') AND  TRY_PARSE( @currentvalue as real ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('smalldatetime') AND  TRY_PARSE( @currentvalue as smalldatetime ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('smallint') AND  TRY_PARSE( @currentvalue as smallint ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('smallmoney') AND  TRY_PARSE( @currentvalue as smallmoney ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('time') AND  TRY_PARSE( @currentvalue as time ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('tinyint') AND  TRY_PARSE( @currentvalue as tinyint ) IS NOT NULL THEN 1
																				ELSE 0
																			END

								IF			(@currenttypetest > 0)
								BEGIN		
											SELECT @CMDparamsIN			=	CASE	
																				WHEN @currenttypetest = 3 AND (@i < @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=' + @currentvalue + ', '
																				WHEN @currenttypetest = 3 AND (@i = @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=' + @currentvalue + ' '
																				WHEN @currenttypetest = 2 AND (@i < @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=''' + @currentvalue + ''', '
																				WHEN @currenttypetest = 1 AND (@i < @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=' + @currentvalue + ', '
																				WHEN @currenttypetest = 2 AND (@i = @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=''' + @currentvalue + ''' '
																				WHEN @currenttypetest = 1 AND (@i = @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=' + @currentvalue + ' '
																			END
											SET @i = @i + 1
								END
								ELSE		SET @i = 0


				END


				IF				( @i > @totalparams OR @totalparams = 0 )
				BEGIN

								SET				@FinalCMD				=	N'declare @cmd nvarchar(500) '
								SET				@FinalCMD				=	@FinalCMD + N'declare @paramsIN NVARCHAR(500) = N''' + @CMDParam + ''' '
								SET				@FinalCMD				=	@FinalCMD + N'set @cmd = N'''+@CMD+''' '

								INSERT			#CMDTable ( RegionID, SDBSourceID,  SDBSourceSystemID, SDBSourceSystemName, MPEGDBName, CurrentCMD )
								SELECT			RegionID				= m.RegionID, 
												SDBSourceID				= a.SDBSourceID,  
												SDBSourceSystemID		= a.SDBSourceSystemID, 
												SDBSourceSystemName		= a.SDBComputerName, 
												MPEGDBName				= 'MPEG' + CAST(SDBSourceSystemID AS VARCHAR(50)), 
												CurrentCMD				=	REPLACE( REPLACE(@FinalCMD, 'MPEGN', 'MPEG' + CAST(SDBSourceSystemID AS VARCHAR(50))), '@ReplicationCluster', d.Name ) + 
																			N'exec sp_executesql @stmt = @cmd, @params = @paramsIN, ' + 
																			'@RegionID		= ' + CAST(m.RegionID AS VARCHAR(50)) + ', ' +
																			'@SDBSourceID	= ' + CAST(a.SDBSourceID AS VARCHAR(50)) + ', ' +
																			'@SDBName		= ''' + CAST(a.SDBComputerName AS VARCHAR(100)) + ''', ' +
																			'@UTCOffset		= ' + CAST(ISNULL(b.UTCOffset, 0) AS VARCHAR(50)) + ' ' +
																			ISNULL(', ' + @CMDparamsIN, '')
								FROM			DINGODB.dbo.SDBSourceSystem a WITH (NOLOCK)
								JOIN			DINGODB.dbo.SDBSource b WITH (NOLOCK)
								ON				a.SDBSourceID			= b.SDBSourceID
								JOIN			DINGODB.dbo.MDBSource m WITH (NOLOCK)
								ON				b.MDBSourceID			= m.MDBSourceID
								JOIN			DINGODB.dbo.ReplicationCluster d WITH (NOLOCK)
								ON				b.ReplicationClusterID	= d.ReplicationClusterID
								LEFT JOIN		@SDBID r
								ON				a.SDBSourceID			= r.Value
								WHERE			a.Role					= CASE WHEN b.SDBStatus = 1 THEN 1 WHEN b.SDBStatus = 5 THEN 2 END
								AND				a.Enabled				= 1
								AND				d.Enabled				= 1
								AND				( r.value IS NOT NULL OR @TotalSDBID = 0)
								SELECT			@TotalSDB				= SCOPE_IDENTITY()
								SELECT			@TotalSDB				= ISNULL(@TotalSDB,0)

				END
				ELSE			SELECT			@TotalSDB				= 0


				WHILE			( @CurrentSDBID <= @TotalSDB )
				BEGIN
								
								SELECT		@CurrentCMD					= a.CurrentCMD
								FROM		#CMDTable a
								WHERE		a.id						= @CurrentSDBID 

								EXECUTE		sys.sp_executesql			@CurrentCMD
								SET			@CurrentSDBID				= @CurrentSDBID + 1

				END

				DROP TABLE		#CMDTable
				DROP TABLE		#ParameterIN

END
GO