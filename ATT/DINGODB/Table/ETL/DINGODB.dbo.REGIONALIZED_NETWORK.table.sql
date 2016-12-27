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
// Module:  dbo.REGIONALIZED_NETWORK
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Regionalizes the Seachange Network
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.REGIONALIZED_NETWORK.table.sql 3650 2014-03-10 17:33:42Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[REGIONALIZED_NETWORK]
CREATE TABLE [dbo].[REGIONALIZED_NETWORK](
	[REGIONALIZED_NETWORK_ID] [int] IDENTITY(1,1) NOT NULL,
	[REGIONID] [int] NOT NULL,
	[NETWORKID] [int] NOT NULL,
	[NAME] [varchar](32) NULL,
	[DESCRIPTION] [varchar](255) NULL,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_NETWORK] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_NETWORK_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGO Unique identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_NETWORK_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RegionID for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'REGIONID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot Unique identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'NETWORKID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Brief text identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'NAME'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Brief text identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'DESCRIPTION'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A field available to make comments about each network.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'msrepl_tran_version'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[REGIONALIZED_NETWORK]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_NETWORK_REGIONID_-->_Region_RegionID] FOREIGN KEY([REGIONID])
REFERENCES [dbo].[Region] ([RegionID])
GO

ALTER TABLE [dbo].[REGIONALIZED_NETWORK] CHECK CONSTRAINT [FK_REGIONALIZED_NETWORK_REGIONID_-->_Region_RegionID]
GO


--ALTER TABLE [dbo].[REGIONALIZED_NETWORK]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_NETWORK_NETWORKID_-->_NETWORK_ID] FOREIGN KEY([NETWORKID])
--REFERENCES [dbo].[NETWORK] ([ID])
--GO

--ALTER TABLE [dbo].[REGIONALIZED_NETWORK] CHECK CONSTRAINT [FK_REGIONALIZED_NETWORK_NETWORKID_-->_NETWORK_ID]
--GO

CREATE UNIQUE INDEX UNC_REGIONALIZED_NETWORK_NETWORKID_REGIONID_msrepl_tran_version ON dbo.REGIONALIZED_NETWORK ( REGIONID, msrepl_tran_version )
GO


CREATE UNIQUE INDEX UNC_REGIONALIZED_NETWORK_NETWORKID_REGIONID_imsrepl_tran_version_NAME ON dbo.REGIONALIZED_NETWORK ( NETWORKID, REGIONID ) INCLUDE ( msrepl_tran_version, NAME )
GO



ALTER TABLE [dbo].[REGIONALIZED_NETWORK] ADD  CONSTRAINT [DF_REGIONALIZED_NETWORK_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[REGIONALIZED_NETWORK] ADD  CONSTRAINT [DF_REGIONALIZED_NETWORK_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO


