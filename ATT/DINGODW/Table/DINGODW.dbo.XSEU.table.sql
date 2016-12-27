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
// Module: dbo.XSEU
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Bridge table used to map a SPOT to an IE and an IU for a particular instance in time.  Designed and used for reporting.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.XSEU.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[XSEU]    Script Date: 4/24/2014 10:48:59 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[XSEU]
CREATE TABLE [dbo].[XSEU](
	[XSEUID] [bigint] IDENTITY(1,1) NOT NULL,
	[DimSpotID] [bigint] NOT NULL,
	[DimIEID] [bigint] NULL,
	[DimIUID] [bigint] NULL,
	[DimTB_REQUESTID] [bigint] NULL,
	[DimSpotStatusID] [int] NULL,
	[DimSpotConflictStatusID] [int] NULL,
	[DimIEStatusID] [int] NULL,
	[DimIEConflictStatusID] [int] NULL,
	[DimSDBSourceID] [int] NOT NULL,
	[UTCSPOTDayDate] [date] NOT NULL,
	[UTCSPOTDayOfYearPartitionKey] [int] NOT NULL,
	[UTCIEDayDate] [date] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[SPOTDayDate] [date] NOT NULL,
	[SPOTDayOfYearPartitionKey] [int] NOT NULL,
	[IEDayDate] [date] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_XSEU_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_XSEU_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_XSEU] PRIMARY KEY CLUSTERED 
(
	[XSEUID] ASC,
	[UTCSPOTDayOfYearPartitionKey]
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCSPOTDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY] FOREIGN KEY([DimSpotID],[UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimSpot] ([DimSpotID],[UTCSPOTDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY]
GO

ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimIEID_UTCDY_-->_DimIE_DimIEID_UTCDY] FOREIGN KEY([DimIEID],[UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimIE] ([DimIEID],[UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimIEID_UTCDY_-->_DimIE_DimIEID_UTCDY]
GO

ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimIUID_UTCDY_-->_DimIU_DimIUID_UTCDY] FOREIGN KEY([DimIUID],[UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimIU] ([DimIUID],[UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimIUID_UTCDY_-->_DimIU_DimIUID_UTCDY]
GO

ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimTB_REQUESTID_UTCDY_-->_DimTB_REQUEST_DimTB_REQUESTID_UTCDY] FOREIGN KEY([DimTB_REQUESTID],[UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimTB_REQUEST] ([DimTB_REQUESTID],[UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimTB_REQUESTID_UTCDY_-->_DimTB_REQUEST_DimTB_REQUESTID_UTCDY]
GO




ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID] FOREIGN KEY([DimSpotStatusID])
REFERENCES [dbo].[DimSpotStatus] ([DimSpotStatusID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID]
GO

ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID] FOREIGN KEY([DimSpotConflictStatusID])
REFERENCES [dbo].[DimSpotConflictStatus] ([DimSpotConflictStatusID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID]
GO

ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimIEStatusID_-->_DimIEStatus_DimIEStatusID] FOREIGN KEY([DimIEStatusID])
REFERENCES [dbo].[DimIEStatus] ([DimIEStatusID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimIEStatusID_-->_DimIEStatus_DimIEStatusID]
GO

ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID] FOREIGN KEY([DimIEConflictStatusID])
REFERENCES [dbo].[DimIEConflictStatus] ([DimIEConflictStatusID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID]
GO

ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimSDBSourceID_-->_DimSDBSource_DimSDBSourceID] FOREIGN KEY([DimSDBSourceID])
REFERENCES [dbo].[DimSDBSource] ([DimSDBSourceID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimSDBSourceID_-->_DimSDBSource_DimSDBSourceID]
GO

ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_UTCDayDate_UTCDY-->_DimDateDay_DimDate_DY] FOREIGN KEY([UTCSPOTDayDate],[UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate],[DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_UTCDayDate_UTCDY-->_DimDateDay_DimDate_DY]
GO


CREATE INDEX NC_XSEU_UTCSPOTDayOfYearPartitionKey_UTCSPOTDayDate ON dbo.XSEU ( UTCSPOTDayOfYearPartitionKey,UTCSPOTDayDate ) 
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_XSEU_DayOfYearPartitionKey_SPOTDayDate ON dbo.XSEU ( SPOTDayOfYearPartitionKey,SPOTDayDate ) 
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_XSEU_UTCDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.XSEU ( UTCSPOTDayOfYearPartitionKey,DimSpotID,DimIEID ) --INCLUDE ( UTCDayOfYearPartitionKey )
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_XSEU_DayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.XSEU ( SPOTDayOfYearPartitionKey,DimSpotID,DimIEID ) ---INCLUDE ( DayOfYearPartitionKey )
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_XSEU_UTCSPOTDayDate_UTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.XSEU ( UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey,DimSpotID,DimIEID )
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_XSEU_SPOTDayDate_SPOTDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.XSEU ( SPOTDayDate,SPOTDayOfYearPartitionKey,DimSpotID,DimIEID ) 
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_XSEU_UTCSPOTDayDate_iUTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.XSEU ( UTCSPOTDayDate ) INCLUDE ( UTCSPOTDayOfYearPartitionKey,DimSpotID,DimIEID )
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO

CREATE INDEX NC_XSEU_SPOTDayDate_iDayOfYearPartitionKey_DimSpotID_DimIEID ON dbo.XSEU ( SPOTDayDate ) INCLUDE ( SPOTDayOfYearPartitionKey,DimSpotID,DimIEID ) 
ON [DayOfYearPartitionScheme] (SPOTDayOfYearPartitionKey) 
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot for a specific instance in time.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'XSEUID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimSpotID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IE dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimIEID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IU dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimIUID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an TB_REQUEST dimension instance.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimTB_REQUESTID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot status dimension.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimSpotStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for a Spot conflict status dimension.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimSpotConflictStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IE status dimension.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimIEStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an IE conflict status dimension.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimIEConflictStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW Unique Identifier for an SDB system dimension.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'DimSDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Day dimension in UTC time zone value for SpotID.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'UTCSPOTDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Day dimension in UTC time zone value for IEID.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'UTCIEDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC day dimensions day of year value for IEID.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Day dimension in the SDB time zone specific value for SpotID.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'SPOTDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'SDB time zone specific day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Day dimension in nonUTC time zone value for IEID.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'IEDayDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'NonUTC day dimensions day of year value for IEID.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'XSEU', N'COLUMN',N'UpdateDate'
GO


