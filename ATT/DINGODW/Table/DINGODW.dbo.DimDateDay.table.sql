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
// Module: dbo.DimDateDay
// Created: 2014-May-10
// Author:  Tony Lew
// 
// Purpose: Dimension table for Dates.  Designed and used for reporting purposes.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DimDateDay.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODW]
GO

/****** Object:  Table [dbo].[DimDateDay]    Script Date: 4/24/2014 10:13:36 AM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[DimDateDay]
CREATE TABLE [dbo].[DimDateDay]
(
	[DimDate] [DATE] NOT NULL,
	[DateYear] [int] NOT NULL,
	[DateQuarter] [int] NOT NULL,
	[DateMonth] [int] NOT NULL,
	[DateDay] [int] NOT NULL,
	[DateDayOfWeek] [int] NOT NULL,
	[DayOfYearPartitionKey] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DimDateDay_CreateDate]  DEFAULT (GETUTCDATE()),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_DimDateDay_UpdateDate]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_DimDateDay] PRIMARY KEY CLUSTERED 
(
	[DimDate] ASC,
	[DayOfYearPartitionKey] 
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme](DayOfYearPartitionKey)
) ON [DayOfYearPartitionScheme](DayOfYearPartitionKey)

GO

SET ANSI_PADDING OFF
GO



EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date unique identifier.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DimDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateYear'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateQuarter'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Month of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day of month of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateDay'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day of week of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateDayOfWeek'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day of year of DimDateDay.  Used for partitioning.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DayOfYearPartitionKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO



--alter table dbo.XSEU Drop Constraint [FK_XSEU_UTCDimDateDay_UTCDY-->_DimDate_DimDateDay_DY]








