


USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.CheckDimensionCount'), 0) > 0 
	DROP PROCEDURE dbo.CheckDimensionCount
GO

CREATE PROCEDURE dbo.CheckDimensionCount 
							@StartingDate		DATE = NULL,
							@EndingDate			DATE = NULL,
							@Complete			BIT OUTPUT,
							@EventLogTypeID		INT OUTPUT
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
// Module:  dbo.CheckDimensionCount
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Check dimension counts for the given date range.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.CheckDimensionCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							DECLARE			@CompleteOUT BIT
//							DECLARE			@EventLogTypeIDOUT INT
//							EXEC			dbo.CheckDimensionCount	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03',
//												@Complete				= @CompleteOUT OUTPUT,
//												@EventLogTypeID			= @EventLogTypeIDOUT OUTPUT
//							SELECT			@CompleteOUT, @EventLogTypeIDOUT
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@TotalDayRangeCount											INT
							DECLARE				@TotalSDBSources											INT
							DECLARE				@TotalRequiredRows											INT
							DECLARE				@TotalActiveRows											INT
							DECLARE				@TotalInComplete											INT
							DECLARE				@TotalDimensions											INT = 4
							DECLARE				@DimensionName_SPOT											VARCHAR(50) = 'SPOT'
							DECLARE				@DimensionName_IE											VARCHAR(50) = 'IE'
							DECLARE				@DimensionName_IU											VARCHAR(50) = 'IU'
							DECLARE				@DimensionName_TB_REQUEST									VARCHAR(50) = 'TB_REQUEST'
							DECLARE				@EndingDateWhereValue										DATE

							SELECT				@Complete													= 0,
												@EventLogTypeID												= 0

							IF					( ISNULL(OBJECT_ID('tempdb..#ActiveDimensionAndDay'), 0) > 0 ) DROP TABLE #ActiveDimensionAndDay
							CREATE TABLE		#ActiveDimensionAndDay ( ID INT IDENTITY(1,1), DateDay DATE, SDBSourceID INT, DimensionID INT, DimensionName VARCHAR(50) )

							IF					( ISNULL(OBJECT_ID('tempdb..#InCompleteDay'), 0) > 0 )		DROP TABLE #InCompleteDay
							CREATE TABLE		#InCompleteDay ( ID INT IDENTITY(1,1), DateDay DATE, SDBSourceID INT, DimensionID INT, DimensionName VARCHAR(50), DimensionCount INT )

							SELECT				@StartingDate												= ISNULL( @StartingDate,GETUTCDATE() )
							SELECT				@EndingDate													= ISNULL( @EndingDate, DATEADD(DAY,1,@StartingDate) )
							SELECT				@EndingDateWhereValue										= DATEADD(DAY,-1,@EndingDate)
							SELECT				@TotalDayRangeCount											= DATEDIFF(DAY,@StartingDate,@EndingDate)

							SELECT				@TotalSDBSources											= COUNT(1)
							FROM				dbo.DimSDBSource d WITH (NOLOCK)
							WHERE				d.Enabled													= 1

							SELECT				@TotalRequiredRows											= @TotalDayRangeCount * @TotalDimensions * @TotalSDBSources

							INSERT				#ActiveDimensionAndDay ( DateDay,SDBSourceID,DimensionID,DimensionName )
							SELECT				dy.DimDate, 
												s.SDBSourceID, 
												d.DimensionID, 
												d.Name
							FROM				dbo.DimDateDay dy WITH (NOLOCK)
							CROSS JOIN			dbo.Dimension d WITH (NOLOCK)
							CROSS JOIN			dbo.DimSDBSource s WITH (NOLOCK)
							WHERE				dy.DimDate													BETWEEN @StartingDate AND @EndingDateWhereValue
							AND					d.Name														IN (@DimensionName_SPOT,@DimensionName_IE,@DimensionName_IU,@DimensionName_TB_REQUEST)
							AND					s.Enabled													= 1
							SELECT				@TotalActiveRows											= @@ROWCOUNT

							IF					( @TotalActiveRows <> @TotalRequiredRows )
							BEGIN
												SELECT		@Complete										= 0
												SELECT		@EventLogTypeID									= -1
												--Log the error that the we are NOT checking the complete number of dimensions.  
												--Possibly due to misspelling of dimension names.  This should be a VERY rare error.
												--Then exit.
												RETURN
							END

							--					Calculate the number of incomplete SDBSourceID per DimensionID per day
							INSERT				#InCompleteDay ( DateDay,SDBSourceID,DimensionID,DimensionName,DimensionCount )
							SELECT				d1.DateDay,
												d1.SDBSourceID,
												d1.DimensionID,
												d1.DimensionName, 
												d2.DimensionCount
							FROM				#ActiveDimensionAndDay d1 WITH (NOLOCK) 
							LEFT JOIN			dbo.CountDimensionDate d2 WITH (NOLOCK) 
							ON					d1.DateDay													= d2.UTCDateStored
							AND					d1.DimensionID												= d2.DimensionID
							WHERE				d2.CountDimensionDateID										IS NULL
							OR					( d2.Enabled = 1 AND d2.DimensionCount = 0 )
							SELECT				@TotalInComplete											= @@ROWCOUNT

							--If there are NO incomplete days in the date range, then return @Complete = 1 else 0.
							SELECT				@Complete													= CASE WHEN (ISNULL(@TotalInComplete,0)  = 0) THEN 1 ELSE 0 END
							SELECT				@EventLogTypeID												= CASE WHEN (@Complete = 1) THEN 1 ELSE 0 END

							DROP TABLE			#ActiveDimensionAndDay
							DROP TABLE			#InCompleteDay


END
GO


