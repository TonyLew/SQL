

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
	--   Module:		dbo.XProjectStatusProjectCategory
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
	--					FROM		dbo.XProjectStatusProjectCategory WITH (NOLOCK)
	--					ORDER BY	XProjectStatusProjectCategoryId
	--

*/ 
-- =============================================



--------------------------------------------------------------------------------------------
----CREATION of XProjectStatusProjectCategory TABLE
--------------------------------------------------------------------------------------------


IF ( OBJECT_ID('XProjectStatusProjectCategory', 'u') IS NULL )					
BEGIN

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		--DROP TABLE dbo.XProjectStatusProjectCategory
		CREATE TABLE dbo.XProjectStatusProjectCategory
		(
			[XProjectStatusProjectCategoryId]		[UNIQUEIDENTIFIER] NOT NULL CONSTRAINT PK_XProjectStatusProjectCategory PRIMARY KEY,
			[Created]								[DATETIME] NOT NULL CONSTRAINT [DF_XProjectStatusProjectCategory_Created] DEFAULT (GETDATE()),
			[Updated]								[DATETIME] NULL,
			[IsActive]								[BIT] NOT NULL CONSTRAINT [DF_XProjectStatusProjectCategory_IsActive] DEFAULT (1),
			[ProjectCategoryId]						[UNIQUEIDENTIFIER] NOT NULL,
			[ProjectCategoryFilterGroup]			[INT] NOT NULL,
			[ProjectStatusId]						[UNIQUEIDENTIFIER] NULL,
			[DocumentStatusTypeId]					[UNIQUEIDENTIFIER] NULL,
			[TalentDeal]							[BIT] NOT NULL,
			[NetworkId]								[UNIQUEIDENTIFIER] NOT NULL,
			[AgreementClassId]						[UNIQUEIDENTIFIER] NULL,
			[FormatId]								[UNIQUEIDENTIFIER] NULL,
			[GenreId]								[UNIQUEIDENTIFIER] NULL,
			[LengthId]								[UNIQUEIDENTIFIER] NULL,
			[ProgramTypeId]							[UNIQUEIDENTIFIER] NULL

		) ON [PRIMARY]

		SET ANSI_PADDING OFF


		ALTER TABLE  dbo.XProjectStatusProjectCategory ADD CONSTRAINT DF_XProjectStatusProjectCategory_XProjectStatusProjectCategoryId DEFAULT NEWSEQUENTIALID()  FOR XProjectStatusProjectCategoryId


		ALTER TABLE dbo.XProjectStatusProjectCategory  WITH CHECK ADD  CONSTRAINT [FK_XProjectStatusProjectCategory_NetworkId-->Network_NetworkId] FOREIGN KEY ( NetworkId )
		REFERENCES dbo.Network ( NetworkId )

		ALTER TABLE dbo.XProjectStatusProjectCategory  WITH CHECK ADD  CONSTRAINT [FK_XProjectStatusProjectCategory_ProjectStatusId-->ProjectStatus_ProjectStatusId] FOREIGN KEY ( ProjectStatusId )
		REFERENCES dbo.ProjectStatus ( ProjectStatusId )

		ALTER TABLE dbo.XProjectStatusProjectCategory  WITH CHECK ADD  CONSTRAINT [FK_XProjectStatusProjectCategory_DocumentStatusTypeId-->DocumentStatusType_DocumentStatusTypeId] FOREIGN KEY ( DocumentStatusTypeId )
		REFERENCES dbo.DocumentStatusType ( DocumentStatusTypeId )

		ALTER TABLE dbo.XProjectStatusProjectCategory  WITH CHECK ADD  CONSTRAINT [FK_XProjectStatusProjectCategory_AgreementClassId-->AgreementClass_AgreementClassId] FOREIGN KEY ( AgreementClassId )
		REFERENCES dbo.AgreementClass ( AgreementClassId )

		ALTER TABLE dbo.XProjectStatusProjectCategory  WITH CHECK ADD  CONSTRAINT [FK_XProjectStatusProjectCategory_FormatId-->Format_FormatId] FOREIGN KEY ( FormatId )
		REFERENCES dbo.Format ( FormatId )

		ALTER TABLE dbo.XProjectStatusProjectCategory  WITH CHECK ADD  CONSTRAINT [FK_XProjectStatusProjectCategory_GenreId-->Genre_GenreId] FOREIGN KEY ( GenreId )
		REFERENCES dbo.Genre ( GenreId )

		ALTER TABLE dbo.XProjectStatusProjectCategory  WITH CHECK ADD  CONSTRAINT [FK_XProjectStatusProjectCategory_ProgramTypeId-->ProgramType_ProgramTypeId] FOREIGN KEY ( ProgramTypeId )
		REFERENCES dbo.ProgramType ( ProgramTypeId )

		ALTER TABLE dbo.XProjectStatusProjectCategory  WITH CHECK ADD  CONSTRAINT [FK_XProjectStatusProjectCategory_ProjectCategoryId-->ProjectCategory_ProjectCategoryId] FOREIGN KEY ( ProjectCategoryId )
		REFERENCES dbo.ProjectCategory ( ProjectCategoryId )



		--DROP INDEX XProjectStatusProjectCategory.UX_XProjectStatusProjectCategory_NId1_ACId_FId_NId2_PTId_PSId_PCId_iIsActive 
		--CREATE UNIQUE INDEX UX_XProjectStatusProjectCategory_NId1_ACId_FId_NId2_PTId_PSId_PCId_iIsActive 
		--ON dbo.XProjectStatusProjectCategory ( NetworkId,AgreementClassId,FormatId,NetworkId2,ProgramTypeId,ProjectStatusId,ProjectCategoryId ) INCLUDE ( IsActive )

		--DROP INDEX XProjectStatusProjectCategory.UX_XProjectStatusProjectCategory_NId1_ACId_FId_LId_PTId_PSId_PCId_iIsActive 
		--CREATE UNIQUE INDEX UX_XProjectStatusProjectCategory_NId1_ACId_FId_LId_PTId_PSId_PCId_iIsActive 
		--ON dbo.XProjectStatusProjectCategory ( NetworkId,AgreementClassId,FormatId,LengthId,ProgramTypeId,ProjectStatusId,ProjectCategoryId ) INCLUDE ( IsActive )

		CREATE UNIQUE INDEX UX_XProjectStatusProjectCategory_NId1_PSId_DSTId_ACId_FId_GId_LId_PTId_PCId_iIsActive 
		ON dbo.XProjectStatusProjectCategory ( NetworkId,ProjectStatusId,DocumentStatusTypeId,AgreementClassId,FormatId,GenreId,LengthId,ProgramTypeId,ProjectCategoryId ) INCLUDE ( IsActive )

		--DROP INDEX XProjectStatusProjectCategory.UX_XProjectStatusProjectCategory_NId1_DSTId_ACId_FId_GId_LId_PTId_PCId_iIsActive
		--CREATE UNIQUE INDEX UX_XProjectStatusProjectCategory_NId1_DSTId_ACId_FId_GId_LId_PTId_PCId_iIsActive 
		--ON dbo.XProjectStatusProjectCategory ( NetworkId,DocumentStatusTypeId,AgreementClassId,FormatId,GenreId,LengthId,ProgramTypeId,ProjectCategoryId ) INCLUDE ( IsActive )
		

END
GO


------------------------------------------------------------------------------------------
--POPULATION of XProjectStatusProjectCategory TABLE
------------------------------------------------------------------------------------------


IF ( OBJECT_ID('XProjectStatusProjectCategory', 'u') IS NOT NULL )					
BEGIN



		SET				NOCOUNT ON

		DECLARE			@EmptyGUID					UNIQUEIDENTIFIER = CAST('00000000-0000-0000-0000-000000000000' as UNIQUEIDENTIFIER)

		DECLARE			@Xtmp						TABLE	( 
																[Id]									INT IDENTITY(1,1) NOT NULL,
																[ProjectCategoryId]						[UNIQUEIDENTIFIER] NOT NULL,
																[ProjectCategoryName]					[VARCHAR](200) NOT NULL,
																[ProjectCategoryFilterGroup]			[INT] NOT NULL,
																[TalentDeal]							[BIT] NOT NULL,
																[NetworkId]								[UNIQUEIDENTIFIER] NOT NULL,
																[NetworkName]							[VARCHAR](200) NOT NULL,
																[NetworkShortName]						[VARCHAR](20) NOT NULL,
																[ProjectStatusId]						[UNIQUEIDENTIFIER] NULL,
																[ProjectStatusName]						[VARCHAR](200) NULL,
																[DocumentStatusTypeId]					[UNIQUEIDENTIFIER] NULL,
																[DocumentStatusTypeName]				[VARCHAR](200) NULL,
																[AgreementClassId]						[UNIQUEIDENTIFIER] NULL,
																[AgreementClassName]					[VARCHAR](200) NULL,
																[FormatId]								[UNIQUEIDENTIFIER] NULL,
																[FormatName]							[VARCHAR](200) NULL,
																[GenreId]								[UNIQUEIDENTIFIER] NULL,
																[GenreName]								[VARCHAR](200) NULL,
																[LengthId]								[UNIQUEIDENTIFIER] NULL,
																[LengthName]							[VARCHAR](200) NULL,
																[ProgramTypeId]							[UNIQUEIDENTIFIER] NULL,
																[ProgramTypeName]						[VARCHAR](200) NULL
															)


															
		INSERT			@Xtmp
					(

						ProjectCategoryId					,
						ProjectCategoryName					,
						ProjectCategoryFilterGroup			,
						TalentDeal							,
						NetworkId							,
						NetworkName							,
						NetworkShortName					,
						ProjectStatusId						,
						ProjectStatusName					,
						DocumentStatusTypeId				,
						DocumentStatusTypeName				,
						AgreementClassId					,
						AgreementClassName					,
						FormatId							,
						FormatName							,
						GenreId								,
						GenreName							,
						LengthId							,
						LengthName							,
						ProgramTypeId						,
						ProgramTypeName						

					)


		SELECT		
						ProjectCategoryId					= x0.ProjectCategoryId,
						ProjectCategoryName					= x0.Name,
						ProjectCategoryFilterGroup			= x0.ProjectCategoryFilterGroup,
						TalentDeal							= x.TalentDeal,
						NetworkId							= x1.NetworkId,
						NetworkName							= x1.NetworkName,
						NetworkShortName					= x1.ShortName,
						ProjectStatusId						= x2.ProjectStatusId,
						ProjectStatusName					= x2.ProjectStatusName,
						DocumentStatusTypeId				= x3.DocumentStatusTypeId,
						DocumentStatusTypeName				= x3.DocumentStatusTypeName,
						AgreementClassId					= x4.AgreementClassId,
						AgreementClassName					= x4.AgreementClassName,
						FormatId							= x5.FormatId,
						FormatName							= x5.FormatName,
						GenreId								= x6.GenreId,
						GenreName							= x6.GenreName,
						LengthId							= x7.LengthId,
						LengthName							= x7.LengthName,
						ProgramTypeId						= x8.ProgramTypeId,
						ProgramTypeName						= x8.ProgramTypeName

		FROM		
				(	

					-- Group 1
					Select		SortOrder =    1, Grp =  1, TalentDeal = 1, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =    2, Grp =  1, TalentDeal = 1, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =    3, Grp =  1, TalentDeal = 1, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =    4, Grp =  1, TalentDeal = 1, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Talent Deal'			UNION

					Select		SortOrder =    5, Grp =  1, TalentDeal = 1, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =    6, Grp =  1, TalentDeal = 1, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =    7, Grp =  1, TalentDeal = 1, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =    8, Grp =  1, TalentDeal = 1, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Talent Deal'			UNION

					Select		SortOrder =    9, Grp =  1, TalentDeal = 1, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =   10, Grp =  1, TalentDeal = 1, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =   11, Grp =  1, TalentDeal = 1, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Talent Deal'			UNION
					Select		SortOrder =   12, Grp =  1, TalentDeal = 1, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',		FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Talent Deal'			UNION

					-- Group 2
					Select		SortOrder =    1, Grp =  2, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =    2, Grp =  2, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =    3, Grp =  2, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =    4, Grp =  2, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Co-Productions'		UNION

					Select		SortOrder =    5, Grp =  2, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =    6, Grp =  2, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =    7, Grp =  2, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =    8, Grp =  2, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Co-Productions'		UNION

					Select		SortOrder =    9, Grp =  2, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =   10, Grp =  2, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =   11, Grp =  2, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Co-Productions'		UNION
					Select		SortOrder =   12, Grp =  2, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Co-Production',	FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Co-Productions'		UNION


					-- Group 3
					Select		SortOrder =    1, Grp =  3, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'Pending' ,					ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION
					Select		SortOrder =    2, Grp =  3, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'Pending' ,					ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION
					Select		SortOrder =    3, Grp =  3, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'Pending' ,					ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION

					Select		SortOrder =    4, Grp =  3, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'Reliance Letter' ,			ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION
					Select		SortOrder =    5, Grp =  3, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'Reliance Letter' ,			ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION
					Select		SortOrder =    6, Grp =  3, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'Reliance Letter' ,			ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION

					Select		SortOrder =    7, Grp =  3, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'TBD' ,						ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION
					Select		SortOrder =    8, Grp =  3, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'TBD' ,						ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION
					Select		SortOrder =    9, Grp =  3, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'License',			FormatName = '', GenreName = ''		, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = 'TBD' ,						ProjectStatusName = ''	, ProjectCategoryName = 'License'				UNION


					-- Group 4
					Select		SortOrder =    1, Grp =  4, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Alt/Reality Dev'		UNION
					Select		SortOrder =    2, Grp =  4, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Alt/Reality Dev'		UNION
					Select		SortOrder =    3, Grp =  4, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Alt/Reality Prod'		UNION
					Select		SortOrder =    4, Grp =  4, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Alt/Reality Prod'		UNION
																																									 
					Select		SortOrder =    6, Grp =  4, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Alt/Reality Dev'		UNION
					Select		SortOrder =    7, Grp =  4, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Alt/Reality Dev'		UNION
					Select		SortOrder =    8, Grp =  4, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Alt/Reality Prod'		UNION
					Select		SortOrder =    9, Grp =  4, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Alt/Reality Prod'		UNION
																																								 
					Select		SortOrder =   11, Grp =  4, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Alt/Reality Dev'		UNION
					Select		SortOrder =   12, Grp =  4, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Alt/Reality Dev'		UNION
					Select		SortOrder =   13, Grp =  4, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Alt/Reality Prod'		UNION
					Select		SortOrder =   14, Grp =  4, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = '',		GenreName = 'Reality'	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Alt/Reality Prod'		UNION



					-- Group 5
					Select		SortOrder =    1, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =    2, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =    3, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Disney JR Prod'		UNION
					Select		SortOrder =    4, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Disney JR Prod'		UNION
											   
					Select		SortOrder =    6, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =    7, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =    8, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Disney JR Prod'		UNION
					Select		SortOrder =    9, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Disney JR Prod'		UNION

					Select		SortOrder =   11, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =   12, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =   13, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Disney JR Prod'		UNION
					Select		SortOrder =   14, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Disney JR Prod'		UNION

					Select		SortOrder =   16, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =   17, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =   18, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Disney JR Prod'		UNION
					Select		SortOrder =   19, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Disney JR Prod'		UNION

					Select		SortOrder =   21, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =   22, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Disney JR Dev'			UNION
					Select		SortOrder =   23, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Disney JR Prod'		UNION
					Select		SortOrder =   24, Grp =  5, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = '' , ProgramTypeName = ''	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Disney JR Prod'		UNION



					-- Group 6
					Select		SortOrder =    1, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	   3, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    4, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    6, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    7, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    8, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =    9, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    7, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    8, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    3, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    4, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =    4, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =    9, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   11, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   12, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =    3, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =    4, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =    4, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =   13, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   15, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   16, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =    3, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =    4, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =    4, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION


					Select		SortOrder =   21, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   23, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   24, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   22, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   23, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   24, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =   25, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   27, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   28, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   26, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   27, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   28, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =   29, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   21, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   22, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   20, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   21, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   22, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =   23, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   25, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   26, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   24, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   25, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   26, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION


					Select		SortOrder =   31, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   33, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   34, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   32, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   33, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   34, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =   35, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   37, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   38, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   36, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   37, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   38, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =   39, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   41, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   42, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   40, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   41, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   42, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =   53, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   55, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   56, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   54, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   55, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   56, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION


					Select		SortOrder =   61, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   63, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   64, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   62, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   63, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   64, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =   65, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   67, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   68, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   66, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   67, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   68, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =   69, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   71, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   72, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   70, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   71, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   72, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =   73, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   75, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   76, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   74, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   75, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   76, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION



					Select		SortOrder =   81, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   83, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   84, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   82, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   83, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   84, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =   85, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   87, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   88, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   86, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   87, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =   88, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =   89, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   91, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   92, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   90, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   91, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   92, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =   93, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   95, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   96, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   94, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   95, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =   96, Grp =  6, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION


					Select		SortOrder =	 141, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 143, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 144, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 142, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 143, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 144, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =	 145, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 147, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 148, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 146, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 147, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =	 148, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =	 149, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 151, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 152, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 150, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 151, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 152, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =	 153, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 155, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 156, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 154, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 155, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =	 156, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION



					Select		SortOrder =  161, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  163, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  164, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  162, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  163, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  164, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  165, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  167, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  168, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  166, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  167, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  168, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  169, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  171, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  172, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  170, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  171, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  172, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  173, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  175, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  176, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  175, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  176, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION



					Select		SortOrder =  181, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  183, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  184, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  182, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  183, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  184, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  185, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  187, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  188, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  186, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  187, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  188, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  189, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  191, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  192, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  190, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  191, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  192, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  193, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  195, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  196, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  194, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  195, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  196, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION



					Select		SortOrder =  201, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  203, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  204, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  202, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  203, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  204, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  205, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  207, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  208, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  206, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  207, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  208, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  209, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  211, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  212, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  210, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  211, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  212, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  213, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  215, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  216, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  214, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  215, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  216, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION


					Select		SortOrder =  221, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  223, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  224, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  222, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  223, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  224, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  225, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  227, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  228, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  226, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  227, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  228, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  229, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  231, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  232, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  230, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  231, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  232, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  233, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  235, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  236, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  234, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  235, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  236, Grp =  6, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION



					Select		SortOrder =  281, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  283, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  284, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  282, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  283, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  284, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  285, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  287, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  288, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  286, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  287, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  288, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  289, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  291, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  292, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  290, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  291, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  292, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  293, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  295, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  296, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  294, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  295, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  296, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION


					Select		SortOrder =  301, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  303, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  304, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  302, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  303, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  304, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  305, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  307, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  308, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  306, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  307, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  308, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  309, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  311, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  312, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  310, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  311, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  312, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  313, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  315, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  316, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  314, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  315, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  316, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION



					Select		SortOrder =  321, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  323, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  324, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  322, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  323, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  324, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  325, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  327, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  328, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  326, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  327, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  328, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  329, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  341, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  342, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  330, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  341, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  342, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  343, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  345, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  346, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  344, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  345, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  346, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION



					Select		SortOrder =  351, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  353, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  354, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  352, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  353, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  354, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  355, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  357, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  358, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  356, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  357, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  358, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  359, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  371, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  372, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  360, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  371, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  372, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  373, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  375, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  376, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  374, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  375, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  376, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION


					Select		SortOrder =  381, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  383, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  384, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  382, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  383, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  384, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  385, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  387, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  388, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  386, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  387, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION
					Select		SortOrder =  388, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Series Development'	UNION

					Select		SortOrder =  389, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  391, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  392, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  390, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  391, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  392, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Series Production'		UNION

					Select		SortOrder =  393, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot'				, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  395, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series'		, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  396, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Pilot/Series 2'	, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  394, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Series'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  395, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Shorts'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION
					Select		SortOrder =  396, Grp =  6, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''	, LengthName = ''			, ProgramTypeName = 'Special'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Series Production'		UNION




											 
					-- Group 7
					Select		SortOrder =    1, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =    2, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =    3, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =    4, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =    6, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =    7, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =    8, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =    9, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   11, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   12, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   13, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   14, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   16, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   17, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   18, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   19, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   21, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   22, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   23, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   24, Grp =  7, TalentDeal = 0, NetworkShortName = 'DC'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION


											  
					Select		SortOrder =   36, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   37, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   38, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   39, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   41, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   42, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   43, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   44, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   46, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   47, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   48, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   49, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   51, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   52, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   53, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   54, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   56, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   57, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   58, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   59, Grp =  7, TalentDeal = 0, NetworkShortName = 'XD'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION


					Select		SortOrder =   71, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   72, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   73, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   74, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Animation',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   76, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   77, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   78, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   79, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action/Animated',		GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   81, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   82, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   83, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   84, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action',					GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =   86, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   87, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =   88, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =   89, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Single Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		UNION

					Select		SortOrder =	  91, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Development'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =	  92, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Pass Notice Pending'		, ProjectCategoryName = 'Movie Development'		UNION
					Select		SortOrder =	  93, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Post Production'	, ProjectCategoryName = 'Movie Production'		UNION
					Select		SortOrder =	  94, Grp =  7, TalentDeal = 0, NetworkShortName = 'JR'	,  AgreementClassName = 'Production',   FormatName = 'Live Action Multi Camera',	GenreName = ''			, LengthName = ''		, ProgramTypeName = 'Movie'			, DocumentStatusTypeName = '' , ProjectStatusName = 'Current-Production'		, ProjectCategoryName = 'Movie Production'		


					-- Group 8 (A filter group)


				) x

		JOIN		dbo.ProjectCategory x0					ON	x.ProjectCategoryName			= x0.Name
		JOIN		dbo.Network x1							ON	x.NetworkShortName				= x1.ShortName
		LEFT JOIN	dbo.ProjectStatus x2					ON	x.ProjectStatusName				= x2.ProjectStatusName
		LEFT JOIN	dbo.DocumentStatusType x3				ON  x.DocumentStatusTypeName		= x3.DocumentStatusTypeName
		LEFT JOIN	dbo.AgreementClass x4					ON	x.AgreementClassName			= x4.AgreementClassName
		LEFT JOIN	dbo.Format x5							ON	x.FormatName					= x5.FormatName
		LEFT JOIN	dbo.Genre x6							ON	x.GenreName						= x6.GenreName
		LEFT JOIN	dbo.Length x7							ON	x.LengthName					= x7.LengthName
		LEFT JOIN	dbo.ProgramType x8						ON	x.ProgramTypeName				= x8.ProgramTypeName

		WHERE		1=1
		ORDER BY	x.Grp, x.SortOrder, x.NetworkShortName



		--select * from @Xtmp order by Id




		INSERT			dbo.XProjectStatusProjectCategory 
					(

						ProjectCategoryId					,
						ProjectCategoryFilterGroup			,
						TalentDeal							,
						NetworkId							,
						ProjectStatusId						,
						DocumentStatusTypeId				,
						AgreementClassId					,
						FormatId							,
						GenreId								,
						LengthId							,
						ProgramTypeId						

					)
		SELECT		
						ProjectCategoryId										= x.ProjectCategoryId			,
						ProjectCategoryFilterGroup								= x.ProjectCategoryFilterGroup	,
						TalentDeal												= x.TalentDeal					,
						NetworkId												= x.NetworkId					,
						ProjectStatusId											= x.ProjectStatusId				,
						DocumentStatusTypeId									= x.DocumentStatusTypeId		,
						AgreementClassId										= x.AgreementClassId			,
						FormatId												= x.FormatId					,
						GenreId													= x.GenreId						,
						LengthId												= x.LengthId					,
						ProgramTypeId											= x.ProgramTypeId		

		FROM		(

						--				ProjectCategoryGroup 1
						SELECT			ProjectCategoryId						= x1.ProjectCategoryId,
										ProjectCategoryFilterGroup				= x1.ProjectCategoryFilterGroup,
										TalentDeal								= x1.TalentDeal,
										NetworkId								= x1.NetworkId,
										ProjectStatusId							= x1.ProjectStatusId,
										DocumentStatusTypeId					= NULL,
										AgreementClassId						= x1.AgreementClassId,
										FormatId								= NULL,
										GenreId									= NULL,
										LengthId								= NULL,
										ProgramTypeId							= NULL
						FROM			@Xtmp x1
						LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x1.ProjectCategoryId			= y.ProjectCategoryId
																				AND	x1.NetworkId					= y.NetworkId
																				AND x1.ProjectStatusId				= y.ProjectStatusId
						WHERE			1=1
						AND				x1.ProjectCategoryName					= 'Talent Deal'
						AND				y.XProjectStatusProjectCategoryId		IS NULL

						UNION ALL

						--				ProjectCategoryGroup 2
						SELECT			ProjectCategoryId						= x2.ProjectCategoryId,
										ProjectCategoryFilterGroup				= x2.ProjectCategoryFilterGroup,
										TalentDeal								= x2.TalentDeal,
										NetworkId								= x2.NetworkId,
										ProjectStatusId							= x2.ProjectStatusId,
										DocumentStatusTypeId					= NULL,
										AgreementClassId						= x2.AgreementClassId,
										FormatId								= NULL,
										GenreId									= NULL,
										LengthId								= NULL,
										ProgramTypeId							= NULL
						FROM			@Xtmp x2
						LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x2.ProjectCategoryId			= y.ProjectCategoryId
																				AND	x2.NetworkId					= y.NetworkId
																				AND x2.ProjectStatusId				= y.ProjectStatusId
																				AND x2.AgreementClassId				= y.AgreementClassId
						WHERE			1=1
						AND				x2.ProjectCategoryName					= 'Co-Productions'
						AND				y.XProjectStatusProjectCategoryId		IS NULL

						UNION ALL

						--				ProjectCategoryGroup 3
						SELECT			ProjectCategoryId						= x3.ProjectCategoryId,
										ProjectCategoryFilterGroup				= x3.ProjectCategoryFilterGroup,
										TalentDeal								= x3.TalentDeal,
										NetworkId								= x3.NetworkId,
										ProjectStatusId							= NULL,
										DocumentStatusTypeId					= x3.DocumentStatusTypeId,
										AgreementClassId						= x3.AgreementClassId,
										FormatId								= NULL,
										GenreId									= NULL,
										LengthId								= NULL,
										ProgramTypeId							= NULL
						FROM			@Xtmp x3
						LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x3.ProjectCategoryId			= y.ProjectCategoryId
																				AND	x3.NetworkId					= y.NetworkId
																				AND	x3.DocumentStatusTypeId			= y.DocumentStatusTypeId
																				AND x3.AgreementClassId				= y.AgreementClassId
						WHERE			1=1
						AND				x3.ProjectCategoryName					= 'License'
						AND				y.XProjectStatusProjectCategoryId		IS NULL

						UNION ALL

						--				ProjectCategoryGroup 4
						SELECT			ProjectCategoryId						= x4.ProjectCategoryId,
										ProjectCategoryFilterGroup				= x4.ProjectCategoryFilterGroup,
										TalentDeal								= x4.TalentDeal,
										NetworkId								= x4.NetworkId,
										ProjectStatusId							= x4.ProjectStatusId,
										DocumentStatusTypeId					= NULL,
										AgreementClassId						= x4.AgreementClassId,
										FormatId								= x4.FormatId,
										GenreId									= x4.GenreId,
										LengthId								= NULL,
										ProgramTypeId							= NULL
						FROM			@Xtmp x4
						LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x4.ProjectCategoryId			= y.ProjectCategoryId
																				AND	x4.NetworkId					= y.NetworkId
																				AND x4.AgreementClassId				= y.AgreementClassId
																				--AND x4.FormatId						= y.FormatId
																				AND x4.GenreId						= y.GenreId
						WHERE			1=1
						AND				x4.ProjectCategoryName					IN ('Alt/Reality Dev','Alt/Reality Prod')
						AND				y.XProjectStatusProjectCategoryId		IS NULL

						UNION ALL

						--				ProjectCategoryGroup 5 Format ONLY
						SELECT			ProjectCategoryId						= x5.ProjectCategoryId,
										ProjectCategoryFilterGroup				= x5.ProjectCategoryFilterGroup,
										TalentDeal								= x5.TalentDeal,
										NetworkId								= x5.NetworkId,
										ProjectStatusId							= x5.ProjectStatusId,
										DocumentStatusTypeId					= NULL,
										AgreementClassId						= x5.AgreementClassId,
										FormatId								= x5.FormatId,
										GenreId									= NULL,
										LengthId								= NULL,
										ProgramTypeId							= NULL
						FROM			@Xtmp x5
						LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x5.ProjectCategoryId			= y.ProjectCategoryId
																				AND	x5.NetworkId					= y.NetworkId
																				AND x5.AgreementClassId				= y.AgreementClassId
																				AND x5.FormatId						= y.FormatId
						WHERE			1=1
						AND				x5.ProjectCategoryName					IN ('Disney JR Dev','Disney JR Prod')
						AND				x5.GenreId								IS NULL
						AND				y.XProjectStatusProjectCategoryId		IS NULL

						UNION ALL

						----				ProjectCategoryGroup 5 Format AND Genre
						--SELECT			ProjectCategoryId						= x5.ProjectCategoryId,
						--				ProjectCategoryFilterGroup				= x5.ProjectCategoryFilterGroup,
						--				TalentDeal								= x5.TalentDeal,
						--				NetworkId								= x5.NetworkId,
						--				ProjectStatusId							= x5.ProjectStatusId,
						--				DocumentStatusTypeId					= NULL,
						--				AgreementClassId						= x5.AgreementClassId,
						--				FormatId								= x5.FormatId,
						--				GenreId									= x5.GenreId,
						--				LengthId								= NULL,
						--				ProgramTypeId							= NULL
						--FROM			@Xtmp x5
						--LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x5.ProjectCategoryId			= y.ProjectCategoryId
						--														AND	x5.NetworkId					= y.NetworkId
						--														AND x5.AgreementClassId				= y.AgreementClassId
						--														AND x5.FormatId						= y.FormatId
						--														AND x5.GenreId						= y.GenreId
						--WHERE			1=1
						--AND				x5.ProjectCategoryName					IN ('Disney JR Dev','Disney JR Prod')
						--AND				x5.GenreId								IS NOT NULL
						--AND				y.XProjectStatusProjectCategoryId		IS NULL

						--UNION ALL

						--				ProjectCategoryGroup 6 Format, ProgramType ONLY
						SELECT			ProjectCategoryId						= x6.ProjectCategoryId,
										ProjectCategoryFilterGroup				= x6.ProjectCategoryFilterGroup,
										TalentDeal								= x6.TalentDeal,
										NetworkId								= x6.NetworkId,
										ProjectStatusId							= x6.ProjectStatusId,
										DocumentStatusTypeId					= NULL,
										AgreementClassId						= x6.AgreementClassId,
										FormatId								= x6.FormatId,
										GenreId									= NULL,
										LengthId								= NULL,
										ProgramTypeId							= x6.ProgramTypeId
						FROM			@Xtmp x6
						LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x6.ProjectCategoryId			= y.ProjectCategoryId
																				AND	x6.NetworkId					= y.NetworkId
																				AND x6.AgreementClassId				= y.AgreementClassId
																				AND x6.FormatId						= y.FormatId
																				AND x6.ProgramTypeId				= y.ProgramTypeId
						WHERE			1=1
						AND				x6.ProjectCategoryName					IN ('Series Development','Series Production')
						AND				x6.GenreId								IS NULL
						AND				x6.LengthId								IS NULL
						AND				y.XProjectStatusProjectCategoryId		IS NULL

						UNION ALL

						----				ProjectCategoryGroup 6 Format, ProgramType, Genre ONLY
						--SELECT			ProjectCategoryId						= x6.ProjectCategoryId,
						--				ProjectCategoryFilterGroup				= x6.ProjectCategoryFilterGroup,
						--				TalentDeal								= x6.TalentDeal,
						--				NetworkId								= x6.NetworkId,
						--				ProjectStatusId							= x6.ProjectStatusId,
						--				DocumentStatusTypeId					= NULL,
						--				AgreementClassId						= x6.AgreementClassId,
						--				FormatId								= x6.FormatId,
						--				GenreId									= x6.GenreId,
						--				LengthId								= NULL,
						--				ProgramTypeId							= x6.ProgramTypeId
						--FROM			@Xtmp x6
						--LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x6.ProjectCategoryId			= y.ProjectCategoryId
						--														AND	x6.NetworkId					= y.NetworkId
						--														AND x6.AgreementClassId				= y.AgreementClassId
						--														AND x6.FormatId						= y.FormatId
						--														AND x6.ProgramTypeId				= y.ProgramTypeId
						--														AND x6.GenreId						= y.GenreId
						--WHERE			1=1
						--AND				x6.ProjectCategoryName					IN ('Series Development','Series Production')
						--AND				x6.GenreId								IS NOT NULL
						--AND				x6.LengthId								IS NULL
						--AND				y.XProjectStatusProjectCategoryId		IS NULL

						--UNION ALL

						----				ProjectCategoryGroup 6 Format, ProgramType, Length ONLY
						--SELECT			ProjectCategoryId						= x6.ProjectCategoryId,
						--				ProjectCategoryFilterGroup				= x6.ProjectCategoryFilterGroup,
						--				TalentDeal								= x6.TalentDeal,
						--				NetworkId								= x6.NetworkId,
						--				ProjectStatusId							= x6.ProjectStatusId,
						--				DocumentStatusTypeId					= NULL,
						--				AgreementClassId						= x6.AgreementClassId,
						--				FormatId								= x6.FormatId,
						--				GenreId									= NULL,
						--				LengthId								= x6.LengthId,
						--				ProgramTypeId							= x6.ProgramTypeId
						--FROM			@Xtmp x6
						--LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x6.ProjectCategoryId			= y.ProjectCategoryId
						--														AND	x6.NetworkId					= y.NetworkId
						--														AND x6.AgreementClassId				= y.AgreementClassId
						--														AND x6.FormatId						= y.FormatId
						--														AND x6.ProgramTypeId				= y.ProgramTypeId
						--														AND x6.LengthId						= y.LengthId
						--WHERE			1=1
						--AND				x6.ProjectCategoryName					IN ('Series Development','Series Production')
						--AND				x6.GenreId								IS NULL
						--AND				x6.LengthId								IS NOT NULL
						--AND				y.XProjectStatusProjectCategoryId		IS NULL

						--UNION ALL

						----				ProjectCategoryGroup 6 Format, ProgramType, Genre, Length
						--SELECT			ProjectCategoryId						= x6.ProjectCategoryId,
						--				ProjectCategoryFilterGroup				= x6.ProjectCategoryFilterGroup,
						--				TalentDeal								= x6.TalentDeal,
						--				NetworkId								= x6.NetworkId,
						--				ProjectStatusId							= x6.ProjectStatusId,
						--				DocumentStatusTypeId					= NULL,
						--				AgreementClassId						= x6.AgreementClassId,
						--				FormatId								= x6.FormatId,
						--				GenreId									= x6.GenreId,
						--				LengthId								= x6.LengthId,
						--				ProgramTypeId							= x6.ProgramTypeId
						--FROM			@Xtmp x6
						--LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x6.ProjectCategoryId			= y.ProjectCategoryId
						--														AND	x6.NetworkId					= y.NetworkId
						--														AND x6.AgreementClassId				= y.AgreementClassId
						--														AND x6.FormatId						= y.FormatId
						--														AND x6.ProgramTypeId				= y.ProgramTypeId
						--														AND x6.GenreId						= y.GenreId
						--														AND x6.LengthId						= y.LengthId
						--WHERE			1=1
						--AND				x6.ProjectCategoryName					IN ('Series Development','Series Production')
						--AND				x6.GenreId								IS NOT NULL
						--AND				x6.LengthId								IS NOT NULL
						--AND				y.XProjectStatusProjectCategoryId		IS NULL



						--UNION ALL

						--				ProjectCategoryGroup 7 Format, ProgramType ONLY
						SELECT			ProjectCategoryId						= x7.ProjectCategoryId,
										ProjectCategoryFilterGroup				= x7.ProjectCategoryFilterGroup,
										TalentDeal								= x7.TalentDeal,
										NetworkId								= x7.NetworkId,
										ProjectStatusId							= x7.ProjectStatusId,
										DocumentStatusTypeId					= NULL,
										AgreementClassId						= x7.AgreementClassId,
										FormatId								= x7.FormatId,
										GenreId									= NULL,
										LengthId								= NULL, --x7.LengthId,
										ProgramTypeId							= x7.ProgramTypeId
						FROM			@Xtmp x7
						LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x7.ProjectCategoryId			= y.ProjectCategoryId
																				AND	x7.NetworkId					= y.NetworkId
																				AND x7.AgreementClassId				= y.AgreementClassId
																				AND x7.FormatId						= y.FormatId
																				AND x7.ProgramTypeId				= y.ProgramTypeId
																				--AND x7.LengthId						= y.LengthId
						WHERE			1=1
						AND				x7.ProjectCategoryName					IN ('Movie Development','Movie Production')
						AND				x7.GenreId								IS NULL
						--AND				x7.LengthId								IS NOT NULL
						AND				y.XProjectStatusProjectCategoryId		IS NULL

						--UNION ALL

						----				ProjectCategoryGroup 7 Format, ProgramType, Genre, Length
						--SELECT			ProjectCategoryId						= x7.ProjectCategoryId,
						--				ProjectCategoryFilterGroup				= x7.ProjectCategoryFilterGroup,
						--				TalentDeal								= x7.TalentDeal,
						--				NetworkId								= x7.NetworkId,
						--				ProjectStatusId							= x7.ProjectStatusId,
						--				DocumentStatusTypeId					= NULL,
						--				AgreementClassId						= x7.AgreementClassId,
						--				FormatId								= x7.FormatId,
						--				GenreId									= x7.GenreId,
						--				LengthId								= x7.LengthId,
						--				ProgramTypeId							= x7.ProgramTypeId
						--FROM			@Xtmp x7
						--LEFT JOIN		dbo.XProjectStatusProjectCategory y		ON  x7.ProjectCategoryId			= y.ProjectCategoryId
						--														AND	x7.NetworkId					= y.NetworkId
						--														AND x7.AgreementClassId				= y.AgreementClassId
						--														AND x7.FormatId						= y.FormatId
						--														AND x7.ProgramTypeId				= y.ProgramTypeId
						--														AND x7.GenreId						= y.GenreId
						--														AND x7.LengthId						= y.LengthId
						--WHERE			1=1
						--AND				x7.ProjectCategoryName					IN ('Movie Development','Movie Production')
						--AND				x7.GenreId								IS NOT NULL
						--AND				x7.LengthId								IS NOT NULL
						--AND				y.XProjectStatusProjectCategoryId		IS NULL

					) x
		--LEFT JOIN		dbo.XProjectStatusProjectCategory y WITH (NOLOCK)			ON  x.ProjectCategoryId = y.ProjectCategoryId
		--																			AND x.NetworkId = y.NetworkId 
		--																			AND x.TalentDeal = y.TalentDeal
		--																			AND x.AgreementClassId = y.AgreementClassId
		--																			AND	(x.ProjectStatusId = y.ProjectStatusId
		--																			OR	x.DocumentStatusTypeId = y.DocumentStatusTypeId
		--																				)
		--																			AND x.FormatId = ISNULL(y.FormatId,x.FormatId)
		--																			AND	x.GenreId = ISNULL(y.GenreId,x.GenreId)
		--																			AND x.LengthId = ISNULL(y.LengthId,x.LengthId)
		--																			AND x.ProgramTypeId = ISNULL(y.ProgramTypeId,x.ProgramTypeId)
		--WHERE			y.XProjectStatusProjectCategoryId IS NULL




END
GO


--Select ProjectCategoryFilterGroup,* from dbo.XProjectStatusProjectCategory 
--Select * from dbo.ProjectCategory
--Select * from dbo.ProjectCategory Where Name = 'Disney JR Prod'

/*


--Select the distinct values for the definition table:
					

					SELECT			pc.Name,
									ac.AgreementClassName,
									ps.ProjectStatusName,
									l.LengthName,
									pt.ProgramTypeName ,
									f.FormatName,
									g.GenreName

					FROM			dbo.XProjectStatusProjectCategory x WITH (NOLOCK)			--ON  p.NetworkId = x.NetworkId 
					JOIN			dbo.Project p WITH (NOLOCK)				ON x.NetworkId = p.NetworkId
					JOIN			dbo.AgreementClass ac WITH (NOLOCK)		ON x.AgreementClassId = ac.AgreementClassId
					JOIN			dbo.Network n WITH (NOLOCK)				ON x.NetworkId = n.NetworkId
					JOIN			dbo.ProjectStatus ps WITH (NOLOCK)		ON x.ProjectStatusId = ps.ProjectStatusId
					JOIN			dbo.ProjectExecutive pe WITH (NOLOCK)	ON p.ProjectId = pe.ProjectId
					JOIN			dbo.Executive e WITH (NOLOCK)			ON pe.ExecutiveId = e.ExecutiveId
					LEFT JOIN		dbo.DepartmentExecutive de WITH (NOLOCK)	ON pe.ExecutiveId = de.ExecutiveId
					LEFT JOIN		dbo.Department d WITH (NOLOCK)			ON de.DepartmentId = d.DepartmentId
					LEFT JOIN		dbo.Length l							ON x.LengthId = l.LengthId
					LEFT JOIN		dbo.ProgramType pt						ON x.ProgramTypeId = pt.ProgramTypeId
					LEFT JOIN		dbo.Format f WITH (NOLOCK)				ON x.FormatId = f.FormatId
					LEFT JOIN		dbo.Genre g WITH (NOLOCK)				ON x.GenreId = g.GenreId
					LEFT JOIN		dbo.ProjectCategory pc WITH (NOLOCK)	ON  x.ProjectCategoryId = pc.ProjectCategoryId 
					WHERE			1=1
					AND				pc.Name NOT LIKE 'Talent Deal'
					AND				ps.ProjectStatusName					IN ('Current-Development','Current-Post Production','Current-Production','Pass Notice Pending')
					AND				d.DepartmentName							= 'Business Affairs'
					AND				n.ShortName									IN ('DC','JR','XD')
					GROUP BY		
									pc.Name,
									ac.AgreementClassName,
									ps.ProjectStatusName,
									l.LengthName,
									pt.ProgramTypeName ,
									f.FormatName,
									g.GenreName




*/

