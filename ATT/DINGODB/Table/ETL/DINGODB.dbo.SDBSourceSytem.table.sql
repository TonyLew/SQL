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
// Module:  dbo.SDBSourceSystem
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Physical SDB DB server description
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SDBSourceSytem.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO


--DROP TABLE [dbo].[SDBSourceSystem]
CREATE TABLE [dbo].[SDBSourceSystem](
	[SDBSourceSystemID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBComputerName] [varchar](32) NOT NULL,
	[Role] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SDBSourceSystem] PRIMARY KEY CLUSTERED 
(
	[SDBSourceSystemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceSystemID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to SDB node table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual computer name.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'SDBComputerName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Role 1 as primary or Role 2 as backup' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Role'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Update of the most recent SDB server status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A manual switch available to disable the import of an SDB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Enabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the lsat row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[SDBSourceSystem]  WITH CHECK ADD  CONSTRAINT [FK_SDBSourceSystem_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY([SDBSourceID])
REFERENCES [dbo].[SDBSource] ([SDBSourceID])
GO

ALTER TABLE [dbo].[SDBSourceSystem] CHECK CONSTRAINT [FK_SDBSourceSystem_SDBSourceID_-->_SDBSource_SDBSourceID]
GO

ALTER TABLE [dbo].[SDBSourceSystem] ADD  CONSTRAINT [DF_SDBSourceSystem_Status]  DEFAULT (1) FOR [Status]
GO

ALTER TABLE [dbo].[SDBSourceSystem] ADD  CONSTRAINT [DF_SDBSourceSystem_Enabled]  DEFAULT (1) FOR [Enabled]
GO

ALTER TABLE [dbo].[SDBSourceSystem] ADD  CONSTRAINT [DF_SDBSourceSystem_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[SDBSourceSystem] ADD  CONSTRAINT [DF_SDBSourceSystem_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO


CREATE UNIQUE INDEX UNC_SDBSourceSystem_SDBComputerName_iStatus_Enabled ON dbo.SDBSourceSystem ( SDBComputerName ) INCLUDE ( Status, Enabled )
GO


CREATE UNIQUE INDEX UNC_SDBSourceSystem_SDBSourceID_Role ON dbo.SDBSourceSystem ( SDBSourceID, Role )
GO


	--	DECLARE @RegionID INT = 1
	--	DECLARE @MDBSourceID INT
	--	select	TOP 1 @MDBSourceID = MDBSourceID from dbo.MDBSource where RegionID = @RegionID
		
	--	TRUNCATE TABLE		dbo.SDBSourceSystem
	--	INSERT				dbo.SDBSourceSystem
	--					(
	--						SDBSourceID,
	--						SDBComputerName,
	--						Role,
	--						Status,
	--						Enabled
	--					)
	--	SELECT				
	--						--@MDBSourceID AS MDBSourceID,
	--						y.SDBSourceID,
	--						ComputerName AS SDBComputerName,
	--						x.Role,
	--						x.Status,
	--						1 AS Enabled
	--	FROM				HAdb.dbo.HAMachine x (NOLOCK)
	--	JOIN				dbo.SDBSource y (NOLOCK)
	--	ON					 SUBSTRING(x.ComputerName,1,LEN(x.ComputerName)-1) = y.SDBComputerNamePrefix
	--	WHERE				x.SystemType = 13
 
 --select * from dbo.SDBSourceSystem

