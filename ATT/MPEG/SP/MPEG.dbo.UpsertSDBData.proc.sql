
Use MPEG
GO

IF ISNULL(OBJECT_ID('dbo.UpsertSDBData'), 0) > 0 
	DROP PROCEDURE dbo.UpsertSDBData
GO

CREATE PROCEDURE [dbo].[UpsertSDBData]
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
// Module:  dbo.UpsertSDBData
// Created: 2014-Mar-04
// Author:  Tony Lew
// 
// Purpose: Updates DINGODB (dataminer DB interface) with latest SDB info.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.UpsertSDBData.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE	@ErrorIDOUT							INT 
//				DECLARE	@ErrMsgOUT							VARCHAR(200)
//				EXEC	MPEG.dbo.UpsertSDBData	
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




				BEGIN TRY


							INSERT		#ImportIUBreakCount 
										( 
											BREAK_DATE, 
											IU_ID, 
											SOURCE_ID, 
											BREAK_COUNT, 
											SDBSourceID 
										) 
							SELECT			IU_BREAKS.BREAK_DATE, 
											IU_BREAKS.IU_ID AS IU_ID, 
											IU_BREAKS.SOURCE_ID AS SOURCE_ID, 
											IU_BREAKS.BREAK_COUNT, 
											@SDBSourceID AS SDBSourceID 
							FROM 
										( 
											SELECT  
														CONVERT( DATE, IE.SCHED_DATE_TIME ) AS BREAK_DATE, 
														IE.IU_ID AS IU_ID, 
														IE.SOURCE_ID, 
														COUNT(1) AS BREAK_COUNT  
											FROM		dbo.IE IE WITH (NOLOCK) 
											WHERE		IE.SCHED_DATE_TIME  >= @StartDayBreakCount 
											AND			IE.SCHED_DATE_TIME < @EndDayBreakCount 
											GROUP BY	CONVERT( DATE, IE.SCHED_DATE_TIME ), IE.IU_ID, IE.SOURCE_ID  
										)	AS IU_BREAKS


							INSERT		#ImportIE_SPOT 
										( 
											SPOT_ID, 
											IE_ID, 
											IU_ID, 
											SCHED_DATE, 
											SCHED_DATE_TIME, 
											AWIN_END_DT,  
											IE_NSTATUS, 
											IE_CONFLICT_STATUS, 
											IE_SOURCE_ID, 
											VIDEO_ID, 
											ASSET_DESC, 
											SPOT_ORDER,  
											SPOT_NSTATUS, 
											SPOT_CONFLICT_STATUS, 
											SPOT_RUN_DATE_TIME, 
											SDBSourceID 
										) 
							SELECT	
											SPOT.SPOT_ID, 
											IE.IE_ID, 
											IE.IU_ID, 
											CONVERT(DATE, IE.SCHED_DATE_TIME), 
											IE.SCHED_DATE_TIME,  
											IE.AWIN_END_DT WINDOW_CLOSE, 
											IE.NSTATUS, 
											IE.CONFLICT_STATUS, 
											IE.SOURCE_ID, 
											SPOT.VIDEO_ID, 
											SPOT.TITLE + ' - ' + SPOT.CUSTOMER	AS ASSET_DESC, 
											SPOT.SPOT_ORDER,  
											SPOT.NSTATUS, 
											SPOT.CONFLICT_STATUS, 
											SPOT.RUN_DATE_TIME, 
											@SDBSourceID AS SDBSourceID 
							FROM			dbo.IE IE WITH (NOLOCK) 
							JOIN			dbo.SPOT SPOT WITH (NOLOCK) 
							ON				IE.IE_ID = SPOT.IE_ID 
							WHERE			IE.SCHED_DATE_TIME >= @StartDayIESPOT
							AND				IE.SCHED_DATE_TIME < @EndDayIESPOT


							INSERT		#ImportTB_REQUEST 
										( 
											SCHED_DATE, 
											UTC_SCHED_DATE, 
											FILENAME, 
											FILE_DATETIME, 
											UTC_FILE_DATETIME, 
											PROCESSED, 
											SOURCE_ID, 
											STATUS, 
											IU_ID, 
											SDBSourceID 
										) 
							SELECT 
											CONVERT(DATE,TB_DAYPART) AS SCHED_DATE, 
											CONVERT( DATE, DATEADD(hour, @SDBUTCOffset, TB_DAYPART)) AS UTC_SCHED_DATE, 
											SUBSTRING(TBR.TB_FILE,CHARINDEX('\SCH\',TBR.TB_FILE,0)+5,12) AS FILENAME, 
											TBR.TB_FILE_DATE AS [FILE_DATETIME], 
											DATEADD( hour, @SDBUTCOffset, TBR.TB_FILE_DATE ) AS UTC_FILE_DATETIME, 
											TBR.TB_MACHINE_TS AS PROCESSED, 
											TBR.SOURCE_ID, 
											TBR.STATUS, 
											TBR.IU_ID, 
											@SDBSourceID AS SDBSourceID 
							FROM			dbo.TB_REQUEST TBR WITH (NOLOCK)  
							WHERE			TBR.TB_MODE = 3 
							AND				TBR.TB_REQUEST = 2

							SELECT			@ErrorID	= 0,
											@ErrMsg		= NULL


				END TRY
				BEGIN CATCH

							SELECT			@ErrorID	= @@ERROR,
											@ErrMsg		= ERROR_MESSAGE()

				END CATCH


END



GO
