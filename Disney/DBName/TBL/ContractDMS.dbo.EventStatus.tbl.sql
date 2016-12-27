

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
	--   Module:		dbo.EventStatus
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
	--					FROM		dbo.EventStatus WITH (NOLOCK)
	--					ORDER BY	EventStatusId
	--

*/ 
-- =============================================




------------------------------------------------------------------------------------------
--CREATION of EventStatus TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('EventStatus', 'u') IS NULL )					
BEGIN


		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON


		--DROP TABLE dbo.EventStatus
		CREATE TABLE dbo.EventStatus
		(
			[EventStatusId] [INT] NOT NULL IDENTITY(0,1) CONSTRAINT PK_EventStatus PRIMARY KEY,
			[EventStatusTypeId] [UNIQUEIDENTIFIER] NOT NULL,
			[EventTypeId] [UNIQUEIDENTIFIER] NOT NULL,
			[Created] [DATETIME] NOT NULL CONSTRAINT [DF_EventStatus_Created]  DEFAULT (GETDATE()),
			[Updated] [DATETIME] NULL,
			[Name] [varchar] (200) NOT NULL,
			[Description] [varchar] (500) NULL,
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		ALTER TABLE dbo.EventStatus  WITH CHECK ADD  CONSTRAINT [FK_EventStatus_EventTypeId-->EventType_EventTypeId] FOREIGN KEY ( EventTypeId )
		REFERENCES dbo.EventType ( EventTypeId )
		--ON UPDATE CASCADE
		--ON DELETE CASCADE

		ALTER TABLE dbo.EventStatus  WITH CHECK ADD  CONSTRAINT [FK_EventStatus_EventStatusTypeId-->EventStatusType_EventStatusTypeId] FOREIGN KEY ( EventStatusTypeId )
		REFERENCES dbo.EventStatusType ( EventStatusTypeId )
		--ON UPDATE CASCADE
		--ON DELETE CASCADE

		CREATE UNIQUE NONCLUSTERED INDEX UX_EventStatus_EventTypeId_Name ON dbo.EventStatus ( EventTypeId,Name ) 


END


------------------------------------------------------------------------------------------
--POPULATION of EventStatus TABLE
------------------------------------------------------------------------------------------


IF ( OBJECT_ID('EventStatus', 'u') IS NOT NULL )					
BEGIN

		SET			NOCOUNT ON
		DECLARE		@EventStatusTypeIDSuccess		UNIQUEIDENTIFIER
		DECLARE		@EventStatusTypeIDWarning		UNIQUEIDENTIFIER
		DECLARE		@EventStatusTypeIDError			UNIQUEIDENTIFIER
		Select		@EventStatusTypeIDSuccess		= EventStatusTypeId FROM dbo.EventStatusType WHERE Name = 'Success'
		Select		@EventStatusTypeIDWarning		= EventStatusTypeId FROM dbo.EventStatusType WHERE Name = 'Warning'
		Select		@EventStatusTypeIDError			= EventStatusTypeId FROM dbo.EventStatusType WHERE Name = 'Error'

		DECLARE		@EventTypeIDUniversal			UNIQUEIDENTIFIER
		DECLARE		@EventTypeIDDR					UNIQUEIDENTIFIER
		DECLARE		@EventTypeIDDRService			UNIQUEIDENTIFIER
		DECLARE		@EventTypeIDDMS					UNIQUEIDENTIFIER
		DECLARE		@EventTypeIDSelectica			UNIQUEIDENTIFIER

		Select		@EventTypeIDUniversal			= EventTypeId FROM dbo.EventType WHERE Name = 'Universal'
		Select		@EventTypeIDDR					= EventTypeId FROM dbo.EventType WHERE Name = 'DR'
		Select		@EventTypeIDDRService			= EventTypeId FROM dbo.EventType WHERE Name = 'DRService'
		Select		@EventTypeIDDMS					= EventTypeId FROM dbo.EventType WHERE Name = 'DMS'
		Select		@EventTypeIDSelectica			= EventTypeId FROM dbo.EventType WHERE Name = 'Selectica'

		----			Ensure that a 0 = Successful Status
		--Set			Identity_Insert dbo.EventStatus ON
		--Insert		dbo.EventStatus (EventStatusId, Name,	Description,  EventStatusTypeId, EventTypeId )
		--Select		x.EventStatusId, x.Name, x.Description, x. EventStatusTypeId, x.EventTypeId
		--From		(Select		EventStatusId = 0, Name = 'Success', Description = NULL, EventStatusTypeId = @EventStatusTypeIDSuccess, EventTypeId = @EventTypeIDUniversal) x
		--Left Join	dbo.EventStatus y WITH (NOLOCK)		ON x.Name = y.Name
		--Where		y.EventStatusId						IS NULL
		--Set			Identity_Insert dbo.EventStatus OFF

		INSERT		dbo.EventStatus ( Name,	Description, EventStatusTypeId, EventTypeId )
		SELECT		x.Name,	x.Description, x.EventStatusTypeId, x.EventTypeId
		FROM	(

					Select		SortOrder =   0,		Name = 'Success',										Description = NULL,																							EventStatusTypeId = @EventStatusTypeIDSuccess, EventTypeId = @EventTypeIDUniversal UNION 
					Select		SortOrder =   1,		Name = 'General Error',									Description = ' - Used to hold all general errors',															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDUniversal UNION 
					Select		SortOrder =	  2,		Name = 'No Changes',									Description = ' - No Changes have occured',																	EventStatusTypeId = @EventStatusTypeIDWarning, EventTypeId = @EventTypeIDUniversal UNION 
					Select		SortOrder =   3,		Name = 'Invalid DR EventId',							Description = ' - The Deal Request tracking number does not exist.',										EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 

					Select		SortOrder =   4,		Name = 'Invalid DRId',									Description = ' - The Deal Request does not exist.',														EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =   5,		Name = 'Invalid DRId State',							Description = ' - The Deal Request is in the wrong state to be changed.',									EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =   6,		Name = 'Invalid DRServiceId',							Description = ' - The Deal Request Service does not exist.',												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDRService UNION 
					Select		SortOrder =   7,		Name = 'Invalid DRServiceId State',						Description = ' - The Deal Request Service is in the wrong state to be changed.',							EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDRService UNION 
					Select		SortOrder =   8,		Name = 'Invalid DRService CA State',					Description = ' - The Deal Request Service contract admin state is in the wrong state to be changed.',		EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDRService UNION 
					Select		SortOrder =   9,		Name = 'Duplicate DR',									Description = ' - EDR already exists with same Title.', 													EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  10,		Name = 'Missing DR',									Description = ' - The DR was not found.', 																	EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  11,		Name = 'Duplicate DR Talent',							Description = ' - Duplicate DR Talent', 																	EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  12,		Name = 'Duplicate DR Contact',							Description = ' - Duplicate DR Contact', 																	EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION  
					Select		SortOrder =  13,		Name = 'Invalid DR Parameter',							Description = ' - Invalid DR Parameter', 																	EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  14,		Name = 'Invalid DR UserId',								Description = ' - The UserId does not exist or was not entered.', 											EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  15,		Name = 'Invalid DR Type Parameter',						Description = ' - The DRType does not exist or was not entered.', 											EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  16,		Name = 'Invalid DR BusinessExecutive',					Description = ' - The business executive[s] is not in Business Affairs OR Legal Affairs Dept.',				EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  17,		Name = 'Invalid DR LegalExecutive',						Description = ' - The legal executive[s] is not in Legal Affairs OR Legal Affairs Dept.',					EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  18,		Name = 'Invalid DR CreativeExecutive',					Description = ' - The creative executive[s] is not in the Creative Dept.',									EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  19,		Name = 'Invalid DR Service Writing Step Parameter',		Description = ' - The DR Service Writing Step does not exist', 												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  20,		Name = 'Invalid DR Service Parameter',					Description = ' - Invalid DR Service Parameter', 															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  21,		Name = 'Invalid DR Talent Parameter',					Description = ' - Invalid DR Talent Parameter', 															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  22,		Name = 'Invalid DR Contact Parameter',					Description = ' - Invalid DR Contact Parameter', 															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  23,		Name = 'Invalid DR Mapping Parameter',					Description = ' - Invalid DR Mapping Parameter', 															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =  24,		Name = 'Failure DR ProjectId',							Description = ' - Failed to create ProjectId.', 															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =  25,		Name = 'Failure DR ProjectName',						Description = ' - ProjectName already exists.', 															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =  26,		Name = 'Missing DR ProjectId',							Description = ' - The ProjectId is non existent.', 															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  27,		Name = 'Missing DR Agreement Information',				Description = ' - The Agreement Information is incomplete.', 												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  28,		Name = 'Missing DR Document Information',				Description = ' - The Document Information is incomplete.', 												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  29,		Name = 'Unmapped DR Service',							Description = ' - The mapping of the deal request service to a DMS service does not exist.', 				EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  30,		Name = 'Invalid DR Business Analyst',					Description = ' - The Business Analyst does not exist or was not entered.', 								EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  31,		Name = 'Invalid DR Financial Analyst',					Description = ' - The Financial Analyst does not exist or was not entered.', 								EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  32,		Name = 'Unsuccessful DR Business Analyst email',		Description = ' - An unknown error occurred while emailing the Business Analyst.', 							EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  32,		Name = 'Invalid DR Email Template',						Description = ' - The Email Template associated with this function was not found.', 						EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  33,		Name = 'Failed DR BA Email',							Description = ' - The Email to notify the BA of assignment failed.', 										EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  33,		Name = 'Failed DR CA Email',							Description = ' - The Email to notify the CA of assignment failed.', 										EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  34,		Name = 'Failed DR CA Email MailItemId',					Description = ' - The MailItemId used to notify the CA of availability failed to update.', 					EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =  35,		Name = 'Failed DR BA Email MailItemId',					Description = ' - The MailItemId used to notify the BA of assignment failed to update to DR table.', 		EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =  36,		Name = 'Failed DR Service Submission',					Description = ' - There are no services related to this DRId.', 											EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =  37,		Name = 'Failed DR Service Status demotion',				Description = ' - Cannot demote a Deal Request Service status.', 											EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION

					Select		SortOrder =  38,		Name = 'Failed DR Service Agreement creation',			Description = ' - Failure to create a Deal Request Service agreement.', 									EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =  39,		Name = 'Failed DR Service Document creation',			Description = ' - Failure to create a Deal Request Service document.', 										EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION

					Select		SortOrder =  40,		Name = 'Failed DMS Artist Creation',					Description = ' - The DMS Artist name already exists and could not be created.', 							EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  41,		Name = 'Failed DMS Contact Creation',					Description = ' - The DMS Contact name could not be created.', 												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  42,		Name = 'Failed DR Archive',								Description = ' - The Deal Request has already been archived.', 											EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  43,		Name = 'Failed DR Finalization Service',				Description = ' - The Deal Request failed to finalize because not all services have been finalized.', 		EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  44,		Name = 'Missing DRService DocumentId',					Description = ' - There were no Deal Request Services associated with this DocumentId.', 					EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  45,		Name = 'Artist Conflict',								Description = ' - There were one or more artists that need to be reviewed.', 								EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  46,		Name = 'Contact Conflict',								Description = ' - There were one or more contacts that need to be reviewed.', 								EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  47,		Name = 'Invalid Artist JSON',							Description = ' - There were one or more artists that needs to be reviewed.', 								EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  48,		Name = 'Invalid Contact JSON',							Description = ' - There were one or more contacts that needs to be reviewed.', 								EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  49,		Name = 'Missing Document ArtistIds',					Description = ' - There were no ArtistId[s] found.', 														EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  50,		Name = 'Missing Document ContactIds',					Description = ' - There were no ContactId[s] found.', 														EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  51,		Name = 'Term Type Conflict',							Description = ' - There is an error with the additional term.',												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  52,		Name = 'Invalid ProjectId',								Description = ' - A ProjectId value was not sent or already exists in Project table.',						EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  53,		Name = 'Invalid EngagingEntityId',						Description = ' - Unknown key value supplied.',																EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION 
					Select		SortOrder =  54,		Name = 'Invalid DocumentTypeId',						Description = ' - Unknown key value supplied.',																EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION 
					Select		SortOrder =  55,		Name = 'Incomplete OtherCompensation values',			Description = ' - Some mandatory values were not provided.',												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =  56,		Name = 'Invalid CompTypeId',							Description = ' - Unknown key value supplied.',																EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDSelectica UNION 
					Select		SortOrder =  57,		Name = 'Invalid OtherCompensationOtherAmountTypeId',	Description = ' - Unknown key value supplied.',																EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =  58,		Name = 'Invalid SideLetterTypeId',						Description = ' - Unknown key value supplied.',																EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =  59,		Name = 'Invalid RoyaltyConditionTypeId',				Description = ' - Unknown key value supplied.',																EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =  60,		Name = 'Invalid BonusTypeId',							Description = ' - Unknown key value supplied.',																EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =  61,		Name = 'Invalid MerchandisingTypeId',					Description = ' - Unknown key value supplied.',																EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =  62,		Name = 'Invalid DR CreativeExecutive State',			Description = ' - The must be at least ONE CreativeExecutive assigned to a DR.',							EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  63,		Name = 'Invalid DR CreativeExecutive JSON',				Description = ' - The JSON string containing the creative executive information cannot be parsed.',			EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  64,		Name = 'Invalid DR WritingStep JSON',					Description = ' - The JSON string containing the writing step information cannot be parsed.',				EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  65,		Name = 'Invalid Email Message Type',					Description = ' - The Email Message Type does not exist.',													EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  66,		Name = 'Invalid Attachment Type',						Description = ' - The Attachment Type does not exist.',														EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  67,		Name = 'Duplicate DMS Executive Name',					Description = ' - Cannot insert or update executive due to an existing executive name.', 					EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  68,		Name = 'Invalid Financial Grid Type',					Description = ' - The Financial Grid Type does not exist.',													EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  69,		Name = 'Invalid Financial Grid Document',				Description = ' - The DocumentId does not exist.',															EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  69,		Name = 'Invalid Financial Grid Step',					Description = ' - The Financial Grid Step must NOT be blank.',												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  70,		Name = 'Invalid Financial Grid Writing Step',			Description = ' - The Financial Grid Writing Step is invalid.',												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  71,		Name = 'Invalid EventId',								Description = ' - The event tracking number does not exist or could not be created.',						EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDR UNION 
					Select		SortOrder =  72,		Name = 'Invalid Financial Grid Item',					Description = ' - The Financial Grid line item does not exist.',											EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					Select		SortOrder =  73,		Name = 'Invalid DR Service Executive Assignment',		Description = ' - The Executive user for business affairs nor legal affairs does not exist or both have been passed.',	EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION

					SELECT		SortOrder =	 502,		Name = 'Contact Name Empty',									Description	= ' - One or more contacts has an empty comtact name.',									EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 503,		Name = 'Contact Name Changed',									Description	= ' - One or more contacts has a comtact name change request.',							EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 504,		Name = 'Contact Id Not Found',									Description	= ' - One or more contacts has an Id that does not exist in DMS.',						EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 505,		Name = 'Contact Name Exists',									Description	= ' - One or more contacts to be added has a name that does not exist in DMS.',			EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 506,		Name = 'Artist Name Empty',										Description	= ' - One or more artists has an empty artist name.',									EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 507,		Name = 'Artist Name Changed',									Description	= ' - One or more artists has an artist name change request.',							EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 508,		Name = 'Artist Id Not Found',									Description	= ' - One or more artists has an Id that does not exist in DMS.',						EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 509,		Name = 'Artist Name Exists',									Description	= ' - One or more artists to be added has a name that already exists in DMS.',			EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 510,		Name = 'Artist Id Invalid',										Description	= ' - One or more artists has an empty GUID that cannot be used.',						EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 511,		Name = 'Contact Id Invalid',									Description	= ' - One or more contacts has an empty GUID that cannot be used.',						EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 512,		Name = 'Additional Service Term Type',							Description	= ' - The term type for the additional term is not a valid term type in DMS.',			EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 513,		Name = 'EngagingEntity EngagingEntityId',						Description	= ' - Invalid EngagingEntityId value.',													EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 514,		Name = 'DocumentType DocumentTypeId',							Description	= ' - Invalid DocumentTypeId value.',													EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 515,		Name = 'OtherCompensation Values',								Description	= ' - Incomplete OtherCompensation values.',											EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 516,		Name = 'OtherCompensation CompTypeId',							Description	= ' - Invalid CompTypeId value.',														EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 517,		Name = 'OtherCompensation OtherCompensationOtherAmountTypeId',	Description	= ' - Invalid OtherCompensationOtherAmountTypeId value.',								EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 518,		Name = 'SideLetter SideLetterTypeId',							Description	= ' - Invalid SideLetterTypeId value.',													EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 519,		Name = 'RoyaltyCondition RoyaltyConditionTypeId',				Description	= ' - Invalid RoyaltyConditionTypeId value.',											EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 520,		Name = 'Bonus BonusTypeId',										Description	= ' - Invalid BonusTypeId value.',														EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 521,		Name = 'Merchandising MerchandisingTypeId',						Description	= ' - Invalid MerchandisingTypeId value.',												EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS UNION
					SELECT		SortOrder =	 522,		Name = 'CreativeExecutive ExecutiveId',							Description	= ' - Invalid Creative Executive.',														EventStatusTypeId = @EventStatusTypeIDError, EventTypeId = @EventTypeIDDMS 



				)	x
		LEFT JOIN	dbo.EventStatus y WITH (NOLOCK)		ON x.Name = y.Name
														AND x.EventTypeId = y.EventTypeId
		WHERE		y.EventStatusId						IS NULL
		ORDER BY	x.SortOrder 


END
GO


