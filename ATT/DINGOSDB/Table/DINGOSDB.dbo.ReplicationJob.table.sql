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
// Module: dbo.ReplicationJob
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of ReplicationJobs
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.ReplicationJob.table.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//
*/ 

USE [DINGOSDB]
GO

/****** Object:  Table [dbo].[ReplicationJob]    Script Date: 09/25/2013 11:02:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[ReplicationJob]
CREATE TABLE [dbo].[ReplicationJob](
	[ReplicationJobID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSystemID] [int] NOT NULL,
	[JobServer] [varchar](200) NOT NULL,
	[ReplicationJobTypeID] [int] NOT NULL,
	[JobID] [uniqueidentifier] NULL,
	[JobName] [varchar](200) NULL,
	[JobEnabled] [bit] NULL,
	[JobExecutionStatus] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ReplicationJob] PRIMARY KEY CLUSTERED 
(
	[ReplicationJobID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for a ReplicationJob.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'ReplicationJobID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for an SDB system.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'SDBSystemID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of system where the job runs.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobServer'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Function of job used in the replication process.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'ReplicationJobTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sql Server assigned unique identifier for a job.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of job.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'State of job.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobEnabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Run state of job.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'JobExecutionStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJob', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[ReplicationJob] ADD  CONSTRAINT [DF_ReplicationJob_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ReplicationJob] ADD  CONSTRAINT [DF_ReplicationJob_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO


ALTER TABLE [dbo].[ReplicationJob]  WITH CHECK ADD  CONSTRAINT [FK_ReplicationJob_SDBSystemID_-->_SDBSystem_SDBSystemID] FOREIGN KEY([SDBSystemID])
REFERENCES [dbo].[SDBSystem] ([SDBSystemID])
GO


ALTER TABLE [dbo].[ReplicationJob]  WITH CHECK ADD  CONSTRAINT [FK_ReplicationJob_ReplicationJobTypeID_-->_ReplicationJobType_ReplicationJobTypeID] FOREIGN KEY([ReplicationJobTypeID])
REFERENCES [dbo].[ReplicationJobType] ([ReplicationJobTypeID])
GO


CREATE UNIQUE INDEX UNC_ReplicationJob_SDBSystemID_ReplicationJobTypeID ON dbo.ReplicationJob ( SDBSystemID, ReplicationJobTypeID )
GO




