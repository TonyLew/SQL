

IF OBJECT_ID('GetDMSDocumentArtistContact', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetDMSDocumentArtistContact
GO

CREATE PROC dbo.GetDMSDocumentArtistContact
						@DocumentId			UNIQUEIDENTIFIER = NULL
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-Dec-04 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetDMSDocumentArtistContact
	--   Created:		2015-Dec-04
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					Correlate Users to networks
	--					
	--
	--   Usage:
	--
	--
	--					DECLARE			@DocumentId							UNIQUEIDENTIFIER	= CAST('5161F8AC-0755-456D-8E28-7D9262F865CF' as UNIQUEIDENTIFIER)
	--					EXEC			dbo.GetDMSDocumentArtistContact
	--											@DocumentId					= @DocumentId
	--					SELECT			TOP 100 * FROM dbo.Document
	--

*/ 
-- =============================================
BEGIN


						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000	

						SELECT			CreateDate										= dac.Created,
										DocumentId										= dac.DocumentId,
										DocumentDate									= d.DocumentDate,
										ArtistId										= dac.ArtistId,
										ArtistName										= a.MasterName,
										ContactId										= dac.ContactId,
										ContactName										= c.ContactName,
										ContactTypeId									= dac.ContactTypeId,
										ContactTypeName									= ct.ContactTypeName
										--DocumentContactId								= dc.Id,
										--ArtistRef										= dc.ArtistRef
						FROM			dbo.DocumentArtistContact dac WITH (NOLOCK)
						JOIN			dbo.Document d WITH (NOLOCK)					ON	dac.DocumentId = d.DocumentId
						JOIN			dbo.Artist a WITH (NOLOCK)						ON	dac.ArtistId = a.ArtistId
						JOIN			dbo.Contact c WITH (NOLOCK)						ON	dac.ContactId = c.ContactId
						JOIN			dbo.ContactType ct WITH (NOLOCK)				ON	dac.ContactTypeId = ct.ContactTypeId
						--LEFT JOIN		dbo.DocumentContact dc WITH (NOLOCK)			ON  dac.DocumentId = dc.DocumentId
						--																AND dac.ContactId = dc.ContactId
						WHERE			dac.DocumentId									= ISNULL(@DocumentId,dac.DocumentId)


END
GO

