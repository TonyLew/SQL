USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetSDBUTCOffset'), 0) > 0 
	DROP PROCEDURE dbo.GetSDBUTCOffset
GO

CREATE PROCEDURE [dbo].[GetSDBUTCOffset]
		@SDBSourceID		INT,
		@SDBComputerName	VARCHAR(50),
		@Role				INT,
		@JobID				UNIQUEIDENTIFIER,
		@JobName			VARCHAR(100),
		@UTCOffset			INT OUTPUT
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
// Module:  dbo.GetSDBUTCOffset
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the UTCOffset of the given SDB system.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetSDBUTCOffset.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE		@SDBUTCOffset INT
//				EXEC		dbo.GetSDBUTCOffset 
//								@SDBSourceID		= 1,
//								@SDBComputerName	= 'MSSNKNLSDB004B', 
//								@Role				= 1,
//								@JobID				= NULL,
//								@JobName			= ''
//								@UTCOffset			= @SDBUTCOffset OUTPUT
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		SET LOCK_TIMEOUT 1000

		DECLARE			@CMD						NVARCHAR(1000)
		DECLARE			@ParmDefinition				NVARCHAR(500)
		DECLARE			@SDBUTCOffset				INT
		DECLARE			@EventLogStatusID			INT
		DECLARE			@LogIDReturn				INT


		SET				@CMD = 
								'SELECT TOP 1 @Offset = Value
								FROM OPENQUERY(' + @SDBComputerName + ', N''SELECT TOP 1 datepart( tz, SYSDATETIMEOFFSET() ) / 60 AS Value '' )'

		SET				@ParmDefinition = N'@Offset INT OUTPUT'
		BEGIN TRY

						EXECUTE			sp_executesql	@CMD, @ParmDefinition, @Offset = @SDBUTCOffset OUTPUT
						SET				@UTCOffset					= @SDBUTCOffset
						UPDATE			dbo.SDBSource
						SET				UTCOffset					= @SDBUTCOffset
						FROM			dbo.SDBSourceSystem a (NOLOCK)
						WHERE			SDBSource.SDBSourceID		= a.SDBSourceID
						AND				a.SDBComputerName			= @SDBComputerName
						AND				@SDBUTCOffset				IS NOT NULL

		END TRY
		BEGIN CATCH

						SELECT			@UTCOffset					= NULL

		END CATCH

		IF				( @UTCOffset IS NULL AND @Role = 1 )	
						SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Primary SDB Failure'
		ELSE			IF ( @UTCOffset IS NULL AND @Role = 2 )	
						SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Secondary SDB Failure'

		EXEC			dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,			----Log Failure
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBComputerName,	
							@LogIDOUT			= @LogIDReturn OUTPUT
		EXEC			dbo.LogEvent 
							@LogID				= @LogIDReturn, 
							@EventLogStatusID	= @EventLogStatusID, 
							@Description		= NULL



END



GO


