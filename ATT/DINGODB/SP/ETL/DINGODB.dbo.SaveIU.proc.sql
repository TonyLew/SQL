USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveIU'), 0) > 0 
	DROP PROCEDURE dbo.SaveIU
GO

CREATE PROCEDURE [dbo].[SaveIU]
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
// Module:  dbo.SaveIU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts and SPOT IU IDs to DINGODB and regionalizes the IU ID with a DINGODB IU ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveIU.proc.sql 4051 2014-04-29 16:44:03Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveIU 
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


		DECLARE		@CMD						NVARCHAR(4000)
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						VARCHAR(200)
		DECLARE		@EventLogStatusID			INT = 1		--Unidentified Step
		DECLARE		@TempTableCount				INT
		DECLARE		@ZONECount					INT
		DECLARE		@LastIUID					INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#DeletedIU'), 0) > 0 
				DROP TABLE		#DeletedIU

		CREATE TABLE	#DeletedIU 
						(
							ID INT Identity(1,1),
							REGIONALIZED_IU_ID int NOT NULL,
							IU_ID int NOT NULL
						)



		IF		ISNULL(OBJECT_ID('tempdb..#IU'), 0) > 0 
				DROP TABLE		#IU

		CREATE TABLE	#IU 
						(
							ID INT Identity(1,1),
							IU_ID int NOT NULL,
							REGIONID int NOT NULL,
							ZONE int NOT NULL,
							ZONE_NAME varchar(32) NOT NULL,
							CHANNEL varchar(12) NOT NULL,
							CHAN_NAME varchar(32) NOT NULL,
							CHANNEL_NAME varchar(200) NULL,
							DELAY int NOT NULL,
							START_TRIGGER char(5) NOT NULL,
							END_TRIGGER char(5) NOT NULL,
							AWIN_START int NULL,
							AWIN_END int NULL,
							VALUE int NULL,
							MASTER_NAME varchar(32) NULL,
							COMPUTER_NAME varchar(32) NULL,
							PARENT_ID int NULL,
							SYSTEM_TYPE int NULL,
							COMPUTER_PORT int NOT NULL,
							MIN_DURATION int NOT NULL,
							MAX_DURATION int NOT NULL,
							START_OF_DAY char(8) NOT NULL,
							RESCHEDULE_WINDOW int NOT NULL,
							IC_CHANNEL varchar(12) NULL,
							VSM_SLOT int NULL,
							DECODER_PORT int NULL,
							TC_ID int NULL,
							IGNORE_VIDEO_ERRORS int NULL,
							IGNORE_AUDIO_ERRORS int NULL,
							COLLISION_DETECT_ENABLED int NULL,
							TALLY_NORMALLY_HIGH int NULL,
							PLAY_OVER_COLLISIONS int NULL,
							PLAY_COLLISION_FUDGE int NULL,
							TALLY_COLLISION_FUDGE int NULL,
							TALLY_ERROR_FUDGE int NULL,
							LOG_TALLY_ERRORS int NULL,
							TBI_START [datetime] NULL,
							TBI_END [datetime] NULL,
							CONTINUOUS_PLAY_FUDGE int NULL,
							TONE_GROUP varchar(64) NULL,
							IGNORE_END_TONES int NULL,
							END_TONE_FUDGE int NULL,
							MAX_AVAILS int NULL,
							RESTART_TRIES int NULL,
							RESTART_BYTE_SKIP int NULL,
							RESTART_TIME_REMAINING int NULL,
							GENLOCK_FLAG int NULL,
							SKIP_HEADER int NULL,
							GPO_IGNORE int NULL,
							GPO_NORMAL int NULL,
							GPO_TIME int NULL,
							DECODER_SHARING int NULL,
							HIGH_PRIORITY int NULL,
							SPLICER_ID int NULL,
							PORT_ID int NULL,
							VIDEO_PID int NULL,
							SERVICE_PID int NULL,
							DVB_CARD int NULL,
							SPLICE_ADJUST int NOT NULL,
							POST_BLACK int NOT NULL,
							SWITCH_CNT int NULL,
							DECODER_CNT int NULL,
							DVB_CARD_CNT int NULL,
							DVB_PORTS_PER_CARD int NULL,
							DVB_CHAN_PER_PORT int NULL,
							USE_ISD int NULL,
							NO_NETWORK_VIDEO_DETECT int NULL,
							NO_NETWORK_PLAY int NULL,
							IP_TONE_THRESHOLD int NULL,
							USE_GIGE int NULL,
							GIGE_IP varchar(24) NULL,
							IS_ACTIVE_IND [bit] NOT NULL,
							msrepl_tran_version uniqueidentifier
						)

		SET			@CMD			= 
		'INSERT		#IU

						(
							IU_ID,
							REGIONID,
							ZONE,
							ZONE_NAME,
							CHANNEL,
							CHAN_NAME,
							DELAY,
							START_TRIGGER,
							END_TRIGGER,
							AWIN_START,
							AWIN_END,
							VALUE,
							MASTER_NAME,
							COMPUTER_NAME,
							PARENT_ID,
							SYSTEM_TYPE,
							COMPUTER_PORT,
							MIN_DURATION,
							MAX_DURATION,
							START_OF_DAY,
							RESCHEDULE_WINDOW,
							IC_CHANNEL,
							VSM_SLOT,
							DECODER_PORT,
							TC_ID,
							IGNORE_VIDEO_ERRORS,
							IGNORE_AUDIO_ERRORS,
							COLLISION_DETECT_ENABLED,
							TALLY_NORMALLY_HIGH,
							PLAY_OVER_COLLISIONS,
							PLAY_COLLISION_FUDGE,
							TALLY_COLLISION_FUDGE,
							TALLY_ERROR_FUDGE,
							LOG_TALLY_ERRORS,
							TBI_START,
							TBI_END,
							CONTINUOUS_PLAY_FUDGE,
							TONE_GROUP,
							IGNORE_END_TONES,
							END_TONE_FUDGE,
							MAX_AVAILS,
							RESTART_TRIES,
							RESTART_BYTE_SKIP,
							RESTART_TIME_REMAINING,
							GENLOCK_FLAG,
							SKIP_HEADER,
							GPO_IGNORE,
							GPO_NORMAL,
							GPO_TIME,
							DECODER_SHARING,
							HIGH_PRIORITY,
							SPLICER_ID,
							PORT_ID,
							VIDEO_PID,
							SERVICE_PID,
							DVB_CARD,
							SPLICE_ADJUST,
							POST_BLACK,
							SWITCH_CNT,
							DECODER_CNT,
							DVB_CARD_CNT,
							DVB_PORTS_PER_CARD,
							DVB_CHAN_PER_PORT,
							USE_ISD,
							NO_NETWORK_VIDEO_DETECT,
							NO_NETWORK_PLAY,
							IP_TONE_THRESHOLD,
							USE_GIGE,
							GIGE_IP,
							IS_ACTIVE_IND,
							msrepl_tran_version
						)

			SELECT  
							IU_ID,
							' + CAST(@RegionID AS VARCHAR(50)) + ' AS REGIONID,
							ZONE,
							ZONE_NAME,
							CHANNEL,
							CHAN_NAME,
							DELAY,
							START_TRIGGER,
							END_TRIGGER,
							AWIN_START,
							AWIN_END,
							VALUE,
							MASTER_NAME,
							COMPUTER_NAME,
							PARENT_ID,
							SYSTEM_TYPE,
							COMPUTER_PORT,
							MIN_DURATION,
							MAX_DURATION,
							START_OF_DAY,
							RESCHEDULE_WINDOW,
							IC_CHANNEL,
							VSM_SLOT,
							DECODER_PORT,
							TC_ID,
							IGNORE_VIDEO_ERRORS,
							IGNORE_AUDIO_ERRORS,
							COLLISION_DETECT_ENABLED,
							TALLY_NORMALLY_HIGH,
							PLAY_OVER_COLLISIONS,
							PLAY_COLLISION_FUDGE,
							TALLY_COLLISION_FUDGE,
							TALLY_ERROR_FUDGE,
							LOG_TALLY_ERRORS,
							TBI_START,
							TBI_END,
							CONTINUOUS_PLAY_FUDGE,
							TONE_GROUP,
							IGNORE_END_TONES,
							END_TONE_FUDGE,
							MAX_AVAILS,
							RESTART_TRIES,
							RESTART_BYTE_SKIP,
							RESTART_TIME_REMAINING,
							GENLOCK_FLAG,
							SKIP_HEADER,
							GPO_IGNORE,
							GPO_NORMAL,
							GPO_TIME,
							DECODER_SHARING,
							HIGH_PRIORITY,
							SPLICER_ID,
							PORT_ID,
							VIDEO_PID,
							SERVICE_PID,
							DVB_CARD,
							SPLICE_ADJUST,
							POST_BLACK,
							SWITCH_CNT,
							DECODER_CNT,
							DVB_CARD_CNT,
							DVB_PORTS_PER_CARD,
							DVB_CHAN_PER_PORT,
							USE_ISD,
							NO_NETWORK_VIDEO_DETECT,
							NO_NETWORK_PLAY,
							IP_TONE_THRESHOLD,
							USE_GIGE,
							GIGE_IP,
							IS_ACTIVE_IND,
							msrepl_tran_version ' +
		'FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.IU a WITH (NOLOCK) '

		--SELECT			@CMD




		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			--			Identify the IDs from the REGIONALIZED_IU table to be deleted
			INSERT		#DeletedIU 
					(
						REGIONALIZED_IU_ID,
						IU_ID
					)
			SELECT		a.REGIONALIZED_IU_ID,
						a.IU_ID
			FROM		dbo.REGIONALIZED_IU a WITH (NOLOCK)
			LEFT JOIN	#IU b
			ON			a.IU_ID										= b.IU_ID
			WHERE		a.RegionID									= @RegionID
			AND			b.ID										IS NULL


			--			Delete from the tables with FK constraints first
			DELETE		dbo.REGIONALIZED_NETWORK_IU_MAP
			FROM		#DeletedIU d
			WHERE		REGIONALIZED_NETWORK_IU_MAP.REGIONALIZED_IU_ID	= d.REGIONALIZED_IU_ID


			DELETE		dbo.REGIONALIZED_IU
			FROM		#DeletedIU d
			WHERE		REGIONALIZED_IU.RegionID					= @RegionID
			AND			REGIONALIZED_IU.REGIONALIZED_IU_ID			= d.REGIONALIZED_IU_ID


			INSERT		dbo.REGIONALIZED_IU
						(
								RegionID,
								--SDBSourceID,
								IU_ID,
								ZONE,
								ZONE_NAME,
								CHANNEL,
								CHAN_NAME,
								CHANNEL_NAME,
								DELAY,
								START_TRIGGER,
								END_TRIGGER,
								AWIN_START,
								AWIN_END,
								VALUE,
								MASTER_NAME,
								COMPUTER_NAME,
								PARENT_ID,
								SYSTEM_TYPE,
								COMPUTER_PORT,
								MIN_DURATION,
								MAX_DURATION,
								START_OF_DAY,
								RESCHEDULE_WINDOW,
								IC_CHANNEL,
								VSM_SLOT,
								DECODER_PORT,
								TC_ID,
								IGNORE_VIDEO_ERRORS,
								IGNORE_AUDIO_ERRORS,
								COLLISION_DETECT_ENABLED,
								TALLY_NORMALLY_HIGH,
								PLAY_OVER_COLLISIONS,
								PLAY_COLLISION_FUDGE,
								TALLY_COLLISION_FUDGE,
								TALLY_ERROR_FUDGE,
								LOG_TALLY_ERRORS,
								TBI_START,
								TBI_END,
								CONTINUOUS_PLAY_FUDGE,
								TONE_GROUP,
								IGNORE_END_TONES,
								END_TONE_FUDGE,
								MAX_AVAILS,
								RESTART_TRIES,
								RESTART_BYTE_SKIP,
								RESTART_TIME_REMAINING,
								GENLOCK_FLAG,
								SKIP_HEADER,
								GPO_IGNORE,
								GPO_NORMAL,
								GPO_TIME,
								DECODER_SHARING,
								HIGH_PRIORITY,
								SPLICER_ID,
								PORT_ID,
								VIDEO_PID,
								SERVICE_PID,
								DVB_CARD,
								SPLICE_ADJUST,
								POST_BLACK,
								SWITCH_CNT,
								DECODER_CNT,
								DVB_CARD_CNT,
								DVB_PORTS_PER_CARD,
								DVB_CHAN_PER_PORT,
								USE_ISD,
								NO_NETWORK_VIDEO_DETECT,
								NO_NETWORK_PLAY,
								IP_TONE_THRESHOLD,
								USE_GIGE,
								GIGE_IP,
								IS_ACTIVE_IND,
								msrepl_tran_version,
								CreateDate
						)

			SELECT  
								@RegionID AS RegionID,
								--@SDBSourceID AS SDBSourceID,
								y.IU_ID,
								y.ZONE,
								y.ZONE_NAME,
								y.CHANNEL,
								y.CHAN_NAME,
								ISNULL(y.CHANNEL_NAME,''),
								y.DELAY,
								y.START_TRIGGER,
								y.END_TRIGGER,
								y.AWIN_START,
								y.AWIN_END,
								y.VALUE,
								y.MASTER_NAME,
								y.COMPUTER_NAME,
								y.PARENT_ID,
								y.SYSTEM_TYPE,
								y.COMPUTER_PORT,
								y.MIN_DURATION,
								y.MAX_DURATION,
								y.START_OF_DAY,
								y.RESCHEDULE_WINDOW,
								y.IC_CHANNEL,
								y.VSM_SLOT,
								y.DECODER_PORT,
								y.TC_ID,
								y.IGNORE_VIDEO_ERRORS,
								y.IGNORE_AUDIO_ERRORS,
								y.COLLISION_DETECT_ENABLED,
								y.TALLY_NORMALLY_HIGH,
								y.PLAY_OVER_COLLISIONS,
								y.PLAY_COLLISION_FUDGE,
								y.TALLY_COLLISION_FUDGE,
								y.TALLY_ERROR_FUDGE,
								y.LOG_TALLY_ERRORS,
								y.TBI_START,
								y.TBI_END,
								y.CONTINUOUS_PLAY_FUDGE,
								y.TONE_GROUP,
								y.IGNORE_END_TONES,
								y.END_TONE_FUDGE,
								y.MAX_AVAILS,
								y.RESTART_TRIES,
								y.RESTART_BYTE_SKIP,
								y.RESTART_TIME_REMAINING,
								y.GENLOCK_FLAG,
								y.SKIP_HEADER,
								y.GPO_IGNORE,
								y.GPO_NORMAL,
								y.GPO_TIME,
								y.DECODER_SHARING,
								y.HIGH_PRIORITY,
								y.SPLICER_ID,
								y.PORT_ID,
								y.VIDEO_PID,
								y.SERVICE_PID,
								y.DVB_CARD,
								y.SPLICE_ADJUST,
								y.POST_BLACK,
								y.SWITCH_CNT,
								y.DECODER_CNT,
								y.DVB_CARD_CNT,
								y.DVB_PORTS_PER_CARD,
								y.DVB_CHAN_PER_PORT,
								y.USE_ISD,
								y.NO_NETWORK_VIDEO_DETECT,
								y.NO_NETWORK_PLAY,
								y.IP_TONE_THRESHOLD,
								y.USE_GIGE,
								y.GIGE_IP,
								y.IS_ACTIVE_IND,
								y.msrepl_tran_version,
								GETUTCDATE()
			FROM				#IU y
 		--	JOIN				dbo.ZONE_MAP zm with (NOLOCK) 	--We only care about IUs whose zone names we know
			--ON					y.ZONE_NAME			= zm.ZONE_NAME 
			LEFT JOIN			(
										SELECT		IU_ID
										FROM		dbo.REGIONALIZED_IU (NOLOCK)
										WHERE		REGIONID = @RegionID
										--AND			SDBSourceID = @SDBSourceID
								) z
			ON					y.IU_ID = z.IU_ID
			WHERE				z.IU_ID IS NULL
			ORDER BY			y.ID

			UPDATE		#IU
			SET			CHANNEL_NAME							= ISNULL(x.CCMS,'')
			FROM		(
									SELECT	a.IU_ID, 
											e.Name + '-' + c.NAME + '/' + SUBSTRING('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', ((CAST(a.CHANNEL AS INT) / 10) + 1), 1) +  CAST((CAST(a.CHANNEL AS INT) % 10) AS VARCHAR) +'-' + RIGHT('00000'+CAST((CASE WHEN ISNUMERIC(RIGHT(a.ZONE_NAME, 5)) = 1 THEN RIGHT(a.ZONE_NAME, 5)ELSE 0 END) AS VARCHAR(5)),5)
																		AS CCMS
									FROM	dbo.REGIONALIZED_IU AS a (NOLOCK)
									JOIN	dbo.REGIONALIZED_NETWORK_IU_MAP AS b (NOLOCK) ON a.REGIONALIZED_IU_ID = b.REGIONALIZED_IU_ID
									JOIN	dbo.REGIONALIZED_NETWORK AS c (NOLOCK) ON b.REGIONALIZED_NETWORK_ID = c.REGIONALIZED_NETWORK_ID
									JOIN	dbo.ZONE_MAP AS d  (NOLOCK) ON a.ZONE_NAME = d.ZONE_NAME
									JOIN	dbo.Market AS e  (NOLOCK) ON d.MarketID = e.MarketID
									WHERE	a.REGIONID					= @RegionID
						) x
			WHERE		#IU.IU_ID								= x.IU_ID


			UPDATE		dbo.REGIONALIZED_IU
			SET
						ZONE									= w.ZONE,
						ZONE_NAME								= w.ZONE_NAME,
						CHANNEL									= w.CHANNEL,
						CHAN_NAME								= w.CHAN_NAME,
						CHANNEL_NAME							= ISNULL(w.CHANNEL_NAME, ''),
						DELAY									= w.DELAY,
						START_TRIGGER							= w.START_TRIGGER,
						END_TRIGGER								= w.END_TRIGGER,
						AWIN_START								= w.AWIN_START,
						AWIN_END								= w.AWIN_END,
						VALUE									= w.VALUE,
						MASTER_NAME								= w.MASTER_NAME,
						COMPUTER_NAME							= w.COMPUTER_NAME,
						PARENT_ID								= w.PARENT_ID,
						SYSTEM_TYPE								= w.SYSTEM_TYPE,
						COMPUTER_PORT							= w.COMPUTER_PORT,
						MIN_DURATION							= w.MIN_DURATION,
						MAX_DURATION							= w.MAX_DURATION,
						START_OF_DAY							= w.START_OF_DAY,
						RESCHEDULE_WINDOW						= w.RESCHEDULE_WINDOW,
						IC_CHANNEL								= w.IC_CHANNEL,
						VSM_SLOT								= w.VSM_SLOT,
						DECODER_PORT							= w.DECODER_PORT,
						TC_ID									= w.TC_ID,
						IGNORE_VIDEO_ERRORS						= w.IGNORE_VIDEO_ERRORS,
						IGNORE_AUDIO_ERRORS						= w.IGNORE_AUDIO_ERRORS,
						COLLISION_DETECT_ENABLED				= w.COLLISION_DETECT_ENABLED,
						TALLY_NORMALLY_HIGH						= w.TALLY_NORMALLY_HIGH,
						PLAY_OVER_COLLISIONS					= w.PLAY_OVER_COLLISIONS,
						PLAY_COLLISION_FUDGE					= w.PLAY_COLLISION_FUDGE,
						TALLY_COLLISION_FUDGE					= w.TALLY_COLLISION_FUDGE,
						TALLY_ERROR_FUDGE						= w.TALLY_ERROR_FUDGE,
						LOG_TALLY_ERRORS						= w.LOG_TALLY_ERRORS,
						TBI_START								= w.TBI_START,
						TBI_END									= w.TBI_END,
						CONTINUOUS_PLAY_FUDGE					= w.CONTINUOUS_PLAY_FUDGE,
						TONE_GROUP								= w.TONE_GROUP,
						IGNORE_END_TONES						= w.IGNORE_END_TONES,
						END_TONE_FUDGE							= w.END_TONE_FUDGE,
						MAX_AVAILS								= w.MAX_AVAILS,
						RESTART_TRIES							= w.RESTART_TRIES,
						RESTART_BYTE_SKIP						= w.RESTART_BYTE_SKIP,
						RESTART_TIME_REMAINING					= w.RESTART_TIME_REMAINING,
						GENLOCK_FLAG							= w.GENLOCK_FLAG,
						SKIP_HEADER								= w.SKIP_HEADER,
						GPO_IGNORE								= w.GPO_IGNORE,
						GPO_NORMAL								= w.GPO_NORMAL,
						GPO_TIME								= w.GPO_TIME,
						DECODER_SHARING							= w.DECODER_SHARING,
						HIGH_PRIORITY							= w.HIGH_PRIORITY,
						SPLICER_ID								= w.SPLICER_ID,
						PORT_ID									= w.PORT_ID,
						VIDEO_PID								= w.VIDEO_PID,
						SERVICE_PID								= w.SERVICE_PID,
						DVB_CARD								= w.DVB_CARD,
						SPLICE_ADJUST							= w.SPLICE_ADJUST,
						POST_BLACK								= w.POST_BLACK,
						SWITCH_CNT								= w.SWITCH_CNT,
						DECODER_CNT								= w.DECODER_CNT,
						DVB_CARD_CNT							= w.DVB_CARD_CNT,
						DVB_PORTS_PER_CARD						= w.DVB_PORTS_PER_CARD,
						DVB_CHAN_PER_PORT						= w.DVB_CHAN_PER_PORT,
						USE_ISD									= w.USE_ISD,
						NO_NETWORK_VIDEO_DETECT					= w.NO_NETWORK_VIDEO_DETECT,
						NO_NETWORK_PLAY							= w.NO_NETWORK_PLAY,
						IP_TONE_THRESHOLD						= w.IP_TONE_THRESHOLD,
						USE_GIGE								= w.USE_GIGE,
						GIGE_IP									= w.GIGE_IP,
						IS_ACTIVE_IND							= w.IS_ACTIVE_IND,
						msrepl_tran_version						= w.msrepl_tran_version,
						UpdateDate								= GETUTCDATE()

			FROM		#IU w
			WHERE		REGIONALIZED_IU.REGIONID				= @RegionID
			AND			REGIONALIZED_IU.IU_ID					= w.IU_ID
			AND			(
						REGIONALIZED_IU.msrepl_tran_version		<> w.msrepl_tran_version
			OR			REGIONALIZED_IU.CHANNEL_NAME			= ''
			OR			REGIONALIZED_IU.CHANNEL_NAME			<> w.CHANNEL_NAME
						)

			SELECT				TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU Success Step'
			SET					@ErrorID = 0
		END TRY
		BEGIN CATCH
			SELECT				@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET					@ErrorID = @ErrNum
			SELECT				TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU Fail Step'
		END CATCH

		EXEC					dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#IU
		DROP TABLE		#DeletedIU

END




GO


