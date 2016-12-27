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
// Module:  dbo.Conflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Stores the conflicts of channels
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.Conflict.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[Conflict]
CREATE TABLE [dbo].[Conflict](
	[ConflictID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[IU_ID] [int] NOT NULL,
	[SPOT_ID] [int] NOT NULL,
	[Time] [datetime] NULL,
	[UTCTime] [datetime] NULL,
	[Asset_ID] [varchar](32) NULL,
	[Asset_Desc] [varchar](334) NULL,
	[Conflict_Code] [int] NULL,
	[Scheduled_Insertions] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL
)
ON [SDBPartitionKeyScheme](SDBSourceID);

GO

ALTER TABLE dbo.Conflict SET (LOCK_ESCALATION = AUTO )
GO

ALTER TABLE dbo.Conflict ADD CONSTRAINT [PK_Conflict] PRIMARY KEY CLUSTERED 
(
	[ConflictID] ASC, SDBSourceID ASC
)
WITH
(	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
	IGNORE_DUP_KEY = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
)
	 ON [SDBPartitionKeyScheme](SDBSourceID);
GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a conflict' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'ConflictID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB NodeID from which this rows data is derived' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot Insertion Unit identifer for this insertion.  Unique on a single instance of Spot at a given time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'IU_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot Insertion Event identifer for this insertion.  Unique on a single instance of Spot at a given time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'SPOT_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Time this insertion is scheduled' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'Time'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC Time this insertion is scheduled' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'UTCTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot identifier of the asset scheduled for insertion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'Asset_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot description of the asset scheduled for insertion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'Asset_Desc'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot conflict code for this insertion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'Conflict_Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[Conflict]  WITH CHECK ADD  CONSTRAINT [FK_Conflict_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY([SDBSourceID])
REFERENCES [dbo].[SDBSource] ([SDBSourceID])
GO

ALTER TABLE [dbo].[Conflict] CHECK CONSTRAINT [FK_Conflict_SDBSourceID_-->_SDBSource_SDBSourceID]
GO

ALTER TABLE [dbo].[Conflict] ADD  CONSTRAINT [DF_Conflict_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[Conflict] ADD  CONSTRAINT [DF_Conflict_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO



ALTER TABLE [dbo].[Conflict] ADD  CONSTRAINT [UNC_Conflict_SDBSourceID_IU_ID_SPOT_ID]  UNIQUE ( SDBSourceID,IU_ID,SPOT_ID )
GO


CREATE UNIQUE NONCLUSTERED INDEX UNC_Conflict_SDBSourceID_IU_ID_SPOT_ID_Asset_ID_i ON dbo.Conflict ( SDBSourceID,IU_ID,SPOT_ID,Asset_ID ) INCLUDE (UTCTime,Time,Asset_Desc,Conflict_Code,Scheduled_Insertions,CreateDate,UpdateDate)
ON [SDBPartitionKeyScheme](SDBSourceID)


--DROP INDEX dbo.Conflict.NC_Conflict_SDBSourceID_UTCTime_i 
CREATE NONCLUSTERED INDEX NC_Conflict_SDBSourceID_UTCTime_i ON dbo.Conflict ( SDBSourceID, UTCTime  ) 
INCLUDE ([IU_ID],[SPOT_ID],[Time],[Asset_ID],[Asset_Desc],[CreateDate],[UpdateDate],[Scheduled_Insertions])
ON [SDBPartitionKeyScheme](SDBSourceID)


--DROP INDEX dbo.Conflict.NC_Conflict_UTCTime_SDBSourceID_i 
CREATE NONCLUSTERED INDEX NC_Conflict_UTCTime_SDBSourceID_i ON dbo.Conflict ( UTCTime, SDBSourceID ) 
INCLUDE ([IU_ID],[SPOT_ID],[Time],[Asset_ID],[Asset_Desc],[CreateDate],[UpdateDate],[Scheduled_Insertions])
ON [SDBPartitionKeyScheme](SDBSourceID)

ALTER TABLE [dbo].[Conflict] ADD 	[UTCTime] [datetime] NULL
