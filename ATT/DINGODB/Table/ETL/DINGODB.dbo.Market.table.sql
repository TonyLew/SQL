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
// Module: dbo.Market
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of Markets
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.Market.table.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

/****** Object:  Table [dbo].[Market]    Script Date: 09/25/2013 11:02:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[Market]
CREATE TABLE [dbo].[Market](
	[MarketID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CILLI] [varchar](50) NOT NULL,
	[ProfileID] [varchar](5) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Market] PRIMARY KEY CLUSTERED 
(
	[MarketID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'MarketID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CLLI code for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CLLI code for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'CILLI'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ProfileID for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'ProfileID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the City and 2-character state identifier for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


CREATE UNIQUE INDEX UNC_Market_Name ON dbo.Market ( Name )
GO

----Truncate Table dbo.Market

--------DELETE dbo.Market Where MarketID >= 1
--INSERT dbo.Market ( Name, CILLI, Description, CreateDate, UpdateDate )
--SELECT x.[Name], x.CILLI, x.Description, GETUTCDATE() AS CreateDate, GETUTCDATE() AS UpdateDate
--FROM (
--		SELECT 'n/a'	AS [Name], 'n/a'	AS [CILLI],	'' AS Description,	1 AS SortOrder UNION
--		SELECT 'AUS'	AS [Name], 'AUS2TX' AS [CILLI], 'Austin, TX' AS Description,	30 AS SortOrder UNION
--		SELECT 'CLE'	AS [Name], 'BCVLOH' AS [CILLI], 'Cleveland, OH' AS Description,	30 AS SortOrder UNION
--		SELECT 'BKF'	AS [Name], 'BKF2CA' AS [CILLI], 'Bakersfield, CA' AS Description,	30 AS SortOrder UNION
--		SELECT 'BIR'	AS [Name], 'BRHMAL' AS [CILLI], 'Birmingham, AL' AS Description,	30 AS SortOrder UNION
--		SELECT 'BAT'	AS [Name], 'BTRGLA' AS [CILLI], 'Baton Rouge, LA' AS Description,	30 AS SortOrder UNION
--		SELECT 'CRL'	AS [Name], 'CHRLNC' AS [CILLI], 'Charlotte, NC' AS Description,	30 AS SortOrder UNION
--		SELECT 'CHI'	AS [Name], 'CICRIL' AS [CILLI], 'Chicago, IL' AS Description,	30 AS SortOrder UNION
--		SELECT 'CLB'	AS [Name], 'CLMASC' AS [CILLI], 'Columbia, SC' AS Description,	30 AS SortOrder UNION
--		SELECT 'COL'	AS [Name], 'CLMBOH' AS [CILLI], 'Columbus, OH' AS Description,	30 AS SortOrder UNION
--		SELECT 'DAY'	AS [Name], 'CNTMOH' AS [CILLI], 'Dayton, OH' AS Description,	30 AS SortOrder UNION
--		SELECT 'CMP'	AS [Name], 'DCTRIL' AS [CILLI], 'Springfield, IL' AS Description,	30 AS SortOrder UNION
--		SELECT 'ORL'	AS [Name], 'DYBHFL' AS [CILLI], 'Daytona Beach, FL' AS Description,	30 AS SortOrder UNION
--		SELECT 'SAC'	AS [Name], 'FROKCA' AS [CILLI], 'Sacramento, CA' AS Description,	30 AS SortOrder UNION
--		SELECT 'FRS'	AS [Name], 'FRS2CA' AS [CILLI], 'Fresno, CA' AS Description,	30 AS SortOrder UNION
--		SELECT 'FTS'	AS [Name], 'FYVLAR' AS [CILLI], 'Ft. Smith, AR' AS Description,	30 AS SortOrder UNION
--		SELECT 'GRP'	AS [Name], 'GDRPMI' AS [CILLI], 'Grand Rapids, MI' AS Description,	30 AS SortOrder UNION
--		SELECT 'GVL'	AS [Name], 'GNVLSC' AS [CILLI], 'Greenville, SC' AS Description,	30 AS SortOrder UNION
--		SELECT 'HST'	AS [Name], 'HSTNTX' AS [CILLI], 'Houston, TX' AS Description,	30 AS SortOrder UNION
--		SELECT 'IND'	AS [Name], 'IPLSIN' AS [CILLI], 'Indianapolis, IN' AS Description,	30 AS SortOrder UNION
--		SELECT 'LA'		AS [Name], 'IRV2CA' AS [CILLI], 'Irvine, CA' AS Description,	30 AS SortOrder UNION
--		SELECT 'JAK'	AS [Name], 'JCSNMS' AS [CILLI], 'Jackson, MS' AS Description,	30 AS SortOrder UNION
--		SELECT 'JVL'	AS [Name], 'JCVLFL' AS [CILLI], 'Jacksonville, FL' AS Description,	30 AS SortOrder UNION
--		SELECT 'DET'	AS [Name], 'LIVNMI' AS [CILLI], 'Detroit, MI' AS Description,	30 AS SortOrder UNION
--		SELECT 'LAN'	AS [Name], 'LNNGMI' AS [CILLI], 'Lansing, MI' AS Description,	30 AS SortOrder UNION
--		SELECT 'LVL'	AS [Name], 'LSVLKY' AS [CILLI], 'Louisville, KY' AS Description,	30 AS SortOrder UNION
--		SELECT 'LRK'	AS [Name], 'LTRKAR' AS [CILLI], 'Little Rock, AR' AS Description,	30 AS SortOrder UNION
--		SELECT 'MAD'	AS [Name], 'MDS2WI' AS [CILLI], 'Madison, WI' AS Description,	30 AS SortOrder UNION
--		SELECT 'MIA'	AS [Name], 'MIAMFL' AS [CILLI], 'Miami, FL' AS Description,	30 AS SortOrder UNION
--		SELECT 'MIL'	AS [Name], 'MIL2WI' AS [CILLI], 'Milwaukee, WI' AS Description,	30 AS SortOrder UNION
--		SELECT 'MEM'	AS [Name], 'MMPHTN' AS [CILLI], 'Memphis, TN' AS Description,	30 AS SortOrder UNION
--		SELECT 'MOB'	AS [Name], 'MOBLAL' AS [CILLI], 'Mobile, AL' AS Description,	30 AS SortOrder UNION
--		SELECT 'KC'		AS [Name], 'MSSNKV' AS [CILLI], 'Kansas City, KS' AS Description,	30 AS SortOrder UNION
--		SELECT 'MTY'	AS [Name], 'MTRYCA' AS [CILLI], 'Monterey, CA' AS Description,	30 AS SortOrder UNION
--		SELECT 'NSH'	AS [Name], 'NSVLTN' AS [CILLI], 'Nashville, TN' AS Description,	30 AS SortOrder UNION
--		SELECT 'NOL'	AS [Name], 'NWORLA' AS [CILLI], 'New Orleans, LA' AS Description,	30 AS SortOrder UNION
--		SELECT 'OKC'	AS [Name], 'OKCYOK' AS [CILLI], 'Oklahoma City, OK' AS Description,	30 AS SortOrder UNION
--		SELECT 'GBY'	AS [Name], 'OSHKWI' AS [CILLI], 'Oshkosh, WI' AS Description,	30 AS SortOrder UNION
--		SELECT 'DAL'	AS [Name], 'RCSNTX' AS [CILLI], 'Dallas, TX' AS Description,	30 AS SortOrder UNION
--		SELECT 'REN'	AS [Name], 'RENONV' AS [CILLI], 'Reno, NC' AS Description,	30 AS SortOrder UNION
--		SELECT 'RLE'	AS [Name], 'RLGHNC' AS [CILLI], 'Raleigh, NC' AS Description,	30 AS SortOrder UNION
--		SELECT 'SAG'	AS [Name], 'SGN2MI' AS [CILLI], 'Saginaw, MI' AS Description,	30 AS SortOrder UNION
--		SELECT 'SNA'	AS [Name], 'SNANTX' AS [CILLI], 'San Antonio, TX' AS Description,	30 AS SortOrder UNION
--		SELECT 'SND'	AS [Name], 'SND3CA' AS [CILLI], 'San Diego, CA' AS Description,	30 AS SortOrder UNION
--		SELECT 'STC'	AS [Name], 'SNTCCA' AS [CILLI], 'Santa Clara, CA' AS Description,	30 AS SortOrder UNION
--		SELECT 'STL'	AS [Name], 'STL2MO' AS [CILLI], 'St Louis, MO' AS Description,	30 AS SortOrder UNION
--		SELECT 'TOL'	AS [Name], 'TOLDOH' AS [CILLI], 'Toledo, OH' AS Description,	30 AS SortOrder UNION
--		SELECT 'ATL'	AS [Name], 'TUKRGV' AS [CILLI], 'Atlanta, GA' AS Description,	30 AS SortOrder UNION
--		SELECT 'WCH'	AS [Name], 'WCH2KS' AS [CILLI], 'Wichita, KS' AS Description,	30 AS SortOrder UNION
--		SELECT 'WPB'	AS [Name], 'WEPBFL' AS [CILLI], 'West Palm Beach, FL' AS Description,	30 AS SortOrder UNION
--		SELECT 'HRT'	AS [Name], 'WLFRCT' AS [CILLI], 'Wallingford, CT' AS Description,	30 AS SortOrder 
--) x
--left join dbo.Market y
--on x.Name = y.Name
--where y.MarketID is null
--Order by x.SortOrder,x.Name
--select * from dbo.Market

