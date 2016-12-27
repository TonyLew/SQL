
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
// Module: dbo.DimSDBSource
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for SDB systems.  Designed and used for reporting.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimSDBSource.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimSDBSource]    Script Date: 4/24/2014 10:13:36 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimSDBSource]
CREATE TABLE [dbo].[DimSDBSource]
(
	[DimSDBSourceID] [int] NOT NULL IDENTITY(1,1),
	[SDBSourceID] [int] NOT NULL,
	[SDBName] [varchar](50) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBName] [varchar](50) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[UTCOffset] [int] NULL,
	[Enabled] [int] NOT NULL CONSTRAINT [DF_DimSDBSource_Enabled]  DEFAULT (1),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DimSDBSource_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_DimSDBSource_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimSDBSource] PRIMARY KEY CLUSTERED 
(
	[DimSDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [Primary]
) ON [Primary]

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for an SDB system.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'DimSDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODB unique identifier for an SDB system.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Computer name for an SDB system.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'SDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODB unique identifier for an MDB system', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Computer name for an MDB system.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'MDBName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODB unique identifier for a region.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'RegionID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Name for a region.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'RegionName'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Hours to add to SDB system time in order to be = UTC time.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'Used to determine if data should be gathered from a specific SDB system.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'Enabled'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'DimSDBSource', N'COLUMN',N'UpdateDate'
GO

