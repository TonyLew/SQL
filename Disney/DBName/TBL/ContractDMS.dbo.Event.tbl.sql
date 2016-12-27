

-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-Dec-01 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.Event
	--   Created:		2015-Dec-01
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--					
	--
	--   Usage:
	--
	--
	--					SELECT		*
	--					FROM		dbo.Event WITH (NOLOCK)
	--					ORDER BY	EventId
	--

*/ 
-- =============================================





IF ( OBJECT_ID('Event', 'u') IS NULL )					
BEGIN


		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON


		--DROP TABLE dbo.Event
		CREATE TABLE dbo.Event
		(
			[EventId] [UNIQUEIDENTIFIER] NOT NULL CONSTRAINT PK_Event PRIMARY KEY,
			[EventTypeId] [UNIQUEIDENTIFIER] NOT NULL,
			[Created] [DATETIME] NOT NULL CONSTRAINT [DF_Event_Created]  DEFAULT (GETDATE()),
			[Updated] [DATETIME] NULL,
			[IsActive] [BIT] NOT NULL CONSTRAINT [DF_Event_IsActive]  DEFAULT (1),
			[Name] [varchar] (200) NULL,
			[Description] [varchar] (500) NULL
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		ALTER TABLE  dbo.Event ADD CONSTRAINT DF_Event_EventId  DEFAULT NEWSEQUENTIALID() FOR EventId

		ALTER TABLE dbo.Event  WITH CHECK ADD  CONSTRAINT [FK_Event_EventTypeId-->EventType_EventTypeId] FOREIGN KEY ( EventTypeId )
		REFERENCES dbo.EventType ( EventTypeId )

		--CREATE UNIQUE NONCLUSTERED INDEX UX_Event_Name ON dbo.Event (Name)


END 




------------------------------------------------------------------------------------------
--POPULATION of Event TABLE
------------------------------------------------------------------------------------------


IF ( OBJECT_ID('Event', 'u') IS NOT NULL )					
BEGIN


		SET			NOCOUNT ON
		DECLARE		@EventTypeIDDMS			UNIQUEIDENTIFIER
		Select		@EventTypeIDDMS			= EventTypeId FROM dbo.EventType WHERE Name = 'DMS'

		Insert		dbo.Event ( EventTypeId,Name,Description )
		SELECT		@EventTypeIDDMS AS EventTypeId, x.Name,	x.Description
		FROM	(
					Select		SortOrder =	    1, Name = 'Executive Upsert', 									Description = 'Used to identify all Executive upsert activity' UNION
					Select		SortOrder =	    2, Name = 'Production Document Upsert', 						Description = 'Used to identify all Production Document upsert activity' UNION
					Select		SortOrder =	    3, Name = 'Financial Grid Upsert', 								Description = 'Used to identify all Financial Grid upsert activity' 
					
				) x
		LEFT JOIN	dbo.Event y ON x.Name = y.Name
		WHERE		y.EventId IS NULL
		ORDER BY	x.SortOrder

--Select * from dbo.Event


END
GO




