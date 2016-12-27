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
// Module:  dbo.CSPLogImport
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Initial entry point for the SYSLog file for the ETL process
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOCT.dbo.CSPLogImport.table.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//
*/ 

USE [DINGOCT]
GO


--DROP TABLE [dbo].[CSPLogImport]
CREATE TABLE [dbo].[CSPLogImport](
	[CSPLogImportID] [int] IDENTITY(1,1) NOT NULL,
	[RowText] [varchar](2000) NULL,
	[Mark1] INT, 
	[Mark2] INT, 
	[Mark3] INT, 
	[Mark4] INT, 
	[Mark5] INT, 
	[Mark6] INT, 
	[Mark7] INT,
	[Mark8] INT,
	[Status] [int] NULL
 CONSTRAINT [PK_CSPLogImport] PRIMARY KEY CLUSTERED 
(
	[CSPLogImportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [Primary]
) ON [Primary]
GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogImport', @level2type=N'COLUMN',@level2name=N'CSPLogImportID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The row text.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogImport', @level2type=N'COLUMN',@level2name=N'RowText'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The row status.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogImport', @level2type=N'COLUMN',@level2name=N'Status'
GO


--DROP INDEX dbo.CSPLogImport.FNC_CSPLogImport_Status 
CREATE NONCLUSTERED INDEX FNC_CSPLogImport_Status ON dbo.CSPLogImport ( Status ) WHERE Status IS NULL 
GO

