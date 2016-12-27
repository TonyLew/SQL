/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module: dbo.SDBSystem
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of SDBSystems
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.SDBSystem.table.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//
*/ 

USE [DINGOSDB]
GO

/****** Object:  Table [dbo].[SDBSystem]    Script Date: 09/25/2013 11:02:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[SDBSystem]
CREATE TABLE [dbo].[SDBSystem](
	[SDBSystemID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBSourceSystemID] [int] NOT NULL,
	[SDBSourceName] [varchar](50) NOT NULL,
	[SDBSourceSystemName] [varchar](50) NOT NULL,
	[SDBState] [int] NOT NULL,
	[Role] [int] NOT NULL,
	[MPEGDBName] [varchar](50) NOT NULL,
	[DBExistence] [bit] NOT NULL,
	[IEExistence] [bit] NOT NULL,
	[Subscribed] [bit] NOT NULL,
	[SubscriptionType] [varchar](10) NULL,
	[Description] [varchar](200) NULL,
	[Enabled] bit NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SDBSystem] PRIMARY KEY CLUSTERED 
(
	[SDBSystemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for a SDBSystem' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSystemID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDBSourceID from DINGOSDB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDBSourceSystemID from DINGOSDB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceSystemID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB Logical Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB Physical Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceSystemName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Determines if logical SDB node is using Primary = 1 or Backup = 5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SDBState'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Determines if system is Primary = 1 or Backup = 2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'Role'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MPEG database name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'MPEGDBName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Flag used to determine if the MPEG database has been created.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'DBExistence'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to determine if MPEG.dbo.IE table exists.  This should not exist for stand by SDB systems.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'IEExistence'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Flag to indicate whether a subscription job exists.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'Subscribed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of subscription (0 = push or 1 = pull)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'SubscriptionType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of replication job' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'JobID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of replication job (either push or pull)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'JobName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Replication job status (enabled or disabled)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'JobEnabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description for a SDBSystem' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manual setting for availability of a SDBSystem' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'Enabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSystem', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_Enabled]  DEFAULT (1) FOR [Enabled]
GO

ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_DBExistence]  DEFAULT (0) FOR [DBExistence]
GO

ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_IEExistence]  DEFAULT (0) FOR [IEExistence]
GO

ALTER TABLE [dbo].[SDBSystem] ADD  CONSTRAINT [DF_SDBSystem_Subscribed]  DEFAULT (0) FOR [Subscribed]
GO

CREATE UNIQUE INDEX UNC_SDBSystem_SDBSourceSystemID ON dbo.SDBSystem ( SDBSourceSystemID )
GO


CREATE UNIQUE INDEX UNC_SDBSystem_SDBSourceSystemName ON dbo.SDBSystem ( SDBSourceSystemName )
GO




