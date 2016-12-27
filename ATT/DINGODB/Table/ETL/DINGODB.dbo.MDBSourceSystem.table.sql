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
// Module:  dbo.MDBSourceSystem
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Physical MDB DB server description
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MDBSourceSystem.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[MDBSourceSystem]
CREATE TABLE [dbo].[MDBSourceSystem](
	[MDBSourceSystemID] [int] IDENTITY(1,1) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBID] [int] NULL,
	[MDBComputerName] [varchar](32) NOT NULL,
	[Role] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MDBSourceSystem] PRIMARY KEY CLUSTERED 
(
	[MDBSourceSystemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto Generated Primary Key for MDSSource' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'MDBSourceSystemID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key Reference to dbo.MDBSource.MDBSourceID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reference to HAdb.dbo.HAMachine.ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'MDBID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual computer name.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'MDBComputerName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Role 1 as primary or Role 2 as backup' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Role'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The operational status of an MDB server' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A manual switch available to disable an MDB server' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Enabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[MDBSourceSystem]  WITH CHECK ADD  CONSTRAINT [FK_MDBSourceSystem_MDBSourceID_-->_MDBSource_MDBSourceID] FOREIGN KEY([MDBSourceID])
REFERENCES [dbo].[MDBSource] ([MDBSourceID])
GO

ALTER TABLE [dbo].[MDBSourceSystem] CHECK CONSTRAINT [FK_MDBSourceSystem_MDBSourceID_-->_MDBSource_MDBSourceID]
GO

ALTER TABLE [dbo].[MDBSourceSystem] ADD  CONSTRAINT [DF_MDBSourceSystem_Status]  DEFAULT (1) FOR [Status]
GO

ALTER TABLE [dbo].[MDBSourceSystem] ADD  CONSTRAINT [DF_MDBSourceSystem_Enabled]  DEFAULT (1) FOR [Enabled]
GO

ALTER TABLE [dbo].[MDBSourceSystem] ADD  CONSTRAINT [DF_MDBSourceSystem_CreateDate]  DEFAULT (GETUTCDATE()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[MDBSourceSystem] ADD  CONSTRAINT [DF_MDBSourceSystem_UpdateDate]  DEFAULT (GETUTCDATE()) FOR [UpdateDate]
GO

CREATE UNIQUE INDEX UNC_MDBSourceSystem_MDBComputerName_iStatus_Enabled ON dbo.MDBSourceSystem ( MDBComputerName ) INCLUDE ( Status, Enabled )
GO

CREATE UNIQUE INDEX UNC_MDBSourceSystem_MDBSourceID_Role ON dbo.MDBSourceSystem ( MDBSourceID, Role )
GO


		--DECLARE @RegionID INT = 1
		--DECLARE @MDBSourceID INT
		--select	TOP 1 @MDBSourceID = MDBSourceID from dbo.MDBSource where RegionID = @RegionID
		
		--TRUNCATE TABLE		dbo.MDBSourceSystem
		--INSERT				dbo.MDBSourceSystem
		--				(
		--					MDBSourceID,
		--					MDBID,
		--					MDBComputerName,
		--					Role,
		--					Status,
		--					Enabled
		--				)
		--SELECT				
		--					@MDBSourceID AS MDBSourceID,
		--					x.ID AS MDBID,
		--					ComputerName AS MDBComputerName,
		--					x.Role,
		--					x.Status,
		--					1 AS Enabled
		--FROM				HAdb.dbo.HAMachine x (NOLOCK)
		--WHERE				x.SystemType = 12

		--select	* from dbo.MDBSourceSystem



