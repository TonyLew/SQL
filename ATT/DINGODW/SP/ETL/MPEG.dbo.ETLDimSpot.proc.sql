



USE MPEG
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimSpot'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimSpot
GO

CREATE PROCEDURE dbo.ETLDimSpot 
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
// Module:  dbo.ETLDimSpot
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.SPOT to DINGODW.dbo.DimSpot.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ETLDimSpot.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimSpot	
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
								Spot_ID														= SPOT.SPOT_ID,
								VIDEO_ID													= SPOT.VIDEO_ID,
								DURATION													= SPOT.DURATION,
								CUSTOMER													= SPOT.CUSTOMER,
								TITLE														= SPOT.TITLE,
								NSTATUS														= SPOT.NSTATUS,
								CONFLICT_STATUS												= SPOT.CONFLICT_STATUS,
								RATE														= SPOT.RATE,
								CODE														= SPOT.CODE,
								NOTES														= SPOT.NOTES,
								SERIAL														= SPOT.SERIAL,
								IDSpot														= SPOT.ID,
								IE_ID														= SPOT.IE_ID,
								Spot_ORDER													= SPOT.SPOT_ORDER,
								RUN_DATE_TIME												= SPOT.RUN_DATE_TIME,
								RUN_LENGTH													= SPOT.RUN_LENGTH,
								VALUE														= SPOT.VALUE,
								ORDER_ID													= SPOT.ORDER_ID,
								BONUS_FLAG													= SPOT.BONUS_FLAG,
								SOURCE_ID													= SPOT.SOURCE_ID,
								TS															= SPOT.TS,

								NSTATUSValue												= SS.VALUE,
								CONFLICT_STATUSValue										= SCS.VALUE,
								SOURCE_ID_INTERCONNECT_NAME									= ICS.INTERCONNECT_NAME,
								IESCHED_DATE												= CONVERT(DATE,IE.SCHED_DATE_TIME,121),
								IESCHED_DATE_TIME											= IE.SCHED_DATE_TIME,
								IU_ID														= IU.IU_ID,
								NetworkID													= net.ID,
								NetworkName													= net.NAME,
								
								UTCSPOTDatetime												= DATEADD ( HOUR,	@UTCOffset, SPOT.RUN_DATE_TIME ),
								UTCSPOTDate													= CONVERT ( DATE,	(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )), 121 ),
								UTCSPOTDateYear												= DATEPART( YEAR,	(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )) ),
								UTCSPOTDateMonth											= DATEPART( MONTH,	(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )) ),
								UTCSPOTDateDay												= DATEPART( DAY,	(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )) ),
								UTCSPOTDayOfYearPartitionKey								= DATEPART( DY,		(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )) )

				FROM			dbo.SPOT SPOT WITH (NOLOCK)
				JOIN			dbo.IE IE WITH (NOLOCK)										ON SPOT.IE_ID = IE.IE_ID
				LEFT JOIN		dbo.IU IU WITH (NOLOCK)										ON IE.IU_ID = IU.IU_ID
				LEFT JOIN		dbo.INTERCONNECT_SOURCE ICS WITH (NOLOCK)					ON SPOT.SOURCE_ID = ICS.SOURCE_ID
				LEFT JOIN		dbo.SPOT_STATUS SS WITH (NOLOCK)							ON SPOT.NSTATUS = SS.NSTATUS
				LEFT JOIN		dbo.SPOTCONFLICT_STATUS SCS WITH (NOLOCK)					ON SPOT.CONFLICT_STATUS = SCS.NSTATUS
				LEFT JOIN		dbo.NETWORK_IU_MAP netmap WITH (NOLOCK)						ON IU.IU_ID = netmap.IU_ID
				LEFT JOIN		dbo.NETWORK net WITH (NOLOCK)								ON netmap.NETWORK_ID = net.ID
				WHERE			IE.SCHED_DATE_TIME											>= @TimeZoneDateStampStart
				AND				IE.SCHED_DATE_TIME											< @TimeZoneDateStampEnd



END
GO