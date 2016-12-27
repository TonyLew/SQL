

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
	--   Module:		dbo.EventLogType
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
	--					FROM		dbo.EventLogType WITH (NOLOCK)
	--					ORDER BY	EventLogTypeId
	--

*/ 
-- =============================================




------------------------------------------------------------------------------------------
--CREATION of EventLogType TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('EventLogType', 'u') IS NULL )					
BEGIN


		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON


		--DROP TABLE dbo.EventLogType
		CREATE TABLE dbo.EventLogType
		(
			[EventLogTypeId]	[UNIQUEIDENTIFIER] NOT NULL CONSTRAINT PK_EventLogType PRIMARY KEY,
			[EventTypeId]		[UNIQUEIDENTIFIER] NOT NULL,
			[Created]			[DATETIME] NOT NULL CONSTRAINT [DF_EventLogType_Created]  DEFAULT (GETDATE()),
			[Updated]			[DATETIME] NULL,
			[IsActive]			[BIT] NOT NULL CONSTRAINT [DF_EventLogType_IsActive]  DEFAULT (1),
			[Name]				[varchar] (200) NOT NULL,
			[AuditName]			[varchar] (200) NULL,
			[Description]		[varchar] (500) NULL,
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		ALTER TABLE  dbo.EventLogType ADD CONSTRAINT DF_EventLogType_EventLogTypeId  DEFAULT NEWSEQUENTIALID() FOR EventLogTypeId

		ALTER TABLE dbo.EventType  WITH CHECK ADD  CONSTRAINT [FK_EventType_EventTypeId-->EventType_EventTypeId] FOREIGN KEY ( EventTypeId )
		REFERENCES dbo.EventType ( EventTypeId )
		--ON UPDATE CASCADE
		--ON DELETE CASCADE

		CREATE UNIQUE NONCLUSTERED INDEX UX_EventLogType_Name_iIsActive ON dbo.EventLogType (Name) INCLUDE ( IsActive )

END


------------------------------------------------------------------------------------------
--POPULATION of EventLogType TABLE
------------------------------------------------------------------------------------------


IF ( OBJECT_ID('EventLogType', 'u') IS NOT NULL )					
BEGIN


		SET			NOCOUNT ON

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

		INSERT		dbo.EventLogType (Name,	AuditName, Description, EventTypeId )
		SELECT		x.Name,	x.AuditName, x.Description, x.EventTypeId
		FROM	(
					Select		SortOrder =	    1, Name = 'UnKnown', 											AuditName = '',						Description = 'Used to hold all unknown Types', EventTypeId = @EventTypeIDUniversal UNION
					Select		SortOrder =	    2, Name = 'Error', 												AuditName = '',						Description = 'Used to hold all Error Types', EventTypeId = @EventTypeIDUniversal UNION
					Select		SortOrder =	  102, Name = 'DR Canceled',										AuditName = '',						Description = 'DR Canceled', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  103, Name = 'DR Creation',										AuditName = '',						Description = 'DR Creation', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  104, Name = 'DR Delete', 											AuditName = '',						Description = 'DR Delete', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  105, Name = 'DR Delete Service', 									AuditName = '',						Description = 'DR Delete Service', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  106, Name = 'DR Update', 											AuditName = '',						Description = 'DR Update', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  107, Name = 'DR Update - DR Business Executive',					AuditName = '',						Description = 'DR Update - DR Business Executive', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  108, Name = 'DR Update - DR Creative Executive',					AuditName = '',						Description = 'DR Update - DR Creative Executive', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  109, Name = 'DR Update - DR Service', 							AuditName = '',						Description = 'DR Update - DR Service', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  110, Name = 'DR Update - DR Service Writing Step',				AuditName = '',						Description = 'DR Update - DR Service Writing Step', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  111, Name = 'DR Update - Talent', 								AuditName = '',						Description = 'DR Update - Talent', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  113, Name = 'DR Update - Contact', 								AuditName = '',						Description = 'DR Update - Contact', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  114, Name = 'DR Update - BA Assigned',							AuditName = '',						Description = 'DR Update - BA Assigned', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  115, Name = 'DR Update - CA Assigned',							AuditName = '',						Description = 'DR Update - CA Assigned', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  116, Name = 'DR Update - FA Assigned',							AuditName = '',						Description = 'DR Update - FA Assigned', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  117, Name = 'DR Update - BA and CA Assigned', 					AuditName = '',						Description = 'DR Update - BA and CA Assigned', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  118, Name = 'DR Update - BA',										AuditName = '',						Description = 'DR Update - BA', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  119, Name = 'DR Update - CA',										AuditName = '',						Description = 'DR Update - CA', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  120, Name = 'DR Update - ProjectId Creation', 					AuditName = '',						Description = 'DR Update - ProjectId Creation', EventTypeId = @EventTypeIDDR UNION

					--			DR/DMS Logging
					Select		SortOrder =	  121, Name = 'DR Update - AttachmentId Creation', 					AuditName = '',						Description = ' - Created AttachmentId', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  122, Name = 'DR Update - AgreementId Creation', 					AuditName = '',						Description = ' - Created AgreementId[s]', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  123, Name = 'DR Update - ProdAgreementId Creation',				AuditName = '',						Description = ' - Created ProdAgreementId[s]', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  125, Name = 'DR Update - DocumentId Creation',					AuditName = '',						Description = ' - Created DocumentId[s]', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  126, Name = 'DR Update - AttachmentId Deletion', 					AuditName = '',						Description = ' - Deleted AttachmentId', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  127, Name = 'DMS Update - DMS ArtistId Upsert',					AuditName = '',						Description = ' - Inserted/updated  ArtistId', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  128, Name = 'DMS Update - DMS ContactId Upsert',					AuditName = '',						Description = ' - Inserted/updated ContactId', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  129, Name = 'DR Archived', 										AuditName = '',						Description = ' - Archived creative executive deal request document.', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  130, Name = 'DMS Executive',										AuditName = '',						Description = ' - Added/Updated Executive', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  131, Name = 'DMS Project Attachment',								AuditName = '',						Description = ' - Added Attachments to Project ', EventTypeId = @EventTypeIDDRService UNION

					--			DR Status logging
					Select		SortOrder =	  132, Name = 'DR Submit', 											AuditName = '',						Description = ' - Upgraded DR to Submitted', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  133, Name = 'DR Review Complete', 								AuditName = '',						Description = ' - Upgraded DR to Review Complete', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  134, Name = 'DR Final Approval', 									AuditName = '',						Description = ' - Upgraded DR to Final Approval', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  135, Name = 'DR Withdrawn', 										AuditName = '',						Description = ' - Updated DR to Withdrawn', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  136, Name = 'DR Financial Pending Review', 						AuditName = '',						Description = ' - Upgraded DR to Financial Pending Review', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  137, Name = 'DR Financial Final Approval', 						AuditName = '',						Description = ' - Upgraded DR to Financial Final Approval', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  138, Name = 'DR Financial Rejection',								AuditName = '',						Description = ' - Updated DR to Rejection', EventTypeId = @EventTypeIDDR UNION

					--			DR Service Status logging
					Select		SortOrder =	  139, Name = 'DR Save Email Message',								AuditName = '',						Description = ' - Email Message saved.', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  140, Name = 'DR Service Creation',								AuditName = '',						Description = ' - Creation of DR service.', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  141, Name = 'DR Service Contract Admin Pending',					AuditName = '',						Description = ' - Updated DR Service Contract Admin to Pending.', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  142, Name = 'DR Service Contract Admin Completed',				AuditName = '',						Description = ' - Updated DR Service Contract Admin From Pending DR to Completed.', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  143, Name = 'DR Service Unassigned',								AuditName = '',						Description = ' - Upgraded DR service to Unassigned', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  144, Name = 'DR Service Assigned',								AuditName = '',						Description = ' - Upgraded DR service to Assigned', EventTypeId = @EventTypeIDDRService UNION
					Select		SortOrder =	  145, Name = 'DR Service Request Complete',						AuditName = '',						Description = ' - Upgraded DR service to Request Complete', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  146, Name = 'DR Service Assemble Complete',						AuditName = '',						Description = ' - Upgraded DR service to Assemble Complete', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  147, Name = 'DR Service Negotiate Complete',						AuditName = '',						Description = ' - Upgraded DR service to Negotiate Complete', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  148, Name = 'DR Service Execute Complete',						AuditName = '',						Description = ' - Upgraded DR service to Execute Complete', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  149, Name = 'DR Service Manage Complete',							AuditName = '',						Description = ' - Upgraded DR service to Manage Complete', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  150, Name = 'DR Service Review Complete',							AuditName = '',						Description = ' - Upgraded DR service to Review Complete', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  151, Name = 'DR Service Final Approval',							AuditName = '',						Description = ' - Upgraded DR service to Final Approval', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  152, Name = 'DR Upsert to DMS',									AuditName = '',						Description = ' - Integrate DR to DMS system.', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  153, Name = 'DR Service Upsert to DMS',							AuditName = '',						Description = ' - Integrate DR Service to DMS system.', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  154, Name = 'DR Service Legal Affairs Assignment',				AuditName = '',						Description = ' - Legal Affairs Assignment.', EventTypeId = @EventTypeIDSelectica UNION

					--			Financial View
					Select		SortOrder =	  200, Name = 'DMS Financial Grid Upsert',							AuditName = '',						Description = ' - Add or Update to FinancialGrid.', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  201, Name = 'DMS Financial Grid Delete',							AuditName = '',						Description = ' - Delete line item from FinancialGrid.', EventTypeId = @EventTypeIDSelectica UNION

					--			Selectica JSON logging
					Select		SortOrder =	  300, Name = 'DMS Document Additional Term',						AuditName = '',						Description = ' - Add or Update additional term to document.', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  301, Name = 'DMS Document Credit Approval',						AuditName = '',						Description = ' - Add or Update credit approval to document.', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  302, Name = 'DMS Project',										AuditName = '',						Description = ' - Add or Update project.', EventTypeId = @EventTypeIDDR UNION
					Select		SortOrder =	  303, Name = 'DMS Production Document',							AuditName = '',						Description = ' - Add or Update production document.', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  304, Name = 'DR Service Update - DR Service Writing Step JSON',	AuditName = '',						Description = ' - Updated DRService - DR Service Writing Step JSON', EventTypeId = @EventTypeIDDRService UNION

					--			Selectica Conflict logging
					Select		SortOrder =	  305, Name = 'Selectica Conflict Update Status To Pending',		AuditName = '',						Description = ' - Update Status To Pending.', EventTypeId = @EventTypeIDSelectica UNION
					Select		SortOrder =	  306, Name = 'Selectica Conflict Update Status To Resolved',		AuditName = '',						Description = ' - Update Status To Resolved.', EventTypeId = @EventTypeIDSelectica 

				) x
		LEFT JOIN	dbo.EventLogType y ON x.Name = y.Name
		WHERE		y.EventLogTypeId IS NULL
		ORDER BY	x.SortOrder



END
GO


