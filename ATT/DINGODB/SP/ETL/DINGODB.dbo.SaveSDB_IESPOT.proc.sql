Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveSDB_IESPOT'), 0) > 0 
	DROP PROCEDURE dbo.SaveSDB_IESPOT
GO

CREATE PROCEDURE [dbo].[SaveSDB_IESPOT]
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
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
// Module:  dbo.SaveSDB_IESPOT
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 			Upserts the SPOT IE to SPOT map to DINGODB and assigns the mapping with a DINGODB IESPOT ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveSDB_IESPOT.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveSDB_IESPOT 
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'MSSNKNLSDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@LogIDReturn		INT
		DECLARE		@ErrNum				INT
		DECLARE		@ErrMsg				VARCHAR(200)
		DECLARE		@EventLogStatusID	INT = 1		--Unidentified Step
		DECLARE		@TempTableCount		INT
		DECLARE		@ZONECount			INT
		DECLARE		@UTCNow				DATETIME					= GETUTCDATE()
		DECLARE		@RegionID			INT


		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		SELECT				TOP 1 @RegionID							= m.RegionID
		FROM				dbo.SDBSource s WITH (NOLOCK)
		JOIN				dbo.MDBSource m WITH (NOLOCK)
		ON					s.MDBSourceID							= m.MDBSourceID
		WHERE				s.SDBSourceID							= @SDBSourceID

		--		Delete channels where the channel did NOT come back on the SDB import
		--		This has larger implications for the SDB_IESPOT table because it is 
		--		being used elsewhere and for different reasons.
		--		Therefore, it is being commented out until further discussion
		--DELETE				a
		--FROM				dbo.SDB_IESPOT a
		--LEFT JOIN			#ImportIE_SPOT b
		--ON					a.SDBSourceID							= b.SDBSourceID
		--AND					a.IU_ID									= b.IU_ID
		--AND					a.SPOT_ID								= b.SPOT_ID
		--WHERE				a.SDBSourceID							= @SDBSourceID
		--AND					b.ImportIE_SPOTID						IS NULL

		BEGIN TRY
			UPDATE			dbo.SDB_IESPOT
			SET
							IU_ID									= a.IU_ID,
							SCHED_DATE								= a.SCHED_DATE,
							SCHED_DATE_TIME							= a.SCHED_DATE_TIME,
							UTC_SCHED_DATE							= a.UTC_SCHED_DATE,
							UTC_SCHED_DATE_TIME						= a.UTC_SCHED_DATE_TIME,
							IE_NSTATUS								= a.IE_NSTATUS,
							IE_CONFLICT_STATUS						= a.IE_CONFLICT_STATUS,
							SPOTS									= a.SPOTS,
							IE_DURATION								= a.IE_DURATION,
							IE_RUN_DATE_TIME						= a.IE_RUN_DATE_TIME,
							UTC_IE_RUN_DATE_TIME					= a.UTC_IE_RUN_DATE_TIME,
							BREAK_INWIN								= a.BREAK_INWIN,
							AWIN_START_DT							= a.AWIN_START_DT,
							AWIN_END_DT								= a.AWIN_END_DT,
							UTC_AWIN_START_DT						= a.UTC_AWIN_START_DT,
							UTC_AWIN_END_DT							= a.UTC_AWIN_END_DT,
							IE_SOURCE_ID							= a.IE_SOURCE_ID,
							VIDEO_ID								= a.VIDEO_ID,
							ASSET_DESC								= a.ASSET_DESC,
							SPOT_DURATION							= a.SPOT_DURATION,
							SPOT_NSTATUS							= a.SPOT_NSTATUS,
							SPOT_CONFLICT_STATUS					= a.SPOT_CONFLICT_STATUS,
							SPOT_ORDER								= a.SPOT_ORDER,
							SPOT_RUN_DATE_TIME						= a.SPOT_RUN_DATE_TIME,
							UTC_SPOT_RUN_DATE_TIME					= a.UTC_SPOT_RUN_DATE_TIME,
							RUN_LENGTH								= a.RUN_LENGTH,
							SPOT_SOURCE_ID							= a.SPOT_SOURCE_ID,
							UTC_SPOT_NSTATUS_UPDATE_TIME			= CASE WHEN SDB_IESPOT.SPOT_NSTATUS			<> a.SPOT_NSTATUS			THEN @UTCNow ELSE UTC_SPOT_NSTATUS_UPDATE_TIME END,
							UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME	= CASE WHEN SDB_IESPOT.SPOT_CONFLICT_STATUS	<> a.SPOT_CONFLICT_STATUS	THEN @UTCNow ELSE UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME END,
							UTC_IE_NSTATUS_UPDATE_TIME				= CASE WHEN SDB_IESPOT.IE_NSTATUS			<> a.IE_NSTATUS				THEN @UTCNow ELSE UTC_IE_NSTATUS_UPDATE_TIME END,
							UTC_IE_CONFLICT_STATUS_UPDATE_TIME		= CASE WHEN SDB_IESPOT.IE_CONFLICT_STATUS	<> a.IE_CONFLICT_STATUS		THEN @UTCNow ELSE UTC_IE_CONFLICT_STATUS_UPDATE_TIME END,

							UpdateDate								= @UTCNow
			FROM			dbo.Conflict c with (NOLOCK)
			JOIN			#ImportIE_SPOT a
			ON				c.SDBSourceID							= a.SDBSourceID
			AND				c.IU_ID									= a.IU_ID
			AND				c.SPOT_ID								= a.SPOT_ID
			WHERE			SDB_IESPOT.SDBSourceID					= a.SDBSourceID
			AND				SDB_IESPOT.SPOT_ID						= a.SPOT_ID
			AND				SDB_IESPOT.IE_ID						= a.IE_ID
			AND				(
							SDB_IESPOT.SPOT_NSTATUS					<> a.SPOT_NSTATUS
							OR SDB_IESPOT.SPOT_CONFLICT_STATUS		<> a.SPOT_CONFLICT_STATUS
							OR SDB_IESPOT.IE_NSTATUS				<> a.IE_NSTATUS
							OR SDB_IESPOT.IE_CONFLICT_STATUS		<> a.IE_CONFLICT_STATUS
							)



			INSERT		dbo.SDB_IESPOT
						(
							SDBSourceID,
							SPOT_ID,
							IE_ID,
							IU_ID,
							SCHED_DATE,
							SCHED_DATE_TIME,
							UTC_SCHED_DATE,
							UTC_SCHED_DATE_TIME,
							IE_NSTATUS,
							IE_CONFLICT_STATUS,
							SPOTS,
							IE_DURATION,
							IE_RUN_DATE_TIME,
							UTC_IE_RUN_DATE_TIME,
							BREAK_INWIN,
							AWIN_START_DT,
							AWIN_END_DT,
							UTC_AWIN_START_DT,
							UTC_AWIN_END_DT,
							IE_SOURCE_ID,
							VIDEO_ID,
							ASSET_DESC,
							SPOT_DURATION,
							SPOT_NSTATUS,
							SPOT_CONFLICT_STATUS,
							SPOT_ORDER,
							SPOT_RUN_DATE_TIME,
							UTC_SPOT_RUN_DATE_TIME,
							RUN_LENGTH,
							SPOT_SOURCE_ID,
							UTC_SPOT_NSTATUS_UPDATE_TIME,
							UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME,
							UTC_IE_NSTATUS_UPDATE_TIME,
							UTC_IE_CONFLICT_STATUS_UPDATE_TIME,
							CreateDate
						)
			SELECT
							a.SDBSourceID							AS SDBSourceID,
							a.SPOT_ID								AS SPOT_ID,
							a.IE_ID									AS IE_ID,
							a.IU_ID									AS IU_ID,
							a.SCHED_DATE							AS SCHED_DATE,
							a.SCHED_DATE_TIME						AS SCHED_DATE_TIME,
							a.UTC_SCHED_DATE						AS UTC_SCHED_DATE,
							a.UTC_SCHED_DATE_TIME					AS UTC_SCHED_DATE_TIME,
							a.IE_NSTATUS							AS IE_NSTATUS,
							a.IE_CONFLICT_STATUS					AS IE_CONFLICT_STATUS,
							a.SPOTS									AS SPOTS,
							a.IE_DURATION							AS IE_DURATION,
							a.IE_RUN_DATE_TIME						AS IE_RUN_DATE_TIME,
							a.UTC_IE_RUN_DATE_TIME					AS UTC_IE_RUN_DATE_TIME,
							a.BREAK_INWIN							AS BREAK_INWIN,
							a.AWIN_START_DT							AS AWIN_START_DT,
							a.AWIN_END_DT							AS AWIN_END_DT,
							a.UTC_AWIN_START_DT						AS UTC_AWIN_START_DT,
							a.UTC_AWIN_END_DT						AS UTC_AWIN_END_DT,
							a.IE_SOURCE_ID							AS IE_SOURCE_ID,
							a.VIDEO_ID								AS VIDEO_ID,
							a.ASSET_DESC							AS ASSET_DESC,
							a.SPOT_DURATION							AS SPOT_DURATION,
							a.SPOT_NSTATUS							AS SPOT_NSTATUS,
							a.SPOT_CONFLICT_STATUS					AS SPOT_CONFLICT_STATUS,
							a.SPOT_ORDER							AS SPOT_ORDER,
							a.SPOT_RUN_DATE_TIME					AS SPOT_RUN_DATE_TIME,
							a.UTC_SPOT_RUN_DATE_TIME				AS UTC_SPOT_RUN_DATE_TIME,
							a.RUN_LENGTH							AS RUN_LENGTH,
							a.SPOT_SOURCE_ID						AS SPOT_SOURCE_ID,
							@UTCNow									AS UTC_SPOT_NSTATUS_UPDATE_TIME,
							@UTCNow									AS UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME,
							@UTCNow									AS UTC_IE_NSTATUS_UPDATE_TIME,
							@UTCNow									AS UTC_IE_CONFLICT_STATUS_UPDATE_TIME,
							@UTCNow									AS CreateDate
			FROM			#ImportIE_SPOT a
			JOIN			dbo.REGIONALIZED_IU riu WITH (NOLOCK)	--We only care about zone names we recognize/have mapped
			ON				a.IU_ID									= riu.IU_ID
			LEFT JOIN		dbo.SDB_IESPOT b 
			ON				a.SDBSourceID							= b.SDBSourceID
			AND				a.SPOT_ID								= b.SPOT_ID
			AND				a.IE_ID									= b.IE_ID
			WHERE			b.SDB_IESPOTID							IS NULL
			AND				riu.REGIONID							= @RegionID
			AND				(
							a.SPOT_NSTATUS							= 1
							OR a.SPOT_NSTATUS						>= 6
							)
			AND				a.SPOT_RUN_DATE_TIME					IS NULL



			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END



GO


