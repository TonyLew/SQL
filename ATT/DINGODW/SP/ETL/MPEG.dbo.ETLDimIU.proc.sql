



USE MPEG
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimIU'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimIU
GO

CREATE PROCEDURE dbo.ETLDimIU 
				@RegionID			INT,
				@SDBSourceID		INT,
				@SDBName			VARCHAR(64),
				@UTCOffset			INT,
				@StartingDate		DATE,
				@EndingDate			DATE
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
// Module:  dbo.ETLDimIU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ETLDimIU.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimIU	
//									@RegionID			= 1,
//									@SDBSourceID		= 1,
//									@SDBName			= '',
//									@UTCOffset			= 1,
//									@StartingDate		= '2014-01-01',
//									@EndingDate			= '2014-01-03'
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@StartingDayDateTime										DATETIME = @StartingDate
				DECLARE			@EndingDayDateTime											DATETIME = @EndingDate
				DECLARE			@TimeZoneDateStampStart										DATETIME = DATEADD( HOUR,	@UTCOffset,	@StartingDayDateTime )
				DECLARE			@TimeZoneDateStampEnd										DATETIME = DATEADD( HOUR,	@UTCOffset,	@EndingDayDateTime )

				--				This check is done at the parent stored procedure but also checked here as a precaution.
				--				Make sure the UTC day is over before continuing.
				IF				( @TimeZoneDateStampEnd > GETUTCDATE() )	RETURN

				SELECT
								RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDBName														= @SDBName,
								UTCOffset													= @UTCOffset,
								IU_ID														= IU.IU_ID,
								ZoneName													= IU.ZONE_NAME,
								Channel														= IU.CHANNEL,
								CHAN_NAME													= IU.CHAN_NAME,
								ChannelName													=	'',
								--ChannelName													=	--MarketName + '-'
								--																net.NAME + '/' + 
								--																SUBSTRING('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', ((CAST(IU.CHANNEL AS INT) / 10) + 1), 1) +  
								--																CAST((CAST(IU.CHANNEL AS INT) % 10) AS VARCHAR) + '-' + 
								--																RIGHT('00000'+CAST((CASE WHEN ISNUMERIC(RIGHT(IU.ZONE_NAME, 5)) = 1 THEN RIGHT(IU.ZONE_NAME, 5)ELSE 0 END) AS VARCHAR(5)),5),
								DELAY														= IU.DELAY,
								START_TRIGGER												= IU.START_TRIGGER,
								END_TRIGGER													= IU.END_TRIGGER,
								AWIN_START													= IU.AWIN_START,
								AWIN_END													= IU.AWIN_END,
								VALUE														= IU.VALUE,
								MASTER_NAME													= IU.MASTER_NAME,
								COMPUTER_NAME												= IU.COMPUTER_NAME,
								PARENT_ID													= IU.PARENT_ID,
								SYSTEM_TYPE													= IU.SYSTEM_TYPE,
								COMPUTER_PORT												= IU.COMPUTER_PORT,
								MIN_DURATION												= IU.MIN_DURATION,
								MAX_DURATION												= IU.MAX_DURATION,
								START_OF_DAY												= IU.START_OF_DAY,
								RESCHEDULE_WINDOW											= IU.RESCHEDULE_WINDOW,
								IC_CHANNEL													= IU.IC_CHANNEL,
								VSM_SLOT													= IU.VSM_SLOT,
								DECODER_PORT												= IU.DECODER_PORT,
								TC_ID														= IU.TC_ID,
								IGNORE_VIDEO_ERRORS											= IU.IGNORE_VIDEO_ERRORS,
								IGNORE_AUDIO_ERRORS											= IU.IGNORE_AUDIO_ERRORS,
								COLLISION_DETECT_ENABLED									= IU.COLLISION_DETECT_ENABLED,
								TALLY_NORMALLY_HIGH											= IU.TALLY_NORMALLY_HIGH,
								PLAY_OVER_COLLISIONS										= IU.PLAY_OVER_COLLISIONS,
								PLAY_COLLISION_FUDGE										= IU.PLAY_COLLISION_FUDGE,
								TALLY_COLLISION_FUDGE										= IU.TALLY_COLLISION_FUDGE,
								TALLY_ERROR_FUDGE											= IU.TALLY_ERROR_FUDGE,
								LOG_TALLY_ERRORS											= IU.LOG_TALLY_ERRORS,
								TBI_START													= IU.TBI_START,
								TBI_END														= IU.TBI_END,
								CONTINUOUS_PLAY_FUDGE										= IU.CONTINUOUS_PLAY_FUDGE,
								TONE_GROUP													= IU.TONE_GROUP,
								IGNORE_END_TONES											= IU.IGNORE_END_TONES,
								END_TONE_FUDGE												= IU.END_TONE_FUDGE,
								MAX_AVAILS													= IU.MAX_AVAILS,
								RESTART_TRIES												= IU.RESTART_TRIES,
								RESTART_BYTE_SKIP											= IU.RESTART_BYTE_SKIP,
								RESTART_TIME_REMAINING										= IU.RESTART_TIME_REMAINING,
								GENLOCK_FLAG												= IU.GENLOCK_FLAG,
								SKIP_HEADER													= IU.SKIP_HEADER,
								GPO_IGNORE													= IU.GPO_IGNORE,
								GPO_NORMAL													= IU.GPO_NORMAL,
								GPO_TIME													= IU.GPO_TIME,
								DECODER_SHARING												= IU.DECODER_SHARING,
								HIGH_PRIORITY												= IU.HIGH_PRIORITY,
								SPLICER_ID													= IU.SPLICER_ID,
								PORT_ID														= IU.PORT_ID,
								VIDEO_PID													= IU.VIDEO_PID,
								SERVICE_PID													= IU.SERVICE_PID,
								DVB_CARD													= IU.DVB_CARD,
								SPLICE_ADJUST												= IU.SPLICE_ADJUST,
								POST_BLACK													= IU.POST_BLACK,
								SWITCH_CNT													= IU.SWITCH_CNT,
								DECODER_CNT													= IU.DECODER_CNT,
								DVB_CARD_CNT												= IU.DVB_CARD_CNT,
								DVB_PORTS_PER_CARD											= IU.DVB_PORTS_PER_CARD,
								DVB_CHAN_PER_PORT											= IU.DVB_CHAN_PER_PORT,
								USE_ISD														= IU.USE_ISD,
								NO_NETWORK_VIDEO_DETECT										= IU.NO_NETWORK_VIDEO_DETECT,
								NO_NETWORK_PLAY												= IU.NO_NETWORK_PLAY,
								IP_TONE_THRESHOLD											= IU.IP_TONE_THRESHOLD,
								USE_GIGE													= IU.USE_GIGE,
								GIGE_IP														= IU.GIGE_IP,
								IS_ACTIVE_IND												= IU.IS_ACTIVE_IND,

								SYSTEM_TYPEName												= STT.NAME,
								IESCHED_DATE												= x.SCHED_DATE,
								IESCHED_DATE_TIME											= x.MIN_SCHED_DATE_TIME,
								NetworkID													= net.ID,
								NetworkName													= net.NAME,

								UTCIEDatetime												= DATEADD ( HOUR,	@UTCOffset, x.MIN_SCHED_DATE_TIME ),
								UTCIEDate													= CONVERT ( DATE,	(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )), 121 ),
								UTCIEDateYear												= DATEPART( YEAR,	(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )) ),
								UTCIEDateMonth												= DATEPART( MONTH,	(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )) ),
								UTCIEDateDay												= DATEPART( DAY,	(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )) ),
								UTCIEDayOfYearPartitionKey									= DATEPART( DY,		(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )) )

				FROM			
							(
								SELECT		IU.IU_ID, 
											CONVERT(DATE,IE.SCHED_DATE_TIME,121) AS SCHED_DATE,
											MIN(IE.SCHED_DATE_TIME) AS MIN_SCHED_DATE_TIME
								FROM		dbo.IE IE (NOLOCK)
								JOIN		dbo.IU IU (NOLOCK)								ON IE.IU_ID = IU.IU_ID
								WHERE		IE.SCHED_DATE_TIME								>= @TimeZoneDateStampStart
								AND			IE.SCHED_DATE_TIME								< @TimeZoneDateStampEnd
								GROUP BY	IU.IU_ID, CONVERT(DATE,IE.SCHED_DATE_TIME,121) 
							) x
				JOIN			dbo.IU IU (NOLOCK)											ON x.IU_ID = IU.IU_ID
				LEFT JOIN		dbo.SYSTEM_TYPES_TEXT STT (NOLOCK)							ON IU.SYSTEM_TYPE = STT.TYPE
				LEFT JOIN		dbo.NETWORK_IU_MAP netmap (NOLOCK)							ON IU.IU_ID = netmap.IU_ID
				LEFT JOIN		dbo.NETWORK net (NOLOCK)									ON netmap.NETWORK_ID = net.ID



END
GO