
IF OBJECT_ID('GetDMSArtistProject', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetDMSArtistProject
GO

CREATE PROC dbo.GetDMSArtistProject
					@ArtistId			UNIQUEIDENTIFIER = NULL,
					@ProjectId			UNIQUEIDENTIFIER = NULL
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
	--   Module:		dbo.GetDMSArtistProject
	--   Created:		2015-July-04
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					Correlate Artists to Projects
	--					
	--
	--   Usage:
	--
	--
	--					DECLARE		@ArtistId							UNIQUEIDENTIFIER	= CAST('375A0562-1C94-4F07-BB66-0052501CB215' as UNIQUEIDENTIFIER)
	--					DECLARE		@ProjectId							UNIQUEIDENTIFIER	= CAST('0CCEFA96-6B75-4C38-AB22-0032B961A39F' as UNIQUEIDENTIFIER)
	--					EXEC		dbo.GetDMSArtistProject
	--										@ArtistId					= @ArtistId,
	--										@ProjectId					= @ProjectId
	--

*/ 
-- =============================================
BEGIN


						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000	

						SELECT			ArtistId												= x.ArtistId, 
										ArtistName												= x.ArtistName, 
										ProjectId												= p.ProjectId, 
										ProjectName												= p.ProjectName,
										--NetworkId												= n.NetworkId, 
										--NetworkName												= n.NetworkName,
										DocumentDate											= MIN( x.CreatedOn ),
										ProjectDate												= MIN( p.CreatedOn )
						FROM		(
										SELECT			ArtistId								= a.ArtistId, 
														ArtistName								= a.MasterName, 
														AgreementId								= d.AgreementId,
														DocumentDate							= d.DocumentDate,
														CreatedOn								= d.CreatedOn
										FROM			dbo.Artist a WITH (NOLOCK)	
										JOIN			dbo.ProdDocumentArtist da WITH (NOLOCK)	ON a.ArtistId = da.ArtistId 
										JOIN			dbo.DocumentContact dc WITH (NOLOCK)	ON da.ProdDocumentId = dc.DocumentId 
										JOIN			dbo.Document d WITH (NOLOCK)			ON dc.DocumentId = d.DocumentId 
										WHERE			a.ArtistId								= ISNULL(@ArtistId,a.ArtistId)
									)	x
						JOIN			dbo.ProdAgreement pa WITH (NOLOCK)						ON x.AgreementId = pa.AgreementId	
						JOIN			dbo.Project p WITH (NOLOCK)								ON pa.ProjectId = p.ProjectId
						JOIN			dbo.Network n WITH (NOLOCK)								ON p.NetworkId = n.NetworkId
						WHERE			p.ProjectId												= ISNULL( @ProjectId,p.ProjectId )
						GROUP BY		
										x.ArtistId, 
										x.ArtistName, 
										p.ProjectId,
										p.ProjectName
										--n.NetworkId, 
										--n.NetworkName


END
GO

