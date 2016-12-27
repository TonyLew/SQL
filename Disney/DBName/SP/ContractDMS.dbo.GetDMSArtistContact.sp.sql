

IF OBJECT_ID('GetDMSArtistContact', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetDMSArtistContact
GO

CREATE PROC dbo.GetDMSArtistContact
					@ArtistId			UNIQUEIDENTIFIER = NULL
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-July-04 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetDMSArtistContact
	--   Created:		2015-July-04
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					Correlate Artists to Contacts
	--					
	--
	--   Usage:
	--
	--
	--					DECLARE		@ArtistId							UNIQUEIDENTIFIER	--= CAST('6A3685A9-3C23-4164-A8BA-95B99D32E69C' as UNIQUEIDENTIFIER)
	--					EXEC		dbo.GetDMSArtistContact
	--										@ArtistId					= @ArtistId
	--

*/ 
-- =============================================
BEGIN


						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000	

						SELECT			DMSArtistId												= x.ArtistId, 
										ArtistName												= x.ArtistName, 
										ProjectId												= p.ProjectId, 
										ProjectName												= p.ProjectName, 
										DMSContactId											= c.ContactId,
										Name													= c.ContactName,
										DMSContactTypeId										= ct.ContactTypeId,
										TypeName												= ct.ContactTypeName,
										DateOfDocument											= x.DateOfDocument,
										CompanyName												= c.CompanyName,
										Address													= c.Address,
										Address2												= c.Address2,
										City													= c.City,
										State													= c.State,
										PostalCode												= c.PostalCode,
										Phone													= c.Phone,
										Fax														= c.Fax,
										Mobile													= c.Mobile,
										Email													= c.Email
						FROM		(


										SELECT			ArtistId								= dq.ArtistId, 
														ArtistName								= dq.MasterName, 
														--CAST(MAX(CAST(d.DocumentId AS BINARY(16))) AS UNIQUEIDENTIFIER) AS MAXDocumentId,
														CAST(MAX(CAST(d.AgreementId AS BINARY(16))) AS UNIQUEIDENTIFIER) AS MAXAgreementId,
														ContactId								= c.ContactId,
														ContactName								= c.ContactName,
														ContactTypeId							= ct.ContactTypeId,
														ContactTypeName							= ct.ContactTypeName,
														DateOfDocument							= dq.MaxDocumentDate
										FROM			
													(
														SELECT		a.ArtistId, 
																	a.MasterName, 
																	ct.ContactTypeId, 
																	ct.ContactTypeName, 
																	--CAST(MAX(CAST(d.DocumentId AS BINARY(16))) AS UNIQUEIDENTIFIER) AS MAXDocumentId,
																	MAX(d.DocumentDate) AS MaxDocumentDate
														FROM		dbo.Artist a WITH (NOLOCK)	
														JOIN		dbo.ProdDocumentArtist da WITH (NOLOCK)	ON a.ArtistId = da.ArtistId
														JOIN		dbo.Document d WITH (NOLOCK)			ON da.ProdDocumentId = d.DocumentId
														JOIN		dbo.DocumentContact dc WITH (NOLOCK)	ON da.ProdDocumentId = dc.DocumentId
														JOIN		dbo.Contact c WITH (NOLOCK)				ON dc.ContactId = c.ContactId
														JOIN		dbo.ContactType ct WITH (NOLOCK)		ON c.ContactTypeId = ct.ContactTypeId
														WHERE		a.ArtistId								= ISNULL(@ArtistId,a.ArtistId)
														AND			ct.ContactTypeName						IN ('Manager','Agent','Attorney') --,'Self','Representative','Accountant/Business Manager')
														GROUP BY	a.ArtistId, 
																	a.MasterName, 
																	ct.ContactTypeId, 
																	ct.ContactTypeName
													)	dq										
										JOIN			dbo.ProdDocumentArtist da WITH (NOLOCK)	ON dq.ArtistId = da.ArtistId --and dq.MAXDocumentId = da.ProdDocumentId
										JOIN			dbo.DocumentContact dc WITH (NOLOCK)	ON da.ProdDocumentId = dc.DocumentId --and dq.ContactId = dc.ContactId
										JOIN			dbo.Document d WITH (NOLOCK)			ON dc.DocumentId = d.DocumentId and dq.MaxDocumentDate = d.DocumentDate
										JOIN			dbo.ContactType ct WITH (NOLOCK)		ON dq.ContactTypeId = ct.ContactTypeId
										JOIN			dbo.Contact c WITH (NOLOCK)				ON dc.ContactId = c.ContactId and ct.ContactTypeId = c.ContactTypeId
										GROUP BY		
														dq.ArtistId, 
														dq.MasterName, 
														c.ContactId,
														c.ContactName,
														ct.ContactTypeId,
														ct.ContactTypeName,
														dq.MaxDocumentDate
									)	x
						--JOIN			dbo.ProdDocumentArtist da WITH (NOLOCK)	ON x.ArtistId = da.ArtistId and x.MAXDocumentId = da.ProdDocumentId
						--JOIN			dbo.DocumentContact dc WITH (NOLOCK)	ON da.ProdDocumentId = dc.DocumentId and x.ContactId = dc.ContactId
						--JOIN			dbo.Document d WITH (NOLOCK)			ON dc.DocumentId = d.DocumentId and x.DateOfDocument = d.DocumentDate
						JOIN			dbo.ProdAgreement pa WITH (NOLOCK)		ON x.MaxAgreementId = pa.AgreementId	--d.AgreementId = pa.AgreementId
						--JOIN			dbo.Agreement agmt WITH (NOLOCK)		ON pa.AgreementId = agmt.AgreementId
						JOIN			dbo.Project p WITH (NOLOCK)				ON pa.ProjectId = p.ProjectId
						JOIN			dbo.ContactType ct WITH (NOLOCK)		ON x.ContactTypeId = ct.ContactTypeId
						JOIN			dbo.Contact c WITH (NOLOCK)				ON x.ContactId = c.ContactId and x.ContactTypeId = c.ContactTypeId


END
GO

