Use DINGODB
GO


IF ISNULL(OBJECT_ID('dbo.GetActiveMDB'), 0) > 0 
	DROP PROCEDURE dbo.GetActiveMDB
GO

CREATE PROCEDURE [dbo].[GetActiveMDB]
		@MDBSourceID			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				NVARCHAR(200),
		@MDBNameActive			VARCHAR(32) OUT
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
// Module:  dbo.GetActiveMDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the computer name of the active node for the given MDB logical node 
//			for both the definition table retrieval and for HAdb access
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetActiveMDB.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @MDBNameActiveResult VARCHAR(50)
//				EXEC	dbo.GetActiveMDB 
//						@MDBSourceID				= 1,
//						@JobID						= '', 
//						@JobName					= 'JobName', 
//						@MDBNameActive				= @MDBNameActiveResult OUTPUT
//				SELECT	@MDBNameActiveResult
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@CMD 										NVARCHAR(1000)
		DECLARE		@CMDOUT 									NVARCHAR(30)
		DECLARE		@StatusPOUT 								NVARCHAR(30)
		DECLARE		@StatusBOUT 								NVARCHAR(30)
		DECLARE		@ParmDefinition								NVARCHAR(500)
		DECLARE		@MDBNamePrimary 							VARCHAR(32)
		DECLARE		@MDBNameSecondary	 						VARCHAR(32)
		DECLARE		@EventLogStatusID							INT
		DECLARE		@LogIDReturn								INT

		SELECT		@MDBNameActive		= NULL
		
		SELECT			@MDBNamePrimary							= a.MDBComputerName
		FROM			dbo.MDBSourceSystem a (NOLOCK)
		WHERE 			a.MDBSourceID							= @MDBSourceID
		AND				a.Role									= 1
		AND				a.Enabled								= 1 

		SELECT			@MDBNameSecondary						= a.MDBComputerName
		FROM			dbo.MDBSourceSystem a (NOLOCK)
		WHERE 			a.MDBSourceID							= @MDBSourceID
		AND				a.Role									= 2
		AND				a.Enabled								= 1 

		BEGIN TRY
			SET				@CMD =	'SELECT TOP 1 @Status = ''Ready'' ' +
									'FROM [' + @MDBNamePrimary + '].HAdb.dbo.HAMachine WITH (NOLOCK) '
			SET				@ParmDefinition = N'@Status varchar(30) OUTPUT'
			EXECUTE			sp_executesql	@CMD, @ParmDefinition, @Status = @CMDOUT OUTPUT
			IF				( @CMDOUT = 'Ready')	SELECT		@MDBNameActive = @MDBNamePrimary

		END TRY
		BEGIN CATCH

						SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Primary MDB Failure'
						EXEC		dbo.LogEvent 
											@LogID				= NULL,
											@EventLogStatusID	= @EventLogStatusID,			----Log Failure
											@JobID				= @JobID,
											@JobName			= @JobName,
											@DBID				= @MDBSourceID,
											@DBComputerName		= @MDBNamePrimary,	
											@LogIDOUT			= @LogIDReturn OUTPUT
						EXEC		dbo.LogEvent 
											@LogID				= @LogIDReturn, 
											@EventLogStatusID	= @EventLogStatusID, 
											@Description		= NULL
						SELECT		@MDBNameActive				= NULL

		END CATCH

		IF			( @MDBNameActive IS NULL )
		BEGIN
					BEGIN TRY
						SET				@CMD =	'SELECT TOP 1 @Status = ''Ready'' ' +
												'FROM [' + @MDBNamePrimary + '].HAdb.dbo.HAMachine WITH (NOLOCK) '
						SET				@ParmDefinition = N'@Status varchar(30) OUTPUT'
						EXECUTE			sp_executesql	@CMD, @ParmDefinition, @Status = @CMDOUT OUTPUT
						IF				( @CMDOUT = 'Ready')	SELECT		@MDBNameActive = @MDBNameSecondary
						ELSE									SELECT		@MDBNameActive = NULL

					END TRY
					BEGIN CATCH

						SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Secondary MDB Failure'
						EXEC		dbo.LogEvent 
											@LogID				= NULL,
											@EventLogStatusID	= @EventLogStatusID,			----Log Failure
											@JobID				= @JobID,
											@JobName			= @JobName,
											@DBID				= @MDBSourceID,
											@DBComputerName		= @MDBNameSecondary,
											@LogIDOUT			= @LogIDReturn OUTPUT
						EXEC		dbo.LogEvent 
											@LogID				= @LogIDReturn, 
											@EventLogStatusID	= @EventLogStatusID, 
											@Description		= NULL
						SELECT		@MDBNameActive				= NULL

					END CATCH
		END


END

GO


