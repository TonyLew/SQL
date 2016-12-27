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
// Module: dbo.TempTableFactSummary1
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Bridge table used to map a SPOT to an IE and an IU for a particular instance in time.  Designed and used for reporting.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.TempTableFactSummary1.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[TempTableFactSummary1]    Script Date: 4/24/2014 10:48:59 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[TempTableFactSummary1]
CREATE TABLE [dbo].[TempTableFactSummary1](
		TempTableFactSummary1ID										[int] IDENTITY(1,1) NOT NULL,
		UTCSPOTDayOfYearPartitionKey								[int] NOT NULL,
		UTCSPOTDayDate												[date] NOT NULL,
		SPOTDayOfYearPartitionKey									[int] NOT NULL,
		SPOTDayDate													[date] NOT NULL,
		UTCIEDayOfYearPartitionKey									[int] NOT NULL,
		UTCIEDayDate												[date] NOT NULL,
		IEDayOfYearPartitionKey										[int] NOT NULL,
		IEDayDate													[date] NOT NULL,
		DimSDBSourceID												[int] NOT NULL,
		UTCOffset													[int] NOT NULL,
		DimSpotID													[int] NOT NULL,
		DimSpotStatusID												[int] NOT NULL,
		DimSpotConflictStatusID										[int] NOT NULL,
		DimIEID														[int] NOT NULL,
		DimIEStatusID												[int] NOT NULL,
		DimIEConflictStatusID										[int] NOT NULL,
		DimIUID														[int] NOT NULL,
		DimTB_REQUESTID												[int] NOT NULL,
		AssetID														[varchar](50) NOT NULL,
		RegionID													[int] NOT NULL,
		RegionName													[varchar](50) NOT NULL,
		ChannelName													[varchar](50) NOT NULL,
		MarketID													[int] NOT NULL,
		MarketName													[varchar](50) NOT NULL,
		ZoneName													[varchar](50) NOT NULL,
		NetworkID													[int] NOT NULL,
		NetworkName													[varchar](50) NOT NULL,
		ICProviderID												[int] NOT NULL,
		ICProviderName												[varchar](50) NOT NULL,
		ROCID														[int] NOT NULL,
		ROCName														[varchar](50) NOT NULL,
		SourceID													[int] NOT NULL,
		ScheduleDate												[date] NOT NULL,

		/* OTHER Totals */
		OTHERTotal													[int] NOT NULL,
		DTM_OTHERTotal												[int] NOT NULL,
		DTM_OTHERPlayed												[int] NOT NULL,
		DTM_OTHERFailed												[int] NOT NULL,
		DTM_OTHERNoTone												[int] NOT NULL,
		DTM_OTHERMpegError											[int] NOT NULL,
		DTM_OTHERMissingCopy										[int] NOT NULL,
		OTHERScheduleLoaded											[datetime] NOT NULL,
		OTHERScheduleBreakCount										[int] NOT NULL,
		OTHERMissingMedia											[int] NOT NULL,
		OTHERMediaPrefixErrors										[int] NOT NULL,
		OTHERMediaDurationErrors									[int] NOT NULL,
		OTHERMediaFormatErrors										[int] NOT NULL,

		/* IC Provider Breakdown */
		ICTotal														[int] NOT NULL, 
		DTM_ICTotal													[int] NOT NULL, 
		DTM_ICPlayed												[int] NOT NULL, 
		DTM_ICFailed												[int] NOT NULL, 
		DTM_ICNoTone												[int] NOT NULL, 
		DTM_ICMpegError												[int] NOT NULL, 
		DTM_ICMissingCopy											[int] NOT NULL, 
		ICScheduleLoaded											[datetime] NOT NULL, 
		ICScheduleBreakCount										[int] NOT NULL, 
		ICMissingMedia												[int] NOT NULL, 
		ICMediaPrefixErrors											[int] NOT NULL, 
		ICMediaDurationErrors										[int] NOT NULL, 
		ICMediaFormatErrors											[int] NOT NULL, 

		/* AT&T Breakdown */
		ATTTotal													[int] NOT NULL, 
		DTM_ATTTotal												[int] NOT NULL, 
		DTM_ATTPlayed												[int] NOT NULL, 
		DTM_ATTFailed												[int] NOT NULL, 
		DTM_ATTNoTone												[int] NOT NULL, 
		DTM_ATTMpegError											[int] NOT NULL, 
		DTM_ATTMissingCopy											[int] NOT NULL, 
		ATTScheduleLoaded											[datetime] NOT NULL, 
		ATTScheduleBreakCount										[int] NOT NULL, 
		ATTMissingMedia												[int] NOT NULL, 
		ATTMediaPrefixErrors										[int] NOT NULL, 
		ATTMediaDurationErrors										[int] NOT NULL, 
		ATTMediaFormatErrors										[int] NOT NULL,

		CreateDate													[datetime] NOT NULL CONSTRAINT [DF_TempTableFactSummary1_CreateDate]  DEFAULT (GETUTCDATE()),
		UpdateDate													[datetime] NOT NULL CONSTRAINT [DF_TempTableFactSummary1_UpdateDate]  DEFAULT (GETUTCDATE()),

 CONSTRAINT [PK_TempTableFactSummary1] PRIMARY KEY CLUSTERED 
(
	[TempTableFactSummary1ID] ASC,
	[UTCSPOTDayOfYearPartitionKey]
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCSPOTDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[TempTableFactSummary1]  WITH CHECK ADD  CONSTRAINT [FK_TempTableFactSummary1_UTCSPOTDayDate_DY-->_DimDateDay_DimDate_DY] FOREIGN KEY([UTCSPOTDayDate],[UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate],[DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[TempTableFactSummary1] CHECK CONSTRAINT [FK_TempTableFactSummary1_UTCSPOTDayDate_DY-->_DimDateDay_DimDate_DY]
GO



CREATE INDEX NC_TempTableFactSummary1_UTCSPOTDayOfYearPartitionKey_UTCSPOTDayDate ON dbo.TempTableFactSummary1 ( UTCSPOTDayOfYearPartitionKey,UTCSPOTDayDate ) 
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_TempTableFactSummary1_SPOTDayOfYearPartitionKey_SPOTDayDate ON dbo.TempTableFactSummary1 ( SPOTDayOfYearPartitionKey,SPOTDayDate ) 
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_TempTableFactSummary1_UTCIEDayOfYearPartitionKey_UTCIEDayDate ON dbo.TempTableFactSummary1 ( UTCIEDayOfYearPartitionKey,UTCIEDayDate ) 
ON [DayOfYearPartitionScheme] (UTCIEDayOfYearPartitionKey) 
GO

CREATE INDEX NC_TempTableFactSummary1_IEDayOfYearPartitionKey_IEDayDate ON dbo.TempTableFactSummary1 ( IEDayOfYearPartitionKey,IEDayDate ) 
ON [DayOfYearPartitionScheme] (IEDayOfYearPartitionKey) 
GO




EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot for a specific instance in time.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'TempTableFactSummary1ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC SPOT day dimensions day of year value.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC SPOT Day dimension in UTC time zone value.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'UTCSPOTDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'SPOT day dimensions day of year value.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'SPOT Day dimension in UTC time zone value.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'SPOTDayDate'
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC IE day dimensions day of year value.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC IE Day dimension in UTC time zone value.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'UTCIEDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'IE day dimensions day of year value.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'IE Day dimension in UTC time zone value.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'IEDayDate'
GO



EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'TempTableFactSummary1', N'COLUMN',N'UpdateDate'
GO


