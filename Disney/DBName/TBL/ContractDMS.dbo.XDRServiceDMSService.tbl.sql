

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
	--   Module:		dbo.XDRServiceDMSService
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
	--					FROM		dbo.XDRServiceDMSService WITH (NOLOCK)
	--					ORDER BY	XDRServiceDMSServiceId
	--

*/ 
-- =============================================



--------------------------------------------------------------------------------------------
----CREATION of XDRServiceDMSService TABLE
--------------------------------------------------------------------------------------------


IF ( OBJECT_ID('XDRServiceDMSService', 'u') IS NULL )					
BEGIN

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		--DROP TABLE dbo.XDRServiceDMSService
		CREATE TABLE dbo.XDRServiceDMSService
		(
			[XDRServiceDMSServiceId]				[UNIQUEIDENTIFIER] NOT NULL CONSTRAINT PK_XDRServiceDMSService PRIMARY KEY,
			[Created]								[DATETIME] NOT NULL CONSTRAINT [DF_XDRServiceDMSService_Created] DEFAULT (GETDATE()),
			[Updated]								[DATETIME] NULL,
			[IsActive]								[BIT] NOT NULL CONSTRAINT [DF_XDRServiceDMSService_IsActive] DEFAULT (1),
			[DRServiceTypeId]						[UNIQUEIDENTIFIER] NOT NULL,
			--[DMSServiceTypeId]						[UNIQUEIDENTIFIER] NOT NULL,
			[SelecticaTemplateId]					[UNIQUEIDENTIFIER] NOT NULL,

			-- For Agreement Table
			[AgreementClassId]						[UNIQUEIDENTIFIER] NOT NULL,
			[ReportTypeId]							[UNIQUEIDENTIFIER] NULL,

			-- For ProdAgreement Table
			[ProdAgreementTypeId]					[UNIQUEIDENTIFIER] NOT NULL,
			[ProdAgreementSubTypeId]				[UNIQUEIDENTIFIER] NULL,

			-- For Document Table
			[DocumentTypeId]						[UNIQUEIDENTIFIER] NOT NULL,
			[DocumentStatusTypeId]					[UNIQUEIDENTIFIER] NULL

		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE  dbo.XDRServiceDMSService ADD CONSTRAINT DF_XDRServiceDMSService_XDRServiceDMSServiceId DEFAULT NEWSEQUENTIALID()  FOR XDRServiceDMSServiceId

		ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_DRServiceTypeId-->DRServiceType_DRServiceTypeId] FOREIGN KEY ( DRServiceTypeId )
		REFERENCES dbo.DRServiceType ( DRServiceTypeId )

		--ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_DMSServiceTypeId-->ServiceType_ServiceTypeId] FOREIGN KEY ( DMSServiceTypeId )
		--REFERENCES dbo.ServiceType ( ServiceTypeId )

		ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_SelecticaTemplateId-->SelecticaTemplate_SelecticaTemplateId] FOREIGN KEY ( SelecticaTemplateId )
		REFERENCES dbo.SelecticaTemplate ( SelecticaTemplateId )

		ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_AgreementClassId-->AgreementClass_AgreementClassId] FOREIGN KEY ( AgreementClassId )
		REFERENCES dbo.AgreementClass ( AgreementClassId )

		ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_ReportTypeId-->ReportType_ReportTypeId] FOREIGN KEY ( ReportTypeId )
		REFERENCES dbo.ReportType ( ReportTypeId )

		ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_ProdAgreementTypeId-->ProdAgreementType_ProdAgreementTypeId] FOREIGN KEY ( ProdAgreementTypeId )
		REFERENCES dbo.ProdAgreementType ( ProdAgreementTypeId )

		ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_ProdAgreementSubTypeId-->ProdAgreementSubType_ProdAgreementSubTypeId] FOREIGN KEY ( ProdAgreementSubTypeId )
		REFERENCES dbo.ProdAgreementSubType ( ProdAgreementSubTypeId )


		ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_DocumentTypeId-->DocumentType_DocumentTypeId] FOREIGN KEY ( DocumentTypeId )
		REFERENCES dbo.DocumentType ( DocumentTypeId )

		ALTER TABLE dbo.XDRServiceDMSService  WITH CHECK ADD  CONSTRAINT [FK_XDRServiceDMSService_DocumentStatusTypeId-->DocumentStatusType_DocumentStatusTypeId] FOREIGN KEY ( DocumentStatusTypeId )
		REFERENCES dbo.DocumentStatusType ( DocumentStatusTypeId )

		--DROP INDEX XDRServiceDMSService.UX_XDRServiceDMSService_DRServiceTypeId_SelecticaTemplateId_iIsActive 
		CREATE UNIQUE INDEX UX_XDRServiceDMSService_DRServiceTypeId_SelecticaTemplateId_iIsActive ON dbo.XDRServiceDMSService ( DRServiceTypeId,SelecticaTemplateId ) INCLUDE ( IsActive )



END
GO


------------------------------------------------------------------------------------------
--POPULATION of XDRServiceDMSService TABLE
------------------------------------------------------------------------------------------


IF ( OBJECT_ID('XDRServiceDMSService', 'u') IS NOT NULL )					
BEGIN


		SET				NOCOUNT ON
 		DECLARE			@DRServiceGroupTypeId									UNIQUEIDENTIFIER
		DECLARE			@DRServiceGroupTypeName									VARCHAR(200) = 'Writer'
 		DECLARE			@AgreementClassId										UNIQUEIDENTIFIER
		DECLARE			@AgreementClassName										VARCHAR(200) = 'Production'
		DECLARE			@ReportTypeId											UNIQUEIDENTIFIER
		DECLARE			@ReportTypeName											VARCHAR(200) = NULL
		DECLARE			@DocumentStatusTypeId									UNIQUEIDENTIFIER
		DECLARE			@DocumentStatusTypeName									VARCHAR(200) = 'Pending'
		DECLARE			@DocumentTypeId											UNIQUEIDENTIFIER
		DECLARE			@DocumentTypeName										VARCHAR(200) = 'Confirm Letter'

 		DECLARE			@TemplateId												UNIQUEIDENTIFIER
		DECLARE			@TemplateName											VARCHAR(200) = 'ABCF Series Writer-Producer-Series Creator CE'

		SELECT			@TemplateId												= SelecticaTemplateId FROM dbo.SelecticaTemplate WHERE Name = @TemplateName
 		SELECT			@AgreementClassId 										= AgreementClassId FROM dbo.AgreementClass WHERE AgreementClassName = @AgreementClassName
		SELECT			@DRServiceGroupTypeId 									= DRServiceGroupTypeId FROM dbo.DRServiceGroupType WHERE Name = @DRServiceGroupTypeName
		SELECT			@DocumentStatusTypeId 									= @DocumentStatusTypeId FROM dbo.DocumentStatusType	WHERE DocumentStatusTypeName = @DocumentStatusTypeName
		SELECT			@DocumentTypeId 										= DocumentTypeId FROM dbo.DocumentType WHERE DocumentTypeName = @DocumentTypeName


		--TRUNCATE TABLE dbo.XDRServiceDMSService
		Insert		dbo.XDRServiceDMSService 
						(
							SelecticaTemplateId,
							DRServiceTypeId,
							AgreementClassId,
							ProdAgreementTypeId,
							ProdAgreementSubTypeId,
							DocumentTypeId,
							DocumentStatusTypeId
							--DMSServiceTypeId
						)

		Select		
					SelecticaTemplateId						= @TemplateId,
					--SelecticaTemplateName					= @TemplateName,
					--DRServiceGroupTypeName					= @DRServiceGroupTypeName,
					DRServiceTypeId							= x1.DRServiceTypeId,
					--DRServiceTypeName						= x1.Name,
					AgreementClassId						= @AgreementClassId,
					--AgreementClassName						= @AgreementClassName,
					ProdAgreementTypeId						= x3.ProdAgreementTypeId,
					--ProdAgreementTypeName					= x3.ProdAgreementTypeName,
					ProdAgreementSubTypeId					= x4.ProdAgreementSubTypeId,
					--ProdAgreementSubTypeName				= x4.ProdAgreementSubTypeName,
					DocumentTypeId							= x5.DocumentTypeId,
					--DocumentTypeName						= x5.DocumentTypeName,
					DocumentStatusTypeId					= x6.DocumentStatusTypeId
					--DocumentStatusTypeName					= x6.DocumentStatusTypeName
					--DMSServiceTypeId						= x7.ServiceTypeId
					--DMSServiceTypeName						= x7.ServiceTypeName
		FROM		
				(	

					--			DRServiceGroupType = 'Production Service'
					Select		SortOrder =   1, DRServiceTypeName = 'Production Service',				ProdAgreementTypeName = 'Production Services', 						ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION

					--			DRServiceGroupType = 'Underlying Rights'
					Select		SortOrder =  20, DRServiceTypeName = 'Pre-existing Spec Script',		ProdAgreementTypeName = 'Option/Purchase - Script', 				ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  21, DRServiceTypeName = 'Published Book',					ProdAgreementTypeName = 'Option/Purchase - Book', 					ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  22, DRServiceTypeName = 'Story/Outline',					ProdAgreementTypeName = 'Option/Purchase - Pitch Materials',		ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  23, DRServiceTypeName = 'Unpublished Book',				ProdAgreementTypeName = 'Option/Purchase - Unpublished Novel',		ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  24, DRServiceTypeName = 'Format Rights',					ProdAgreementTypeName = 'Option/Purchase - Format Rights',			ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  25, DRServiceTypeName = 'Graphic Novels',					ProdAgreementTypeName = 'Option/Purchase - Graphic Novels',			ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  26, DRServiceTypeName = 'Life Rights',						ProdAgreementTypeName = 'Option/Purchase - Life Rights',			ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  27, DRServiceTypeName = 'Remake Rights',					ProdAgreementTypeName = 'Option/Purchase - Remake Rights', 			ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  28, DRServiceTypeName = 'Teleplay',						ProdAgreementTypeName = 'Option/Purchase - Teleplay',				ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  29, DRServiceTypeName = 'Unpublished Stage Play',			ProdAgreementTypeName = 'Option/Purchase - Unpublished Stage Play',	ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  30, DRServiceTypeName = 'Purchase (no option)',			ProdAgreementTypeName = 'Purchase', 								ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  31, DRServiceTypeName = 'Purchase - Book',					ProdAgreementTypeName = 'Purchase - Book', 							ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  32, DRServiceTypeName = 'Purchase - Rights',				ProdAgreementTypeName = 'Purchase - Rights', 						ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  33, DRServiceTypeName = 'Purchase - Script',				ProdAgreementTypeName = 'Purchase - Script', 						ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION

					--			DRServiceGroupType = 'Talent'
					Select		SortOrder =  50, DRServiceTypeName = 'Casting Director',				ProdAgreementTypeName = 'Casting Director', 						ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  51, DRServiceTypeName = 'Consultant',						ProdAgreementTypeName = 'Consultant', 								ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  52, DRServiceTypeName = 'Director',						ProdAgreementTypeName = 'Director', 								ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  53, DRServiceTypeName = 'Director/Producer',				ProdAgreementTypeName = 'Director', 								ProdAgreementSubTypeName = 'Producer',					DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  54, DRServiceTypeName = 'Line Producer/UPM',				ProdAgreementTypeName = 'Line Producer', 							ProdAgreementSubTypeName = 'UPM',						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  55, DRServiceTypeName = 'Line Producer',					ProdAgreementTypeName = 'Line Producer', 							ProdAgreementSubTypeName = NULL, 						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  56, DRServiceTypeName = 'Executive Producer',				ProdAgreementTypeName = 'Executive Producer', 						ProdAgreementSubTypeName = NULL, 						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  57, DRServiceTypeName = 'Performer - Day Player',			ProdAgreementTypeName = 'Performer', 								ProdAgreementSubTypeName = 'Day Player',				DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  58, DRServiceTypeName = 'Performer - Main Talent',			ProdAgreementTypeName = 'Performer', 								ProdAgreementSubTypeName = 'Main Talent',				DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  59, DRServiceTypeName = 'Performer - Test Option',			ProdAgreementTypeName = 'Performer', 								ProdAgreementSubTypeName = 'Test Option',				DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  60, DRServiceTypeName = 'Executive Story Editor',			ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Executive Story Editor',	DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  61, DRServiceTypeName = 'Staff Writer',					ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Staff Writer',				DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  62, DRServiceTypeName = 'Story Editor',					ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Story Editor',				DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  63, DRServiceTypeName = 'Writer',							ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = NULL,						DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  64, DRServiceTypeName = 'Writer/Co-Executive Producer',	ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Co-Executive Producer',		DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  65, DRServiceTypeName = 'Writer/Co-Producer',				ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Co- Producer',				DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  66, DRServiceTypeName = 'Writer/Consulting Producer',		ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Consulting Producer',		DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  67, DRServiceTypeName = 'Writer/Executive Producer',		ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Executive Producer',		DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  68, DRServiceTypeName = 'Writer/Producer',					ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Producer',					DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName UNION
					Select		SortOrder =  69, DRServiceTypeName = 'Writer/Supervising Producer',		ProdAgreementTypeName = 'Writer',									ProdAgreementSubTypeName = 'Supervising Producer',		DocumentTypeName = @DocumentTypeName, DocumentStatusTypeName = @DocumentStatusTypeName 

				) x
		JOIN		dbo.DRServiceType x1					ON x.DRServiceTypeName = x1.Name
		--LEFT JOIN	dbo.AgreementClass x2					ON x.Name = x2.AgreementClassIdName
		LEFT JOIN	dbo.ProdAgreementType x3				ON x.ProdAgreementTypeName = x3.ProdAgreementTypeName
		LEFT JOIN	dbo.ProdAgreementSubType x4				ON x.ProdAgreementSubTypeName = x4.ProdAgreementSubTypeName
		LEFT JOIN	dbo.DocumentType x5						ON x.DocumentTypeName = x5.DocumentTypeName
		LEFT JOIN	dbo.DocumentStatusType x6				ON x.DocumentStatusTypeName = x6.DocumentStatusTypeName
		--LEFT JOIN	dbo.ServiceType x7						ON x.ServiceTypeName = x7.ServiceTypeName
		LEFT JOIN	dbo.XDRServiceDMSService y				ON x1.DRServiceTypeId = y.DRServiceTypeId
															AND y.SelecticaTemplateId = @TemplateId
		WHERE		y.XDRServiceDMSServiceId				IS NULL



		--select * from dbo.ProdAgreementType where IsActive = 1 order by ProdAgreementTypeName

END
GO

