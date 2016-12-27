

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
	--   Module:		dbo.EventStatusType
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
	--					FROM		dbo.EventStatusType WITH (NOLOCK)
	--					ORDER BY	EventStatusTypeId
	--

*/ 
-- =============================================




------------------------------------------------------------------------------------------
--CREATION of EventStatusType TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('EventStatusType', 'u') IS NULL )					
BEGIN


		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON


		--DROP TABLE dbo.EventStatusType
		CREATE TABLE dbo.EventStatusType
		(
			[EventStatusTypeId] [UNIQUEIDENTIFIER] NOT NULL CONSTRAINT PK_EventStatusType PRIMARY KEY,
			[Created] [DATETIME] NOT NULL CONSTRAINT [DF_EventStatusType_Created]  DEFAULT (GETDATE()),
			[Updated] [DATETIME] NULL,
			[Name] [varchar] (200) NOT NULL,
			[Description] [varchar] (500) NULL,
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		ALTER TABLE  dbo.EventStatusType ADD CONSTRAINT DF_EventStatusType_EventStatusTypeId  DEFAULT NEWSEQUENTIALID() FOR EventStatusTypeId

		CREATE UNIQUE NONCLUSTERED INDEX UX_EventStatusType_Name ON dbo.EventStatusType ( Name ) 

END


------------------------------------------------------------------------------------------
--POPULATION of EventStatusType TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('EventStatusType', 'u') IS NOT NULL )					
BEGIN


		SET			NOCOUNT ON
		Insert		dbo.EventStatusType ( Name,	Description )
		Select		x.Name,	x.Description
		From	(

					Select		SortOrder =   1,		Name = 'Success',										Description = NULL UNION 
					Select		SortOrder =	  2,		Name = 'Warning',										Description = ' - Warning' UNION 
					Select		SortOrder =	  3,		Name = 'Error',											Description = ' - Error' 

				)	x
		Left Join	dbo.EventStatusType y WITH (NOLOCK)	ON x.Name = y.Name
		Where		y.EventStatusTypeId					IS NULL
		Order By	x.SortOrder 


END
GO


