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
// Module: dbo.EventLogStatus
// Created: 2014-Jul-20
// Author:  Tony Lew
// 
// Purpose: List of event types
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.EventLogStatus.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGOSDB]
GO

--DROP TABLE [dbo].[EventLogStatus]
CREATE TABLE [dbo].[EventLogStatus](
	[EventLogStatusID] [int] IDENTITY(1,1) NOT NULL,
	[EventLogStatusTypeID] [int] NOT NULL,
	[SP] [varchar](100) NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EventLogStatus] PRIMARY KEY CLUSTERED 
(
	[EventLogStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'EventLogStatusID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'FK to EventLogStatusType table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'EventLogStatusTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

--ALTER TABLE [dbo].[EventLogStatus]  DROP  CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID]
ALTER TABLE [dbo].[EventLogStatus]  WITH CHECK ADD  CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID] FOREIGN KEY([EventLogStatusTypeID])
REFERENCES [dbo].[EventLogStatusType] ([EventLogStatusTypeID])
GO

ALTER TABLE [dbo].[EventLogStatus] CHECK CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID]
GO

ALTER TABLE [dbo].[EventLogStatus] ADD  CONSTRAINT [DF_EventLogStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[EventLogStatus] ADD  CONSTRAINT [DF_EventLogStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO





