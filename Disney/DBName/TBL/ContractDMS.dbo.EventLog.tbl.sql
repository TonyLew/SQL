

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
	--   Module:		dbo.EventLog
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
	--					FROM		dbo.EventLog WITH (NOLOCK)
	--					ORDER BY	EventLogId
	--

*/ 
-- =============================================




------------------------------------------------------------------------------------------
--CREATION of EventLog TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('EventLog', 'u') IS NULL )					
BEGIN


		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		--DROP TABLE dbo.EventLog
		CREATE TABLE dbo.EventLog
		(
			[EventLogId] [BIGINT] IDENTITY(1,1) NOT NULL CONSTRAINT PK_EventLog PRIMARY KEY,
			[Created] [DATETIME] NOT NULL CONSTRAINT [DF_EventLog_Created]  DEFAULT (GETDATE()),
			[Updated] [DATETIME] NULL,
			[EventLogTypeId] [UNIQUEIDENTIFIER] NOT NULL,
			[EventId] [UNIQUEIDENTIFIER] NOT NULL,
			[UserId] [UNIQUEIDENTIFIER] NULL
			--[Comment] [varchar](500) NULL
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		--ALTER TABLE  dbo.EventLog ADD CONSTRAINT DF_EventLog_EventLogId  DEFAULT NEWSEQUENTIALID() FOR EventLogId

		ALTER TABLE dbo.EventLog  WITH CHECK ADD  CONSTRAINT [FK_EventLog_EventId-->Event_EventId] FOREIGN KEY ( EventId )
		REFERENCES dbo.Event ( EventId )

		ALTER TABLE dbo.EventLog  WITH CHECK ADD  CONSTRAINT [FK_EventLog_EventLogTypeId-->EventLogType_EventLogTypeId] FOREIGN KEY ( EventLogTypeId )
		REFERENCES dbo.EventLogType ( EventLogTypeId )

		ALTER TABLE dbo.EventLog  WITH CHECK ADD  CONSTRAINT [FK_EventLog_UserId-->Users_UserId] FOREIGN KEY ( UserId )
		REFERENCES dbo.Users ( UserId )



		CREATE INDEX IX_EventLog_EventId_EventLogTypeId ON dbo.EventLog ( EventId,EventLogTypeId ) 

		CREATE INDEX IX_EventLog_EventLogTypeId_EventId ON dbo.EventLog ( EventLogTypeId,EventId ) 


END
GO




