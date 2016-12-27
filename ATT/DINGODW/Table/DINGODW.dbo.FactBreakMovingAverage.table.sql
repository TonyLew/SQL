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
// Module: dbo.FactBreakMovingAverage
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Moving average for breaks.  Designed and used for reporting.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.FactBreakMovingAverage.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[FactBreakMovingAverage]    Script Date: 4/24/2014 10:48:59 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO



--DROP TABLE [dbo].[FactBreakMovingAverage]
CREATE TABLE [dbo].[FactBreakMovingAverage](
		FactBreakMovingAverageID									[bigint] IDENTITY(1,1) NOT NULL,
		IEDayOfYearPartitionKey										[int] NOT NULL,
		IEDayDate													[date] NOT NULL,
		RegionID													[int] NOT NULL,
		RegionName													[varchar](50) NOT NULL,
		MarketID													[int] NOT NULL,
		MarketName													[varchar](50) NOT NULL,
		ZoneName													[varchar](50) NOT NULL,
		NetworkID													[int] NOT NULL,
		NetworkName													[varchar](50) NOT NULL,
		ICProviderID												[int] NOT NULL,
		ICProviderName												[varchar](50) NOT NULL,
		ROCID														[int] NOT NULL,
		ROCName														[varchar](50) NOT NULL,
		ChannelName													[varchar](50) NOT NULL,
		ICDailyCount												[int] NOT NULL,
		ATTDailyCount												[int] NOT NULL,
		ICMovingAvg7Day												[float] NULL,
		ATTMovingAvg7Day											[float] NULL,
		UTC															[bit] NOT NULL,
		CreateDate													[datetime] NOT NULL CONSTRAINT [DF_FactBreakMovingAverage_CreateDate]  DEFAULT (GETUTCDATE()),
		UpdateDate													[datetime] NOT NULL CONSTRAINT [DF_FactBreakMovingAverage_UpdateDate]  DEFAULT (GETUTCDATE()),

 CONSTRAINT [PK_FactBreakMovingAverage] PRIMARY KEY CLUSTERED 
(
	[FactBreakMovingAverageID] ASC,
	[IEDayOfYearPartitionKey]
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON  [DayOfYearPartitionScheme] (IEDayOfYearPartitionKey)
) ON  [DayOfYearPartitionScheme] (IEDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO




CREATE INDEX NC_FactBreakMovingAverage_IEDayOfYearPartitionKey_IEDayDate_UTC_iCounts ON dbo.FactBreakMovingAverage ( IEDayOfYearPartitionKey,IEDayDate, UTC ) INCLUDE ( ICDailyCount, ATTDailyCount, ICMovingAvg7Day, ATTMovingAvg7Day )
GO




EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot for a specific instance in time.', N'SCHEMA', N'dbo', N'TABLE', N'FactBreakMovingAverage', N'COLUMN',N'FactBreakMovingAverageID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'IE day dimensions day of year value.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'FactBreakMovingAverage', N'COLUMN',N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'IE Day dimension in UTC time zone value.', N'SCHEMA', N'dbo', N'TABLE', N'FactBreakMovingAverage', N'COLUMN',N'IEDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC Determines whether the columns IEDayOfYearPartitionKey and IEDayDate are UTC time zone values.', N'SCHEMA', N'dbo', N'TABLE', N'FactBreakMovingAverage', N'COLUMN',N'UTC'
GO



EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'FactBreakMovingAverage', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'FactBreakMovingAverage', N'COLUMN',N'UpdateDate'
GO


