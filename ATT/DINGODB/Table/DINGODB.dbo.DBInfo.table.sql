USE [DINGODB]
GO

/****** Object:  Table [dbo].[DBInfo]    Script Date: 11/8/2013 12:19:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DBInfo](
	[DBInfoID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DBInfo] PRIMARY KEY CLUSTERED 
(
	[DBInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[DBInfo] ADD  CONSTRAINT [DF_DBInfo_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[DBInfo] ADD  CONSTRAINT [DF_DBInfo_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB DBInfo identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'DBInfoID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual DBInfo Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual DBInfo Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO



--Change	DBInfo
Insert		dbo.DBInfo ( Name, Description )
Select		'Version' AS Name, '2.0.0' AS Description
GO

