

IF OBJECT_ID('GetXDRServiceDMSService', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetXDRServiceDMSService
GO


CREATE proc dbo.GetXDRServiceDMSService
			@DRServiceTypeId		UNIQUEIDENTIFIER = NULL
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-Nov-06 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetXDRServiceDMSService
	--   Created:		2015-Nov-06
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--
	--   Usage:
	--
	--
	--					DECLARE		@DRServiceTypeId					UNIQUEIDENTIFIER	= CAST('AD737BED-BD7C-E511-A0FF-005056A06886' as UNIQUEIDENTIFIER)
	--					EXEC		dbo.GetXDRServiceDMSService
	--										@DRServiceTypeId			= @DRServiceTypeId
	--

*/ 
-- =============================================
BEGIN


						SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET			NOCOUNT ON	
						SET			LOCK_TIMEOUT 5000	


						SELECT		SelecticaTemplateId								= w.SelecticaTemplateId,
									SelecticaTemplateName							= w.Name,
									DRServiceGroupTypeName							= y2.Name,
									DRServiceTypeId									= x1.DRServiceTypeId,
									DRServiceTypeName								= x1.Name,
									AgreementClassId								= x2.AgreementClassId,
									AgreementClassName								= x2.AgreementClassName,
									ProdAgreementTypeId								= x3.ProdAgreementTypeId,
									ProdAgreementTypeName							= x3.ProdAgreementTypeName,
									ProdAgreementSubTypeId							= x4.ProdAgreementSubTypeId,
									ProdAgreementSubTypeName						= x4.ProdAgreementSubTypeName,
									DocumentTypeId									= x5.DocumentTypeId,
									DocumentTypeName								= x5.DocumentTypeName,
									DocumentStatusTypeId							= x6.DocumentStatusTypeId,
									DocumentStatusTypeName							= x6.DocumentStatusTypeName
						FROM		dbo.XDRServiceDMSService x WITH (NOLOCK)
						JOIN		dbo.DRServiceType y1 WITH (NOLOCK)				ON x.DRServiceTypeId = y1.DRServiceTypeId
						JOIN		dbo.DRServiceGroupType y2 WITH (NOLOCK)			ON y1.DRServiceGroupTypeId = y2.DRServiceGroupTypeId
						JOIN		dbo.SelecticaTemplate w	WITH (NOLOCK)			ON x.SelecticaTemplateId = w.SelecticaTemplateId
						JOIN		dbo.DRServiceType x1 WITH (NOLOCK)				ON x.DRServiceTypeId = x1.DRServiceTypeId
						LEFT JOIN	dbo.AgreementClass x2 WITH (NOLOCK)				ON x.AgreementClassId = x2.AgreementClassId
						LEFT JOIN	dbo.ProdAgreementType x3 WITH (NOLOCK)			ON x.ProdAgreementTypeId = x3.ProdAgreementTypeId
						LEFT JOIN	dbo.ProdAgreementSubType x4 WITH (NOLOCK)		ON x.ProdAgreementSubTypeId = x4.ProdAgreementSubTypeId
						LEFT JOIN	dbo.DocumentType x5	WITH (NOLOCK)				ON x.DocumentTypeId = x5.DocumentTypeId
						LEFT JOIN	dbo.DocumentStatusType x6 WITH (NOLOCK)			ON x.DocumentStatusTypeId = x6.DocumentStatusTypeId
						WHERE		y1.DRServiceTypeId								= ISNULL(@DRServiceTypeId,y1.DRServiceTypeId)


END
GO
