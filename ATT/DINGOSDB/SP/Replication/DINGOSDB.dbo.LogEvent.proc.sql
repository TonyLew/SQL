Use DINGOSDB
GO


IF ISNULL(OBJECT_ID('dbo.LogEvent'), 0) > 0 
	DROP PROCEDURE dbo.LogEvent
GO


CREATE PROCEDURE [dbo].[LogEvent]
		@LogID					INT					= NULL,
		@EventLogStatusID		INT					= NULL,
		@JobID					UNIQUEIDENTIFIER	= NULL,
		@JobName				VARCHAR(200)		= NULL,
		@DBID					INT					= NULL,
		@DBComputerName			VARCHAR(50)			= NULL,
		@Description			VARCHAR(200)		= NULL,
		@LogIDOUT				INT					= NULL OUTPUT
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
// Module:  dbo.LogEvent
// Created: 2014-Jul-20
// Author:  Tony Lew
// 
// Purpose: Interface to the DINGOSDB EventLog for universal logging.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.LogEvent.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @LogIDReturn INT
//				EXEC	dbo.LogEvent 
//							@LogID					= NULL,
//							@EventLogStatusID		= 1,
//							@JobID					= NULL,
//							@JobName				= NULL,
//							@DBID					= NULL,
//							@DBComputerName			= NULL,
//							@LogIDOUT				= @LogIDReturn OUTPUT
//				
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@ComputerName	VARCHAR(50)

		IF (@EventLogStatusID IS NULL AND @LogID IS NULL) RETURN	--Nothing to log

		IF (@LogID IS NULL)
		BEGIN
					INSERT		dbo.EventLog
								(
									EventLogStatusID,
									JobID,
									JobName,
									DBID,
									DBComputerName,
									StartDate
								)
					SELECT 
									@EventLogStatusID		AS EventLogStatusID,
									@JobID					AS JobID,
									@JobName				AS JobName,
									@DBID					AS DBID,
									@DBComputerName			AS DBComputerName,
									GETUTCDATE()			AS StartDate

					SELECT		@LogIDOUT = @@IDENTITY
		END		
		ELSE
		BEGIN
					UPDATE		dbo.EventLog
					SET			FinishDate					= GETUTCDATE(),
								EventLogStatusID			= ISNULL(@EventLogStatusID, EventLogStatusID),
								Description					= @Description
					WHERE		EventLogID					= @LogID
		END


END

GO

