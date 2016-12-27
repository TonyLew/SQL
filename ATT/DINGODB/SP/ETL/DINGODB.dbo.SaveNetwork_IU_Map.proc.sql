Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveNetwork_IU_Map'), 0) > 0 
	DROP PROCEDURE dbo.SaveNetwork_IU_Map
GO

CREATE PROCEDURE [dbo].[SaveNetwork_IU_Map]
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
// Module:  dbo.SaveNetwork_IU_Map
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts a SPOT network id to IU id mapping table to DINGODB so that the mapping table is preserved.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveNetwork_IU_Map.proc.sql 3772 2014-03-20 15:01:33Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveNetwork_IU_Map 
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

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#Network_IU_Mapped'), 0) > 0 
				DROP TABLE		#Network_IU_Mapped

		CREATE TABLE	#Network_IU_Mapped 
						(
							ID INT Identity(1,1),
							REGIONALIZED_NETWORK_IU_MAP_ID int,
							REGIONALIZED_NETWORK_ID int,
							REGIONALIZED_IU_ID int,
							NETWORK_ID int,
							IU_ID int,
							msrepl_tran_version uniqueidentifier
						)


		IF		ISNULL(OBJECT_ID('tempdb..#Network_IU_Map'), 0) > 0 
				DROP TABLE		#Network_IU_Map

		CREATE TABLE	#Network_IU_Map 
						(
							ID INT Identity(1,1),
							NETWORK_ID int,
							IU_ID int,
							msrepl_tran_version uniqueidentifier
						)



		SET			@CMD			= 
		'INSERT		#Network_IU_Map
					(
							NETWORK_ID,
							IU_ID,
							msrepl_tran_version
					)
		SELECT
							NETWORK_ID,
							IU_ID,
							msrepl_tran_version
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.NETWORK_IU_MAP a WITH (NOLOCK)  '

		--SELECT			@CMD
		EXECUTE		sp_executesql	@CMD


		INSERT		#Network_IU_Mapped ( REGIONALIZED_NETWORK_IU_MAP_ID, REGIONALIZED_NETWORK_ID, REGIONALIZED_IU_ID, NETWORK_ID, IU_ID, msrepl_tran_version )
		SELECT
					NM.REGIONALIZED_NETWORK_IU_MAP_ID,
					RN.REGIONALIZED_NETWORK_ID,
					RIU.REGIONALIZED_IU_ID,
					a.NETWORK_ID,
					a.IU_ID,
					a.msrepl_tran_version
		FROM		#Network_IU_Map a
		LEFT JOIN	(
							SELECT		REGIONALIZED_NETWORK_ID, NETWORKID AS NETWORK_ID
							FROM		dbo.REGIONALIZED_NETWORK (NOLOCK)
							WHERE		REGIONID				= @RegionID
					) RN
		ON			a.NETWORK_ID								= RN.NETWORK_ID
		LEFT JOIN	(
							SELECT		REGIONALIZED_IU_ID, IU_ID
							FROM		dbo.REGIONALIZED_IU (NOLOCK)
							WHERE		REGIONID				= @RegionID
					) RIU
		ON			a.IU_ID										= RIU.IU_ID
		LEFT JOIN	dbo.REGIONALIZED_NETWORK_IU_MAP NM (NOLOCK)
		ON			RN.REGIONALIZED_NETWORK_ID					= NM.REGIONALIZED_NETWORK_ID
		AND			RIU.REGIONALIZED_IU_ID						= NM.REGIONALIZED_IU_ID


		BEGIN TRY

			DELETE		dbo.REGIONALIZED_NETWORK_IU_MAP
			FROM		dbo.REGIONALIZED_NETWORK_IU_MAP a
			JOIN		dbo.REGIONALIZED_NETWORK (NOLOCK) b
			ON			a.REGIONALIZED_NETWORK_ID				= b.REGIONALIZED_NETWORK_ID
			JOIN		dbo.REGIONALIZED_IU (NOLOCK) c
			ON			a.REGIONALIZED_IU_ID					= c.REGIONALIZED_IU_ID
			LEFT JOIN	#Network_IU_Mapped TMap
			ON			b.NETWORKID								= TMap.NETWORK_ID
			AND			c.IU_ID									= TMap.IU_ID
			WHERE		b.REGIONID								= @RegionID
			AND			c.REGIONID								= @RegionID
			AND			TMap.REGIONALIZED_NETWORK_IU_MAP_ID		IS NULL

			UPDATE		dbo.REGIONALIZED_NETWORK_IU_MAP
			SET			
						REGIONALIZED_NETWORK_ID					= a.REGIONALIZED_NETWORK_ID,
						REGIONALIZED_IU_ID						= a.REGIONALIZED_IU_ID,
						msrepl_tran_version						= a.msrepl_tran_version,
						UpdateDate								= GETUTCDATE()
			FROM		#Network_IU_Mapped a
			JOIN		dbo.REGIONALIZED_NETWORK_IU_MAP b
			ON			a.REGIONALIZED_NETWORK_IU_MAP_ID		= b.REGIONALIZED_NETWORK_IU_MAP_ID
			WHERE		a.msrepl_tran_version					<> b.msrepl_tran_version

			INSERT		dbo.REGIONALIZED_NETWORK_IU_MAP
						(
								REGIONALIZED_NETWORK_ID,
								REGIONALIZED_IU_ID,
								msrepl_tran_version,
								CreateDate
						)
			SELECT
						a.REGIONALIZED_NETWORK_ID,
						a.REGIONALIZED_IU_ID,
						a.msrepl_tran_version,
						GETUTCDATE() 
			FROM		#Network_IU_Mapped a
			WHERE		a.REGIONALIZED_NETWORK_IU_MAP_ID		IS NULL
			AND			a.REGIONALIZED_NETWORK_ID				IS NOT NULL
			AND			a.REGIONALIZED_IU_ID					IS NOT NULL

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map Success Step'
			SET			@ErrorID = 0
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#Network_IU_Map

END

GO


