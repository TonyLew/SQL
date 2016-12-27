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
// Module: dbo.DimTB_REQUEST
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for TB requests.  Designed and used for reporting purposes.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimTB_REQUEST.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimTB_REQUEST]    Script Date: 4/24/2014 10:48:59 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimTB_REQUEST]
CREATE TABLE [dbo].[DimTB_REQUEST](
	[DimTB_REQUESTID] [bigint] IDENTITY(1,1) NOT NULL,
	[TB_ID] [int] NOT NULL,
	[ZONE_ID] [int] NOT NULL,
	[IU_ID] [int] NOT NULL,
	[TB_REQUEST] [int] NOT NULL,
	[TB_MODE] [int] NOT NULL,
	[TB_TYPE] [int] NULL,
	[TB_DAYPART] [datetime] NOT NULL,
	[TB_FILE] [varchar](128) NOT NULL,
	[TB_FILE_DATE] [datetime] NOT NULL,
	[STATUS] [int] NOT NULL,
	[EXPLANATION] [varchar](128) NULL,
	[TB_MACHINE] [varchar](32) NULL,
	[TB_MACHINE_TS] [datetime] NULL,
	[TB_MACHINE_THREAD] [int] NULL,
	[REQUESTING_MACHINE] [varchar](32) NULL,
	[REQUESTING_PORT] [int] NULL,
	[SOURCE_ID] [int] NOT NULL,
	[MSGNR] [int] NULL,
	[TS] [binary](8) NOT NULL,


	--Derived Columns
	[UTCTB_FILE_DATE] [date] NOT NULL,
	[UTCTB_FILE_DATE_TIME] [datetime] NOT NULL,
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

	[TB_MODE_NAME] [varchar](32) NOT NULL,
	[REQUEST_NAME] [varchar](32) NOT NULL,
	[SOURCE_ID_NAME] [varchar](32) NOT NULL,
	[STATUS_NAME] [varchar](32) NOT NULL,
	[TYPE_NAME] [varchar](32) NOT NULL,

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
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DimTB_REQUEST_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_DimTB_REQUEST_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimTB_REQUEST] PRIMARY KEY CLUSTERED 
(
	[DimTB_REQUESTID] ASC,
	[UTCIEDayOfYearPartitionKey]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme](UTCIEDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCIEDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for a TB request.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'DimTB_REQUESTID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'ZONE_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'IU_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_REQUEST'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_MODE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_TYPE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_DAYPART'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_FILE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_FILE_DATE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'STATUS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'EXPLANATION'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_MACHINE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_MACHINE_TS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_MACHINE_THREAD'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'REQUESTING_MACHINE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'REQUESTING_PORT'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'SOURCE_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'MSGNR'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'UTCIEDatetime'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'UTCIEDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'UTCIEDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'UTCIEDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'UTCIEDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'IEDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'IEDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'IEDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'IEDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TB_MODE_NAME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'REQUEST_NAME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'SOURCE_ID_NAME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'STATUS_NAME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TYPE_NAME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'RegionID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'RegionName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'SDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'MDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'ChannelName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'MarketID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'MarketName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'ZoneName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'NetworkID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'NetworkName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'TSI'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'ROCID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'ROCName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'DimTB_REQUEST', N'COLUMN',N'UpdateDate'
GO


