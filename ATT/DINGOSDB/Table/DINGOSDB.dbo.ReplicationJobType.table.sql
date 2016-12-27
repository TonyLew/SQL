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
// Module: dbo.ReplicationJobType
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of event categories
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.ReplicationJobType.table.sql 3185 2013-11-25 19:43:45Z tlew $
//    
//
*/ 

USE [DINGOSDB]
GO

/****** Object:  Table [dbo].[ReplicationJobType]    Script Date: 09/25/2013 10:46:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ReplicationJobType](
	[ReplicationJobTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ReplicationJobType] PRIMARY KEY CLUSTERED 
(
	[ReplicationJobTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJobType', @level2type=N'COLUMN',@level2name=N'ReplicationJobTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of replication job type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJobType', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJobType', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationJobType', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[ReplicationJobType] ADD  CONSTRAINT [DF_ReplicationJobType_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ReplicationJobType] ADD  CONSTRAINT [DF_ReplicationJobType_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO




INSERT dbo.ReplicationJobType ( Description )
SELECT x.[Description]
FROM (
SELECT 	'Universal' AS [Description], 1 AS SortOrder UNION
SELECT 	'Push Distribution Agent' AS [Description], 2 AS SortOrder UNION
SELECT 	'Pull Distribution Agent' AS [Description], 3 AS SortOrder UNION
SELECT 	'Log Reader Agent' AS [Description], 4 AS SortOrder UNION
SELECT 	'Snapshot Agent' AS [Description], 5 AS SortOrder UNION
SELECT 	'Publication Agent' AS [Description], 6 AS SortOrder UNION
SELECT 	'Distribution Agent' AS [Description], 7 AS SortOrder UNION
SELECT 	'Queue Reader Agent' AS [Description], 8 AS SortOrder UNION
SELECT 	'Maintenance Agent' AS [Description], 9 AS SortOrder
) x
LEFT JOIN dbo.ReplicationJobType y
ON x.Description = y.Description
where y.ReplicationJobTypeID IS NULL
Order by x.SortOrder
Select * from dbo.ReplicationJobType