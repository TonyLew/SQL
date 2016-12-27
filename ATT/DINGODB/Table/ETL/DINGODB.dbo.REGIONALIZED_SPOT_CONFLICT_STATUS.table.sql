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
// Module:  dbo.REGIONALIZED_SPOT_CONFLICT_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Regionalized the SPOT Conflict Status table
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.REGIONALIZED_SPOT_CONFLICT_STATUS.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO


--DROP TABLE [dbo].[REGIONALIZED_SPOT_CONFLICT_STATUS]
CREATE TABLE [dbo].[REGIONALIZED_SPOT_CONFLICT_STATUS](
	[REGIONALIZED_SPOT_CONFLICT_STATUS_ID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[NSTATUS] [int] NOT NULL,
	[VALUE] [varchar](50) NOT NULL,
	[CHECKSUM_VALUE] [int] NOT NULL
 CONSTRAINT [PK_REGIONALIZED_SPOT_CONFLICT_STATUS] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_SPOT_CONFLICT_STATUS_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB regionalized unique identifier for a SPOT Conflict' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_SPOT_CONFLICT_STATUS_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RegionID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'RegionID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT NStatus id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'NSTATUS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT NStatus value' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'VALUE'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB CHECKSUMValue used to determine changes in the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'CHECKSUM_VALUE'
GO



CREATE UNIQUE INDEX UNC_REGIONALIZED_SPOT_CONFLICT_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE ON dbo.REGIONALIZED_SPOT_CONFLICT_STATUS ( RegionID, NSTATUS ) INCLUDE ( CHECKSUM_VALUE )
GO

CREATE UNIQUE INDEX UNC_REGIONALIZED_SPOT_CONFLICT_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE ON dbo.REGIONALIZED_SPOT_CONFLICT_STATUS ( NSTATUS, RegionID ) INCLUDE ( CHECKSUM_VALUE )
GO



