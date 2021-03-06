

IF OBJECT_ID('Report_WriterCreatorPts', 'p') IS NOT NULL
    DROP PROCEDURE dbo.Report_WriterCreatorPts
GO
 
 
CREATE PROCEDURE dbo.Report_WriterCreatorPts
				@AgreementStartDate											datetime = null,
				@AgreementEndDate 											datetime = null,
				@ReportTypeId 												uniqueidentifier = null,
				@Project 													varchar(250) = '',
				@NetworkIds 												varchar(max) = ''

AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-05-05 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.Report_WriterCreatorPts
	--   Created:		2015-Jun-25
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					Jira Issue CCADMS-584
	--
	--   Usage:
	--
	--
	--					DECLARE @NetworkIds varchar(max)
	--					SELECT	@NetworkIds = COALESCE(@NetworkIds + ', ', '') + CAST(NetworkId AS varchar(100))
	--					FROM	dbo.Network
	--					WHERE	NetworkId <> '00000000-0000-0000-0000-000000000000'
	--					EXEC		dbo.Report_WriterCreatorPts
	--										@AgreementStartDate					= '2014-01-01',
	--										@AgreementEndDate					= '2014-05-01',
	--										@ReportTypeId						= '35007B31-4EA2-4AAC-9AE5-AAE41B3E2E7E',
	--										@Project							= '',
	--										@NetworkIds							= @NetworkIds
	--

*/ 
-- =============================================
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				SET				LOCK_TIMEOUT 5000
 
				DECLARE			@signingbonus uniqueidentifier
				SELECT			TOP 1 @signingbonus			= CompTypeId from dbo.CompType WITH (NOLOCK) where CompTypeName = 'Bonus - Signing';

				DECLARE			@bonusproduction uniqueidentifier
				SELECT			TOP 1 @bonusproduction		= CompTypeId from dbo.CompType WITH (NOLOCK) where CompTypeName = 'Bonus - Production';

				DECLARE			@UserNetworks table(NetworkId uniqueidentifier)
				INSERT			@UserNetworks				select Data from dbo.fn_Split(@NetworkIds,',')

				SELECT			TOP 1 @ReportTypeId			= ReportTypeId from dbo.ReportType WITH (NOLOCK) where ReportTypeName = 'Writer-Creator-PtS'
				--IF				(@ReportTypeId IS NULL)		RETURN

				DECLARE			@ProdDocumentIdTbl UDT_GUID

				DECLARE			@Filter TABLE 
												(
													DocumentId				uniqueidentifier,
													AgreementId				uniqueidentifier,
													DocumentTypeName		varchar(250),
													DocumentDate			date,
													HasSepRights			bit,
													PctOfFourFormulas		float,
													ReportTypeId			uniqueidentifier,
													ReportTypeName			varchar(250),
													ReportTypeSort			tinyint,
													ProjectId				uniqueidentifier,
													ProjectName				varchar(250),
													ProdAgreementTypeName	varchar(250),
													ProdAgreementSubTypeName varchar(250),
													ProdAgreementSubTypeId	uniqueidentifier,
													AgreementDate			date,
													ProgramTypeName			varchar(250),
													NetworkName				varchar(250),
													NetworkShortName		varchar(10),
													ProgramTypeId			uniqueidentifier,
													ProgramTypeShortName	varchar(10)
												)

				INSERT			@Filter 
							(
								DocumentId				,
								AgreementId				,
								DocumentTypeName		,
								DocumentDate			,
								HasSepRights			,
								PctOfFourFormulas		,
								ReportTypeId			,
								ReportTypeName			,
								ReportTypeSort			,
								ProjectId				,
								ProjectName				,
								ProdAgreementTypeName	,
								ProdAgreementSubTypeName,
								ProdAgreementSubTypeId	,
								AgreementDate			,
								ProgramTypeName			,
								NetworkName				,
								NetworkShortName		,
								ProgramTypeId			,
								ProgramTypeShortName	
							)
				SELECT			
								d.DocumentId,																								--uniqueidentifier
								d.AgreementId,																								--uniqueidentifier
								d.DocumentTypeName,																							--varchar(250)
								d.DocumentDate,																								--date
								d.HasSepRights,																								--bit	
								d.PctOfFourFormulas,																						--float	
								pa.ReportTypeId,																							--uniqueidentifier
								ReportTypeName											= isnull(pa.ReportTypeName,'[unspecified]'),		--varchar(250)
								ReportTypeSort											= rt.Sort,											--tinyint
								pa.ProjectId,																								--uniqueidentifier
								pa.ProjectName,																								--varchar(250)
								pa.ProdAgreementTypeName,																					--varchar(250)
								pa.ProdAgreementSubTypeName,																				--varchar(250)
								pa.ProdAgreementSubTypeId,																					--uniqueidentifier
								pa.AgreementDate,																							--date
								pp.ProgramTypeName,																							--varchar(250)
								pp.NetworkName,																								--varchar(250)
								pp.NetworkShortName,																						--varchar(10)
								pp.ProgramTypeId,																							--uniqueidentifier
								pp.ProgramTypeShortName																						--varchar(10)

				FROM			dbo.v_ProdDocument d WITH (NOLOCK)
				JOIN			dbo.v_AgreementDocumentDate vad	WITH (NOLOCK)			ON d.AgreementId = vad.AgreementId
				JOIN			dbo.v_ProdAgreement pa WITH (NOLOCK)					ON pa.AgreementId = d.AgreementId
				LEFT JOIN		dbo.ProdAgreementSubType ast WITH (NOLOCK)				ON pa.ProdAgreementSubTypeId = ast.ProdAgreementSubTypeId
				LEFT JOIN		dbo.ReportType rt WITH (NOLOCK) 						ON pa.ReportTypeId = rt.ReportTypeId
				JOIN			dbo.t_project pp WITH (NOLOCK) 							ON pa.ProjectId = pp.ProjectId
				LEFT JOIN		dbo.CreditApproval ca									ON d.DocumentId = ca.DocumentId
				JOIN			@UserNetworks n											ON pp.NetworkId = n.NetworkId
				WHERE			(@AgreementStartDate IS NULL OR (vad.MaxAgreeDocDate >= @AgreementStartDate))
				AND				(@AgreementEndDate IS NULL OR (vad.MinAgreeDocDate < @AgreementEndDate+1))
				AND				(@ReportTypeId IS NULL OR (pa.ReportTypeId = @ReportTypeId))
				AND				(@Project = '' OR pa.ProjectName LIKE '%' + @Project + '%')

				INSERT			@ProdDocumentIdTbl ( Gid )
				SELECT			DISTINCT f.DocumentId
				FROM			@Filter f



				SELECT

								ReportTypeName											= f.ReportTypeName,
								ReportTypeSort											= f.ReportTypeSort,
								DocumentTypeName										= f.DocumentTypeName,

								AgreementId 											= f.AgreementId,
								DocumentId												= f.DocumentId,
								ArtistNames												= art.ArtistNamesLF,
								ProdAgreementTypeName									= f.ProdAgreementTypeName,
								ProdAgreementSubTypeName								= f.ProdAgreementSubTypeName,
								DocumentDate											= f.DocumentDate,
								ProjectName												= f.ProjectName,

								ProjectAKAs												= ppt.ProjectAKAs,

								ProgramTypeName											= f.ProgramTypeName,
								NetworkName												= f.NetworkName,
								NetworkShortName										= f.NetworkShortName,
								ProgramTypeId											= f.ProgramTypeId,
								ProgramTypeShortName									= f.ProgramTypeShortName,
	
								yc.YearlyCredit,
								PilotScript												= zpp.PilotScript,
								ser.PilotScriptSupervising,
								ser.PilotServices,
								zser.SeriesServices,
								Term													= ISNULL(ser.IsGuaranteed,'0')+'+'+ISNULL(ser.IsOptional,'0'),
								oc.Bonuses,
								rc.SeriesRoyalty,
								ser.Consulting,
								CB														= b.CB,
								ocb.SigningBonus,
								merch.Merchandising,
								bp.BonusProduction,
								Spinoff													= ISNULL((	
																									SELECT		DISTINCT 'Yes'
																									FROM		dbo.t_AdditionalTerm r WITH (NOLOCK) 
																									WHERE		r.DocumentId=f.DocumentId AND r.TermTypeName='spinoff'),'No'
																								),
								SepRts													=	CASE	WHEN f.HasSepRights=1 AND ISNULL(f.PctOfFourFormulas,0) > 0 THEN CAST(f.PctOfFourFormulas AS VARCHAR(MAX)) + '%'
																									WHEN f.HasSepRights=1 AND ISNULL(f.PctOfFourFormulas,0) <= 0 THEN 'Yes'
																									ELSE 'No' 
																							END,
								ct.Agency,
								ct.Agent,
								ct.Attorney,
								ct.Firm,
								aed.BAExec,
								aed.LAExec,
								AddlTerms												=	CASE	WHEN f.DocumentTypeName IN ('Loanout Conversion','Loanout Conversion 2') 
																									THEN f.DocumentTypeName 
																									ELSE at.AddlTerms 
																							END,
								ser.PreProduction,
								ser.Production,
								ser.PilotBudgeting,
								UPM														=	CASE 
																									WHEN f.ProdAgreementSubTypeName = 'UPM'
																									THEN 'Yes'
																									ELSE 'No'
																							END,
								ser.Script,
								ser.Rewrite,
								ser.Polish,
								ser.Development,
								ser.CastingDirector,
								ser.ExecutiveProducer,

								LineProducer											=	ser.LineProducer,

								Sequels													= ISNULL(sp.Sequels,'No'),
								sp.Expenses,
								ser.NumberRoles,
								ser.MinWeeks,
								ser.PrepServices,
								ser.ProdServices,
								ser.Wrap,
								ser.Director,
								ser.CoProducer,
								ser.Pilot,
								ser.Performer,
								ser.Series,
								ser.Series2,
								ser.SeriesContingencyFee,
								Credits													= ISNULL(credits.Names,'')


				FROM			@Filter f
				LEFT JOIN		dbo.Fn_OtherCompensation( @ProdDocumentIdTbl, @ReportTypeId ) oc		ON f.DocumentId = oc.DocumentId
				LEFT JOIN		dbo.Fn_AllPayableServices( @ProdDocumentIdTbl, @ReportTypeId ) ser		ON f.DocumentId = ser.ProdDocumentId
				LEFT JOIN		dbo.Fn_AllExecutiveDocuments( @ProdDocumentIdTbl, @ReportTypeId ) aed	ON f.DocumentId = aed.DocumentId

				--PROJECT AKA
				LEFT JOIN		dbo.Fn_AllTitleClearance( @ReportTypeId ) ppt							ON f.ProjectId = ppt.ProjectId
	
				--ARTISTS
				LEFT JOIN		dbo.ProdAgreementArtistSummary art WITH (NOLOCK)						ON f.AgreementId = art.ProdAgreementId 

				LEFT JOIN		dbo.Fn_AllYearlyCredit(	@ProdDocumentIdTbl, @ReportTypeId ) credits		ON f.DocumentId = credits.DocumentId 
				LEFT JOIN		dbo.Fn_AllAdditionalTerm( @ProdDocumentIdTbl , @ReportTypeId) at		ON f.DocumentId = at.DocumentId
				LEFT JOIN		dbo.Fn_DocumentContact(	@ProdDocumentIdTbl, @ReportTypeId ) ct			ON f.DocumentId = ct.DocumentId 
				LEFT JOIN		dbo.Fn_PilotScript(	@ProdDocumentIdTbl, @ReportTypeId ) zpp				ON f.DocumentId = zpp.DocumentId 
				LEFT JOIN		dbo.Fn_SeriesServices( @ProdDocumentIdTbl, @ReportTypeId ) zser			ON f.DocumentId = zser.DocumentId
				LEFT JOIN		dbo.Fn_SeriesRoyalty( @ProdDocumentIdTbl, @ReportTypeId ) rc			ON f.DocumentId = rc.DocumentId
				LEFT JOIN		dbo.Fn_Bonus( @ProdDocumentIdTbl, @ReportTypeId ) b						ON f.DocumentId = b.DocumentId
				LEFT JOIN		dbo.Fn_SigningBonus( @ProdDocumentIdTbl, @ReportTypeId ) ocb			ON f.DocumentId = ocb.DocumentId
				LEFT JOIN		dbo.Fn_Merchandising( @ProdDocumentIdTbl, @ReportTypeId ) merch			ON f.DocumentId = merch.DocumentId
				LEFT JOIN		dbo.Fn_BonusProduction( @ProdDocumentIdTbl, @ReportTypeId ) bp			ON f.DocumentId = bp.DocumentId 
				LEFT JOIN		dbo.Fn_SequelExpenses( @ProdDocumentIdTbl, @ReportTypeId ) sp			ON f.DocumentId = sp.DocumentId 
				LEFT JOIN		dbo.Fn_YearlyCredit( @ProdDocumentIdTbl , @ReportTypeId ) yc			ON f.DocumentId = yc.DocumentId 


				ORDER BY 
								f.ReportTypeName,
								art.ArtistNames,
								f.ProjectName,
								AgreementDate,
								f.AgreementId,
								f.DocumentTypeName,
								f.DocumentDate


 
 
END
GO

