
IF OBJECT_ID('GetEventLog', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetEventLog
GO


CREATE proc dbo.GetEventLog
			@EventTypeId				UNIQUEIDENTIFIER = NULL,
			@EventId					UNIQUEIDENTIFIER = NULL,
			@EventLogTypeId				UNIQUEIDENTIFIER = NULL,
			@MAXRows					INT = 50
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-06-05 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetEventLog
	--   Created:		2015-Jul-05
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--
	--   Usage:
	--
	--
	--					EXEC		dbo.GetEventLog
	--										@EventTypeId			= 1,
	--										@EventId				= 1,
	--										@EventLogTypeId			= 1
	--										@MAXRows				= 50
	--					SELECT		@EventIdOUT
	--

*/ 
-- =============================================
BEGIN


			SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
			SET			NOCOUNT ON	
			SET			LOCK_TIMEOUT 5000	

			SELECT		TOP ( @MAXRows )
						el.EventLogId,
						e.EventId,
						EventTypeName								= elt.Name,
						EventName									= e.Name,
						EventLogTypeName							= elt.Name,
						UserId										= u.UserId,
						UserName									= u.UserName,
						EventOccurance								= el.Created,
						Comment										= elc.Comment
			FROM		dbo.EventLog el WITH (NOLOCK) 
			JOIN		dbo.EventLogType elt WITH (NOLOCK)			ON el.EventLogTypeId = elt.EventLogTypeId
			JOIN		dbo.Event e WITH (NOLOCK)					ON el.EventId = e.EventId
			JOIN		dbo.EventType et WITH (NOLOCK)				ON e.EventTypeId = et.EventTypeId
			LEFT JOIN	dbo.EventLogComment elc WITH (NOLOCK)		ON el.EventLogId = elc.EventLogId
			LEFT JOIN	dbo.Users u WITH (NOLOCK)					ON el.UserId = u.UserId
			WHERE		1=1
			AND			et.EventTypeId								= ISNULL(@EventTypeId,et.EventTypeId)
			AND			e.EventId									= ISNULL(@EventId,e.EventId)
			AND			el.EventLogTypeId							= ISNULL(@EventLogTypeId,el.EventLogTypeId)
			ORDER BY	el.EventLogId DESC


END
GO
