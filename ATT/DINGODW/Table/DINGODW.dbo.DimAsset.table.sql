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
// Module: dbo.DimAsset
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for Assets.  Designed and used for reporting purposes.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimAsset.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimAsset]    Script Date: 4/24/2014 10:13:36 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimAsset]
CREATE TABLE [dbo].[DimAsset]
(
	[DimAssetID] [int] NOT NULL IDENTITY(1,1),
	[RegionID] [int] NOT NULL,
	[AssetID] [varchar](32) NOT NULL,
	[VIDEO_ID] [varchar](32) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[FRAMES] [int] NULL,
	[CODE] [varchar](65) NULL,
	[DESCRIPTION] [varchar](65) NULL,
	[VALUE] [int] NULL,
	[FPS] [int] NULL,

	--Derived Columns
	[Length] [int] NULL,

	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DimAsset_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_DimAsset_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimAsset] PRIMARY KEY CLUSTERED 
(
	[DimAssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [Primary]
) ON [Primary]

GO

SET ANSI_PADDING OFF
GO


CREATE UNIQUE INDEX UNC_DimAsset_AssetID_RegionID_iLength ON dbo.DimAsset ( AssetID,RegionID ) INCLUDE ( Length )
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for an IE.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'DimAssetID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Region where asset originated.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'RegionID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'AssetID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'VIDEO_ID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'SDB Database ID.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'FRAMES'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'CODE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'DESCRIPTION'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'VALUE'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'FPS'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Length of video in seconds.', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'Length'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'', N'SCHEMA', N'dbo', N'TABLE', N'DimAsset', N'COLUMN',N'UpdateDate'
GO