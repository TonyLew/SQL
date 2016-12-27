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
// Module: dbo.DimIEConflictStatus
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for IE conflict status and used for reporting purposes.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimIEConflictStatus.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimIEConflictStatus]    Script Date: 4/24/2014 10:13:36 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimIEConflictStatus]
CREATE TABLE [dbo].[DimIEConflictStatus]
(
	[DimIEConflictStatusID] [int] NOT NULL IDENTITY(1,1),
	[IEConflictStatusID] [int] NOT NULL,
	[IEConflictStatusValue] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DimIEConflictStatus_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_DimIEConflictStatus_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimIEConflictStatus] PRIMARY KEY CLUSTERED 
(
	[DimIEConflictStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [Primary]
) ON [Primary]

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty N'MS_Description', N'DINGODW unique identifier for an IE conflict status.', N'SCHEMA', N'dbo', N'TABLE', N'DimIEConflictStatus', N'COLUMN',N'DimIEConflictStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIEConflictStatus', N'COLUMN',N'IEConflictStatusID'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'From MPEG database.', N'SCHEMA', N'dbo', N'TABLE', N'DimIEConflictStatus', N'COLUMN',N'IEConflictStatusValue'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row creation.', N'SCHEMA', N'dbo', N'TABLE', N'DimIEConflictStatus', N'COLUMN',N'CreateDate'
GO
EXEC sys.sp_addextendedproperty N'MS_Description', N'UTC timestamp of the row update.', N'SCHEMA', N'dbo', N'TABLE', N'DimIEConflictStatus', N'COLUMN',N'UpdateDate'
GO




