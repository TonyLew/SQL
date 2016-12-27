Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveNetwork'), 0) > 0 
	DROP PROCEDURE dbo.SaveNetwork
GO

CREATE PROCEDURE [dbo].[SaveNetwork]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
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
// Module:  dbo.SaveNetwork
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts and SPOT Networks to DINGODB and regionalizes the network with a DINGODB network id.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveNetwork.proc.sql 3495 2014-02-12 17:28:01Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveNetwork 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD NVARCHAR(4000)
		DECLARE		@LogIDReturn INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#DeletedNetwork'), 0) > 0 
				DROP TABLE		#DeletedNetwork

		CREATE TABLE	#DeletedNetwork
						(
							ID INT Identity(1,1),
							REGIONALIZED_NETWORK_ID int,
							NETWORKID int,
							Name varchar(32)
						)

		IF		ISNULL(OBJECT_ID('tempdb..#Network'), 0) > 0 
				DROP TABLE		#Network

		CREATE TABLE	#Network
						(
							IncID INT Identity(1,1),
							ID int,
							Name varchar(32),
							Description varchar(255),
							msrepl_tran_version uniqueidentifier
						)


		SET			@CMD			= 
		'INSERT		#Network
					(
							ID,
							Name,
							Description,
							msrepl_tran_version
					)
		SELECT
							ID,
							Name,
							Description,
							msrepl_tran_version
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.NETWORK n WITH (NOLOCK) '

		--SELECT			@CMD


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD


			--			Identify the IDs from the REGIONALIZED_NETWORK table to be deleted
			INSERT		#DeletedNetwork 
					(
						REGIONALIZED_NETWORK_ID,
						NETWORKID,
						Name
					)
			SELECT		a.REGIONALIZED_NETWORK_ID,
						a.NETWORKID,
						a.Name
			FROM		dbo.REGIONALIZED_NETWORK a WITH (NOLOCK)
			LEFT JOIN	#Network b
			ON			a.NETWORKID										= b.ID
			WHERE		a.RegionID										= @RegionID
			AND			b.ID											IS NULL
			

			--			Delete from the tables with FK constraints first
			DELETE		dbo.REGIONALIZED_NETWORK_IU_MAP
			FROM		#DeletedNetwork d
			WHERE		REGIONALIZED_NETWORK_IU_MAP.REGIONALIZED_NETWORK_ID	= d.REGIONALIZED_NETWORK_ID


			DELETE		dbo.REGIONALIZED_NETWORK
			FROM		#DeletedNetwork d
			WHERE		REGIONALIZED_NETWORK.RegionID					= @RegionID
			AND			REGIONALIZED_NETWORK.REGIONALIZED_NETWORK_ID	= d.REGIONALIZED_NETWORK_ID


			UPDATE		dbo.REGIONALIZED_NETWORK
			SET
						Name											= n.Name,
						Description										= n.Description,
						msrepl_tran_version								= n.msrepl_tran_version,
						UpdateDate										= GETUTCDATE()
			FROM		#Network n
			WHERE		REGIONALIZED_NETWORK.RegionID					= @RegionID
			AND			REGIONALIZED_NETWORK.NETWORKID					= n.ID
			AND			REGIONALIZED_NETWORK.msrepl_tran_version		<> n.msrepl_tran_version

			

			INSERT		dbo.REGIONALIZED_NETWORK
						(
								REGIONID,
								NETWORKID,
								NAME,
								DESCRIPTION,
								msrepl_tran_version,
								CreateDate
						)
			SELECT
								@RegionID AS REGIONID,
								a.ID AS NETWORKID,
								a.Name,
								a.Description,
								a.msrepl_tran_version,
								GETUTCDATE()
			FROM				#Network a
			LEFT JOIN			(
									SELECT		NETWORKID
									FROM		dbo.REGIONALIZED_NETWORK (NOLOCK)
									WHERE		REGIONID = @RegionID
								) b
			ON					a.ID									= b.NETWORKID
			WHERE				b.NETWORKID								IS NULL
			ORDER BY			a.IncID

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork Success Step'

		END TRY
		BEGIN CATCH

			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork Fail Step'

		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#Network
		DROP TABLE		#DeletedNetwork

END

GO

