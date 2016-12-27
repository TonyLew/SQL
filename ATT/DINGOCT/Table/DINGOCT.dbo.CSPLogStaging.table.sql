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
// Module:  dbo.CSPLogStaging
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Initial entry point for the SYSLog file for the ETL process
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOCT.dbo.CSPLogStaging.table.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//
*/ 

USE [DINGOCT]
GO


--DROP TABLE [dbo].[CSPLogStaging]
CREATE TABLE [dbo].[CSPLogStaging](
	[CSPLogStagingID] [int] IDENTITY(1,1) NOT NULL,
	[UTCDayOfYearPartitionKey] [int] NOT NULL,
	[OccuranceDateStamp] [varchar](25) NOT NULL,
	[OccuranceTimeStamp] [varchar](50) NOT NULL,
	[Severity] [varchar](200) NULL,
	[HostName] [varchar](200) NULL,
	[Tag] [varchar](200) NULL,
	[FileName] [varchar](200) NULL,
	[FilePath] [varchar](200) NULL,
	[Message] [varchar](500) NULL,
	[Status] [int] NULL,
	[TokenID] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CSPLogStaging] PRIMARY KEY CLUSTERED 
(
	[CSPLogStagingID] ASC,
	[UTCDayOfYearPartitionKey]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DayOfYearPartitionScheme](UTCDayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](UTCDayOfYearPartitionKey)
GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'CSPLogStagingID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The corresponding UTC day of year of the OccuranceTimeStamp column value.  This is the designated DINGOCT partition key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'UTCDayOfYearPartitionKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The UTC date given by syslog.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'OccuranceDateStamp'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The UTC time given by syslog.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'OccuranceTimeStamp'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Severity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Hostname'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Tag'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'FileName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'FilePath'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Message'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'TokenID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Status value indicating ETL progress of the row.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

ALTER TABLE [dbo].[CSPLogStaging] ADD  CONSTRAINT [DF_CSPLogStaging_UTCDayOfYearPartitionKey]  DEFAULT ( datepart(dy,getutcdate()) ) FOR [UTCDayOfYearPartitionKey]
GO

ALTER TABLE [dbo].[CSPLogStaging] ADD  CONSTRAINT [DF_CSPLogStaging_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[CSPLogStaging] ADD  CONSTRAINT [DF_CSPLogStaging_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[CSPLogStaging] ADD  CONSTRAINT [DF_CSPLogStaging_TokenID]  DEFAULT (NEWID()) FOR [TokenID]
GO

--DROP INDEX dbo.CSPLogStaging.FNC_CSPLogStaging_Status 
CREATE NONCLUSTERED INDEX FNC_CSPLogStaging_Status ON dbo.CSPLogStaging ( Status ) WHERE Status IS NULL 
GO

