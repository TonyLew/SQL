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
// Module: dbo.ROC
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of ROCs
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ROC.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

CREATE TABLE [dbo].[ROC](
	[ROCID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ROC] PRIMARY KEY CLUSTERED 
(
	[ROCID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB ROC identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'ROCID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual ROC Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual ROC Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

CREATE UNIQUE INDEX UNC_ROC_Name ON dbo.ROC ( Name )
GO

ALTER TABLE [dbo].[ROC] ADD  CONSTRAINT [DF_ROC_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ROC] ADD  CONSTRAINT [DF_ROC_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO


------Truncate Table dbo.ROC
------DELETE dbo.ROC 
--INSERT dbo.ROC ( Name, CreateDate, UpdateDate )
--SELECT x.[Name], GETUTCDATE() AS CreateDate, GETUTCDATE() AS UpdateDate
--FROM (
--SELECT 	'n/a' AS [Name], 1 AS SortOrder UNION
--SELECT 	'AT&T' AS [Name], 20 AS SortOrder UNION
--SELECT 	'BH' AS [Name], 20 AS SortOrder UNION
--SELECT 	'CC' AS [Name], 20 AS SortOrder UNION
--SELECT 	'Charter' AS [Name], 20 AS SortOrder UNION
--SELECT 	'Cox' AS [Name], 20 AS SortOrder UNION
--SELECT 	'TWC (D)' AS [Name], 20 AS SortOrder UNION
--SELECT 	'TWC (L)' AS [Name], 20 AS SortOrder UNION
--SELECT 	'TWC (M)' AS [Name], 20 AS SortOrder UNION
--SELECT 	'TWC (R)' AS [Name], 20 AS SortOrder 
--) x
--left join dbo.ROC y
--ON x.Name = y.Name
--where y.ROCID IS NULL
--Order by x.SortOrder, x.Name
--select * from dbo.ROC


