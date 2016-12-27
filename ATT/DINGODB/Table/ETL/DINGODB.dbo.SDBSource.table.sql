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
// Module:  dbo.SDBSource
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Logical SDB DB server description
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SDBSource.table.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//
*/ 

USE [DINGODB]
GO


--DROP TABLE [dbo].[SDBSource]
CREATE TABLE [dbo].[SDBSource](
	[SDBSourceID] [int] IDENTITY(1,1) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[SDBComputerNamePrefix] [varchar](32) NOT NULL,
	[NodeID] [int] NOT NULL,
	[ReplicationClusterID] [int] NOT NULL,
	[SDBStatus] [int] NOT NULL,
	[JobName] [varchar](100) NULL,
	[JobID] [uniqueidentifier] NULL,
	[UTCOffset] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SDBSource] PRIMARY KEY CLUSTERED 
(
	[SDBSourceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to the associated MDB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB computer name minus the node number and P or B.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'SDBComputerNamePrefix'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The node number taken from the computer name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'NodeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The ID of the Replication Cluster that will accomodate the logical SDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'ReplicationClusterID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The currently active physical SDB of the logical SDB node ( 1 = Primary, 5 = Backup )' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'SDBStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The SQL Job name used to extract data from this SDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'JobName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The SQL Job ID used to extract data from this SDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'JobID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The UTC hour offset for the SDB system.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'UTCOffset'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[SDBSource] ADD  CONSTRAINT [DF_SDBSource_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[SDBSource] ADD  CONSTRAINT [DF_SDBSource_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[SDBSource] ADD  CONSTRAINT [DF_SDBSource_ReplicationClusterID]  DEFAULT (0) FOR [ReplicationClusterID]
GO

ALTER TABLE [dbo].[SDBSource]  WITH CHECK ADD  CONSTRAINT [FK_SDBSource_MDBSourceID_-->_MDBSource_MDBSourceID] FOREIGN KEY([MDBSourceID])
REFERENCES [dbo].[MDBSource] ([MDBSourceID])
GO

ALTER TABLE [dbo].[SDBSource] CHECK CONSTRAINT [FK_SDBSource_MDBSourceID_-->_MDBSource_MDBSourceID]
GO


ALTER TABLE [dbo].[SDBSource]  WITH CHECK ADD  CONSTRAINT [FK_SDBSource_ReplicationClusterID_-->_ReplicationCluster_ReplicationClusterID] FOREIGN KEY([ReplicationClusterID])
REFERENCES [dbo].[ReplicationCluster] ([ReplicationClusterID])
GO

ALTER TABLE [dbo].[SDBSource] CHECK CONSTRAINT [FK_SDBSource_ReplicationClusterID_-->_ReplicationCluster_ReplicationClusterID]
GO

--ALTER TABLE [dbo].[SDBSource] DROP CONSTRAINT [FK_SDBSource_ReplicationClusterID_-->_ReplicationCluster_ReplicationClusterID]
--GO



CREATE INDEX NC_SDBSource_JobID_NodeID_iSDBComputerNamePrefix ON dbo.SDBSource ( JobID, NodeID ) INCLUDE (SDBComputerNamePrefix)
GO

CREATE UNIQUE INDEX UNC_SDBSource_SDBComputerNamePrefix_iUTCOffset ON dbo.SDBSource ( SDBComputerNamePrefix ) INCLUDE ( UTCOffset )
GO


		--DECLARE @RegionID INT = 1
		--DECLARE @MDBSourceID INT
		--select	TOP 1 @MDBSourceID = MDBSourceID from dbo.MDBSource where RegionID = @RegionID

		--TRUNCATE TABLE		dbo.SDBSource
		--INSERT				dbo.SDBSource
		--					(
		--						MDBSourceID,
		--						SDBComputerNamePrefix,
		--						NodeID,
		--						--JobID,
		--						JobName
		--					)
		--SELECT				@MDBSourceID AS MDBSourceID,
		--					x.SDBComputerNamePrefix,
		--					SUBSTRING(x.SDBComputerNamePrefix,LEN(x.SDBComputerNamePrefix),1) AS NodeID,
		--					'Region ' + CAST(@RegionID AS VARCHAR(50)) + ' ' + x.SDBComputerNamePrefix + ' MPEG Import' AS JobName
		--FROM				(
		--						SELECT	SUBSTRING(ComputerName,1,LEN(ComputerName)-1) AS SDBComputerNamePrefix
		--						FROM HAdb.dbo.HAMachine (NOLOCK)
		--						WHERE SystemType = 13
		--						GROUP BY SUBSTRING(ComputerName,1,LEN(ComputerName)-1) 
		--					) x


		--select	* from dbo.SDBSource


