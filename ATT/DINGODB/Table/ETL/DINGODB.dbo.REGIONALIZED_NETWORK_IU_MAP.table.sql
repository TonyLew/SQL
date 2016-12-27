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
// Module:  dbo.REGIONALIZED_NETWORK_IU_MAP
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Regionalizes the Seachange Network to IU mapping
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.REGIONALIZED_NETWORK_IU_MAP.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP]
CREATE TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP](
	[REGIONALIZED_NETWORK_IU_MAP_ID] [int] IDENTITY(1,1) NOT NULL,
	[REGIONALIZED_NETWORK_ID] [int] NOT NULL,
	[REGIONALIZED_IU_ID] [int] NOT NULL,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_NETWORK_IU_MAP] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_NETWORK_IU_MAP_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGO Unique identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_NETWORK_IU_MAP_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGO Unique identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_NETWORK_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot unique identifier for an insertion unit (channel)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_IU_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier that is system generated and that will change when the row changes to indicate an update is necessary' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'msrepl_tran_version'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_NETWORK_ID_-->_REGIONALIZED_NETWORK_REGIONALIZED_NETWORK_ID] FOREIGN KEY([REGIONALIZED_NETWORK_ID])
REFERENCES [dbo].[REGIONALIZED_NETWORK] ([REGIONALIZED_NETWORK_ID])
GO

ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP] CHECK CONSTRAINT [FK_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_NETWORK_ID_-->_REGIONALIZED_NETWORK_REGIONALIZED_NETWORK_ID]
GO


ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_IU_ID_-->_REGIONALIZED_IU_REGIONALIZED_IU_ID] FOREIGN KEY ([REGIONALIZED_IU_ID])
REFERENCES [dbo].[REGIONALIZED_IU] ([REGIONALIZED_IU_ID])
GO

ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP] CHECK CONSTRAINT [FK_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_IU_ID_-->_REGIONALIZED_IU_REGIONALIZED_IU_ID]
GO


CREATE UNIQUE INDEX UNC_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_IU_ID_REGIONALIZED_NETWORK_ID_imsrepl_tran_version ON dbo.REGIONALIZED_NETWORK_IU_MAP ( REGIONALIZED_IU_ID, REGIONALIZED_NETWORK_ID ) INCLUDE ( msrepl_tran_version )
GO

CREATE UNIQUE INDEX UNC_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_NETWORK_ID_REGIONALIZED_IU_ID_imsrepl_tran_version ON dbo.REGIONALIZED_NETWORK_IU_MAP ( REGIONALIZED_NETWORK_ID, REGIONALIZED_IU_ID ) INCLUDE ( msrepl_tran_version )
GO


ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP] ADD  CONSTRAINT [DF_REGIONALIZED_NETWORK_IU_MAP_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP] ADD  CONSTRAINT [DF_REGIONALIZED_NETWORK_IU_MAP_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO


