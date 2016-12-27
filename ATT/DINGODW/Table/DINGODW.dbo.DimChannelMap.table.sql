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
// Module: dbo.DimChannelMap
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for IU.  Designed and used for reporting purposes.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimChannelMap.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimChannelMap]    Script Date: 4/24/2014 10:36:24 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimChannelMap]
CREATE TABLE [dbo].[DimChannelMap](
	[DimChannelMapID]							[bigint] IDENTITY(1,1) NOT NULL,
	[IU_ID] 									[int] NOT NULL,
	[ChannelName] 								[varchar](40) NULL,
	[Channel] 									[varchar](12) NOT NULL,
	[RegionID] 									[int] NOT NULL,
	[RegionName] 								[varchar](50) NOT NULL,
	[NetworkID] 								[int] NULL,
	[NetworkName] 								[varchar](32) NULL,
	[ZoneName] 									[varchar](32) NULL,
	[MarketID] 									[int] NULL,
	[MarketName]								[varchar](50) NULL,
	[ICProviderID] 								[int] NULL,
	[ICProviderName] 							[varchar](50) NULL,
	[ROCID] 									[int] NULL,
	[ROCName] 									[varchar](50) NULL,
	[CreateDate] 								[datetime] NOT NULL CONSTRAINT [DF_DimChannelMap_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] 								[datetime] NOT NULL CONSTRAINT [DF_DimChannelMap_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimChannelMap] PRIMARY KEY CLUSTERED 
(
	[DimChannelMapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [Primary]
) ON [Primary]

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for an IU.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'DimChannelMapID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'IU_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'ChannelName'
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'RegionID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'RegionName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'NetworkID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'NetworkName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'ZoneName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'MarketID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'MarketName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'ROCID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Denormalized data.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'ROCName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'DimChannelMap', N'COLUMN',N'UpdateDate'
GO


