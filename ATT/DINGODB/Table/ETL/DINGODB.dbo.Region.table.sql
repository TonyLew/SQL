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
// Module: dbo.Region
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of Regions
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.Region.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

/****** Object:  Table [dbo].[Region]    Script Date: 09/17/2013 08:27:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Region](
[RegionID] [int] IDENTITY(1,1) NOT NULL,
[Name] [varchar](50) NOT NULL,
[Description] [varchar](200) NULL,
[CreateDate] [datetime] NOT NULL,
[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
[RegionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UC_Region_Name] UNIQUE NONCLUSTERED 
(
[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'RegionID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the Region' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the Region' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Timestamps the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Timestamps the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[Region] ADD  CONSTRAINT [DF_Region_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[Region] ADD  CONSTRAINT [DF_Region_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

--------Truncate Table dbo.Region
--------DELETE dbo.Region 
--INSERT dbo.Region ( Name )
--SELECT x.[Name]
--FROM (
--SELECT 	'Region 1' AS [Name], 20 AS SortOrder UNION
--SELECT 	'Region 2' AS [Name], 30 AS SortOrder 
--) x
--Order by x.SortOrder
--select * from dbo.Region

