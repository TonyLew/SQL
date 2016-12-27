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
// Module: dbo.DimIE
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for IE.  Designed and used for reporting purposes.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimIE.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimIE]    Script Date: 4/24/2014 10:13:36 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimIE]
CREATE TABLE [dbo].[DimIE]
(
	[DimIEID] [bigint] NOT NULL IDENTITY(1,1),
	[IE_ID] [int] NOT NULL,
	[IU_ID] [int] NULL,
	[SCHED_DATE_TIME] [datetime] NOT NULL,
	[START_TRIGGER] [char](5) NULL,
	[END_TRIGGER] [char](5) NULL,
	[NSTATUS] [int] NULL,
	[CONFLICT_STATUS] [int] NULL,
	[SPOTS] [int] NULL,
	[DURATION] [int] NULL,
	[RUN_DATE_TIME] [datetime] NULL,
	[AWIN_START] [int] NULL,
	[AWIN_END] [int] NULL,
	[VALUE] [int] NULL,
	[BREAK_INWIN] [int] NULL,
	[AWIN_START_DT] [datetime] NULL,
	[AWIN_END_DT] [datetime] NULL,
	[SOURCE_ID] [int] NOT NULL,
	[TB_TYPE] [int] NOT NULL,
	[EVENT_ID] [int] NULL,
	[TS] [binary](8) NOT NULL,

	--Derived Columns
	[UTCIEDatetime] [datetime] NOT NULL,
	[UTCIEDate] [date] NOT NULL,
	[UTCIEDateYear] [int] NOT NULL,
	[UTCIEDateMonth] [int] NOT NULL,
	[UTCIEDateDay] [int] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDate] [date] NOT NULL,
	[IEDateYear] [int] NOT NULL,
	[IEDateMonth] [int] NOT NULL,
	[IEDateDay] [int] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[DimIEStatusID] [int] NULL,
	[DimIEConflictStatusID] [int] NULL,
	[NSTATUSValue] [varchar](50) NULL,
	[CONFLICT_STATUSValue] [varchar](50) NULL,
	[SOURCE_IDName]	[varchar](32) NOT NULL,
	[TB_TYPEName]	[varchar](32) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBName] [varchar](32) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBName] [varchar](50) NOT NULL,
	[UTCOffset] [int] NULL,
	[ChannelName] [varchar](40) NULL,
	[MarketID] [int] NULL,
	[MarketName] [varchar](50) NULL,
	[ZoneName] [varchar](32) NULL,
	[NetworkID] [int] NULL,
	[NetworkName] [varchar](32) NULL,
	[TSI] [varchar](32) NULL,
	[ICProviderID] [int] NULL,
	[ICProviderName] [varchar](50) NULL,
	[ROCID] [int] NULL,
	[ROCName] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DimIE_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_DimIE_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimIE] PRIMARY KEY CLUSTERED 
(
	[DimIEID] ASC,
	[UTCIEDayOfYearPartitionKey]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme](UTCIEDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCIEDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO



ALTER TABLE [dbo].[DimIE]  WITH CHECK ADD  CONSTRAINT [FK_DimIE_DimIEStatusID_-->_DimIEStatus_DimIEStatusID] FOREIGN KEY([DimIEStatusID])
REFERENCES [dbo].[DimIEStatus] ([DimIEStatusID])
GO
ALTER TABLE [dbo].[DimIE] CHECK CONSTRAINT [FK_DimIE_DimIEStatusID_-->_DimIEStatus_DimIEStatusID]
GO

ALTER TABLE [dbo].[DimIE]  WITH CHECK ADD  CONSTRAINT [FK_DimIE_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID] FOREIGN KEY([DimIEConflictStatusID])
REFERENCES [dbo].[DimIEConflictStatus] ([DimIEConflictStatusID])
GO
ALTER TABLE [dbo].[DimIE] CHECK CONSTRAINT [FK_DimIE_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID]
GO



EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for an IE.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'DimIEID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'IE_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'IU_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'SCHED_DATE_TIME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'START_TRIGGER'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'END_TRIGGER'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'NSTATUS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'CONFLICT_STATUS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'SPOTS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'DURATION'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'RUN_DATE_TIME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'AWIN_START'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'AWIN_END'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'VALUE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'BREAK_INWIN'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'AWIN_START_DT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'AWIN_END_DT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'SOURCE_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'TB_TYPE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'EVENT_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'TS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'UTCIEDatetime'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'UTCIEDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'UTCIEDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'UTCIEDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'UTCIEDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'IEDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'IEDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'IEDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'IEDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'DimIEStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'DimIEConflictStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'IE Status.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'NSTATUSValue'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'IE Conflict Status.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'CONFLICT_STATUSValue'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'SOURCE_IDName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'TB_TYPEName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'RegionID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'RegionName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'SDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'MDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'ChannelName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'MarketID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'MarketName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'ZoneName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'NetworkID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'NetworkName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'TSI'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'ROCID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'ROCName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimIE', N'COLUMN',N'UpdateDate'
GO