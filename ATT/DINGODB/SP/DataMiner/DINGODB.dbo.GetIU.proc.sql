USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetIU'), 0) > 0 
	DROP PROCEDURE dbo.GetIU
GO

CREATE PROCEDURE [dbo].[GetIU]
		@RegionID			UDT_Int READONLY,
		@IUID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
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
// Module:  dbo.GetIU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the SPOT IU ID associated with DINGODBs regionalized IU ID.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetIU.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @IUID_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetIU 
//						@RegionID			= @RegionID_TBL,
//						@IUID				= @IUID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@IUID_COUNT INT

		SELECT				@RegionID_COUNT = COUNT(1) FROM @RegionID
		SELECT				@IUID_COUNT = COUNT(1) FROM @IUID

		SELECT
							a.REGIONALIZED_IU_ID,
							a.IU_ID,
							a.REGIONID,
							a.ZONE,
							a.ZONE_NAME,
							a.CHANNEL,
							a.CHAN_NAME,
							--DELAY
							--START_TRIGGER
							--END_TRIGGER
							--AWIN_START
							--AWIN_END
							--VALUE
							--MASTER_NAME
							--COMPUTER_NAME
							--PARENT_ID
							--SYSTEM_TYPE
							--COMPUTER_PORT
							--MIN_DURATION
							--MAX_DURATION
							--START_OF_DAY
							--RESCHEDULE_WINDOW
							--IC_CHANNEL
							--VSM_SLOT
							--DECODER_PORT
							--TC_ID
							--IGNORE_VIDEO_ERRORS
							--IGNORE_AUDIO_ERRORS
							--COLLISION_DETECT_ENABLED
							--TALLY_NORMALLY_HIGH
							--PLAY_OVER_COLLISIONS
							--PLAY_COLLISION_FUDGE
							--TALLY_COLLISION_FUDGE
							--TALLY_ERROR_FUDGE
							--LOG_TALLY_ERRORS
							--TBI_START
							--TBI_END
							--CONTINUOUS_PLAY_FUDGE
							--TONE_GROUP
							--IGNORE_END_TONES
							--END_TONE_FUDGE
							--MAX_AVAILS
							--RESTART_TRIES
							--RESTART_BYTE_SKIP
							--RESTART_TIME_REMAINING
							--GENLOCK_FLAG
							--SKIP_HEADER
							--GPO_IGNORE
							--GPO_NORMAL
							--GPO_TIME
							--DECODER_SHARING
							--HIGH_PRIORITY
							--SPLICER_ID
							--PORT_ID
							--VIDEO_PID
							--SERVICE_PID
							--DVB_CARD
							--SPLICE_ADJUST
							--POST_BLACK
							--SWITCH_CNT
							--DECODER_CNT
							--DVB_CARD_CNT
							--DVB_PORTS_PER_CARD
							--DVB_CHAN_PER_PORT
							--USE_ISD
							--NO_NETWORK_VIDEO_DETECT
							--NO_NETWORK_PLAY
							--IP_TONE_THRESHOLD
							--USE_GIGE
							--GIGE_IP
							--IS_ACTIVE_IND
							a.CreateDate,
							a.UpdateDate

		FROM				dbo.REGIONALIZED_IU a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = a.REGIONID)		OR ISNULL(@RegionID_COUNT,0) = 0 )
		AND					( EXISTS(SELECT TOP 1 1 FROM @IUID	WHERE Value = a.IU_ID)		OR ISNULL(@IUID_COUNT,0) = 0 )
		ORDER BY			a.IU_ID, a.REGIONID

		SET					@Return = @@ERROR

END




GO


