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
// Module: dbo.ZONE_MAP
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of zones and their mapping to markets, IC providers, and ROCs.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ZONE_MAP.table.sql 3495 2014-02-12 17:28:01Z tlew $
//    
//
*/ 

USE DINGODB
GO

--DROP TABLE [dbo].[ZONE_MAP]
CREATE TABLE [dbo].[ZONE_MAP](
	[ZONE_MAP_ID] [int] IDENTITY(0,1) NOT NULL,
	[ZONE_NAME] [varchar](32) NOT NULL,
	[MarketID] [int] NOT NULL,
	[ICProviderID] [int] NOT NULL,
	[ROCID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ZONE_MAP] PRIMARY KEY CLUSTERED 
(
	[ZONE_MAP_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'ZONE_MAP_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the zone' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'ZONE_NAME'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'MarketID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the IC Provider' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the ROC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'ROCID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', 
				@level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', 
				@level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


ALTER TABLE [dbo].[ZONE_MAP]  WITH CHECK ADD  CONSTRAINT [FK_ZONE_MAP_ICProviderID_-->_ICProvider_ICProviderID] FOREIGN KEY([ICProviderID])
REFERENCES [dbo].[ICProvider] ([ICProviderID])
GO

ALTER TABLE [dbo].[ZONE_MAP] CHECK CONSTRAINT [FK_ZONE_MAP_ICProviderID_-->_ICProvider_ICProviderID]
GO

ALTER TABLE [dbo].[ZONE_MAP]  WITH CHECK ADD  CONSTRAINT [FK_ZONE_MAP_MarketID_-->_Market_MarketID] FOREIGN KEY([MarketID])
REFERENCES [dbo].[Market] ([MarketID])
GO

ALTER TABLE [dbo].[ZONE_MAP] CHECK CONSTRAINT [FK_ZONE_MAP_MarketID_-->_Market_MarketID]
GO

ALTER TABLE [dbo].[ZONE_MAP]  WITH CHECK ADD  CONSTRAINT [FK_ZONE_MAP_ROCID_-->_ROC_ROCID] FOREIGN KEY([ROCID])
REFERENCES [dbo].[ROC] ([ROCID])
GO

ALTER TABLE [dbo].[ZONE_MAP] CHECK CONSTRAINT [FK_ZONE_MAP_ROCID_-->_ROC_ROCID]
GO




ALTER TABLE [dbo].[ZONE_MAP] ADD  CONSTRAINT [DF_ZONE_MAP_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[ZONE_MAP] ADD  CONSTRAINT [DF_ZONE_MAP_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[ZONE_MAP] ADD  CONSTRAINT [UNC_ZONE_MAP_ZONE_NAME]  UNIQUE  NONCLUSTERED( [ZONE_NAME] )
GO

CREATE UNIQUE INDEX UNC_ZONE_MAP_ZONE_NAME_MarketID_ICProviderID_ROCID ON dbo.ZONE_MAP ( ZONE_NAME, MarketID, ICProviderID, ROCID )
GO


Insert dbo.ZONE_MAP 
				(
				--REGIONALIZED_ZONE_ID,
				ZONE_NAME,
				MarketID,
				ICProviderID,
				ROCID
				)
select 
		--z.REGIONALIZED_ZONE_ID,
		x.ZoneName AS ZONE_NAME,
		b.MarketID,
		c.ICProviderID,
		d.ROCID
from	(


			Select  'Austin, TX' AS ZoneName, 'Austin, TX' AS MarketDescription, 'AUS2TX' AS MarketCILLI, 'AUS' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Austin, TX-01401' AS ZoneName, 'Austin, TX' AS MarketDescription, 'AUS2TX' AS MarketCILLI, 'AUS' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Austin, TX-01402' AS ZoneName, 'Austin, TX' AS MarketDescription, 'AUS2TX' AS MarketCILLI, 'AUS' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Austin, TX-01403' AS ZoneName, 'Austin, TX' AS MarketDescription, 'AUS2TX' AS MarketCILLI, 'AUS' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Austin, TX-01404' AS ZoneName, 'Austin, TX' AS MarketDescription, 'AUS2TX' AS MarketCILLI, 'AUS' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Austin, TX-01405' AS ZoneName, 'Austin, TX' AS MarketDescription, 'AUS2TX' AS MarketCILLI, 'AUS' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Cleveland, OH' AS ZoneName, 'Cleveland, OH' AS MarketDescription, 'BCVLOH' AS MarketCILLI, 'CLE' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Cleveland, OH-01701' AS ZoneName, 'Cleveland, OH' AS MarketDescription, 'BCVLOH' AS MarketCILLI, 'CLE' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Cleveland, OH-01702' AS ZoneName, 'Cleveland, OH' AS MarketDescription, 'BCVLOH' AS MarketCILLI, 'CLE' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Cleveland, OH-01703' AS ZoneName, 'Cleveland, OH' AS MarketDescription, 'BCVLOH' AS MarketCILLI, 'CLE' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Cleveland, OH-01704' AS ZoneName, 'Cleveland, OH' AS MarketDescription, 'BCVLOH' AS MarketCILLI, 'CLE' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Bakersfield, CA' AS ZoneName, 'Bakersfield, CA' AS MarketDescription, 'BKF2CA' AS MarketCILLI, 'BKF' AS MarketName, 'Bright House' AS ICProviderName, 'BH' AS ROCName UNION
			Select  'Birmingham, AL' AS ZoneName, 'Birmingham, AL' AS MarketDescription, 'BRHMAL' AS MarketCILLI, 'BIR' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Birmingham, AL-02901' AS ZoneName, 'Birmingham, AL' AS MarketDescription, 'BRHMAL' AS MarketCILLI, 'BIR' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Birmingham, AL-02902' AS ZoneName, 'Birmingham, AL' AS MarketDescription, 'BRHMAL' AS MarketCILLI, 'BIR' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Birmingham, AL-02903' AS ZoneName, 'Birmingham, AL' AS MarketDescription, 'BRHMAL' AS MarketCILLI, 'BIR' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Birmingham, AL-02904' AS ZoneName, 'Birmingham, AL' AS MarketDescription, 'BRHMAL' AS MarketCILLI, 'BIR' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Birmingham, AL-02905' AS ZoneName, 'Birmingham, AL' AS MarketDescription, 'BRHMAL' AS MarketCILLI, 'BIR' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Baton Rouge, LA' AS ZoneName, 'Baton Rouge, LA' AS MarketDescription, 'BTRGLA' AS MarketCILLI, 'BAT' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'Charlotte, NC' AS ZoneName, 'Charlotte, NC' AS MarketDescription, 'CHRLNC' AS MarketCILLI, 'CRL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (R)' AS ROCName UNION
			Select  'Charlotte, NC-02401' AS ZoneName, 'Charlotte, NC' AS MarketDescription, 'CHRLNC' AS MarketCILLI, 'CRL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (R)' AS ROCName UNION
			Select  'Charlotte, NC-02402' AS ZoneName, 'Charlotte, NC' AS MarketDescription, 'CHRLNC' AS MarketCILLI, 'CRL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (R)' AS ROCName UNION
			Select  'Charlotte, NC-02403' AS ZoneName, 'Charlotte, NC' AS MarketDescription, 'CHRLNC' AS MarketCILLI, 'CRL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (R)' AS ROCName UNION
			Select  'Chicago, IL' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00101' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00102' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00103' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00104' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00105' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00106' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00107' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00108' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00109' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00110' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00111' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00112' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00113' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00114' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00115' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00116' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00117' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00118' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Chicago, IL-00119' AS ZoneName, 'Chicago, IL' AS MarketDescription, 'CICRIL' AS MarketCILLI, 'CHI' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Columbia, SC' AS ZoneName, 'Columbia, SC' AS MarketDescription, 'CLMASC' AS MarketCILLI, 'CLB' AS MarketName, 'TWC' AS ICProviderName, 'TWC (R)' AS ROCName UNION
			Select  'Columbus, OH' AS ZoneName, 'Columbus, OH' AS MarketDescription, 'CLMBOH' AS MarketCILLI, 'COL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Columbus, OH-02001' AS ZoneName, 'Columbus, OH' AS MarketDescription, 'CLMBOH' AS MarketCILLI, 'COL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Columbus, OH-02002' AS ZoneName, 'Columbus, OH' AS MarketDescription, 'CLMBOH' AS MarketCILLI, 'COL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Columbus, OH-02003' AS ZoneName, 'Columbus, OH' AS MarketDescription, 'CLMBOH' AS MarketCILLI, 'COL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Columbus, OH-02004' AS ZoneName, 'Columbus, OH' AS MarketDescription, 'CLMBOH' AS MarketCILLI, 'COL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Columbus, OH-02005' AS ZoneName, 'Columbus, OH' AS MarketDescription, 'CLMBOH' AS MarketCILLI, 'COL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Dayton, OH' AS ZoneName, 'Dayton, OH' AS MarketDescription, 'CNTMOH' AS MarketCILLI, 'DAY' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Champaign, IL' AS ZoneName, 'Champaign, IL' AS MarketDescription, 'DCTRIL' AS MarketCILLI, 'CMP' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Orlando, FL' AS ZoneName, 'Orlando, FL' AS MarketDescription, 'DYBHFL' AS MarketCILLI, 'ORL' AS MarketName, 'Bright House' AS ICProviderName, 'BH' AS ROCName UNION
			Select  'Orlando, FL-01801' AS ZoneName, 'Orlando, FL' AS MarketDescription, 'DYBHFL' AS MarketCILLI, 'ORL' AS MarketName, 'Bright House' AS ICProviderName, 'BH' AS ROCName UNION
			Select  'Orlando, FL-01802' AS ZoneName, 'Orlando, FL' AS MarketDescription, 'DYBHFL' AS MarketCILLI, 'ORL' AS MarketName, 'Bright House' AS ICProviderName, 'BH' AS ROCName UNION
			Select  'Orlando, FL-01803' AS ZoneName, 'Orlando, FL' AS MarketDescription, 'DYBHFL' AS MarketCILLI, 'ORL' AS MarketName, 'Bright House' AS ICProviderName, 'BH' AS ROCName UNION
			Select  'Orlando, FL-01804' AS ZoneName, 'Orlando, FL' AS MarketDescription, 'DYBHFL' AS MarketCILLI, 'ORL' AS MarketName, 'Bright House' AS ICProviderName, 'BH' AS ROCName UNION
			Select  'Sacramento, CA' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00901' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00902' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00903' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00904' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00905' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00906' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00907' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00908' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00909' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00910' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00911' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00912' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00913' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00914' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Sacramento, CA-00915' AS ZoneName, 'Sacramento, CA' AS MarketDescription, 'FROKCA' AS MarketCILLI, 'SAC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Fresno, CA' AS ZoneName, 'Fresno, CA' AS MarketDescription, 'FRS2CA' AS MarketCILLI, 'FRS' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Fresno, CA-03001' AS ZoneName, 'Fresno, CA' AS MarketDescription, 'FRS2CA' AS MarketCILLI, 'FRS' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Fresno, CA-03002' AS ZoneName, 'Fresno, CA' AS MarketDescription, 'FRS2CA' AS MarketCILLI, 'FRS' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Fresno, CA-03003' AS ZoneName, 'Fresno, CA' AS MarketDescription, 'FRS2CA' AS MarketCILLI, 'FRS' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Ft. Smith, AR' AS ZoneName, 'Ft. Smith, AR' AS MarketDescription, 'FYVLAR' AS MarketCILLI, 'FTS' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'Grand Rapids, MI' AS ZoneName, 'Grand Rapids, MI' AS MarketDescription, 'GDRPMI' AS MarketCILLI, 'GRP' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Grand Rapids, MI-01901' AS ZoneName, 'Grand Rapids, MI' AS MarketDescription, 'GDRPMI' AS MarketCILLI, 'GRP' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Grand Rapids, MI-01902' AS ZoneName, 'Grand Rapids, MI' AS MarketDescription, 'GDRPMI' AS MarketCILLI, 'GRP' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Grand Rapids, MI-01903' AS ZoneName, 'Grand Rapids, MI' AS MarketDescription, 'GDRPMI' AS MarketCILLI, 'GRP' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Greenville, SC' AS ZoneName, 'Greenville, SC' AS MarketDescription, 'GNVLSC' AS MarketCILLI, 'GVL' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Houston, TX' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Houston, TX-00301' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Houston, TX-00302' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Houston, TX-00303' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Houston, TX-00304' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Houston, TX-00305' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Houston, TX-00306' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Houston, TX-00307' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Houston, TX-00308' AS ZoneName, 'Houston, TX' AS MarketDescription, 'HSTNTX' AS MarketCILLI, 'HST' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00801' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00802' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00803' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00804' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00805' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00806' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00807' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00808' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00809' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00810' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00811' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00812' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00813' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Indianapolis, IN-00814' AS ZoneName, 'Indianapolis, IN' AS MarketDescription, 'IPLSIN' AS MarketCILLI, 'IND' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Los Angeles, CA' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00401' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00402' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00403' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00404' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00405' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00406' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00407' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00408' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Los Angeles, CA-00409' AS ZoneName, 'Los Angeles, CA' AS MarketDescription, 'IRV2CA' AS MarketCILLI, 'LAN' AS MarketName, 'TWC' AS ICProviderName, 'TWC (L)' AS ROCName UNION
			Select  'Jackson, MS' AS ZoneName, 'Jackson, MS' AS MarketDescription, 'JCSNMS' AS MarketCILLI, 'JAK' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jackson, MS-04001' AS ZoneName, 'Jackson, MS' AS MarketDescription, 'JCSNMS' AS MarketCILLI, 'JAK' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jackson, MS-04002' AS ZoneName, 'Jackson, MS' AS MarketDescription, 'JCSNMS' AS MarketCILLI, 'JAK' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jackson, MS-04003' AS ZoneName, 'Jackson, MS' AS MarketDescription, 'JCSNMS' AS MarketCILLI, 'JAK' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jacksonville, FL' AS ZoneName, 'Jacksonville, FL' AS MarketDescription, 'JCVLFL' AS MarketCILLI, 'JVL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jacksonville, FL-02201' AS ZoneName, 'Jacksonville, FL' AS MarketDescription, 'JCVLFL' AS MarketCILLI, 'JVL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jacksonville, FL-02202' AS ZoneName, 'Jacksonville, FL' AS MarketDescription, 'JCVLFL' AS MarketCILLI, 'JVL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jacksonville, FL-02203' AS ZoneName, 'Jacksonville, FL' AS MarketDescription, 'JCVLFL' AS MarketCILLI, 'JVL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jacksonville, FL-02204' AS ZoneName, 'Jacksonville, FL' AS MarketDescription, 'JCVLFL' AS MarketCILLI, 'JVL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Jacksonville, FL-02205' AS ZoneName, 'Jacksonville, FL' AS MarketDescription, 'JCVLFL' AS MarketCILLI, 'JVL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00501' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00502' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00503' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00504' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00505' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00506' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00507' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00508' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00509' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00510' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00511' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Detroit, MI-00512' AS ZoneName, 'Detroit, MI' AS MarketDescription, 'LIVNMI' AS MarketCILLI, 'DET' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Lansing, MI' AS ZoneName, 'Lansing, MI' AS MarketDescription, 'LNNGMI' AS MarketCILLI, 'LAN' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Louisville, KY' AS ZoneName, 'Louisville, KY' AS MarketDescription, 'LSVLKY' AS MarketCILLI, 'LVL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Little Rock, AR' AS ZoneName, 'Little Rock, AR' AS MarketDescription, 'LTRKAR' AS MarketCILLI, 'LRK' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Little Rock, AR-02801' AS ZoneName, 'Little Rock, AR' AS MarketDescription, 'LTRKAR' AS MarketCILLI, 'LRK' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Little Rock, AR-02802' AS ZoneName, 'Little Rock, AR' AS MarketDescription, 'LTRKAR' AS MarketCILLI, 'LRK' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Little Rock, AR-02803' AS ZoneName, 'Little Rock, AR' AS MarketDescription, 'LTRKAR' AS MarketCILLI, 'LRK' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Madison, WI' AS ZoneName, 'Madison, WI' AS MarketDescription, 'MDS2WI' AS MarketCILLI, 'MAD' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Miami, FL' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01101' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01102' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01103' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01104' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01105' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01106' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01107' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01108' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01109' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01110' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01111' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Miami, FL-01112' AS ZoneName, 'Miami, FL' AS MarketDescription, 'MIAMFL' AS MarketCILLI, 'MIA' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Milwaukee, WI' AS ZoneName, 'Milwaukee, WI' AS MarketDescription, 'MIL2WI' AS MarketCILLI, 'MIL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Milwaukee, WI-01601' AS ZoneName, 'Milwaukee, WI' AS MarketDescription, 'MIL2WI' AS MarketCILLI, 'MIL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Milwaukee, WI-01602' AS ZoneName, 'Milwaukee, WI' AS MarketDescription, 'MIL2WI' AS MarketCILLI, 'MIL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Milwaukee, WI-01603' AS ZoneName, 'Milwaukee, WI' AS MarketDescription, 'MIL2WI' AS MarketCILLI, 'MIL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Milwaukee, WI-01604' AS ZoneName, 'Milwaukee, WI' AS MarketDescription, 'MIL2WI' AS MarketCILLI, 'MIL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Memphis, TN' AS ZoneName, 'Memphis, TN' AS MarketDescription, 'MMPHTN' AS MarketCILLI, 'MEM' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Memphis, TN-03201' AS ZoneName, 'Memphis, TN' AS MarketDescription, 'MMPHTN' AS MarketCILLI, 'MEM' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Memphis, TN-03202' AS ZoneName, 'Memphis, TN' AS MarketDescription, 'MMPHTN' AS MarketCILLI, 'MEM' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Memphis, TN-03203' AS ZoneName, 'Memphis, TN' AS MarketDescription, 'MMPHTN' AS MarketCILLI, 'MEM' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Memphis, TN-03204' AS ZoneName, 'Memphis, TN' AS MarketDescription, 'MMPHTN' AS MarketCILLI, 'MEM' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Mobile, AL' AS ZoneName, 'Mobile, AL' AS MarketDescription, 'MOBLAL' AS MarketCILLI, 'MOB' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'Kansas City, MO' AS ZoneName, 'Kansas City, MO' AS MarketDescription, 'MSSNKV' AS MarketCILLI, 'KC' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Kansas City, MO-02501' AS ZoneName, 'Kansas City, MO' AS MarketDescription, 'MSSNKV' AS MarketCILLI, 'KC' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Kansas City, MO-02502' AS ZoneName, 'Kansas City, MO' AS MarketDescription, 'MSSNKV' AS MarketCILLI, 'KC' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Kansas City, MO-02503' AS ZoneName, 'Kansas City, MO' AS MarketDescription, 'MSSNKV' AS MarketCILLI, 'KC' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Kansas City, MO-02504' AS ZoneName, 'Kansas City, MO' AS MarketDescription, 'MSSNKV' AS MarketCILLI, 'KC' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Kansas City, MO-02505' AS ZoneName, 'Kansas City, MO' AS MarketDescription, 'MSSNKV' AS MarketCILLI, 'KC' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Monterey, CA' AS ZoneName, 'Monterey, CA' AS MarketDescription, 'MTRYCA' AS MarketCILLI, 'MTY' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02301' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02302' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02303' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02304' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02305' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02306' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02307' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02308' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Nashville, TN-02309' AS ZoneName, 'Nashville, TN' AS MarketDescription, 'NSVLTN' AS MarketCILLI, 'NSH' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'New Orleans, LA' AS ZoneName, 'New Orleans, LA' AS MarketDescription, 'NWORLA' AS MarketCILLI, 'NOL' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'Oklahoma City, OK' AS ZoneName, 'Oklahoma City, OK' AS MarketDescription, 'OKCYOK' AS MarketCILLI, 'OKC' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'Green Bay, WI' AS ZoneName, 'Green Bay, WI' AS MarketDescription, 'OSHKWI' AS MarketCILLI, 'GBY' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00201' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00202' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00203' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00204' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00205' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00206' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00207' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00208' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00209' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00210' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00211' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00212' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00213' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00214' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00215' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Dallas-Ft. Worth, TX-00216' AS ZoneName, 'Dallas-Ft. Worth, TX' AS MarketDescription, 'RCSNTX' AS MarketCILLI, 'DAL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'Reno, NV' AS ZoneName, 'Reno, NV' AS MarketDescription, 'RENONV' AS MarketCILLI, 'REN' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Raleigh, NC' AS ZoneName, 'Raleigh, NC' AS MarketDescription, 'RLGHNC' AS MarketCILLI, 'RLE' AS MarketName, 'TWC' AS ICProviderName, 'TWC (R)' AS ROCName UNION
			Select  'Raleigh, NC-03601' AS ZoneName, 'Raleigh, NC' AS MarketDescription, 'RLGHNC' AS MarketCILLI, 'RLE' AS MarketName, 'TWC' AS ICProviderName, 'TWC (R)' AS ROCName UNION
			Select  'Raleigh, NC-03602' AS ZoneName, 'Raleigh, NC' AS MarketDescription, 'RLGHNC' AS MarketCILLI, 'RLE' AS MarketName, 'TWC' AS ICProviderName, 'TWC (R)' AS ROCName UNION
			Select  'Flint, MI' AS ZoneName, 'Flint, MI' AS MarketDescription, 'SGN2MI' AS MarketCILLI, 'SAG' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Antonio, TX' AS ZoneName, 'San Antonio, TX' AS MarketDescription, 'SNANTX' AS MarketCILLI, 'SNA' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'San Antonio, TX-01501' AS ZoneName, 'San Antonio, TX' AS MarketDescription, 'SNANTX' AS MarketCILLI, 'SNA' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'San Antonio, TX-01502' AS ZoneName, 'San Antonio, TX' AS MarketDescription, 'SNANTX' AS MarketCILLI, 'SNA' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'San Antonio, TX-01503' AS ZoneName, 'San Antonio, TX' AS MarketDescription, 'SNANTX' AS MarketCILLI, 'SNA' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'San Antonio, TX-01504' AS ZoneName, 'San Antonio, TX' AS MarketDescription, 'SNANTX' AS MarketCILLI, 'SNA' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'San Antonio, TX-01505' AS ZoneName, 'San Antonio, TX' AS MarketDescription, 'SNANTX' AS MarketCILLI, 'SNA' AS MarketName, 'TWC' AS ICProviderName, 'TWC (D)' AS ROCName UNION
			Select  'San Diego, CA' AS ZoneName, 'San Diego, CA' AS MarketDescription, 'SND3CA' AS MarketCILLI, 'SND' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'San Diego, CA-01001' AS ZoneName, 'San Diego, CA' AS MarketDescription, 'SND3CA' AS MarketCILLI, 'SND' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'San Diego, CA-01002' AS ZoneName, 'San Diego, CA' AS MarketDescription, 'SND3CA' AS MarketCILLI, 'SND' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'San Diego, CA-01003' AS ZoneName, 'San Diego, CA' AS MarketDescription, 'SND3CA' AS MarketCILLI, 'SND' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'San Francisco, CA' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00601' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00602' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00603' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00604' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00605' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00606' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00607' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00608' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00609' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00610' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00611' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00612' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00613' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00614' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00615' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00616' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00617' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'San Francisco, CA-00618' AS ZoneName, 'San Francisco, CA' AS MarketDescription, 'SNTCCA' AS MarketCILLI, 'STC' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'St Louis, MO' AS ZoneName, 'St Louis, MO' AS MarketDescription, 'STL2MO' AS MarketCILLI, 'STL' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'St Louis, MO-01201' AS ZoneName, 'St Louis, MO' AS MarketDescription, 'STL2MO' AS MarketCILLI, 'STL' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'St Louis, MO-01202' AS ZoneName, 'St Louis, MO' AS MarketDescription, 'STL2MO' AS MarketCILLI, 'STL' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'St Louis, MO-01203' AS ZoneName, 'St Louis, MO' AS MarketDescription, 'STL2MO' AS MarketCILLI, 'STL' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'St Louis, MO-01204' AS ZoneName, 'St Louis, MO' AS MarketDescription, 'STL2MO' AS MarketCILLI, 'STL' AS MarketName, 'Charter' AS ICProviderName, 'Charter' AS ROCName UNION
			Select  'Toledo, OH' AS ZoneName, 'Toledo, OH' AS MarketDescription, 'TOLDOH' AS MarketCILLI, 'TOL' AS MarketName, 'TWC' AS ICProviderName, 'TWC (M)' AS ROCName UNION
			Select  'Atlanta, GA' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00701' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00702' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00703' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00704' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00705' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00706' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00707' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00708' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00709' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00710' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00711' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00712' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00713' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00714' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00715' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00716' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00717' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00718' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00719' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Atlanta, GA-00720' AS ZoneName, 'Atlanta, GA' AS MarketDescription, 'TUKRGV' AS MarketCILLI, 'ATL' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Wichita, KS' AS ZoneName, 'Wichita, KS' AS MarketDescription, 'WCH2KS' AS MarketCILLI, 'WCH' AS MarketName, 'Cox' AS ICProviderName, 'Cox' AS ROCName UNION
			Select  'West Palm Beach, FL' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'West Palm Beach, FL-02101' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'West Palm Beach, FL-02102' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'West Palm Beach, FL-02103' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'West Palm Beach, FL-02104' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'West Palm Beach, FL-02105' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'West Palm Beach, FL-02106' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'West Palm Beach, FL-02107' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'West Palm Beach, FL-02108' AS ZoneName, 'West Palm Beach, FL' AS MarketDescription, 'WEPBFL' AS MarketCILLI, 'WPB' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01301' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01302' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01303' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01304' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01305' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01306' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01307' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01308' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01309' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01310' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01311' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01312' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01313' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01314' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName UNION
			Select  'Hartford-Fairfield, CT-01315' AS ZoneName, 'Hartford-Fairfield, CT' AS MarketDescription, 'WLFRCT' AS MarketCILLI, 'HRT' AS MarketName, 'Comcast' AS ICProviderName, 'CC' AS ROCName 


		) x
left join dbo.ZONE_MAP z (NOLOCK)
ON x.ZoneName = z.ZONE_NAME
left join dbo.Market b (NOLOCK)
ON x.MarketName = b.Name
--ON x.MarketName = b.CILLI
left join dbo.ICProvider c (NOLOCK)
ON x.ICProviderName = c.Name
left join dbo.ROC d (NOLOCK)
ON x.ROCName = d.Name
WHERE z.ZONE_MAP_ID IS NULL
--WHERE b.MarketID IS NOT NULL
--and c.ICProviderID is not null
--and d.ROCID is not null

--SELECT * FROM dbo.zone_map
