
IF OBJECT_ID('GetDRService', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetDRService
GO


CREATE PROC dbo.GetDRService
			@DRId								UNIQUEIDENTIFIER	= NULL,
			@DRServiceId						UNIQUEIDENTIFIER	= NULL,
			@SelecticaTrackingNumber			VARCHAR(50)			= NULL
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
	--   Module:		dbo.GetDRService
	--   Created:		2015-Jul-05
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--
	--   Usage:
	--
	--
	--					DECLARE			@DRId								UNIQUEIDENTIFIER	--= CAST('08EF40DD-9B84-E511-A0FF-005056A06886' as UNIQUEIDENTIFIER)
	--					DECLARE			@DRServiceId						UNIQUEIDENTIFIER	--= CAST('09EF40DD-9B84-E511-A0FF-005056A06886' as UNIQUEIDENTIFIER)
	--
	--					EXEC			dbo.GetDRService
	--											@DRId						= @DRId,
	--											@DRServiceId				= @DRServiceId
	--											@SelecticaTrackingNumber	= '1234'
	--
	--					SELECT			y.*
	--					FROM			dbo.DR x
	--					JOIN			dbo.DRService y						ON x.DRId = y.DRId
	--

*/ 
-- =============================================
BEGIN


						SET						TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET						NOCOUNT ON	
						SET						LOCK_TIMEOUT 5000	

						SELECT					DRServiceId													= dr.DRServiceId						,
	  											DRId														= dr.DRId								,
												TypeId														= st.DRServiceTypeId					,
												TypeName													= st.Name								, 
	  											GroupTypeId													= sgt.DRServiceGroupTypeId				,
												GroupTypeName												= sgt.Name								, 
	  											ServiceStatusTypeId											= sst.DRServiceStatusTypeId				,
												ServiceStatusTypeName										= sst.Name								, 
	  											LevelId														= l.LevelId								,
												LevelName													= l.Name								,
												IsTeam														= dr.IsTeam								,
	  											ServiceNotes												= dr.ServiceNotes						,
	  											FinancialTerms												= dr.FinancialTerms						,
	  											ContractAdminNotes											= dr.ContractAdminNotes					,
	  											--ContractAdminUserId											= dr.ContractAdminUserId				,
												LegalAffairsRepresentativeUserId							= dr.LegalAffairsRepUserId				,
	  											LegalAffairsRepresentativeUserName							= la.ExecutiveName						,
												LegalAffairsRepresentativeNotifiedDate						= dr.LegalAffairsRepNotifiedDate		,
												LegalAffairsRepStatusTypeId									= lat.DRServiceLegalAffairsRepStatusTypeId	,
												LegalAffairsRepStatusTypeName								= lat.Name								,
	  											BusinessAnalystUserId										= dr.BusinessAnalystUserId				,
	  											BusinessAnalystUserName										= ba.ExecutiveName						,
	  											BusinessAnalystUserNotifiedDate								= dr.BusinessAnalystUserNotifiedDate	,
												CreatorUserId												= dr.CreatorUserId						,
												CreatorRole													= dr.CreatorRole						,
												JSONWritingStep												= dr.JSONWritingStep					,
												JSONTalent													= dr.JSONTalent							,
												JSONContact													= dr.JSONContact						,
												SelecticaTrackingNumber										= dr.SelecticaTrackingNumber			,
												AgreementId													= dr.AgreementId						,
												DocumentId													= dr.DocumentId
						FROM					dbo.DRService dr WITH (NOLOCK)
						JOIN					dbo.DRServiceStatusType sst WITH (NOLOCK)					ON dr.DRServiceStatusTypeId = sst.DRServiceStatusTypeId
						JOIN					dbo.DRServiceType st WITH (NOLOCK)							ON dr.DRServiceTypeId = st.DRServiceTypeId
						JOIN					dbo.DRServiceGroupType sgt WITH (NOLOCK)					ON st.DRServiceGroupTypeId = sgt.DRServiceGroupTypeId
						JOIN					dbo.DRServiceLegalAffairsRepStatusType lat WITH (NOLOCK)	ON dr.LegalAffairsRepStatusTypeId = lat.DRServiceLegalAffairsRepStatusTypeId
						LEFT JOIN				dbo.Level l WITH (NOLOCK)									ON dr.LevelId = l.LevelId
						LEFT JOIN				dbo.Executive ba WITH (NOLOCK)								ON dr.BusinessAnalystUserId = ba.ExecutiveId
						LEFT JOIN				dbo.Executive la WITH (NOLOCK)								ON dr.LegalAffairsRepUserId = la.ExecutiveId
						WHERE					dr.IsActive													= 1
						AND						st.IsActive													= 1
						AND						sgt.IsActive												= 1
						AND						dr.DRId														= ISNULL(@DRId, dr.DRId)
						AND						dr.DRServiceId												= ISNULL(@DRServiceId,DRServiceId)
						AND						(dr.SelecticaTrackingNumber									= @SelecticaTrackingNumber
												OR @SelecticaTrackingNumber									IS NULL
												)


END
GO
