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
// Module:  dbo.CacheStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Stores the cache timestamp for each type of cache and for each SDB
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CacheStatus.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[CacheStatus]
CREATE TABLE [dbo].[CacheStatus](
	[CacheStatusID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[CacheStatusTypeID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL
)
ON [SDBPartitionKeyScheme](SDBSourceID);

GO

ALTER TABLE dbo.CacheStatus SET (LOCK_ESCALATION = AUTO )
GO

ALTER TABLE dbo.CacheStatus ADD CONSTRAINT [PK_CacheStatus] PRIMARY KEY CLUSTERED 
(
	[CacheStatusID] ASC, SDBSourceID ASC
)
WITH
(	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
	IGNORE_DUP_KEY = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
)
	 ON [SDBPartitionKeyScheme](SDBSourceID);
GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'CacheStatusID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Node or SDB associated with this cachestatus entry' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Two types of data cached: Channel and Conflict' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'CacheStatusTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[CacheStatus]  WITH CHECK ADD  CONSTRAINT [FK_CacheStatus_CacheStatusTypeID_-->_CacheStatusType_CacheStatusTypeID] FOREIGN KEY([CacheStatusTypeID])
REFERENCES [dbo].[CacheStatusType] ([CacheStatusTypeID])
GO

ALTER TABLE [dbo].[CacheStatus] CHECK CONSTRAINT [FK_CacheStatus_CacheStatusTypeID_-->_CacheStatusType_CacheStatusTypeID]
GO

ALTER TABLE [dbo].[CacheStatus]  WITH CHECK ADD  CONSTRAINT [FK_CacheStatus_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY([SDBSourceID])
REFERENCES [dbo].[SDBSource] ([SDBSourceID])
GO

ALTER TABLE [dbo].[CacheStatus] CHECK CONSTRAINT [FK_CacheStatus_SDBSourceID_-->_SDBSource_SDBSourceID]
GO

ALTER TABLE [dbo].[CacheStatus] ADD  CONSTRAINT [DF_CacheStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[CacheStatus] ADD  CONSTRAINT [DF_CacheStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

--DROP INDEX dbo.CacheStatus.NC_CacheStatus_SDBSourceID_CacheStatusTypeID_iUpdateDate
CREATE NONCLUSTERED INDEX NC_CacheStatus_SDBSourceID_CacheStatusTypeID_iUpdateDate ON dbo.CacheStatus ( SDBSourceID,CacheStatusTypeID ) INCLUDE ( UpdateDate )
ON [SDBPartitionKeyScheme](SDBSourceID)
GO
