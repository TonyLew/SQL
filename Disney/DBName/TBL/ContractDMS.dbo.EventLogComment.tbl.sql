
------------------------------------------------------------------------------------------
--CREATION of EventLogComment TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('EventLogComment', 'u') IS NULL )					
BEGIN


		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		--DROP TABLE dbo.EventLogComment
		CREATE TABLE dbo.EventLogComment
		(
			[EventLogCommentId] [BIGINT] IDENTITY(1,1) NOT NULL CONSTRAINT PK_EventLogComment PRIMARY KEY,
			[Created] [DATETIME] NOT NULL CONSTRAINT [DF_EventLogComment_Created]  DEFAULT (GETDATE()),
			[EventLogId] [BIGINT] NOT NULL,
			[Comment] [varchar](MAX) NOT NULL
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		ALTER TABLE dbo.EventLogComment  WITH CHECK ADD  CONSTRAINT [FK_EventLogComment_EventLogId-->EventLog_EventLogId] FOREIGN KEY ( EventLogId )
		REFERENCES dbo.EventLog ( EventLogId )

		CREATE UNIQUE INDEX UX_EventLogComment_EventLogCommentTypeId_EventId ON dbo.EventLogComment ( EventLogId ) 


END
GO




