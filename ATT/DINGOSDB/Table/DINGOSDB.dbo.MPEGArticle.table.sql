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
// Module: dbo.MPEGArticle
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of MPEGArticles
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOSDB.dbo.MPEGArticle.table.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//
*/ 

USE [DINGOSDB]
GO

/****** Object:  Table [dbo].[MPEGArticle]    Script Date: 09/25/2013 11:02:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[MPEGArticle]
CREATE TABLE [dbo].[MPEGArticle](
	[MPEGArticleID] [int] IDENTITY(1,1) NOT NULL,
	[CMD] [nvarchar](MAX) NOT NULL,
	[CMDType] [varchar](100) NOT NULL,
	[CMDParam] [varchar](500) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MPEGArticle] PRIMARY KEY CLUSTERED 
(
	[MPEGArticleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOSDB Unique Identifier for a MPEGArticle' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'MPEGArticleID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Command to execute.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'CMD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of object to create' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'CMDType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'List of parameters to pass to Stored Procedure call.  This column is only important with CMDType = "INSERT-EXEC" ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'CMDParam'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Normally used for stored procedure names.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MPEGArticle', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[MPEGArticle] ADD  CONSTRAINT [DF_MPEGArticle_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[MPEGArticle] ADD  CONSTRAINT [DF_MPEGArticle_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO





