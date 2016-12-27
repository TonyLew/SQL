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
// Module: dbo.DimIU
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for IU.  Designed and used for reporting purposes.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimIU.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimIU]    Script Date: 4/24/2014 10:36:24 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimIU]
CREATE TABLE [dbo].[DimIU](
	[DimIUID] [bigint] IDENTITY(1,1) NOT NULL,
	[IU_ID] [int] NOT NULL,

	--[ZONE] [int] NOT NULL,
	--[ZONE_NAME] [varchar](32) NOT NULL,
	[CHANNEL] [varchar](12) NOT NULL,
	[CHAN_NAME] [varchar](32) NOT NULL,
	[DELAY] [int] NOT NULL,
	[START_TRIGGER] [char](5) NOT NULL,
	[END_TRIGGER] [char](5) NOT NULL,
	[AWIN_START] [int] NULL,
	[AWIN_END] [int] NULL,
	[VALUE] [int] NULL,
	[MASTER_NAME] [varchar](32) NULL,
	[COMPUTER_NAME] [varchar](32) NULL,
	[PARENT_ID] [int] NULL,
	[SYSTEM_TYPE] [int] NULL,
	[COMPUTER_PORT] [int] NOT NULL,
	[MIN_DURATION] [int] NOT NULL,
	[MAX_DURATION] [int] NOT NULL,
	[START_OF_DAY] [char](8) NOT NULL,
	[RESCHEDULE_WINDOW] [int] NOT NULL,
	[IC_CHANNEL] [varchar](12) NULL,
	[VSM_SLOT] [int] NULL,
	[DECODER_PORT] [int] NULL,
	[TC_ID] [int] NULL,
	[IGNORE_VIDEO_ERRORS] [int] NULL,
	[IGNORE_AUDIO_ERRORS] [int] NULL,
	[COLLISION_DETECT_ENABLED] [int] NULL,
	[TALLY_NORMALLY_HIGH] [int] NULL,
	[PLAY_OVER_COLLISIONS] [int] NULL,
	[PLAY_COLLISION_FUDGE] [int] NULL,
	[TALLY_COLLISION_FUDGE] [int] NULL,
	[TALLY_ERROR_FUDGE] [int] NULL,
	[LOG_TALLY_ERRORS] [int] NULL,
	[TBI_START] [datetime] NULL,
	[TBI_END] [datetime] NULL,
	[CONTINUOUS_PLAY_FUDGE] [int] NULL,
	[TONE_GROUP] [varchar](64) NULL,
	[IGNORE_END_TONES] [int] NULL,
	[END_TONE_FUDGE] [int] NULL,
	[MAX_AVAILS] [int] NULL,
	[RESTART_TRIES] [int] NULL,
	[RESTART_BYTE_SKIP] [int] NULL,
	[RESTART_TIME_REMAINING] [int] NULL,
	[GENLOCK_FLAG] [int] NULL,
	[SKIP_HEADER] [int] NULL,
	[GPO_IGNORE] [int] NULL,
	[GPO_NORMAL] [int] NULL,
	[GPO_TIME] [int] NULL,
	[DECODER_SHARING] [int] NULL,
	[HIGH_PRIORITY] [int] NULL,
	[SPLICER_ID] [int] NULL,
	[PORT_ID] [int] NULL,
	[VIDEO_PID] [int] NULL,
	[SERVICE_PID] [int] NULL,
	[DVB_CARD] [int] NULL,
	[SPLICE_ADJUST] [int] NOT NULL,
	[POST_BLACK] [int] NOT NULL,
	[SWITCH_CNT] [int] NULL,
	[DECODER_CNT] [int] NULL,
	[DVB_CARD_CNT] [int] NULL,
	[DVB_PORTS_PER_CARD] [int] NULL,
	[DVB_CHAN_PER_PORT] [int] NULL,
	[USE_ISD] [int] NULL,
	[NO_NETWORK_VIDEO_DETECT] [int] NULL,
	[NO_NETWORK_PLAY] [int] NULL,
	[IP_TONE_THRESHOLD] [int] NULL,
	[USE_GIGE] [int] NULL,
	[GIGE_IP] [varchar](24) NULL,
	[IS_ACTIVE_IND] [bit] NOT NULL,

	--Derived Columns
	[UTCIEDatetime] [datetime] NOT NULL,
	[UTCIEDate] [date] NOT NULL,
	[UTCIEDateYear] [int] NOT NULL,
	[UTCIEDateMonth] [int] NOT NULL,
	[UTCIEDateDay] [int] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDate] [date] NOT NULL,			--Use Minimum IE.SCHED_DATE_TIME
	[IEDateYear] [int] NOT NULL,
	[IEDateMonth] [int] NOT NULL,
	[IEDateDay] [int] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[SystemTypeName]	[varchar](64) NOT NULL,
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
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DimIU_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_DimIU_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimIU] PRIMARY KEY CLUSTERED 
(
	[DimIUID] ASC,
	[UTCIEDayOfYearPartitionKey]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme](UTCIEDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCIEDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for an IU.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DimIUID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IU_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'CHANNEL'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DELAY'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'START_TRIGGER'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'END_TRIGGER'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'AWIN_START'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'AWIN_END'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'VALUE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'MASTER_NAME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'COMPUTER_NAME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'PARENT_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SYSTEM_TYPE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'COMPUTER_PORT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'MIN_DURATION'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'MAX_DURATION'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'START_OF_DAY'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'RESCHEDULE_WINDOW'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IC_CHANNEL'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'VSM_SLOT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DECODER_PORT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'TC_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IGNORE_VIDEO_ERRORS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IGNORE_AUDIO_ERRORS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'COLLISION_DETECT_ENABLED'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'TALLY_NORMALLY_HIGH'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'PLAY_OVER_COLLISIONS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'PLAY_COLLISION_FUDGE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'TALLY_COLLISION_FUDGE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'TALLY_ERROR_FUDGE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'LOG_TALLY_ERRORS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'TBI_START'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'TBI_END'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'CONTINUOUS_PLAY_FUDGE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'TONE_GROUP'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IGNORE_END_TONES'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'END_TONE_FUDGE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'MAX_AVAILS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'RESTART_TRIES'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'RESTART_BYTE_SKIP'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'RESTART_TIME_REMAINING'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'GENLOCK_FLAG'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SKIP_HEADER'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'GPO_IGNORE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'GPO_NORMAL'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'GPO_TIME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DECODER_SHARING'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'HIGH_PRIORITY'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SPLICER_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'PORT_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'VIDEO_PID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SERVICE_PID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DVB_CARD'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SPLICE_ADJUST'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'POST_BLACK'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SWITCH_CNT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DECODER_CNT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DVB_CARD_CNT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DVB_PORTS_PER_CARD'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'DVB_CHAN_PER_PORT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'USE_ISD'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'NO_NETWORK_VIDEO_DETECT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'NO_NETWORK_PLAY'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IP_TONE_THRESHOLD'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'USE_GIGE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'GIGE_IP'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IS_ACTIVE_IND'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'UTCIEDatetime'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'UTCIEDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'UTCIEDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'UTCIEDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'UTCIEDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IEDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IEDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IEDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IEDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SystemTypeName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'RegionID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'RegionName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'SDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'MDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'ChannelName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'MarketID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'MarketName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'ZoneName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'NetworkID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'NetworkName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'TSI'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'ROCID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'ROCName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'DimIU', N'COLUMN',N'UpdateDate'
GO


