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
// Module:  dbo.ChannelStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Stores the status of channels
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ChannelStatus.table.sql 4178 2014-05-13 22:00:51Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[ChannelStatus]
CREATE TABLE [dbo].[ChannelStatus](
	[ChannelStatusID] [int] IDENTITY(1,1) NOT NULL,
	[IU_ID] [int] NOT NULL,
	[RegionalizedZoneID] [int] NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	--[PartitionID] AS [SDBSourceID] % 10 PERSISTED,
	[TotalInsertionsToday] [int] NULL,
	[TotalInsertionsNextDay] [int] NULL,
	[DTM_Total] [int] NULL,
	[DTM_Played] [int] NULL,
	[DTM_Failed] [int] NULL,
	[DTM_NoTone] [int] NULL,
	[DTM_MpegError] [int] NULL,
	[DTM_MissingCopy] [int] NULL,

	[MTE_Conflicts] [int] NULL,
	[MTE_Conflicts_Window1] [int] NULL,
	[MTE_Conflicts_Window2] [int] NULL,
	[MTE_Conflicts_Window3] [int] NULL,
	[ConflictsNextDay] [int] NULL,

	[ICTotal] [int] NULL,
	[ICTotalNextDay] [int] NULL,
	[DTM_ICTotal] [int] NULL,
	[DTM_ICPlayed] [int] NULL,
	[DTM_ICFailed] [int] NULL,
	[DTM_ICNoTone] [int] NULL,
	[DTM_ICMpegError] [int] NULL,
	[DTM_ICMissingCopy] [int] NULL,

	[MTE_ICConflicts] [int] NULL,
	[MTE_ICConflicts_Window1] [int] NULL,
	[MTE_ICConflicts_Window2] [int] NULL,
	[MTE_ICConflicts_Window3] [int] NULL,
	[ICConflictsNextDay] [int] NULL,

	[ATTTotal] [int] NULL,
	[DTM_ATTTotal] [int] NULL,
	[ATTTotalNextDay] [int] NULL,
	[DTM_ATTPlayed] [int] NULL,
	[DTM_ATTFailed] [int] NULL,
	[DTM_ATTNoTone] [int] NULL,
	[DTM_ATTMpegError] [int] NULL,
	[DTM_ATTMissingCopy] [int] NULL,

	[MTE_ATTConflicts] [int] NULL,
	[MTE_ATTConflicts_Window1] [int] NULL,
	[MTE_ATTConflicts_Window2] [int] NULL,
	[MTE_ATTConflicts_Window3] [int] NULL,
	[ATTConflictsNextDay] [int] NULL,

	[DTM_Failed_Rate] [float] NULL,

	[DTM_Run_Rate] [float] NULL,
	[Forecast_Best_Run_Rate] [float] NULL,
	[Forecast_Worst_Run_Rate] [float] NULL,
	[NextDay_Forecast_Run_Rate] [float] NULL,
	[DTM_NoTone_Rate] [float] NULL,
	[DTM_NoTone_Count] [int] NULL,
	[Consecutive_NoTone_Count] [int] NULL,
	[Consecutive_Error_Count] [int] NULL,
	[BreakCount] [int] NULL,
	[NextDay_BreakCount] [int] NULL,
	[Average_BreakCount] [int] NULL,
	[ATT_DTM_Failed_Rate]	FLOAT NULL,
	[ATT_DTM_Run_Rate] FLOAT NULL,
	[ATT_Forecast_Best_Run_Rate]	FLOAT NULL,
	[ATT_Forecast_Worst_Run_Rate]	FLOAT NULL,
	[ATT_NextDay_Forecast_Run_Rate] FLOAT NULL,
	[ATT_DTM_NoTone_Rate]	FLOAT NULL,
	[ATT_DTM_NoTone_Count] INT NULL,
	[ATT_BreakCount] INT NULL,
	[ATT_NextDay_BreakCount] INT NULL,

	[IC_DTM_Failed_Rate]	FLOAT NULL,
	[IC_DTM_Run_Rate]	FLOAT NULL,
	[IC_Forecast_Best_Run_Rate]	FLOAT NULL,
	[IC_Forecast_Worst_Run_Rate]FLOAT NULL,
	[IC_NextDay_Forecast_Run_Rate]	FLOAT NULL,
	[IC_DTM_NoTone_Rate]	FLOAT NULL,
	[IC_DTM_NoTone_Count]	INT NULL,
	[IC_BreakCount] INT NULL,
	[IC_NextDay_BreakCount] INT NULL,

	[ATT_LastSchedule_Load] [datetime] NULL,
	[ATT_NextDay_LastSchedule_Load] [datetime] NULL,
	[IC_LastSchedule_Load]  [datetime] NULL,
	[IC_NextDay_LastSchedule_Load] [datetime] NULL,

	[Enabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL
)
ON [SDBPartitionKeyScheme](SDBSourceID);
GO

ALTER TABLE dbo.ChannelStatus SET (LOCK_ESCALATION = AUTO )
GO


ALTER TABLE dbo.ChannelStatus ADD CONSTRAINT [PK_ChannelStatus] PRIMARY KEY CLUSTERED 
(
	[ChannelStatusID] ASC, SDBSourceID ASC
)
WITH
(	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
	IGNORE_DUP_KEY = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
)
	 ON [SDBPartitionKeyScheme](SDBSourceID);
GO



EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a channel' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'ChannelStatusID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot unique identifier for a channel - might not be unique across regions' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'IU_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for a Zone - regionalized.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'RegionalizedZoneID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for a logical SDB.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions scheduled on this channel today' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'TotalInsertionsToday'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have been attempted on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_Total'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_Played'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_Failed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have failed due to No-Tone alarms on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_NoTone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have failed due to MPEG Errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_MpegError'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have failed due to missing copy errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_MissingCopy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Moment-to-end insertion conflicts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_Conflicts'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Moment-to-end insertion conflicts in time window1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_Conflicts_Window1'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Moment-to-end insertion conflicts in time window2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_Conflicts_Window2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Moment-to-end insertion conflicts in time window3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_Conflicts_Window3'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions scheduled on this channel today' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'ICTotal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have been attempted on this channel since midnight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICTotal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICPlayed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICFailed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have failed due to No-Tone alarms on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICNoTone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have failed due to MPEG Errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICMpegError'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have failed due to missing copy errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICMissingCopy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Moment-to-end insertion conflicts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ICConflicts'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Moment-to-end insertion conflicts in time window1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ICConflicts_Window1'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Moment-to-end insertion conflicts in time window2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ICConflicts_Window2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Moment-to-end insertion conflicts in time window3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ICConflicts_Window3'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions scheduled on this channel today' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'ATTTotal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have been attempted on this channel since midnight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTTotal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTPlayed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTFailed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have failed due to No-Tone alarms on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTNoTone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have failed due to MPEG Errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTMpegError'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have failed due to missing copy errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTMissingCopy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT Moment-to-end insertion conflicts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ATTConflicts'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT Moment-to-end insertion conflicts in time window1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ATTConflicts_Window1'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT Moment-to-end insertion conflicts in time window2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ATTConflicts_Window2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT Moment-to-end insertion conflicts in time window3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ATTConflicts_Window3'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Percentage of total insertions that have been sucessful on this channel since midnight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_Run_Rate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected percentage of total insertions on this channel for the entire day that will be successful, if all missing media arrives' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Forecast_Best_Run_Rate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected percentage of total insertions on this channel for the entire day that will be successful if no missing media arrives' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Forecast_Worst_Run_Rate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected percentage of total insertions on this channel for tomorrow that will be successful if no missing media arrives' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'NextDay_Forecast_Run_Rate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected percentage of total insertions on this channel for the entire day that will be successful if no missing media arrives' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_NoTone_Rate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Percentage of total insertions on this channel since midnight that have been failed due to no tone errors' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_NoTone_Count'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Count of consecutive insertions on this channel that have failed because of no tone errors, starting with the most recent insertion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Consecutive_NoTone_Count'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total number of insertions scheduled on this channel today' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'BreakCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total number of insertions scheduled on this channel tomorrow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'NextDay_BreakCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Average number of insertions scheduled on this channel on each of the past 7 days' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Average_BreakCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manual switch used to disable a region''s channel from the update and import process' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Enabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[ChannelStatus]  WITH CHECK ADD  CONSTRAINT [FK_ChannelStatus_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY([SDBSourceID])
REFERENCES [dbo].[SDBSource] ([SDBSourceID])
GO

ALTER TABLE [dbo].[ChannelStatus] CHECK CONSTRAINT [FK_ChannelStatus_SDBSourceID_-->_SDBSource_SDBSourceID]
GO


ALTER TABLE [dbo].[ChannelStatus]  WITH CHECK ADD  CONSTRAINT [FK_ChannelStatus_RegionalizedZoneID_-->_REGIONALIZED_ZONE_REGIONALIZED_ZONE_ID] FOREIGN KEY([RegionalizedZoneID])
REFERENCES [dbo].[REGIONALIZED_ZONE] ([REGIONALIZED_ZONE_ID])
GO

ALTER TABLE [dbo].[ChannelStatus] CHECK CONSTRAINT [FK_ChannelStatus_RegionalizedZoneID_-->_REGIONALIZED_ZONE_REGIONALIZED_ZONE_ID]
GO



ALTER TABLE [dbo].[ChannelStatus] ADD  CONSTRAINT [DF_ChannelStatus_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO

ALTER TABLE [dbo].[ChannelStatus] ADD  CONSTRAINT [DF_ChannelStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ChannelStatus] ADD  CONSTRAINT [DF_ChannelStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO


--DROP INDEX [dbo].[ChannelStatus].[UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i]
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ChannelStatus_SDBSourceID_IU_ID] ON [dbo].[ChannelStatus] 
(
	[SDBSourceID] ASC,
	[IU_ID] ASC
)

--DROP INDEX [dbo].[ChannelStatus].[UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i]
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i] ON [dbo].[ChannelStatus] 
(
	[SDBSourceID] ASC,
	[Enabled] ASC,
	[IU_ID] ASC,
	[RegionalizedZoneID] ASC
)
INCLUDE
(
	DTM_Run_Rate,
	Forecast_Best_Run_Rate,
	Forecast_Worst_Run_Rate,
	NextDay_Forecast_Run_Rate,
	DTM_NoTone_Rate,
	DTM_Failed_Rate,
	ATT_DTM_Run_Rate,
	ATT_Forecast_Best_Run_Rate,
	ATT_Forecast_Worst_Run_Rate,
	ATT_NextDay_Forecast_Run_Rate,
	ATT_DTM_NoTone_Rate,
	ATT_BreakCount,
	ATT_NextDay_BreakCount,
	ATT_DTM_Failed_Rate,
	IC_DTM_Run_Rate,
	IC_Forecast_Best_Run_Rate,
	IC_Forecast_Worst_Run_Rate,
	IC_NextDay_Forecast_Run_Rate,
	IC_DTM_NoTone_Rate,
	IC_DTM_Failed_Rate,
	IC_BreakCount,
	IC_NextDay_BreakCount,
	Consecutive_NoTone_Count,
	Consecutive_Error_Count,
	Average_BreakCount,
	TotalInsertionsToday,	
	TotalInsertionsNextDay,	
	DTM_Total,				
	DTM_Played,				
	DTM_Failed,				
	DTM_NoTone,				
	MTE_Conflicts,			
	MTE_Conflicts_Window1,
	MTE_Conflicts_Window2,
	MTE_Conflicts_Window3,
	ConflictsNextDay,		
	ATTTotal,				
	ATTTotalNextDay,		
	DTM_ATTTotal,			
	DTM_ATTPlayed,			
	DTM_ATTFailed,			
	DTM_ATTNoTone,			
	MTE_ATTConflicts,		
	MTE_ATTConflicts_Window1,
	MTE_ATTConflicts_Window2,
	MTE_ATTConflicts_Window3,
	ATTConflictsNextDay,	
	ICTotal,				
	ICTotalNextDay,			
	DTM_ICTotal,			
	DTM_ICPlayed,			
	DTM_ICFailed,			
	DTM_ICNoTone,			
	MTE_ICConflicts,		
	MTE_ICConflicts_Window1,
	MTE_ICConflicts_Window2,
	MTE_ICConflicts_Window3,
	ICConflictsNextDay,	
	UpdateDate

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
ON [SDBPartitionKeyScheme](SDBSourceID)
GO



CREATE NONCLUSTERED INDEX [NC_ChannelStatus_IU_ID_RegionalizedZoneID_i] ON [dbo].[ChannelStatus] 
(
	[IU_ID] ASC,
	[RegionalizedZoneID] ASC
)
INCLUDE
(
	[SDBSourceID],
	[Enabled]
)
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
ON [SDB]
GO

