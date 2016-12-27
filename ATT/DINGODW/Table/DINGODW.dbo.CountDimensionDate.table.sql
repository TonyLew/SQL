
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
// Module: dbo.CountDimensionDate
// Created: 2014-May-01
// Author:  Tony Lew
// 
// Purpose: Count of dimensions by SDBSourceID
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

/****** Object:  Table [dbo].[CountDimensionDate]    Script Date: 6/16/2014 3:20:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CountDimensionDate](
	[CountDimensionDateID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[UTCDateStored] [date] NOT NULL,
	[DimensionID] [int] NOT NULL,
	[DimensionCount] [int] NOT NULL,
	[Enabled] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CountDimensionDate] PRIMARY KEY CLUSTERED 
(
	[CountDimensionDateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CountDimensionDate] ADD  CONSTRAINT [DF_CountDimensionDate_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO

ALTER TABLE [dbo].[CountDimensionDate] ADD  CONSTRAINT [DF_CountDimensionDate_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[CountDimensionDate] ADD  CONSTRAINT [DF_CountDimensionDate_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[CountDimensionDate]  WITH CHECK ADD  CONSTRAINT [FK_CountDimensionDate_DimensionID_-->_Dimension_DimensionID] FOREIGN KEY([DimensionID])
REFERENCES [dbo].[Dimension] ([DimensionID])
GO

ALTER TABLE [dbo].[CountDimensionDate] CHECK CONSTRAINT [FK_CountDimensionDate_DimensionID_-->_Dimension_DimensionID]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a SDB to dimension to day record.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'CountDimensionDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a logical ID of the SDB system.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC Date Stored in dimension table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'UTCDateStored'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'DimensionID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Count of the records for this dimension for an SDB for a particular day.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'DimensionCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to determine if count for a particular dimension, for a particular SDB and particular Date should be used to determine validity.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'Enabled'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


