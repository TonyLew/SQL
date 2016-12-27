
Use MPEG
GO

IF ISNULL(OBJECT_ID('dbo.ImportChannelAndConflictStats'), 0) > 0 
	DROP PROCEDURE dbo.ImportChannelAndConflictStats
GO

CREATE PROCEDURE [dbo].[ImportChannelAndConflictStats]
				@SDBUTCOffset				INT,
				@SDBSourceID				INT,
				@Day						DATETIME = NULL,
				@ErrorID					INT OUTPUT,
				@ErrMsg						VARCHAR(200) OUTPUT
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
// Module:  dbo.ImportChannelAndConflictStats
// Created: 2014-Mar-04
// Author:  Tony Lew
// 
// Purpose: Updates DINGODB (dataminer DB interface) with latest SDB info.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ImportChannelAndConflictStats.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE	@ErrorIDOUT							INT 
//				DECLARE	@ErrMsgOUT							VARCHAR(200)
//				EXEC	MPEG.dbo.ImportChannelAndConflictStats	
//								@SDBUTCOffset				= 8,
//								@SDBSourceID				= 1,
//								@Day						= '2014-01-01',
//								@ErrorID					= @ErrorIDOUT OUTPUT,
//								@ErrMsg						= @ErrMsgOUT OUTPUT
//
*/ 
-- =============================================
BEGIN


				SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET			NOCOUNT ON;

				DECLARE		@StartDayIESPOT					DATE
				DECLARE		@EndDayIESPOT					DATE
				DECLARE		@StartDayBreakCount				DATE
				DECLARE		@EndDayBreakCount				DATE
				DECLARE		@NowSDBTime						DATETIME

				SELECT		@StartDayIESPOT					= ISNULL(@Day, DATEADD(HOUR, @SDBUTCOffset, GETUTCDATE()) ),
							@EndDayIESPOT					= DATEADD(DAY, 2, @StartDayIESPOT)

				SELECT		@NowSDBTime						= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
				SELECT		@StartDayBreakCount				= DATEADD( DAY, -6, @NowSDBTime ),
							@EndDayBreakCount				= DATEADD( DAY, 2, @NowSDBTime )


							SELECT	
											@SDBSourceID AS SDBSourceID, 
											SPOT.SPOT_ID, 
											IE.IE_ID, 
											IE.IU_ID, 
											CONVERT(DATE, IE.SCHED_DATE_TIME), 
											IE.SCHED_DATE_TIME,  
											IE.NSTATUS, 
											IE.CONFLICT_STATUS, 
											IE.AWIN_END_DT, 
											IE.SOURCE_ID, 
											SPOT.VIDEO_ID, 
											SPOT.TITLE + ' - ' + SPOT.CUSTOMER	AS ASSET_DESC, 
											SPOT.NSTATUS, 
											SPOT.CONFLICT_STATUS, 
											SPOT.SPOT_ORDER,  
											SPOT.RUN_DATE_TIME
							FROM			dbo.IE IE WITH (NOLOCK) 
							JOIN			dbo.SPOT SPOT WITH (NOLOCK) 
							ON				IE.IE_ID = SPOT.IE_ID 
							WHERE			IE.SCHED_DATE_TIME >= @StartDayIESPOT
							AND				IE.SCHED_DATE_TIME < @EndDayIESPOT
							AND				IE.NSTATUS <> 15 



END



GO
