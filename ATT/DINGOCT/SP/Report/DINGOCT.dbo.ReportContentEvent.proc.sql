



USE DINGOCT
GO

IF ISNULL(OBJECT_ID('dbo.ReportContentEvent'), 0) > 0 
	DROP PROCEDURE dbo.ReportContentEvent
GO

CREATE PROCEDURE dbo.ReportContentEvent 
				@ContentID			UDT_Int READONLY,
				@ContentTypeID		UDT_Int READONLY,
				@SortOrder			INT = NULL
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
// Module:  dbo.ReportContentEvent
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate Content - Event report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOCT.dbo.ReportContentEvent.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				DECLARE			@ContentIDIN			UDT_Int,
//								@ContentTypeIDIN		UDT_Int
//				EXEC			dbo.ReportContentEvent	
//										@ContentID		= @ContentIDIN,
//										@ContentTypeID	= @ContentTypeIDIN,
//										@SortOrder		= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@LastContentID								INT
				DECLARE			@LastContentTypeID							INT

				SELECT			TOP 1 @LastContentID						= c.ID
				FROM			@ContentID c
				ORDER BY		c.ID DESC

				SELECT			TOP 1 @LastContentTypeID					= ct.ID
				FROM			@ContentTypeID ct
				ORDER BY		ct.ID DESC


				SELECT
								UTCDayOfYearPartitionKey	= ce.UTCDayOfYearPartitionKey,
								ContentTypeID				= ce.ContentTypeID,
								ContentID					= ce.ContentID,
								CSPLogID					= ce.CSPLogID,
								ContentIdentifier			= c.ContentIdentifier,
								OccuranceDateStamp			= e.OccuranceDateStamp,
								OccuranceTimeStamp			= e.OccuranceTimeStamp,
								Severity					= e.Severity,
								HostName					= e.HostName,
								Tag							= e.Tag,
								FileName					= e.FileName,
								FilePath					= e.FilePath,
								Message						= e.Message,
								ContentType					= ctdef.Name
				FROM			dbo.ContentEvent ce (NOLOCK)
				JOIN			dbo.Content c (NOLOCK)
				ON				ce.ContentID				= c.ContentID
				JOIN			dbo.CSPLog e (NOLOCK)
				ON				ce.CSPLogID					= e.CSPLogID
				JOIN			dbo.ContentType ctdef (NOLOCK)
				ON				ce.ContentTypeID			= ctdef.ContentTypeID
				LEFT JOIN		@ContentID cp
				ON				ce.ContentID				= cp.Value
				LEFT JOIN		@ContentTypeID ct
				ON				ce.ContentTypeID			= ct.Value
				WHERE			( cp.ID IS NOT NULL OR @LastContentID IS NULL )
				AND				( ct.ID IS NOT NULL OR @LastContentTypeID IS NULL )
				ORDER BY		CASE WHEN @SortOrder = 1 THEN ce.ContentEventID WHEN  @SortOrder = 2 THEN c.ContentIdentifier END,
								CASE WHEN @SortOrder = 2 THEN ce.ContentEventID WHEN  @SortOrder = 1 THEN c.ContentIdentifier END



END
GO