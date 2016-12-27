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
// Module:  dbo.REGIONALIZED_IU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Regionalizes the Seachange IU
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.REGIONALIZED_IU.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[REGIONALIZED_IU]
CREATE TABLE [dbo].[REGIONALIZED_IU](
	[REGIONALIZED_IU_ID] [int] IDENTITY(1,1) NOT NULL,
	[IU_ID] [int] NOT NULL,
	[REGIONID] [int] NOT NULL,
	[ZONE] [int] NOT NULL,
	[ZONE_NAME] [varchar](32) NOT NULL,
	[CHANNEL] [varchar](12) NOT NULL,
	[CHAN_NAME] [varchar](32) NOT NULL,
	[CHANNEL_NAME] [varchar](200) NOT NULL,
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
	[msrepl_tran_version] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_IU] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_IU_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier that is system generated and that will change when the row changes to indicate an update is necessary' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IU', @level2type=N'COLUMN',@level2name=N'msrepl_tran_version'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IU', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IU', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO



CREATE UNIQUE INDEX UNC_REGIONALIZED_IU_IU_ID_REGIONID_iCOMPUTER_NAME_CHANNEL_NAME_msrepl_tran_version ON dbo.REGIONALIZED_IU ( IU_ID, REGIONID  ) INCLUDE ( COMPUTER_NAME, CHANNEL_NAME, msrepl_tran_version )
GO

ALTER TABLE [dbo].[REGIONALIZED_IU] ADD  CONSTRAINT [DF_REGIONALIZED_IU_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[REGIONALIZED_IU] ADD  CONSTRAINT [DF_REGIONALIZED_IU_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO




