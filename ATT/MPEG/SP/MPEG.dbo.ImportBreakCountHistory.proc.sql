
Use MPEG
GO

IF ISNULL(OBJECT_ID('dbo.ImportBreakCountHistory'), 0) > 0 
	DROP PROCEDURE dbo.ImportBreakCountHistory
GO

CREATE PROCEDURE [dbo].[ImportBreakCountHistory]
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
// Module:  dbo.ImportBreakCountHistory
// Created: 2014-Mar-04
// Author:  Tony Lew
// 
// Purpose: Updates DINGODB (dataminer DB interface) with latest SDB info.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ImportBreakCountHistory.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				DECLARE	@ErrorIDOUT							INT 
//				DECLARE	@ErrMsgOUT							VARCHAR(200)
//				EXEC	MPEG.dbo.ImportBreakCountHistory	
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
											AND			IE.NSTATUS <> 15 
											GROUP BY	CONVERT( DATE, IE.SCHED_DATE_TIME ), IE.IU_ID, IE.SOURCE_ID  
										)	AS IU_BREAKS


END



GO
