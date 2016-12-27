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
// Module: dbo.ICProvider
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of IC Providers
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ICProvider.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

/****** Object:  Table [dbo].[ICProvider]    Script Date: 09/25/2013 10:51:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ICProvider](
	[ICProviderID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ICProvider] PRIMARY KEY CLUSTERED 
(
	[ICProviderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for an IC Provider' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Provider Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Provider Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[ICProvider] ADD  CONSTRAINT [DF_ICProvider_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ICProvider] ADD  CONSTRAINT [DF_ICProvider_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO


CREATE UNIQUE INDEX UNC_ICProvider_Name ON dbo.ICProvider ( Name )

------Truncate Table dbo.ICProvider
--------DELETE dbo.ICProvider 
--INSERT dbo.ICProvider ( Name, CreateDate, UpdateDate )
--SELECT x.[Name], GETUTCDATE() AS CreateDate, GETUTCDATE() AS UpdateDate
--FROM (
--SELECT 	'n/a' AS [Name], 1 AS SortOrder UNION
--SELECT 	'AT&T' AS [Name], 20 AS SortOrder UNION
--SELECT 	'Comcast' AS [Name], 30 AS SortOrder UNION
--SELECT 	'TWC' AS [Name], 40 AS SortOrder UNION
--SELECT 	'Charter' AS [Name], 50 AS SortOrder UNION
--SELECT 	'COX' AS [Name], 60 AS SortOrder UNION
--SELECT 	'Bright House' AS [Name], 70 AS SortOrder 
--) x
--left join dbo.ICProvider y
--ON x.Name = y.Name
--where y.ICProviderID IS NULL
--Order by x.SortOrder
--select * from dbo.ICProvider



