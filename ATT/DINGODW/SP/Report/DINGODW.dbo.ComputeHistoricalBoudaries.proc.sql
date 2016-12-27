






USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ComputeHistoricalBoundaries'), 0) > 0 
	DROP PROCEDURE dbo.ComputeHistoricalBoundaries
GO

CREATE PROCEDURE dbo.ComputeHistoricalBoundaries 
				@StartDateTime					DATETIME,
				@EndDateTime					DATETIME,
				@UseUTC							INT,
				@UTCHistoricalMarkerDateTime	DATETIME OUTPUT,
				@UTCHistoricalStartDateTime		DATETIME OUTPUT,
				@UTCHistoricalEndDateTime		DATETIME OUTPUT,
				@UTCCurrentStartDateTime		DATETIME OUTPUT,
				@UTCCurrentEndDateTime			DATETIME OUTPUT
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
// Module:  dbo.ComputeHistoricalBoundaries
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Determine the historical and current datetime ranges based on the input parameters.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ComputeHistoricalBoundaries.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//
//				DECLARE				@UTCHistoricalMarkerDateTimeO			DATETIME
//				DECLARE				@UTCHistoricalStartDateTimeO			DATETIME
//				DECLARE				@UTCHistoricalEndDateTimeO				DATETIME
//				DECLARE				@UTCCurrentStartDateTimeO				DATETIME
//				DECLARE				@UTCCurrentEndDateTimeO					DATETIME
//
//				EXEC				dbo.ComputeHistoricalBoundaries	
//											@StartDateTime					= '2014-06-19 08:00:00',
//											@EndDateTime					= '2014-06-23 20:00:00',
//											@UseUTC							= 1,
//											@UTCHistoricalMarkerDateTime	= @UTCHistoricalMarkerDateTimeO OUTPUT,
//											@UTCHistoricalStartDateTime		= @UTCHistoricalStartDateTimeO OUTPUT,
//											@UTCHistoricalEndDateTime		= @UTCHistoricalEndDateTimeO OUTPUT,
//											@UTCCurrentStartDateTime		= @UTCCurrentStartDateTimeO OUTPUT,
//											@UTCCurrentEndDateTime			= @UTCCurrentEndDateTimeO OUTPUT
//
//				SELECT				@UTCHistoricalMarkerDateTimeO,
//									@UTCHistoricalStartDateTimeO,
//									@UTCHistoricalEndDateTimeO,
//									@UTCCurrentStartDateTimeO,
//									@UTCCurrentEndDateTimeO
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				DECLARE			@UTCHourOffset									INT = DATEDIFF(HOUR,GETUTCDATE(),GETDATE())
				DECLARE			@UTCHistoricalMarkerNextDayDateTime				DATETIME
				DECLARE			@UTCStartDateTime								DATETIME
				DECLARE			@UTCEndDateTime									DATETIME
				DECLARE			@UTCHistoricalMarkerDate						DATE

				--				The dataware house marker may NOT always be @UTCToday because the job may not have run.
				--				So we have the last recorded datetime stored here: @UTCHistoricalMarkerDateTime .
				SELECT TOP 1	@UTCHistoricalMarkerDateTime					= UTCDateStored,
								@UTCHistoricalMarkerNextDayDateTime				= DATEADD( DAY,1,@UTCHistoricalMarkerDateTime ),
								@UTCHistoricalMarkerDateTime					= DATEADD( SECOND,86399,@UTCHistoricalMarkerDateTime ) --86399 = seconds per day -1
				FROM			dbo.CountFactDate (NOLOCK)
				ORDER BY		UTCDateStored DESC

				IF				( @StartDateTime IS NULL OR @EndDateTime IS NULL )
								SELECT TOP 1	@StartDateTime					= UTCDateStored,
												@EndDateTime					= @UTCHistoricalMarkerDateTime
								FROM			dbo.CountFactDate (NOLOCK)
								ORDER BY		UTCDateStored 


				SELECT			@UTCStartDateTime								= CASE WHEN @UseUTC = 1 THEN @StartDateTime ELSE DATEADD( HOUR,@UTCHourOffset,@StartDateTime ) END,
								@UTCEndDateTime									= CASE WHEN @UseUTC = 1 THEN @EndDateTime ELSE DATEADD( HOUR,@UTCHourOffset,@EndDateTime ) END


				SELECT			@UTCHistoricalStartDateTime						= CASE WHEN @UTCStartDateTime		< @UTCHistoricalMarkerNextDayDateTime		THEN @UTCStartDateTime						ELSE @UTCHistoricalMarkerDateTime END, 
								@UTCHistoricalEndDateTime						= CASE WHEN @UTCEndDateTime			< @UTCHistoricalMarkerNextDayDateTime		THEN @UTCEndDateTime						ELSE @UTCHistoricalMarkerDateTime END,
								@UTCCurrentStartDateTime						= CASE WHEN @UTCStartDateTime		< @UTCHistoricalMarkerNextDayDateTime		THEN @UTCHistoricalMarkerNextDayDateTime	ELSE @UTCStartDateTime END,
								@UTCCurrentEndDateTime							= CASE WHEN @UTCEndDateTime			< @UTCHistoricalMarkerNextDayDateTime		THEN @UTCHistoricalMarkerNextDayDateTime	ELSE @UTCEndDateTime END



END


GO





