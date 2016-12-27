



USE MPEG
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimIE'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimIE
GO

CREATE PROCEDURE dbo.ETLDimIE 
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
// Module:  dbo.ETLDimIE
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ETLDimIE.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimIE	
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
								ZoneName													= IU.ZONE_NAME,
								ChannelName													= IU.CHAN_NAME,
								TSI															= IU.COMPUTER_NAME,
								SCHED_DATE_TIME												= IE.SCHED_DATE_TIME,
								IE_ID														= IE.IE_ID,
								IU_ID														= IE.IU_ID,
								NSTATUS														= IE.NSTATUS,
								NSTATUSValue												= IES.VALUE,
								CONFLICT_STATUS												= IE.CONFLICT_STATUS,
								CONFLICT_STATUSValue										= IECS.VALUE,
								SPOTS														= IE.SPOTS,
								DURATION													= IE.DURATION,
								RUN_DATE_TIME												= IE.RUN_DATE_TIME,

								START_TRIGGER												= IE.START_TRIGGER,
								END_TRIGGER													= IE.END_TRIGGER,
								AWIN_START													= IE.AWIN_START,
								AWIN_END													= IE.AWIN_END,
								VALUE														= IE.VALUE,
								BREAK_INWIN													= IE.BREAK_INWIN,
								AWIN_START_DT												= IE.AWIN_START_DT,
								AWIN_END_DT													= IE.AWIN_END_DT,
								EVENT_ID													= IE.EVENT_ID,
								TS															= IE.TS,

								SOURCE_ID													= IE.SOURCE_ID,
								SOURCE_IDName												= TST.NAME,
								TB_TYPE														= IE.TB_TYPE,
								TB_TYPEName													= TTT.NAME,
								NetworkID													= net.ID,
								NetworkName													= net.NAME,

								UTCIEDatetime												= DATEADD ( HOUR,	@UTCOffset, IE.SCHED_DATE_TIME ),
								UTCIEDate													= CONVERT ( DATE,	(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )), 121 ),
								UTCIEDateYear												= DATEPART( YEAR,	(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )) ),
								UTCIEDateMonth												= DATEPART( MONTH,	(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )) ),
								UTCIEDateDay												= DATEPART( DAY,	(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )) ),
								UTCIEDayOfYearPartitionKey									= DATEPART( DY,		(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )) )

				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.TB_SOURCE_TEXT TST (NOLOCK)								ON IE.SOURCE_ID = TST.SOURCE_ID
				INNER JOIN		dbo.TB_TYPES_TEXT TTT (NOLOCK)								ON IE.TB_TYPE = TTT.TYPE
				LEFT JOIN		dbo.IU IU (NOLOCK)											ON IE.IU_ID = IU.IU_ID
				LEFT JOIN		dbo.NETWORK_IU_MAP netmap (NOLOCK)							ON IE.IU_ID = netmap.IU_ID
				LEFT JOIN		dbo.NETWORK net (NOLOCK)									ON netmap.NETWORK_ID = net.ID
				LEFT JOIN		dbo.IE_STATUS IES (NOLOCK)									ON IE.NSTATUS = IES.NSTATUS
				LEFT JOIN		dbo.IECONFLICT_STATUS IECS (NOLOCK)							ON IE.CONFLICT_STATUS = IECS.NSTATUS
				WHERE			IE.SCHED_DATE_TIME											>= @TimeZoneDateStampStart
				AND				IE.SCHED_DATE_TIME											< @TimeZoneDateStampEnd


END
GO

