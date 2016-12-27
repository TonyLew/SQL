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
// Module: dbo.FactIESummary
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Table used to store summaries of insertion events.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.FactIESummary.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[FactIESummary]    Script Date: 4/24/2014 10:48:59 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[FactIESummary]
CREATE TABLE [dbo].[FactIESummary](
		[FactIESummaryID] 												[bigint] IDENTITY(1,1) NOT NULL,
		[UTCIEDayOfYearPartitionKey] 									[int] NOT NULL,
		[UTCIEDayDate] 													[date] NOT NULL,
		[IEDayOfYearPartitionKey] 										[int] NOT NULL,
		[IEDayDate] 													[date] NOT NULL,
		[DimIEID] 														[bigint] NULL,
		[DimIUID] 														[bigint] NULL,
		[DimTB_REQUESTID] 												[bigint] NULL,

		/* IC Provider Breakdown */
		[ICScheduleLoaded]												[datetime] NOT NULL, 
		[ICScheduleBreakCount]											[int] NOT NULL, 
		[ICMissingMedia]												[int] NOT NULL, 
		[ICMediaPrefixErrors]											[int] NOT NULL, 
		[ICMediaDurationErrors]											[int] NOT NULL, 
		[ICMediaFormatErrors]											[int] NOT NULL, 

		/* AT&T Breakdown */
		[ATTScheduleLoaded]												[datetime] NOT NULL, 
		[ATTScheduleBreakCount]											[int] NOT NULL, 
		[ATTMissingMedia]												[int] NOT NULL, 
		[ATTMediaPrefixErrors]											[int] NOT NULL, 
		[ATTMediaDurationErrors]										[int] NOT NULL, 
		[ATTMediaFormatErrors]											[int] NOT NULL,

		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_FactIESummary_CreateDate]  DEFAULT (GETUTCDATE()),
		[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_FactIESummary_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_FactIESummary] PRIMARY KEY CLUSTERED 
(
	[FactIESummaryID] ASC,
	[UTCIEDayOfYearPartitionKey]
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme] (UTCIEDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCIEDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[FactIESummary]  WITH CHECK ADD  CONSTRAINT [FK_FactIESummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY] FOREIGN KEY([UTCIEDayDate],[UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate],[DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactIESummary] CHECK CONSTRAINT [FK_FactIESummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY]
GO


ALTER TABLE [dbo].[FactIESummary]  WITH CHECK ADD  CONSTRAINT [FK_FactIESummary_DimIEID_UTCDY-->_DimIE_DimIEID_UTCDY] FOREIGN KEY([DimIEID],[UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimIE] ([DimIEID],[UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactIESummary] CHECK CONSTRAINT [FK_FactIESummary_DimIEID_UTCDY-->_DimIE_DimIEID_UTCDY]
GO



CREATE INDEX NC_FactIESummary_UTCIEDayOfYearPartitionKey_UTCIEDimDateDay ON dbo.FactIESummary ( UTCIEDayOfYearPartitionKey,UTCIEDayDate ) 
ON [DayOfYearPartitionScheme] (UTCIEDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactIESummary_IEDayOfYearPartitionKey_IEDayDate ON dbo.FactIESummary ( IEDayOfYearPartitionKey,IEDayDate ) 
ON [DayOfYearPartitionScheme] (IEDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactIESummary_UTCDayOfYearPartitionKey_DimIEID ON dbo.FactIESummary ( UTCIEDayOfYearPartitionKey,DimIEID ) --INCLUDE ( UTCDayOfYearPartitionKey )
ON [DayOfYearPartitionScheme] (UTCIEDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactIESummary_IEDayOfYearPartitionKey_DimIEID ON dbo.FactIESummary ( IEDayOfYearPartitionKey,DimIEID ) ---INCLUDE ( DayOfYearPartitionKey )
ON [DayOfYearPartitionScheme] (UTCIEDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactIESummary_UTCIEDayDate_UTCIEDayOfYearPartitionKey_DimIEID ON dbo.FactIESummary ( UTCIEDayDate,UTCIEDayOfYearPartitionKey,DimIEID )
ON [DayOfYearPartitionScheme] (UTCIEDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactIESummary_IEDimDateDay_IEDayOfYearPartitionKey_DimIEID ON dbo.FactIESummary ( IEDayDate,IEDayOfYearPartitionKey,DimIEID ) 
ON [DayOfYearPartitionScheme] (IEDayOfYearPartitionKey) 
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot for a specific instance in time.', N'SCHEMA', N'dbo', N'TABLE', N'FactIESummary', N'COLUMN',N'FactIESummaryID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC day dimensions day of year value for insertion event.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'FactIESummary', N'COLUMN',N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Day dimension in UTC time zone value for insertion event.', N'SCHEMA', N'dbo', N'TABLE', N'FactIESummary', N'COLUMN',N'UTCIEDayDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IE dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'FactIESummary', N'COLUMN',N'DimIEID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IU dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'FactIESummary', N'COLUMN',N'DimIUID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an TB_REQUEST dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'FactIESummary', N'COLUMN',N'DimTB_REQUESTID'
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'FactIESummary', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'FactIESummary', N'COLUMN',N'UpdateDate'
GO


