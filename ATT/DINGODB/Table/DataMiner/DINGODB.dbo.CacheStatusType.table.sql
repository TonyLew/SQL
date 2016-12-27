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
// Module:  dbo.CacheStatusType
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Stores the types of cache status
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CacheStatusType.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO


CREATE TABLE [dbo].[CacheStatusType](
	[CacheStatusTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](32) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_CacheStatusType] PRIMARY KEY CLUSTERED 
(
	[CacheStatusTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatusType', @level2type=N'COLUMN',@level2name=N'CacheStatusTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The description of the cache status type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatusType', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatusType', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatusType', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[CacheStatusType] ADD  CONSTRAINT [DF_CacheStatusType_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[CacheStatusType] ADD  CONSTRAINT [DF_CacheStatusType_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

Insert dbo.CacheStatusType (Description)
select x.Description
from (
SELECT	1 AS ID,	'Channel Status' AS Description, 1 as sortorder UNION ALL
SELECT	2 AS ID,	'Media Status' AS Description , 2 as sortorder
) x
Order by x.sortorder