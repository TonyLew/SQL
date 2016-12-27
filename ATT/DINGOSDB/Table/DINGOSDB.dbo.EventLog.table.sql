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
// Module: dbo.EventLog
// Created: 2014-Jul-20
// Author:  Tony Lew
// 
// Purpose: List of events
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.EventLog.table.sql 3497 2014-02-14 00:08:24Z tlew $
//    
//
*/ 

USE [DINGOSDB]
GO

/****** Object:  Table [dbo].[EventLog]    Script Date: 09/25/2013 10:37:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[EventLog](
	[EventLogID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [uniqueidentifier] NULL,
	[JobName] [varchar](200) NULL,
	[DBID] [int] NULL,
	[DBComputerName] [varchar](32) NULL,
	[EventLogStatusID] [int] NOT NULL,
	[Description] [varchar](200) NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishDate] [datetime] NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[EventLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for an event.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'EventLogID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL Job Unique Identifier.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'JobID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL Job name.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'Jobname'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB database ID.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'DBID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB database computer name.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'DBComputerName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Event log status identifier.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'EventLogStatusID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Event log event description.' , @level0type=N'SCHEMA',@level0name=N'dbo', 
@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', 
				@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'StartDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', 
				@level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'FinishDate'
GO

--ALTER TABLE [dbo].[EventLog]  DROP  CONSTRAINT [FK_EventLog_EventLogStatusID_-->_EventLogStatus_EventLogStatusID] 
ALTER TABLE [dbo].[EventLog]  WITH CHECK ADD  CONSTRAINT [FK_EventLog_EventLogStatusID_-->_EventLogStatus_EventLogStatusID] FOREIGN KEY([EventLogStatusID])
REFERENCES [dbo].[EventLogStatus] ([EventLogStatusID])
GO

ALTER TABLE [dbo].[EventLog] CHECK CONSTRAINT [FK_EventLog_EventLogStatusID_-->_EventLogStatus_EventLogStatusID]
GO

