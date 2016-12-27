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
// Module:  dbo.MDBSource
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Logical MDB DB server description
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MDBSource.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO


--DROP TABLE [dbo].[MDBSource]
CREATE TABLE [dbo].[MDBSource](
	[MDBSourceID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[MDBComputerNamePrefix] [varchar](32) NOT NULL,
	[NodeID] [int] NOT NULL,
	[JobID] [uniqueidentifier] NULL,
	[JobName] [varchar](100) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MDBSource] PRIMARY KEY CLUSTERED 
(
	[MDBSourceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto Generated Primary Key for MDSSource' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The RegionID which this MDB serves' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'RegionID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MDB computer name minus the node number and P or B.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'MDBComputerNamePrefix'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The node number taken from the computer name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'NodeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The SQL Job ID used to extract data from this MDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'JobID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The SQL Job name used to extract data from this SDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'JobName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[MDBSource]  WITH CHECK ADD  CONSTRAINT [FK_MDBSource_RegionID_-->_Region_RegionID] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Region] ([RegionID])
GO

ALTER TABLE [dbo].[MDBSource] CHECK CONSTRAINT [FK_MDBSource_RegionID_-->_Region_RegionID]
GO

ALTER TABLE [dbo].[MDBSource] ADD  CONSTRAINT [DF_MDBSource_CreateDate]  DEFAULT (GETUTCDATE()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[MDBSource] ADD  CONSTRAINT [DF_MDBSource_UpdateDate]  DEFAULT (GETUTCDATE()) FOR [UpdateDate]
GO

CREATE UNIQUE INDEX UNC_MDBSource_MDBComputerNamePrefix_iJobID_JobName ON dbo.MDBSource ( MDBComputerNamePrefix ) INCLUDE ( JobID, JobName )
GO


		--DECLARE @RegionID INT = 1
		----TRUNCATE TABLE		dbo.MDBSource
		--INSERT				dbo.MDBSource
		--					(
		--					RegionID,
		--					MDBComputerNamePrefix,
		--					NodeID,
		--					--JobID,
		--					JobName
		--					)
		--SELECT
		--					1 AS RegionID,
		--					x.MDBComputerNamePrefix,
		--					--SUBSTRING(ComputerName,LEN(ComputerName)-1,1) AS NodeID,
		--					SUBSTRING(x.MDBComputerNamePrefix,LEN(MDBComputerNamePrefix),1) AS NodeID,
		--					'Region ' + CAST(@RegionID AS VARCHAR(50)) + ' Job Executor' AS JobName
		--FROM				(
		--						SELECT SUBSTRING(ComputerName,1,LEN(ComputerName)-1) AS MDBComputerNamePrefix
		--						FROM HAdb.dbo.HAMachine 
		--						WHERE SystemType = 12
		--						GROUP BY SUBSTRING(ComputerName,1,LEN(ComputerName)-1) 
		--					) x


		--select	* from dbo.MDBSource
