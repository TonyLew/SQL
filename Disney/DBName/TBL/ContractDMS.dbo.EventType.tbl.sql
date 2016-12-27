

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
	--   Module:		dbo.EventType
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
	--					FROM		dbo.EventType WITH (NOLOCK)
	--					ORDER BY	EventTypeId
	--

*/ 
-- =============================================




------------------------------------------------------------------------------------------
--CREATION of EventType TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('EventType', 'u') IS NULL )					
BEGIN

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		--DROP TABLE dbo.EventType
		CREATE TABLE dbo.EventType
		(
			[EventTypeId] [UNIQUEIDENTIFIER] NOT NULL CONSTRAINT PK_EventType PRIMARY KEY,
			[Created] [DATETIME] NOT NULL CONSTRAINT [DF_EventType_Created]  DEFAULT (GETDATE()),
			[Updated] [DATETIME] NULL,
			[IsActive] [BIT] NOT NULL CONSTRAINT [DF_EventTypeIsActive]  DEFAULT (1),
			[Name] [varchar] (200) NOT NULL,
			[Description] [varchar] (500) NULL,
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		ALTER TABLE  dbo.EventType ADD CONSTRAINT DF_EventType_EventId  DEFAULT NEWSEQUENTIALID() FOR EventTypeId

		CREATE UNIQUE NONCLUSTERED INDEX UX_EventType_Name_iIsActive ON dbo.EventType (Name) INCLUDE ( IsActive )

END


------------------------------------------------------------------------------------------
--POPULATION of EventType TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('EventType', 'u') IS NOT NULL )					
BEGIN

		SET			NOCOUNT ON
		Insert		dbo.EventType (Name,	Description )
		Select		x.Name , x.Description 
		From	(
					Select		SortOrder =   1,  Name = 'Universal', 		Description = 'Used to hold all universal Types' UNION
					Select		SortOrder =   2,  Name = 'UnKnown', 		Description = 'Used to hold all unknown Types' UNION
					Select		SortOrder =   3,  Name = 'DR', 				Description = 'Used to hold all DR Types' UNION
					Select		SortOrder =   4,  Name = 'DRService',		Description = 'Used to hold all DRService Types' UNION
					Select		SortOrder =   5,  Name = 'HTTP', 			Description = 'Used to hold all HTTP Types' UNION
					Select		SortOrder =   6,  Name = 'DMS', 			Description = 'Used to hold all DMS Types' UNION
					Select		SortOrder =   7,  Name = 'Selectica',		Description = 'Used to hold all Selectica Types'
				) x
		Left Join	dbo.EventType y		on x.Name = y.Name
		Where		y.Name IS NULL
		Order By	x.SortOrder


END
GO