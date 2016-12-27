Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetEventLog'), 0) > 0 
	DROP PROCEDURE dbo.GetEventLog
GO

CREATE PROCEDURE [dbo].[GetEventLog]
		@Page				INT = 1,
		@PageSize			INT = 50,
		@SortOrder			INT = 2			--	1 = ascending order and 2 = descending order
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
// Module:  dbo.GetEventLog
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the EventLog with configurable pagination logic
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetEventLog.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	dbo.GetEventLog
//						@Page				= 1,
//						@PageSize			= 50,
//						@SortOrder			= 2	
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@Results		UDT_Int
		DECLARE				@FirstRowID		INT
		DECLARE				@LastRow		INT
		DECLARE				@FirstRow		INT
		
		SELECT				@Page = @Page - 1					

		IF	( @SortOrder = 1 )
				SELECT		
							@FirstRowID		=	1,
							@FirstRow		=	@FirstRowID + ( @Page * @PageSize ),
							@LastRow		=	@FirstRow + @PageSize - 1 
		ELSE
				SELECT		
							@FirstRowID		=	IDENT_CURRENT( 'Eventlog' ),
							@LastRow		=	@FirstRowID - ( @Page * @PageSize ), 
							@FirstRow		=	@LastRow - @PageSize


		SELECT				TOP ( @PageSize )
							a.EventLogID,
							datediff( SECOND, a.StartDate, ISNULL(a.FinishDate, GETUTCDATE()) ) AS TotalTime,
							b.Description,
							a.JobID,
							a.JobName,
							a.DBID,
							a.DBComputerName,
							a.Description,
							a.StartDate,
							a.FinishDate
		FROM				dbo.EventLog a (NOLOCK)
		JOIN				dbo.EventLogStatus b (NOLOCK)
		ON					a.EventlogStatusID									= b.EventLogStatusID
		WHERE				a.EventLogID BETWEEN @FirstRow AND @LastRow
		ORDER BY			CASE WHEN @SortOrder = 1 THEN a.EventLogID END ASC, 
							CASE WHEN @SortOrder = 2 THEN a.EventLogID END DESC

END

GO


