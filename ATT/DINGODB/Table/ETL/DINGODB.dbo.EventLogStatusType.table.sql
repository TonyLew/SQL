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
// Module: dbo.EventLogStatusType
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of event categories
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.EventLogStatusType.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

/****** Object:  Table [dbo].[EventLogStatusType]    Script Date: 09/25/2013 10:46:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[EventLogStatusType](
	[EventLogStatusTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EventLogStatusType] PRIMARY KEY CLUSTERED 
(
	[EventLogStatusTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'EventLogStatusTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of status type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[EventLogStatusType] ADD  CONSTRAINT [DF_EventLogStatusType_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[EventLogStatusType] ADD  CONSTRAINT [DF_EventLogStatusType_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO




INSERT dbo.EventLogStatusType ( Description )
SELECT x.[Description]
FROM (
SELECT 	'Universal' AS [Description], 1 AS SortOrder UNION
SELECT 	'ETL Job: SDB Execute Job' AS [Description], 2 AS SortOrder UNION
SELECT 	'Maintenance Job: MDB Definition Table Update' AS [Description], 3 AS SortOrder UNION
SELECT 	'Maintenance Job: MDB Add SDB Node' AS [Description], 4 AS SortOrder UNION
SELECT 	'Maintenance Job: Update SDB Node' AS [Description], 5 AS SortOrder UNION
SELECT 	'Maintenance Job: Maintenance Tasks' AS [Description], 6 AS SortOrder
) x
LEFT JOIN dbo.EventLogStatusType y
ON x.Description = y.Description
where y.EventLogStatusTypeID IS NULL
Order by x.SortOrder
Select * from dbo.EventLogStatusType