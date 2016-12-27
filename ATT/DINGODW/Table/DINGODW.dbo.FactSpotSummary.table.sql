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
// Module: dbo.FactSpotSummary
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Table used to store summaries of SPOTs.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.FactSpotSummary.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[FactSpotSummary]    Script Date: 4/24/2014 10:48:59 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[FactSpotSummary]
CREATE TABLE [dbo].[FactSpotSummary](
		[FactSpotSummaryID] 											[bigint] IDENTITY(1,1) NOT NULL,
		[UTCSPOTDayOfYearPartitionKey] 									[int] NOT NULL,
		[UTCSPOTDayDate] 												[date] NOT NULL,
		[SPOTDayOfYearPartitionKey] 									[int] NOT NULL,
		[SPOTDayDate] 													[date] NOT NULL,
		[UTCIEDayOfYearPartitionKey] 									[int] NOT NULL,
		[UTCIEDayDate] 													[date] NOT NULL,
		[IEDayOfYearPartitionKey] 										[int] NOT NULL,
		[IEDayDate] 													[date] NOT NULL,
		[DimSDBSourceID] 												[int] NOT NULL,
		[DimSPOTID] 													[bigint] NULL,
		[DimIEID] 														[bigint] NULL,
		[DimIUID] 														[bigint] NULL,
		[DimTB_REQUESTID] 												[bigint] NULL,
		[DimSpotStatusID]												[int] NULL,
		[DimSpotConflictStatusID] 										[int] NULL,
		[DimIEStatusID] 												[int] NULL,
		[DimIEConflictStatusID] 										[int] NULL,

		/* OTHER Totals */
		[OTHERTotal]													[int] NOT NULL,
		[DTM_OTHERTotal]												[int] NOT NULL,
		[DTM_OTHERPlayed]												[int] NOT NULL,
		[DTM_OTHERFailed]												[int] NOT NULL,
		[DTM_OTHERNoTone]												[int] NOT NULL,
		[DTM_OTHERMpegError]											[int] NOT NULL,
		[DTM_OTHERMissingCopy]											[int] NOT NULL,
		[OTHERScheduleLoaded]											[datetime] NOT NULL,
		[OTHERScheduleBreakCount]										[int] NOT NULL,
		[OTHERMissingMedia]												[int] NOT NULL,
		[OTHERMediaPrefixErrors]										[int] NOT NULL,
		[OTHERMediaDurationErrors]										[int] NOT NULL,
		[OTHERMediaFormatErrors]										[int] NOT NULL,

		/* IC Provider Breakdown */
		[ICTotal]														[int] NOT NULL, 
		[DTM_ICTotal]													[int] NOT NULL, 
		[DTM_ICPlayed]													[int] NOT NULL, 
		[DTM_ICFailed]													[int] NOT NULL, 
		[DTM_ICNoTone]													[int] NOT NULL, 
		[DTM_ICMpegError]												[int] NOT NULL, 
		[DTM_ICMissingCopy]												[int] NOT NULL, 
		[ICScheduleLoaded]												[datetime] NOT NULL, 
		[ICScheduleBreakCount]											[int] NOT NULL, 
		[ICMissingMedia]												[int] NOT NULL, 
		[ICMediaPrefixErrors]											[int] NOT NULL, 
		[ICMediaDurationErrors]											[int] NOT NULL, 
		[ICMediaFormatErrors]											[int] NOT NULL, 

		/* AT&T Breakdown */
		[ATTTotal]														[int] NOT NULL, 
		[DTM_ATTTotal]													[int] NOT NULL, 
		[DTM_ATTPlayed]													[int] NOT NULL, 
		[DTM_ATTFailed]													[int] NOT NULL, 
		[DTM_ATTNoTone]													[int] NOT NULL, 
		[DTM_ATTMpegError]												[int] NOT NULL, 
		[DTM_ATTMissingCopy]											[int] NOT NULL, 
		[ATTScheduleLoaded]												[datetime] NOT NULL, 
		[ATTScheduleBreakCount]											[int] NOT NULL, 
		[ATTMissingMedia]												[int] NOT NULL, 
		[ATTMediaPrefixErrors]											[int] NOT NULL, 
		[ATTMediaDurationErrors]										[int] NOT NULL, 
		[ATTMediaFormatErrors]											[int] NOT NULL,

		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_FactSpotSummary_CreateDate]  DEFAULT (GETUTCDATE()),
		[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_FactSpotSummary_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_FactSpotSummary] PRIMARY KEY CLUSTERED 
(
	[FactSpotSummaryID] ASC,
	[UTCSPOTDayOfYearPartitionKey]
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCSPOTDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY] FOREIGN KEY([UTCSPOTDayDate],[UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate],[DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY]
GO


ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY] FOREIGN KEY([DimSpotID],[UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimSpot] ([DimSpotID],[UTCSPOTDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY]
GO



/*
ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimIEID_UTCDY_-->_DimIE_DimIEID_UTCDY] FOREIGN KEY([DimIEID],[UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimIE] ([DimIEID],[UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimIEID_UTCDY_-->_DimIE_DimIEID_UTCDY]
GO

ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimIUID_UTCDY_-->_DimIU_DimIUID_UTCDY] FOREIGN KEY([DimIUID],[UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimIU] ([DimIUID],[UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimIUID_UTCDY_-->_DimIU_DimIUID_UTCDY]
GO

ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimTB_REQUESTID_UTCDY_-->_DimTB_REQUEST_DimTB_REQUESTID_UTCDY] FOREIGN KEY([DimTB_REQUESTID],[UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimTB_REQUEST] ([DimTB_REQUESTID],[UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimTB_REQUESTID_UTCDY_-->_DimTB_REQUEST_DimTB_REQUESTID_UTCDY]
GO

ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID] FOREIGN KEY([DimSpotStatusID])
REFERENCES [dbo].[DimSpotStatus] ([DimSpotStatusID])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID]
GO

ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID] FOREIGN KEY([DimSpotConflictStatusID])
REFERENCES [dbo].[DimSpotConflictStatus] ([DimSpotConflictStatusID])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID]
GO

ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimIEStatusID_-->_DimIEStatus_DimIEStatusID] FOREIGN KEY([DimIEStatusID])
REFERENCES [dbo].[DimIEStatus] ([DimIEStatusID])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimIEStatusID_-->_DimIEStatus_DimIEStatusID]
GO

ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID] FOREIGN KEY([DimIEConflictStatusID])
REFERENCES [dbo].[DimIEConflictStatus] ([DimIEConflictStatusID])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID]
GO

ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimSDBSourceID_-->_DimSDBSource_DimSDBSourceID] FOREIGN KEY([DimSDBSourceID])
REFERENCES [dbo].[DimSDBSource] ([DimSDBSourceID])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimSDBSourceID_-->_DimSDBSource_DimSDBSourceID]
GO
*/

CREATE INDEX NC_FactSpotSummary_UTCSPOTDayOfYearPartitionKey_UTCSPOTDimDateDay ON dbo.FactSpotSummary ( UTCSPOTDayOfYearPartitionKey,UTCSPOTDayDate ) 
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactSpotSummary_DayOfYearPartitionKey_DimDateDay ON dbo.FactSpotSummary ( SPOTDayOfYearPartitionKey,SPOTDayDate ) 
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactSpotSummary_UTCDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.FactSpotSummary ( UTCSPOTDayOfYearPartitionKey,DimSpotID,DimIEID ) --INCLUDE ( UTCDayOfYearPartitionKey )
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactSpotSummary_DayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.FactSpotSummary ( SPOTDayOfYearPartitionKey,DimSpotID,DimIEID ) ---INCLUDE ( DayOfYearPartitionKey )
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactSpotSummary_UTCSPOTDimDateDay_UTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.FactSpotSummary ( UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey,DimSpotID,DimIEID )
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactSpotSummary_SPOTDimDateDay_SPOTDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.FactSpotSummary ( SPOTDayDate,SPOTDayOfYearPartitionKey,DimSpotID,DimIEID ) 
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactSpotSummary_UTCSPOTDimDateDay_iUTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.FactSpotSummary ( UTCSPOTDayDate ) INCLUDE ( UTCSPOTDayOfYearPartitionKey,DimSpotID,DimIEID )
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_FactSpotSummary_SPOTDimDateDay_iDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.FactSpotSummary ( SPOTDayDate ) INCLUDE ( SPOTDayOfYearPartitionKey,DimSpotID,DimIEID ) 
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot for a specific instance in time.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'FactSpotSummaryID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Day dimension in UTC time zone value for SpotID.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'UTCSPOTDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Day dimension in UTC time zone value for SpotID.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'SPOTDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Day dimension in UTC time zone value for SpotID.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'UTCIEDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an SDB system dimension.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimSDBSourceID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimSpotID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IE dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimIEID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IU dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimIUID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an TB_REQUEST dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimTB_REQUESTID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot status dimension.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimSpotStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot conflict status dimension.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimSpotConflictStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IE status dimension.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimIEStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IE conflict status dimension.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'DimIEConflictStatusID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'FactSpotSummary', N'COLUMN',N'UpdateDate'
GO


