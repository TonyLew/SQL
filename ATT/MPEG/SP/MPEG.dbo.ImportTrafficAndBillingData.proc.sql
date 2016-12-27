
Use MPEG
GO

IF ISNULL(OBJECT_ID('dbo.ImportTrafficAndBillingData'), 0) > 0 
	DROP PROCEDURE dbo.ImportTrafficAndBillingData
GO

CREATE PROCEDURE [dbo].[ImportTrafficAndBillingData]
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
// Module:  dbo.ImportTrafficAndBillingData
// Created: 2014-Mar-04
// Author:  Tony Lew
// 
// Purpose: Updates DINGODB (dataminer DB interface) with latest SDB info.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ImportTrafficAndBillingData.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE	@ErrorIDOUT							INT 
//				DECLARE	@ErrMsgOUT							VARCHAR(200)
//				EXEC	MPEG.dbo.ImportTrafficAndBillingData	
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


END



GO
