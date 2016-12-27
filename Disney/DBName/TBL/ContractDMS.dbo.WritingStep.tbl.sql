

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
	--   Module:		dbo.WritingStep
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
	--					FROM		dbo.WritingStep WITH (NOLOCK)
	--					ORDER BY	WritingStepId
	--

*/ 
-- =============================================


------------------------------------------------------------------------------------------
--CREATION of WritingStep TABLE
------------------------------------------------------------------------------------------


IF ( OBJECT_ID('WritingStep', 'u') IS NULL )					
BEGIN


		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		--DROP TABLE dbo.WritingStep
		CREATE TABLE dbo.WritingStep
		(
			[WritingStepId] [UNIQUEIDENTIFIER] NOT NULL CONSTRAINT PK_WritingStep PRIMARY KEY,
			[Name] [varchar] (200) NOT NULL,
			[Description] [varchar] (500) NULL,
			[SortOrder] [int] NOT NULL,
			[Created] [DATETIME] NOT NULL CONSTRAINT [DF_WritingStep_Created]  DEFAULT (GETDATE()),
			[Updated] [DATETIME] NULL,
			[IsActive] [BIT] NOT NULL CONSTRAINT [DF_WritingStep_IsActive]  DEFAULT (1),
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		ALTER TABLE  dbo.WritingStep ADD CONSTRAINT DF_WritingStep_WritingStepId  DEFAULT NEWSEQUENTIALID() FOR WritingStepId

		CREATE UNIQUE NONCLUSTERED INDEX UX_WritingStep_Name ON dbo.WritingStep (Name)


END


------------------------------------------------------------------------------------------
--POPULATION of WritingStep TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('WritingStep', 'u') IS NOT NULL )					
BEGIN

		SET			NOCOUNT ON
		ALTER TABLE  dbo.WritingStep DROP CONSTRAINT DF_WritingStep_WritingStepId 

		Insert		dbo.WritingStep ( WritingStepId, Name, Description, SortOrder )
		Select		x.WritingStepId, x.Name, x.Description, x.SortOrder
		FROM		
				(	
					--Select		SortOrder =   0, Name = 'UnDefined', Description = 'Used to hold all UnDefined types' UNION
					Select		WritingStepId = 'E3C8224A-A94D-E511-B5CA-005056A06886', SortOrder =   1, Name = 'Bible', Description = 'Bible' UNION
					Select		WritingStepId = 'E4C8224A-A94D-E511-B5CA-005056A06886', SortOrder =   2, Name = 'Full Script (5 Steps)', Description = 'Full Script (5 Steps)' UNION
					Select		WritingStepId = 'E5C8224A-A94D-E511-B5CA-005056A06886', SortOrder =   3, Name = 'Story & Teleplay', Description = 'Story & Teleplay' UNION
					Select		WritingStepId = 'E6C8224A-A94D-E511-B5CA-005056A06886', SortOrder =   4, Name = 'Story', Description = 'Story' UNION
					Select		WritingStepId = 'E7C8224A-A94D-E511-B5CA-005056A06886', SortOrder =   5, Name = 'Teleplay', Description = 'Teleplay' UNION
					Select		WritingStepId = 'E8C8224A-A94D-E511-B5CA-005056A06886', SortOrder =   6, Name = 'Rewrite', Description = 'Rewrite' UNION
					Select		WritingStepId = 'E9C8224A-A94D-E511-B5CA-005056A06886', SortOrder =   7, Name = 'Polish', Description = 'Polish' UNION
					Select		WritingStepId = 'EAC8224A-A94D-E511-B5CA-005056A06886', SortOrder =   8, Name = 'Optional Rewrite', Description = 'Optional Rewrite' UNION
					Select		WritingStepId = 'EBC8224A-A94D-E511-B5CA-005056A06886', SortOrder =   9, Name = 'Optional Polish', Description = 'Optional Polish' UNION
					Select		WritingStepId = 'ECC8224A-A94D-E511-B5CA-005056A06886', SortOrder =  10, Name = 'Other', Description = 'Other'
				) x
		LEFT JOIN	dbo.WritingStep y			ON x.Name = y.Name AND x.SortOrder = y.SortOrder
		WHERE		y.WritingStepId IS NULL
		ORDER BY	x.SortOrder

		ALTER TABLE  dbo.WritingStep ADD CONSTRAINT DF_WritingStep_WritingStepId  DEFAULT NEWSEQUENTIALID() FOR WritingStepId


END
GO