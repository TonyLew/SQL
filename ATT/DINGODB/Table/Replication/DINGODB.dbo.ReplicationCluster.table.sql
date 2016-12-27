
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
// Module: dbo.ReplicationCluster
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of ReplicationClusters
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ReplicationCluster.table.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//
*/ 

USE [DINGODB]
GO

/****** Object:  Table [dbo].[ReplicationCluster]    Script Date: 09/25/2013 11:02:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[ReplicationCluster]
CREATE TABLE [dbo].[ReplicationCluster](
	[ReplicationClusterID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[NameFQ] [varchar](100) NOT NULL,
	[VIP] [varchar](50) NOT NULL,
	[ModuloValue] [int] NULL,
	[Description] [varchar](200) NULL,
	[Enabled] bit NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ReplicationCluster] PRIMARY KEY CLUSTERED 
(
	[ReplicationClusterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a ReplicationCluster' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationCluster', @level2type=N'COLUMN',@level2name=N'ReplicationClusterID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of a ReplicationCluster' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationCluster', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP address for a ReplicationCluster' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationCluster', @level2type=N'COLUMN',@level2name=N'VIP'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Modulo value for a ReplicationCluster.  Used by to determine which cluster will accomodate each logical SDB node.  Values start at zero.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationCluster', @level2type=N'COLUMN',@level2name=N'ModuloValue'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description for a ReplicationCluster' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationCluster', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manual setting for availability of a ReplicationCluster' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationCluster', @level2type=N'COLUMN',@level2name=N'Enabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationCluster', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReplicationCluster', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[ReplicationCluster] ADD  CONSTRAINT [DF_ReplicationCluster_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ReplicationCluster] ADD  CONSTRAINT [DF_ReplicationCluster_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[ReplicationCluster] ADD  CONSTRAINT [DF_ReplicationCluster_Enabled]  DEFAULT (1) FOR [Enabled]
GO

CREATE UNIQUE INDEX UNC_ReplicationCluster_Name ON dbo.ReplicationCluster ( Name )
GO

CREATE UNIQUE INDEX UNC_ReplicationCluster_VIP ON dbo.ReplicationCluster ( VIP )
GO

CREATE UNIQUE INDEX UNC_ReplicationCluster_ModuloValue ON dbo.ReplicationCluster ( ModuloValue )
GO

----Truncate Table dbo.ReplicationCluster

--------DELETE dbo.ReplicationCluster Where ReplicationClusterID >= 1
--INSERT dbo.ReplicationCluster ( Name, VIP, Description, CreateDate, UpdateDate )
--SELECT x.[Name], x.CILLI, x.Description, GETUTCDATE() AS CreateDate, GETUTCDATE() AS UpdateDate
--FROM (
--		SELECT 'AUS'	AS [Name], 'AUS2TX' AS [VIP], 0 AS ModuloValue, 'Austin, TX' AS Description,	10 AS SortOrder UNION
--		SELECT 'CLE'	AS [Name], 'BCVLOH' AS [VIP], 1 AS ModuloValue, 'Cleveland, OH' AS Description,	20 AS SortOrder UNION
--		SELECT 'BKF'	AS [Name], 'BKF2CA' AS [VIP], 2 AS ModuloValue, 'Bakersfield, CA' AS Description,	30 AS SortOrder UNION
--		SELECT 'BIR'	AS [Name], 'BRHMAL' AS [VIP], 3 AS ModuloValue, 'Birmingham, AL' AS Description,	40 AS SortOrder UNION
--		SELECT 'BAT'	AS [Name], 'BTRGLA' AS [VIP], 4 AS ModuloValue, 'Baton Rouge, LA' AS Description,	50 AS SortOrder UNION
--		SELECT 'HRT'	AS [Name], 'WLFRCT' AS [VIP], 5 AS ModuloValue, 'Wallingford, CT' AS Description,	60 AS SortOrder 
--) x
--left join dbo.ReplicationCluster y
--on x.Name = y.Name
--where y.ReplicationClusterID is null
--Order by x.SortOrder,x.Name
--select * from dbo.ReplicationCluster

