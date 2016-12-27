



USE MPEG
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimTB_REQUEST'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimTB_REQUEST
GO

CREATE PROCEDURE dbo.ETLDimTB_REQUEST 
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
// Module:  dbo.ETLDimTB_REQUEST
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ETLDimTB_REQUEST.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimTB_REQUEST	
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
								TB_ID														= tb.TB_ID,
								ZONE_ID														= tb.ZONE_ID,
								IU_ID														= tb.IU_ID,
								TB_REQUEST													= tb.TB_REQUEST,
								TB_MODE														= tb.TB_MODE,
								TB_TYPE														= tb.TB_TYPE,
								TB_DAYPART													= tb.TB_DAYPART,
								TB_FILE														= tb.TB_FILE,
								TB_FILE_DATE												= tb.TB_FILE_DATE,
								STATUS														= tb.STATUS,
								EXPLANATION													= tb.EXPLANATION,
								TB_MACHINE													= tb.TB_MACHINE,
								TB_MACHINE_TS												= tb.TB_MACHINE_TS,
								TB_MACHINE_THREAD											= tb.TB_MACHINE_THREAD,
								REQUESTING_MACHINE											= tb.REQUESTING_MACHINE,
								REQUESTING_PORT												= tb.REQUESTING_PORT,
								SOURCE_ID													= tb.SOURCE_ID,
								MSGNR														= tb.MSGNR,
								TS															= tb.TS,

								ZoneName													= z.ZONE_NAME,
								TB_MODE_NAME												= tmt.NAME,
								REQUEST_NAME												= trt.NAME,
								SOURCE_ID_NAME												= tst1.NAME,
								STATUS_NAME													= tst2.NAME,
								TYPE_NAME													= ttt.NAME,
								DAYPART_DATE												= CONVERT( DATE,tb.TB_DAYPART,121 ),
								DAYPART_DATE_TIME											= tb.TB_DAYPART,
								NetworkID													= net.ID,
								NetworkName													= net.NAME,

								UTCIEDatetime												= DATEADD ( HOUR,	@UTCOffset, tb.TB_DAYPART ),
								UTCIEDate													= CONVERT ( DATE,	(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )), 121 ),
								UTCIEDateYear												= DATEPART( YEAR,	(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )) ),
								UTCIEDateMonth												= DATEPART( MONTH,	(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )) ),
								UTCIEDateDay												= DATEPART( DAY,	(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )) ),
								UTCIEDayOfYearPartitionKey									= DATEPART( DY,		(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )) )

				FROM			dbo.TB_REQUEST tb WITH (NOLOCK)
				JOIN			dbo.ZONE z WITH (NOLOCK)									ON tb.ZONE_ID = z.ZONE_ID
				JOIN			dbo.TB_MODE_TEXT tmt WITH (NOLOCK)							ON tb.TB_MODE = tmt.MODE
				JOIN			dbo.TB_REQUEST_TEXT trt WITH (NOLOCK)						ON tb.TB_REQUEST = trt.REQUEST
				JOIN			dbo.TB_SOURCE_TEXT tst1 WITH (NOLOCK)						ON tb.SOURCE_ID = tst1.SOURCE_ID
				JOIN			dbo.TB_STATUS_TEXT tst2 WITH (NOLOCK)						ON tb.STATUS = tst2.STATUS
				LEFT JOIN		dbo.TB_TYPES_TEXT ttt WITH (NOLOCK)							ON tb.TB_TYPE = ttt.TYPE
				LEFT JOIN		dbo.NETWORK_IU_MAP netmap (NOLOCK)							ON tb.IU_ID = netmap.IU_ID
				LEFT JOIN		dbo.NETWORK net (NOLOCK)									ON netmap.NETWORK_ID = net.ID
				WHERE			tb.TB_DAYPART												>= @TimeZoneDateStampStart
				AND				tb.TB_DAYPART												< @TimeZoneDateStampEnd


END
GO