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
// Module:  dbo.SDB_IESPOT
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Stores the Seachange mpeg.dbo.IE and mpeg.dbo.SPOT table join and identified by SDB
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SDB_IESPOT.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[SDB_IESPOT]
CREATE TABLE [dbo].[SDB_IESPOT](
	[SDB_IESPOTID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SPOT_ID] [int] NOT NULL,
	[IE_ID] [int] NOT NULL,
	[IU_ID] [int] NULL,
	[SCHED_DATE] [date] NULL,
	[SCHED_DATE_TIME] [datetime] NULL,
	[UTC_SCHED_DATE] [date] NULL,
	[UTC_SCHED_DATE_TIME] [datetime] NULL,
	[IE_NSTATUS] [int] NULL,
	[IE_CONFLICT_STATUS] [int] NULL,
	[SPOTS] [int] NULL,
	[IE_DURATION] [int] NULL,
	[IE_RUN_DATE_TIME] [datetime] NULL,
	[UTC_IE_RUN_DATE_TIME] [datetime] NULL,
	[BREAK_INWIN] [int] NULL,
	[AWIN_START_DT] [datetime] NULL,
	[AWIN_END_DT] [datetime] NULL,
	[UTC_AWIN_START_DT] [datetime] NULL,
	[UTC_AWIN_END_DT] [datetime] NULL,
	[IE_SOURCE_ID] [int] NULL,
	----------------------
	[VIDEO_ID] [varchar](32) NULL,  --Asset_ID
	[ASSET_DESC] [varchar](334) NULL,
	[SPOT_DURATION] [int] NULL,
	[SPOT_NSTATUS] [int] NULL,
	[SPOT_CONFLICT_STATUS] [int] NULL,
	[SPOT_ORDER] [int] NULL,
	[SPOT_RUN_DATE] [date] NULL,
	[SPOT_RUN_DATE_TIME] [datetime] NULL,
	[UTC_SPOT_RUN_DATE] [date] NULL,
	[UTC_SPOT_RUN_DATE_TIME] [datetime] NULL,

	[UTC_SPOT_NSTATUS_UPDATE_TIME] [datetime] NULL,
	[UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME] [datetime] NULL,
	[UTC_IE_NSTATUS_UPDATE_TIME] [datetime] NULL,
	[UTC_IE_CONFLICT_STATUS_UPDATE_TIME] [datetime] NULL,

	[RUN_LENGTH] [int] NULL,
	[SPOT_SOURCE_ID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL
)
ON [SDBPartitionKeyScheme](SDBSourceID);

GO

ALTER TABLE dbo.SDB_IESPOT SET (LOCK_ESCALATION = AUTO )
GO

ALTER TABLE dbo.SDB_IESPOT ADD CONSTRAINT [PK_SDB_IESPOT] PRIMARY KEY CLUSTERED 
(
	SDB_IESPOTID ASC, SDBSourceID ASC
)
WITH
(	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
	IGNORE_DUP_KEY = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
)
	 ON [SDBPartitionKeyScheme](SDBSourceID);
GO




EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The auto generated unique identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'SDB_IESPOTID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The DINGODB SDB unique identifier that is system generated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time the SPOT_NSTATUS was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UTC_SPOT_NSTATUS_UPDATE_TIME'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time the SPOT_CONFLICT_STATUS was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time the IE_NSTATUS was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UTC_IE_NSTATUS_UPDATE_TIME'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time the IE_CONFLICT_STATUS was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UTC_IE_CONFLICT_STATUS_UPDATE_TIME'
GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


--DROP INDEX dbo.SDB_IESPOT.UNC_SDB_IESPOT_IE_ID_SPOT_ID_SDBSourceID 
CREATE UNIQUE INDEX UNC_SDB_IESPOT_IE_ID_SPOT_ID_SDBSourceID ON dbo.SDB_IESPOT ( IE_ID, SPOT_ID, SDBSourceID ) 
ON [SDB]
GO

--DROP INDEX dbo.SDB_IESPOT.NC_SDB_IESPOT_SDBSourceID_IU_ID_VIDEO_ID_SPOT_ID_UTC_SCHED_DATE_i 
--CREATE NONCLUSTERED INDEX NC_SDB_IESPOT_SDBSourceID_IU_ID_VIDEO_ID_SPOT_ID_UTC_SCHED_DATE_i ON dbo.SDB_IESPOT (SDBSourceID, IU_ID, VIDEO_ID, SPOT_ID, UTC_SCHED_DATE) INCLUDE ( IE_ID, SPOT_ORDER )
--ON [SDBPartitionKeyScheme](SDBSourceID)
--GO


--DROP INDEX dbo.SDB_IESPOT.UNC_SDB_IESPOT_SDBSourceID_IU_ID_VIDEO_ID_SPOT_ID_i 
CREATE UNIQUE NONCLUSTERED INDEX UNC_SDB_IESPOT_SDBSourceID_IU_ID_VIDEO_ID_SPOT_ID_i 
	ON dbo.SDB_IESPOT (SDBSourceID, IU_ID, VIDEO_ID, SPOT_ID) 
	INCLUDE (	
				SPOT_NSTATUS,
				SPOT_CONFLICT_STATUS,
				IE_NSTATUS,
				IE_CONFLICT_STATUS,

				IE_ID, 
				SPOT_ORDER,
				UTC_SPOT_NSTATUS_UPDATE_TIME,
				UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME,
				UTC_IE_NSTATUS_UPDATE_TIME,
				UTC_IE_CONFLICT_STATUS_UPDATE_TIME,
				CreateDate,
				UpdateDate
			)
	ON [SDBPartitionKeyScheme](SDBSourceID)
GO


ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_CreateDate]  DEFAULT (GETUTCDATE()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UpdateDate]  DEFAULT (GETUTCDATE()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UTC_SPOT_NSTATUS_UPDATE_TIME]  DEFAULT (GETUTCDATE()) FOR [UTC_SPOT_NSTATUS_UPDATE_TIME]
GO

ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME]  DEFAULT (GETUTCDATE()) FOR [UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME]
GO

ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UTC_IE_NSTATUS_UPDATE_TIME]  DEFAULT (GETUTCDATE()) FOR [UTC_IE_NSTATUS_UPDATE_TIME]
GO

ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UTC_IE_CONFLICT_STATUS_UPDATE_TIME]  DEFAULT (GETUTCDATE()) FOR [UTC_IE_CONFLICT_STATUS_UPDATE_TIME]
GO

