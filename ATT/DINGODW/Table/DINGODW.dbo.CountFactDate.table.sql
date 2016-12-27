
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
// Module: dbo.CountFactDate
// Created: 2014-May-01
// Author:  Tony Lew
// 
// Purpose: Count of facts by day
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.Fact.table.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//
*/ 


USE [DINGODW]
GO

/****** Object:  Table [dbo].[CountFactDate]    Script Date: 6/16/2014 3:20:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CountFactDate](
	[CountFactDateID] [int] IDENTITY(1,1) NOT NULL,
	[UTCDateStored] [date] NOT NULL,
	[FactID] [int] NOT NULL,
	[FactCount] [int] NOT NULL,
	[Enabled] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CountFactDate] PRIMARY KEY CLUSTERED 
(
	[CountFactDateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CountFactDate] ADD  CONSTRAINT [DF_CountFactDate_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO

ALTER TABLE [dbo].[CountFactDate] ADD  CONSTRAINT [DF_CountFactDate_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[CountFactDate] ADD  CONSTRAINT [DF_CountFactDate_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[CountFactDate]  WITH CHECK ADD  CONSTRAINT [FK_CountFactDate_FactID_-->_Fact_FactID] FOREIGN KEY([FactID])
REFERENCES [dbo].[Fact] ([FactID])
GO

ALTER TABLE [dbo].[CountFactDate] CHECK CONSTRAINT [FK_CountFactDate_FactID_-->_Fact_FactID]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Fact to day record.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'CountFactDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC Date Stored in Fact table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'UTCDateStored'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Fact.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'FactID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Count of the records for this Fact for a particular day.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'FactCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to determine if count for a particular Fact and particular Date should be used to determine validity.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'Enabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


