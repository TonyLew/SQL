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
// Module: dbo.DimSpot
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for Spot.  Designed and used for reporting purposes.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimSpot.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimSpot]    Script Date: 4/24/2014 10:32:33 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO


--DROP TABLE [dbo].[DimSpot]
CREATE TABLE [dbo].[DimSpot](
	[DimSpotID] [bigint] IDENTITY(1,1) NOT NULL,
	[Spot_ID] [int] NOT NULL,
	[VIDEO_ID] [varchar](32) NULL,
	[DURATION] [int] NULL,
	[CUSTOMER] [varchar](80) NULL,
	[TITLE] [varchar](254) NULL,
	[NSTATUS] [int] NULL,
	[CONFLICT_STATUS] [int] NULL,
	[RATE] [float] NULL,
	[CODE] [varchar](12) NULL,
	[NOTES] [varchar](254) NULL,
	[SERIAL] [varchar](32) NULL,
	[ID] [varchar](32) NULL,
	[IE_ID] [int] NULL,
	[Spot_ORDER] [int] NULL,
	[RUN_DATE_TIME] [datetime] NULL,
	[RUN_LENGTH] [int] NULL,
	[VALUE] [int] NULL,
	[ORDER_ID] [int] NULL,
	[BONUS_FLAG] [int] NULL,
	[SOURCE_ID] [int] NULL,
	[TS] [binary](8) NULL,


	--Derived Columns
	[UTCSPOTDatetime] [datetime] NOT NULL,
	[UTCSPOTDate] [date] NOT NULL,
	[UTCSPOTDateYear] [int] NOT NULL,
	[UTCSPOTDateMonth] [int] NOT NULL,
	[UTCSPOTDateDay] [int] NOT NULL,
	[UTCSPOTDayOfYearPartitionKey] [int] NOT NULL,
	[SPOTDate] [date] NOT NULL,
	[SPOTDateYear] [int] NOT NULL,
	[SPOTDateMonth] [int] NOT NULL,
	[SPOTDateDay] [int] NOT NULL,
	[SPOTDayOfYearPartitionKey] [int] NOT NULL,
	[UTCIEDatetime] [datetime] NOT NULL,
	[UTCIEDate] [date] NOT NULL,
	[UTCIEDateYear] [int] NOT NULL,
	[UTCIEDateMonth] [int] NOT NULL,
	[UTCIEDateDay] [int] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDatetime] [datetime] NOT NULL,
	[IEDate] [date] NOT NULL,
	[IEDateYear] [int] NOT NULL,
	[IEDateMonth] [int] NOT NULL,
	[IEDateDay] [int] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[DimSpotStatusID] [int] NULL,
	[DimSpotConflictStatusID] [int] NULL,
	[IU_ID] [int] NULL,
	[NSTATUSValue] [varchar](50) NULL,
	[CONFLICT_STATUSValue] [varchar](50) NULL,
	[SOURCE_ID_INTERCONNECT_NAME] [varchar](32) NULL,
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
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DimSpot_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_DimSpot_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DIMSpot] PRIMARY KEY CLUSTERED 
(
	[DimSpotID] ASC,
	[UTCSPOTDayOfYearPartitionKey]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme](UTCSPOTDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCSPOTDayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[DimSpot]  WITH CHECK ADD  CONSTRAINT [FK_DIMSpot_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID] FOREIGN KEY([DimSpotStatusID])
REFERENCES [dbo].[DimSpotStatus] ([DimSpotStatusID])
GO
ALTER TABLE [dbo].[DimSpot] CHECK CONSTRAINT [FK_DIMSpot_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID]
GO

ALTER TABLE [dbo].[DimSpot]  WITH CHECK ADD  CONSTRAINT [FK_DIMSpot_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID] FOREIGN KEY([DimSpotConflictStatusID])
REFERENCES [dbo].[DimSpotConflictStatus] ([DimSpotConflictStatusID])
GO
ALTER TABLE [dbo].[DimSpot] CHECK CONSTRAINT [FK_DIMSpot_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID]
GO

CREATE INDEX NC_DimSpot_UTCSPOTDayOfYearPartitionKey_VIDEO_ID_RegionID ON dbo.DimSpot ( UTCSPOTDayOfYearPartitionKey,VIDEO_ID,RegionID ) 
ON [DayOfYearPartitionScheme] (UTCSPOTDayOfYearPartitionKey) 
GO



EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for a Spot.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'DimSpotID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'Spot_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'VIDEO_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'DURATION'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'CUSTOMER'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'TITLE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'NSTATUS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'CONFLICT_STATUS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'RATE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'CODE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'NOTES'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SERIAL'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'IE_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'Spot_ORDER'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'RUN_DATE_TIME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'RUN_LENGTH'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'VALUE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'ORDER_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'BONUS_FLAG'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SOURCE_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'TS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCSPOTDatetime'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCSPOTDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCSPOTDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCSPOTDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCSPOTDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SPOTDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SPOTDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SPOTDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SPOTDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCIEDatetime'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCIEDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCIEDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCIEDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCIEDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'IEDatetime'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'IEDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'IEDateYear'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'IEDateMonth'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'IEDateDay'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'DimSpotStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'DimSpotConflictStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Spot Status.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'NSTATUSValue'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Spot Conflict Status.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'CONFLICT_STATUSValue'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SOURCE_ID_INTERCONNECT_NAME'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'RegionID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'RegionName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'SDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'MDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'ChannelName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'MarketID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'MarketName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'ZoneName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'NetworkID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'NetworkName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'TSI'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'ROCID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'ROCName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'DimSpot', N'COLUMN',N'UpdateDate'
GO
