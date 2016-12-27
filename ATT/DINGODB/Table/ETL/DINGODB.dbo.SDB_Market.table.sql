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
// Module:  dbo.SDB_Market
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Mapping of SDB to Market
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SDB_Market.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO


CREATE TABLE [dbo].[SDB_Market](
	[SDB_MarketID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[MarketID] [int] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SDB_Market] PRIMARY KEY CLUSTERED 
(
	[SDB_MarketID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a SDB_Market mapping' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'SDB_MarketID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a SDB logical DB system' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a Market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'MarketID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the last row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


USE [DINGODB]
GO

ALTER TABLE [dbo].[SDB_Market]  WITH CHECK ADD  CONSTRAINT [FK_SDB_Market_MarketID_-->_Market_MarketID] FOREIGN KEY([MarketID])
REFERENCES [dbo].[Market] ([MarketID])
GO

ALTER TABLE [dbo].[SDB_Market] CHECK CONSTRAINT [FK_SDB_Market_MarketID_-->_Market_MarketID]
GO


CREATE NONCLUSTERED INDEX NC_SDB_Market_Enabled_SDBSourceID_MarketID ON dbo.SDB_Market (Enabled,SDBSourceID,MarketID)
GO

CREATE UNIQUE INDEX UNC_SDB_Market_SDBSourceID_MarketID_iEnabled ON dbo.SDB_Market ( SDBSourceID, MarketID ) INCLUDE ( Enabled )
GO

ALTER TABLE [dbo].[SDB_Market] ADD  CONSTRAINT [DF_SDB_Market_Enabled]  DEFAULT (1) FOR [Enabled]
GO

ALTER TABLE [dbo].[SDB_Market] ADD  CONSTRAINT [DF_SDB_Market_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[SDB_Market] ADD  CONSTRAINT [DF_SDB_Market_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO


----Truncate Table dbo.SDB_Market
--------DELETE dbo.SDB_Market Where SDB_MarketID >= 1
--INSERT dbo.SDB_Market ( SDBSourceID, MarketID, CreateDate, UpdateDate )
--SELECT z.SDBSourceID, y.MarketID, GETUTCDATE() AS CreateDate, GETUTCDATE() AS UpdateDate
--FROM (
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'n/a' AS Name, '' AS Description,	1 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'AUS2TX' AS [Name], 'Austin, TX' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'BCVLOH' AS [Name], 'Cleveland, OH' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'BKF2CA' AS [Name], 'Bakersfield, CA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'BRHMAL' AS [Name], 'Birmingham, AL' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'BTRGLA' AS [Name], 'Baton Rouge, LA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'CHRLNC' AS [Name], 'Charlotte, NC' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'CICRIL' AS [Name], 'Chicago, IL' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'CLMASC' AS [Name], 'Columbia, SC' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'CLMBOH' AS [Name], 'Columbus, OH' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'CNTMOH' AS [Name], 'Dayton, OH' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'DCTRIL' AS [Name], 'Springfield, IL' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'DYBHFL' AS [Name], 'Daytona Beach, FL' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'FROKCA' AS [Name], 'Sacramento, CA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'FRS2CA' AS [Name], 'Fresno, CA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'FYVLAR' AS [Name], 'Ft. Smith, AR' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'GDRPMI' AS [Name], 'Grand Rapids, MI' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'GNVLSC' AS [Name], 'Greenville, SC' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'HSTNTX' AS [Name], 'Houston, TX' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'IPLSIN' AS [Name], 'Indianapolis, IN' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'IRV2CA' AS [Name], 'Irvine, CA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'JCSNMS' AS [Name], 'Jackson, MS' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'JCVLFL' AS [Name], 'Jacksonville, FL' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'LIVNMI' AS [Name], 'Detroit, MI' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'LNNGMI' AS [Name], 'Lansing, MI' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'LSVLKY' AS [Name], 'Louisville, KY' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'LTRKAR' AS [Name], 'Little Rock, AR' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'MDS2WI' AS [Name], 'Madison, WI' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'MIAMFL' AS [Name], 'Miami, FL' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'MIL2WI' AS [Name], 'Milwaukee, WI' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'MMPHTN' AS [Name], 'Memphis, TN' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'MOBLAL' AS [Name], 'Mobile, AL' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'MSSNKV' AS [Name], 'Mission, KS' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'MTRYCA' AS [Name], 'Monterey, CA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'NSVLTN' AS [Name], 'Nashville, TN' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'NWORLA' AS [Name], 'New Orleans, LA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'OKCYOK' AS [Name], 'Oklahoma City, OK' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'OSHKWI' AS [Name], 'Oshkosh, WI' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'RCSNTX' AS [Name], 'Dallas, TX' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'RENONV' AS [Name], 'Reno, NC' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'RLGHNC' AS [Name], 'Raleigh, NC' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'SGN2MI' AS [Name], 'Saginaw, MI' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'SNANTX' AS [Name], 'San Antonio, TX' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'SND3CA' AS [Name], 'San Diego, CA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'SNTCCA' AS [Name], 'Santa Clara, CA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'STL2MO' AS [Name], 'St Louis, MO' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'TOLDOH' AS [Name], 'Toledo, OH' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'TUKRGV' AS [Name], 'Tucker, GA' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'WCH2KS' AS [Name], 'Wichita, KS' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'WEPBFL' AS [Name], 'West Palm Beach, FL' AS Description,	30 AS SortOrder UNION
--SELECT 	'MSSNKNLSDB001' AS SDBComputerNamePrefix, 'WLFRCT' AS [Name], 'Wallingford, CT' AS Description,	30 AS SortOrder 
--) x
--join dbo.Market y (NOLOCK)
--on x.Name = y.Name
--join dbo.SDBSource z (NOLOCK)
--on x.SDBComputerNamePrefix = z.SDBComputerNamePrefix
----where y.SDB_MarketID is null
--Order by x.SortOrder,x.Name
--select * from dbo.SDB_Market
