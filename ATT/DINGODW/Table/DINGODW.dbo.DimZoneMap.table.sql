
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
// Module: dbo.DimZoneMap
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for ZoneMap.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimZoneMap.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimZoneMap]    Script Date: 4/24/2014 10:13:36 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimZoneMap]
CREATE TABLE [dbo].[DimZoneMap]
(
	[DimZoneMapID]				[int] NOT NULL IDENTITY(1,1),
	[ZoneMapID] 				[int] NOT NULL,
	[ZoneName] 					[varchar](50) NOT NULL,
	[MarketID] 					[int] NOT NULL,
	[MarketName] 				[varchar](50) NOT NULL,
	[ICProviderID] 				[int] NOT NULL,
	[ICProviderName] 			[varchar](50) NOT NULL,
	[ROCID] 					[int] NOT NULL,
	[ROCName]					[varchar](50) NOT NULL,
	[Enabled] 					[int] NOT NULL CONSTRAINT [DF_DimZoneMap_Enabled]  DEFAULT (1),
	[CreateDate] 				[datetime] NOT NULL CONSTRAINT [DF_DimZoneMap_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] 				[datetime] NOT NULL CONSTRAINT [DF_DimZoneMap_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimZoneMap] PRIMARY KEY CLUSTERED 
(
	[DimZoneMapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [Primary]
) ON [Primary]

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for an SDB system.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'DimZoneMapID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODB unique identifier for a ZoneMap.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'ZoneMapID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Name for a zone.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'ZoneName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODB unique identifier for an MDB system', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'MarketID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Name for a market.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'MarketName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODB unique identifier for a region.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Name for a ICProvider.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODB unique identifier for a region.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'ROCID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Name for a ROC.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'ROCName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Used to determine if row is active.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'Enabled'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'DimZoneMap', N'COLUMN',N'UpdateDate'
GO

