


IF OBJECT_ID('GetDMSFinancialView', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetDMSFinancialView
GO


CREATE PROC dbo.GetDMSFinancialView
						@DocumentId										UNIQUEIDENTIFIER 
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-Dec-25 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetDMSFinancialView
	--   Created:		2015-Dec-25
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					Get financial documents correlated to Artists and Projects
	--					
	--
	--   Usage:
	--
	--					DECLARE		@DocumentId							UNIQUEIDENTIFIER	= CAST('A3CE45CC-A349-4F94-9A3D-001C653C7D6E' as UNIQUEIDENTIFIER)
	--					EXEC		dbo.GetDMSFinancialView
	--										@DocumentId					= @DocumentId
	--

*/ 
-- =============================================
BEGIN



						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000	
						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	

						DECLARE			@IsTeam													BIT
						DECLARE			@HeaderModified											DATETIME
						DECLARE			@HeaderModifierId										UNIQUEIDENTIFIER
						DECLARE			@HeaderModifier											VARCHAR(250)
						DECLARE			@TabModified											DATETIME
						DECLARE			@TabModifierId											UNIQUEIDENTIFIER
						DECLARE			@TabModifier											VARCHAR(250)
						DECLARE			@ProjectIdTbl											UDT_GUID
						DECLARE			@DocumentIdTbl											TABLE	( 
																											Id							INT IDENTITY(1,1),
																											ProjectId					UNIQUEIDENTIFIER,
																											AgreementId					UNIQUEIDENTIFIER,
																											DocumentId					UNIQUEIDENTIFIER,
																											EngagingEntityID			UNIQUEIDENTIFIER,
																											FinancialGridDocumentId		UNIQUEIDENTIFIER
																										)


						INSERT			@DocumentIdTbl 
									( 
										ProjectId,
										AgreementId,
										DocumentId,
										EngagingEntityID,
										FinancialGridDocumentId
									)
						SELECT			ProjectId												= pa.ProjectId,
										AgreementId												= d.AgreementId,
										DocumentId												= d.DocumentId,
										EngagingEntityID										= e.EngagingEntityID,
										FinancialGridDocumentId									= fgd.FinancialGridDocumentId

										--AgreementDate											= a.AgreementDate,
										--ExecContract
										--CofA
										--ProjectNum
										--StartForms
										--TalentAddress
										--TalentPhone
										--ReleaseCKTo
										--CKRelease
										--RepEmail
										--RepAddress
										--RepPhone
										--DOB
										--StartDate
										--TrackingStatus

										--HeaderModified											= ISNULL(fgd.Updated,fgd.Created),
										--HeaderModifierId										= hm.UserId,
										--HeaderModifier											= hm.UserName,
										--TabModified												= tab.TabModified,
										--TabModifierId											= tab.TabModifierId,
										--TabModifier												= tab.TabModifier		

						FROM			dbo.Document d WITH (NOLOCK)
						JOIN			dbo.ProdDocument pd WITH (NOLOCK)						ON d.DocumentId = pd.DocumentId 
						JOIN			dbo.Agreement a WITH (NOLOCK)							ON d.AgreementId = a.AgreementId 
						JOIN			dbo.ProdAgreement pa WITH (NOLOCK)						ON d.AgreementId = pa.AgreementId 
						--JOIN			dbo.FinancialGrid fg WITH (NOLOCK)						ON pd.DocumentId = fg.DocumentId
						--JOIN			dbo.FinancialGridType fgt WITH (NOLOCK)					ON fg.FinancialGridTypeId = fgt.FinancialGridTypeId
						JOIN			dbo.FinancialGridDocument fgd WITH (NOLOCK)				ON d.DocumentId = fgd.DocumentId
						--JOIN			dbo.Users hm WITH (NOLOCK)								ON fgd.UserId = hm.UserId
						LEFT JOIN		dbo.EngagingEntity e WITH (NOLOCK)						ON pd.EngagingEntityID = e.EngagingEntityID 
						--JOIN		(
						--				SELECT	TOP 1 
						--						DocumentId										= 'EF4DDF4A-D05B-4715-9D2F-8DE861F97FF6', --@DocumentId,
						--						TabModified										= ISNULL(fg.Updated,fg.Created),
						--						TabModifierId									= u.UserId,
						--						TabModifier										= u.UserName,
						--						RowNum											= ROW_NUMBER() OVER ( ORDER BY ISNULL(fg.Updated,fg.Created) DESC )
						--				FROM	dbo.FinancialGrid fg WITH (NOLOCK)
						--				JOIN	dbo.Users u WITH (NOLOCK)						ON fg.UserId = u.UserId
						--				WHERE	fg.DocumentId									= 'EF4DDF4A-D05B-4715-9D2F-8DE861F97FF6' --@DocumentId
						--				--ORDER BY		ISNULL(fg.Updated,fg.Created) DESC
						--			) tab														ON tab.DocumentId = fg.DocumentId
						WHERE			pd.DocumentId											= @DocumentId

						----				Determine if this is a team.
						--SELECT			@IsTeam													= CASE WHEN COUNT(1) > 1 THEN 1 ELSE 0 END
						--FROM			dbo.ProdDocumentArtist pda WITH (NOLOCK)
						--WHERE			pda.ProdDocumentId										= @DocumentId
						--GROUP BY		pda.ProdDocumentId, pda.ArtistId





						--INSERT			@DocumentIdTbl ( ProjectId,AgreementId,DocumentId,EngagingEntityID )
						--SELECT			pa.ProjectId,d.AgreementId,d.DocumentId,e.EngagingEntityID
						--FROM			dbo.Document d WITH (NOLOCK)
						--JOIN			dbo.DocumentType dt WITH (NOLOCK)						ON d.DocumentTypeId = dt.DocumentTypeId
						--JOIN			dbo.DocumentStatusType dst WITH (NOLOCK)				ON d.DocumentStatusTypeId = dst.DocumentStatusTypeId
						--JOIN			dbo.ProdDocument pd WITH (NOLOCK)						ON d.DocumentId = pd.DocumentId 
						--JOIN			dbo.ProdAgreement pa WITH (NOLOCK)						ON d.AgreementId = pa.AgreementId 
						--JOIN			dbo.Project p WITH (NOLOCK)								ON pa.ProjectId = p.ProjectId
						--JOIN			dbo.ProjectStatus ps WITH (NOLOCK)						ON p.ProjectStatusId = ps.ProjectStatusId
						--JOIN		(
						--				SELECT		ProdDocumentId
						--				FROM		dbo.ProdDocumentArtist WITH (NOLOCK)
						--				WHERE		ArtistId									= ISNULL( @ArtistId,ArtistId )
						--				GROUP BY	ProdDocumentId
						--			) da														ON pd.DocumentId = da.ProdDocumentId 
						--LEFT JOIN		dbo.EngagingEntity e WITH (NOLOCK)						ON pd.EngagingEntityID = e.EngagingEntityID 
						--WHERE			dt.IsActive												= 1
						--AND				dst.IsActive 											= 1
						--AND				e.IsActive 												= 1
						--AND				dst.DocumentStatusTypeName								<> 'Fully Executed'
						--AND				p.ProjectId												= ISNULL( @ProjectId,p.ProjectId )
						--AND				d.DocumentId											= ISNULL( @DocumentId,d.DocumentId )
						--AND				ps.ProjectStatusName									IN	( 
						--																				'Current-Development',
						--																				'Current-Post Production',
						--																				'Current-Production',
						--																				'Pass Notice Pending'
						--																			)


						--INSERT			@ProjectIdTbl ( Gid )
						--SELECT			p.ProjectId
						--FROM			@DocumentIdTbl x
						----JOIN			dbo.ProdDocument pd WITH (NOLOCK)						ON x.DocumentId = pd.DocumentId 
						--JOIN			dbo.ProdAgreement pa WITH (NOLOCK)						ON x.AgreementId = pa.AgreementId 
						--JOIN			dbo.Project p WITH (NOLOCK)								ON pa.ProjectId = p.ProjectId
						--JOIN			dbo.Network n WITH (NOLOCK)								ON p.NetworkId = n.NetworkId
						--LEFT JOIN		dbo.ProjectStatus ps WITH (NOLOCK)						ON p.ProjectStatusId = ps.ProjectStatusId
						--WHERE			n.IsActive												= 1
						--GROUP BY		p.ProjectId




						------------------------------------------------------------------------------------------------------------------------------------------------------------------
						--				Header
						------------------------------------------------------------------------------------------------------------------------------------------------------------------

						--SELECT			HeaderName												= 'HeaderName'




						------------------------------------------------------------------------------------------------------------------------------------------------------------------
						--				Project Level
						------------------------------------------------------------------------------------------------------------------------------------------------------------------

						--SELECT			ProjectId												= p.ProjectId			, 
						--				ProjectName												= p.ProjectName			,
						--				ProjectDate												= p.CreatedOn			,
						--				ProjectStatusName										= ps.ProjectStatusName	,
						--				NetworkId												= n.NetworkId			,
						--				NetworkName												= n.NetworkName			,
						--				ProgramTypeName											= pt.ProgramTypeName	
						--FROM			@ProjectIdTbl x
						--JOIN			dbo.Project p WITH (NOLOCK)								ON x.Gid = p.ProjectId
						--JOIN			dbo.ProjectStatus ps WITH (NOLOCK)						ON p.ProjectStatusId = ps.ProjectStatusId
						--LEFT JOIN		dbo.ProgramType pt WITH (NOLOCK)						ON p.ProgramTypeId = pt.ProgramTypeId
						--JOIN			dbo.Network n WITH (NOLOCK)								ON p.NetworkId = n.NetworkId
						--ORDER BY		p.ProjectName

						SELECT			ProjectId												= p.ProjectId			, 
										ProjectName												= p.ProjectName			,
										ProjectDate												= p.CreatedOn			,
										ProjectStatusId											= ps.ProjectStatusId	,
										ProjectStatusName										= ps.ProjectStatusName	,
										NetworkId												= n.NetworkId			,
										NetworkName												= n.NetworkName			,
										ProgramTypeName											= pt.ProgramTypeName	,
										TrackingStatusTypeName									= tst.TrackingStatusTypeName,
										EffectiveOn												= dt2.EffectiveOn,
										EngagingEntityId										= e.EngagingEntityId,
										EngagingEntityName										= e.EngagingEntityName,
										DocumentId												= x.DocumentId,
										IsTeam													= team.IsTeam,

										AgreementDate											= a.AgreementDate,
										ExecContract											= fgd.ExecContract,
										CofA													= fgd.CofA,
										StartForms												= fgd.StartForms,
										TalentAddress											= fgd.TalentAddress,
										TalentPhone												= fgd.TalentPhone,
										ReleaseCKTo												= fgd.ReleaseCKTo,
										CKRelease												= fgd.CKRelease,
										RepEmail												= fgd.RepEmail,
										RepAddress												= fgd.RepAddress,
										RepPhone												= fgd.RepPhone,
										DOB														= fgd.DOB,
										StartDate												= fgd.StartDate,
										TrackingStatus											= fgd.TrackingStatus,

										HeaderModified											= ISNULL(fgd.Updated,fgd.Created),
										HeaderModifierId										= hm.UserId,
										HeaderModifier											= hm.UserName,
										TabModified												= tab.TabModified,
										TabModifierId											= tab.TabModifierId,
										TabModifier												= tab.TabModifier		
						FROM			@DocumentIdTbl x 
						JOIN			dbo.Project p WITH (NOLOCK)								ON x.ProjectId = p.ProjectId
						JOIN			dbo.ProjectStatus ps WITH (NOLOCK)						ON p.ProjectStatusId = ps.ProjectStatusId
						JOIN			dbo.Network n WITH (NOLOCK)								ON p.NetworkId = n.NetworkId
						JOIN			dbo.Document d WITH (NOLOCK)							ON x.DocumentId = d.DocumentId 
						JOIN			dbo.Agreement a WITH (NOLOCK)							ON x.AgreementId = a.AgreementId 
						JOIN			dbo.FinancialGridDocument fgd WITH (NOLOCK)				ON x.FinancialGridDocumentId = fgd.FinancialGridDocumentId
						JOIN			dbo.Users hm WITH (NOLOCK)								ON fgd.UserId = hm.UserId
						JOIN		(
										SELECT	TOP 1 
												DocumentId										= @DocumentId,
												TabModified										= ISNULL(fg.Updated,fg.Created),
												TabModifierId									= u.UserId,
												TabModifier										= u.UserName,
												RowNum											= ROW_NUMBER() OVER ( ORDER BY ISNULL(fg.Updated,fg.Created) DESC )
										FROM	dbo.FinancialGrid fg WITH (NOLOCK)
										JOIN	dbo.Users u WITH (NOLOCK)						ON fg.UserId = u.UserId
										WHERE	fg.DocumentId									= @DocumentId
										--ORDER BY		ISNULL(fg.Updated,fg.Created) DESC
									) tab														ON x.DocumentId = tab.DocumentId

						JOIN		(
										SELECT		DocumentId									= @DocumentId,
													IsTeam										= CASE WHEN COUNT(1) > 1 THEN 1 ELSE 0 END
										FROM		dbo.ProdDocumentArtist pda WITH (NOLOCK)
										WHERE		pda.ProdDocumentId							= @DocumentId
										GROUP BY	pda.ProdDocumentId, pda.ArtistId
									) team														ON x.DocumentId = team.DocumentId
						LEFT JOIN		dbo.ProgramType pt WITH (NOLOCK)						ON p.ProgramTypeId = pt.ProgramTypeId
						LEFT JOIN		dbo.EngagingEntity e WITH (NOLOCK)						ON x.EngagingEntityId = e.EngagingEntityId 
						LEFT JOIN	(
										SELECT		DocumentId, MAX(EffectiveOn) AS MAXEffectiveOn
										FROM		dbo.DocumentTracking WITH (NOLOCK)
										WHERE		DocumentId									= @DocumentId
										GROUP BY	DocumentId
									) dt1														ON x.DocumentId = dt1.DocumentId
						LEFT JOIN		dbo.DocumentTracking dt2 WITH (NOLOCK)					ON dt1.DocumentId = dt2.DocumentId 
																								AND dt1.MAXEffectiveOn = dt2.EffectiveOn
						LEFT JOIN		dbo.TrackingStatusType tst WITH (NOLOCK)				ON dt2.TrackingStatusTypeId = tst.TrackingStatusTypeId




						------------------------------------------------------------------------------------------------------------------------------------------------------------------
						--				Document Level (Artist and Contact)
						------------------------------------------------------------------------------------------------------------------------------------------------------------------

						--SELECT			ProjectId												= x.ProjectId,
						--				ArtistId												= a.ArtistId, 
						--				ArtistName												= a.MasterName, 
						--				AgreementId												= x.AgreementId,
						--				DocumentId												= x.DocumentId,
						--				DocumentDate											= d.DocumentDate,
						--				CreatedOn												= d.CreatedOn,
						--				ContactId												= c.ContactId,
						--				ContactName												= c.ContactName,
						--				ContactTypeName											= ct.ContactTypeName,
						--				CompanyName												= c.CompanyName,
						--				Address													= c.Address,
						--				Address2												= c.Address2,
						--				City													= c.City,
						--				State													= c.State,
						--				PostalCode												= c.PostalCode,
						--				Phone													= c.Phone,
						--				Fax														= c.Fax,
						--				Mobile													= c.Mobile,
						--				Email													= c.Email,
						--				Note													= c.Note
						--FROM			@DocumentIdTbl x 
						--JOIN			dbo.Project p WITH (NOLOCK)								ON x.ProjectId = p.ProjectId
						--JOIN			dbo.Document d WITH (NOLOCK)							ON x.DocumentId = d.DocumentId 
						--JOIN			dbo.ProdDocumentArtist da WITH (NOLOCK)					ON x.DocumentId = da.ProdDocumentId 
						--JOIN			dbo.Artist a WITH (NOLOCK)								ON da.ArtistId = a.ArtistId 
						--JOIN			dbo.DocumentContact dc WITH (NOLOCK)					ON x.DocumentId = dc.DocumentId 
						--JOIN			dbo.Contact c WITH (NOLOCK)								ON dc.ContactId = c.ContactId 
						--JOIN			dbo.ContactType ct WITH (NOLOCK)						ON c.ContactTypeId = ct.ContactTypeId 
						--WHERE			a.ArtistId												= ISNULL( @ArtistId,a.ArtistId )
						--ORDER BY		p.ProjectName,
						--				a.MasterName




						------------------------------------------------------------------------------------------------------------------------------------------------------------------
						--				Document Level (Document Tracking Status)
						------------------------------------------------------------------------------------------------------------------------------------------------------------------

						--SELECT			ProjectId												= x.ProjectId,
						--				AgreementId												= x.AgreementId,
						--				DocumentId												= x.DocumentId,
						--				DocumentSubTypeName										= dst.DocumentSubTypeName,
						--				DocumentDate											= d.DocumentDate,
						--				CreatedOn												= d.CreatedOn,
						--				TrackingStatusTypeName									= tst.TrackingStatusTypeName,
						--				EffectiveOn												= dt2.EffectiveOn,
						--				EngagingEntityId										= e.EngagingEntityId,
						--				EngagingEntityName										= e.EngagingEntityName
						--FROM			@DocumentIdTbl x 
						--JOIN			dbo.Project p WITH (NOLOCK)								ON x.ProjectId = p.ProjectId
						--JOIN			dbo.Document d WITH (NOLOCK)							ON x.DocumentId = d.DocumentId 
						--LEFT JOIN		dbo.EngagingEntity e WITH (NOLOCK)						ON x.EngagingEntityId = e.EngagingEntityId 
						--LEFT JOIN	(
						--				SELECT		DocumentId, MAX(EffectiveOn) AS MAXEffectiveOn
						--				FROM		dbo.DocumentTracking WITH (NOLOCK)
						--				GROUP BY	DocumentId
						--			) dt1														ON x.DocumentId = dt1.DocumentId
						--LEFT JOIN		dbo.DocumentTracking dt2 WITH (NOLOCK)					ON dt1.DocumentId = dt2.DocumentId 
						--																		AND dt1.MAXEffectiveOn = dt2.EffectiveOn
						--LEFT JOIN		dbo.TrackingStatusType tst WITH (NOLOCK)				ON dt2.TrackingStatusTypeId = tst.TrackingStatusTypeId
						--LEFT JOIN		dbo.DocumentSubType dst WITH (NOLOCK)					ON dt2.DocumentSubTypeId = dst.DocumentSubTypeId
						--ORDER BY		p.ProjectName




						------------------------------------------------------------------------------------------------------------------------------------------------------------------
						--				Document Service Level (Compensation and itemized costs)
						------------------------------------------------------------------------------------------------------------------------------------------------------------------





						SELECT			
										--ProjectId												= p.ProjectId,
										--ProjectName												= p.ProjectName,
										--ArtistId												= a.ArtistId, 
										--ArtistName												= a.MasterName,
										FinancialGridId											= fg.FinancialGridId,
										FinancialGridTypeId										= fg.FinancialGridTypeId,
										FinancialGridTypeName									= fgt.Name,
										DocumentId												= fg.DocumentId,
										Rec														= fg.Rec,
										WritingStepId											= ws.WritingStepId,
										WritingStepName											= ws.Name,
										Step													= fg.Step,
										Percentage												= fg.Percentage,
										StepAmount												= fg.StepAmount,
										StepDate												= fg.StepDate,
										RequestDate												= fg.RequestDate,
										Gross													= fg.Gross,
										PRTaxesFB												= fg.PRTaxesFB,
										Total													= fg.Total,
										CCCheckNum												= fg.CCCheckNum,
										CCInvoiceNum											= fg.CCInvoiceNum,
										DeliveryInfo											= fg.DeliveryInfo,
										CreativeNote											= fg.CreativeNote,
										Modified												= CASE WHEN fg.Updated IS NULL THEN fg.Created ELSE fg.Updated END,
										ModifierId												= u.UserId,
										Modifier												= u.UserName

						FROM			@DocumentIdTbl x 
						JOIN			dbo.Project p WITH (NOLOCK)								ON x.ProjectId = p.ProjectId
						JOIN			dbo.FinancialGrid fg WITH (NOLOCK)						ON x.DocumentId = fg.DocumentId
						JOIN			dbo.FinancialGridType fgt WITH (NOLOCK)					ON fg.FinancialGridTypeId = fgt.FinancialGridTypeId
						JOIN			dbo.WritingStep ws WITH (NOLOCK)						ON fg.WritingStepId = ws.WritingStepId
						JOIN			dbo.ProdDocument pd WITH (NOLOCK)						ON fg.DocumentId = pd.DocumentId
						JOIN			dbo.Users u WITH (NOLOCK)								ON fg.UserId = u.UserId
						WHERE			x.DocumentId											= @DocumentId
						--LEFT JOIN		dbo.ProdDocumentArtist da WITH (NOLOCK)					ON pd.DocumentId = da.ProdDocumentId 
						--LEFT JOIN		dbo.Artist a WITH (NOLOCK)								ON da.ArtistId = a.ArtistId 
						--WHERE			(	a.ArtistId											= ISNULL( @ArtistId,a.ArtistId )
						--					OR ( a.ArtistId IS NULL AND  @ArtistId IS NULL )
						--				)




						--SELECT			ProjectId												= p.ProjectId,
						--				ProjectName												= p.ProjectName,
						--				ArtistId												= a.ArtistId, 
						--				ArtistName												= a.MasterName, 
						--				DocumentId												= x.DocumentId,
						--				ServiceTypeName											= st.ServiceTypeName,
						--				ServiceAmount											= s.Amount,
						--				ServiceSort												= s.Sort,

						--				HasSeparationOfRights									= ISNULL( c.HasSepRights,0 ),
						--				CompensationNote										= c.CompensationNote, 
						--				MinorTypeName											= mrt.MinorTypeName,
						--				PassivePayment											= pp.Percentage, 
						--				PassivePaymentTypeName									= pt.PaymentTypeName,
						--				OtherCompensationTypeName								= ct.CompTypeName,
						--				OtherCompensationOtherAmountTypeName					= ot.OtherCompensationOtherAmountTypeName,
						--				OtherCompensationTypeAmount								= oc.Amount,

						--				SideLetterTypeName										= slt.SideLetterTypeName,
						--				SideLetterTypeAmount									= sl.Amount,

						--				RoyaltyConditionTypeName								= rct.RoyaltyConditionTypeName,
						--				RoyaltyConditionTypeAmount								= rc.Amount,

						--				MerchandisingTypeName									= mt.MerchandisingTypeName,
						--				MerchandisingTypePercentage								= m.Percentage

						--FROM			@DocumentIdTbl x 
						--JOIN			dbo.Project p WITH (NOLOCK)								ON x.ProjectId = p.ProjectId
						--JOIN			dbo.[Service] s WITH (NOLOCK)							ON x.DocumentId = s.ProdDocumentId 
						--JOIN			dbo.ServiceType st WITH (NOLOCK)						ON s.ServiceTypeId = st.ServiceTypeId 
						--JOIN			dbo.ProdDocument pd WITH (NOLOCK)						ON s.ProdDocumentId = pd.DocumentId
						--LEFT JOIN		dbo.ProdDocumentArtist da WITH (NOLOCK)					ON pd.DocumentId = da.ProdDocumentId 
						--LEFT JOIN		dbo.Artist a WITH (NOLOCK)								ON da.ArtistId = a.ArtistId 
						--LEFT JOIN		dbo.Compensation c WITH (NOLOCK)						ON pd.DocumentId = c.ProdDocumentId
						--LEFT JOIN		dbo.Minor mr WITH (NOLOCK)								ON pd.DocumentId = mr.ProdDocumentId
						--LEFT JOIN		dbo.MinorType mrt WITH (NOLOCK)							ON mr.MinorTypeId = mrt.MinorTypeId
						--LEFT JOIN		dbo.PassivePayment pp WITH (NOLOCK)						ON pd.DocumentId = pp.ProdDocumentId
						--LEFT JOIN		dbo.PaymentType pt WITH (NOLOCK)						ON pp.PaymentTypeId = pt.PaymentTypeId
						--LEFT JOIN		dbo.OtherCompensation oc WITH (NOLOCK)					ON pd.DocumentId = oc.ProdDocumentId
						--LEFT JOIN		dbo.CompType ct	WITH (NOLOCK)							ON oc.CompTypeId = ct.CompTypeId
						--LEFT JOIN		dbo.OtherCompensationOtherAmountType ot	WITH (NOLOCK)	ON oc.OtherCompensationOtherAmountTypeId = oc.OtherCompensationOtherAmountTypeId
						--LEFT JOIN		dbo.SideLetter sl WITH (NOLOCK)							ON pd.DocumentId = sl.ProdDocumentId
						--LEFT JOIN		dbo.SideLetterType slt WITH (NOLOCK)					ON sl.SideLetterTypeId = slt.SideLetterTypeId
						--LEFT JOIN		dbo.RoyaltyCondition rc	WITH (NOLOCK)					ON pd.DocumentId = rc.ProdDocumentId
						--LEFT JOIN		dbo.RoyaltyConditionType rct WITH (NOLOCK)				ON rc.RoyaltyConditionTypeId = rct.RoyaltyConditionTypeId
						--LEFT JOIN		dbo.Merchandising m	WITH (NOLOCK)						ON pd.DocumentId = m.ProdDocumentId
						--LEFT JOIN		dbo.MerchandisingType mt WITH (NOLOCK)					ON m.MerchandisingTypeId = mt.MerchandisingTypeId
						--WHERE			(	a.ArtistId											= ISNULL( @ArtistId,a.ArtistId )
						--					OR ( a.ArtistId IS NULL AND  @ArtistId IS NULL )
						--				)
						--ORDER BY		p.ProjectName,
						--				a.MasterName 



END


