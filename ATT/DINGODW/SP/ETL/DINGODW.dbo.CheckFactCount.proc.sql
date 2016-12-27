


USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.CheckFactCount'), 0) > 0 
	DROP PROCEDURE dbo.CheckFactCount
GO

CREATE PROCEDURE dbo.CheckFactCount 
							@StartingDate		DATE = NULL,
							@EndingDate			DATE = NULL,
							@Exists				BIT OUTPUT,
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
// Module:  dbo.CheckFactCount
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Check fact counts for the given date range.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.CheckFactCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							DECLARE			@ExistsOUT BIT
//							DECLARE			@EventLogTypeIDOUT INT
//							EXEC			dbo.CheckFactCount	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03',
//												@Exists					= @ExistsOUT OUTPUT,
//												@EventLogTypeID			= @EventLogTypeIDOUT OUTPUT
//							SELECT			@ExistsOUT, @EventLogTypeIDOUT
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@TotalDayRangeCount											INT
							DECLARE				@TotalRequiredFactAndDay									INT
							DECLARE				@TotalActiveFactAndDay										INT
							DECLARE				@TotalComplete												INT
							DECLARE				@TotalFacts													INT = 1
							DECLARE				@FactName_XSEU												VARCHAR(50) = 'XSEU'
							--DECLARE				@FactName_IE												VARCHAR(50) = 'IE'
							--DECLARE				@FactName_IU												VARCHAR(50) = 'IU'
							--DECLARE				@FactName_TB_REQUEST										VARCHAR(50) = 'TB_REQUEST'
							DECLARE				@EndingDateWhereValue										DATE

							SELECT				@Exists														= 1,
												@EventLogTypeID												= 0

							IF					( ISNULL(OBJECT_ID('tempdb..#ActiveFactAndDay'), 0) > 0 )	DROP TABLE #ActiveFactAndDay
							CREATE TABLE		#ActiveFactAndDay ( ID INT IDENTITY(1,1), DateDay DATE, FactID INT, FactName VARCHAR(50) )

							IF					( ISNULL(OBJECT_ID('tempdb..#CompleteDay'), 0) > 0 )		DROP TABLE #CompleteDay
							CREATE TABLE		#CompleteDay ( ID INT IDENTITY(1,1), DateDay DATE, FactID INT, FactName VARCHAR(50), FactCount INT )

							SELECT				@StartingDate												= ISNULL( @StartingDate,GETUTCDATE() )
							SELECT				@EndingDate													= ISNULL( @EndingDate, DATEADD(DAY,1,@StartingDate) )
							SELECT				@EndingDateWhereValue										= DATEADD(DAY,-1,@EndingDate)
							SELECT				@TotalDayRangeCount											= DATEDIFF(DAY,@StartingDate,@EndingDate)

							SELECT				@TotalRequiredFactAndDay									= @TotalDayRangeCount * @TotalFacts

							INSERT				#ActiveFactAndDay ( DateDay,FactID,FactName )
							SELECT				dy.DimDate, d.FactID, d.Name
							FROM				dbo.DimDateDay dy WITH (NOLOCK)
							CROSS JOIN			dbo.Fact d WITH (NOLOCK)
							WHERE				dy.DimDate													BETWEEN @StartingDate AND @EndingDateWhereValue
							AND					d.Name														IN (@FactName_XSEU)
							SELECT				@TotalActiveFactAndDay										= @@ROWCOUNT

							IF					( @TotalActiveFactAndDay <> @TotalRequiredFactAndDay )
							BEGIN
												SELECT		@Exists											= 1
												SELECT		@EventLogTypeID									= 1
												--Log the error that the we are NOT checking the complete number of Facts.  
												--Possibly due to misspelling of Fact names.  This should be a VERY rare error.
												--Then exit.
												--Insert into DINGODB.dbo.EventLog table.
												RETURN
							END

							--					Calculate the number of complete days
							INSERT				#CompleteDay ( DateDay,FactID,FactName,FactCount )
							SELECT				d.DateDay,
												d.FactID,
												d.FactName, 
												f.FactCount
							FROM				#ActiveFactAndDay d WITH (NOLOCK) 
							JOIN				dbo.CountFactDate f WITH (NOLOCK) 
							ON					d.DateDay													= f.UTCDateStored
							AND					d.FactID													= f.FactID
							WHERE				f.Enabled													= 1 
							AND					f.FactCount													> 0
							SELECT				@TotalComplete												= @@ROWCOUNT

							--If any of the days to be archived have Facts that are incomplete or missing, then return @Exists = 0 and log the error.
							SELECT				@Exists														= CASE WHEN (ISNULL(@TotalComplete,0) > 0) THEN 1 ELSE 0 END
							SELECT				@EventLogTypeID												= CASE WHEN (@Exists = 1) THEN 1 ELSE 0 END


							DROP TABLE			#ActiveFactAndDay
							DROP TABLE			#CompleteDay


END

GO




