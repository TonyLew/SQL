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
// Module: dbo.EventLogStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: List of event types
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.EventLogStatus.table.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

USE [DINGODB]
GO

--DROP TABLE [dbo].[EventLogStatus]
CREATE TABLE [dbo].[EventLogStatus](
	[EventLogStatusID] [int] IDENTITY(1,1) NOT NULL,
	[EventLogStatusTypeID] [int] NOT NULL,
	[SP] [varchar](100) NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EventLogStatus] PRIMARY KEY CLUSTERED 
(
	[EventLogStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'EventLogStatusID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'FK to EventLogStatusType table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'EventLogStatusTypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO

--ALTER TABLE [dbo].[EventLogStatus]  DROP  CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID]
ALTER TABLE [dbo].[EventLogStatus]  WITH CHECK ADD  CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID] FOREIGN KEY([EventLogStatusTypeID])
REFERENCES [dbo].[EventLogStatusType] ([EventLogStatusTypeID])
GO

ALTER TABLE [dbo].[EventLogStatus] CHECK CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID]
GO

ALTER TABLE [dbo].[EventLogStatus] ADD  CONSTRAINT [DF_EventLogStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[EventLogStatus] ADD  CONSTRAINT [DF_EventLogStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO


----------DBCC CHECKIDENT ('dbo.EventLogStatus', RESEED, 0);
----------Truncate Table dbo.EventLogStatus
----------DELETE dbo.EventLogStatus Where EventLogStatusID >= 2
INSERT dbo.EventLogStatus ( Description, SP, EventLogStatusTypeID )
SELECT x.[Description], x.SP, x.EventLogStatusTypeID
FROM (
SELECT  0 as ID, 'Unidentified Step' AS [Description],										'Unidentified First Step' AS SP,						1 AS EventLogStatusTypeID, 0 AS SortOrder UNION
SELECT  1 as ID, 'Reserved 1 Step' AS [Description],										'Reserved 1 First Step' AS SP,							1 AS EventLogStatusTypeID, 1 AS SortOrder UNION
SELECT  2 as ID, 'Reserved 2 Step' AS [Description],										'Reserved 2 First Step' AS SP,							1 AS EventLogStatusTypeID, 2 AS SortOrder UNION
SELECT  3 as ID, 'Reserved 3 Step' AS [Description],										'Reserved 3 First Step' AS SP,							1 AS EventLogStatusTypeID, 3 AS SortOrder UNION
SELECT  4 as ID, 'Reserved 4 Step' AS [Description],										'Reserved 4 First Step' AS SP,							1 AS EventLogStatusTypeID, 4 AS SortOrder UNION
SELECT  5 as ID, 'Reserved 5 Step' AS [Description],										'Reserved 5 First Step' AS SP,							1 AS EventLogStatusTypeID, 5 AS SortOrder UNION
SELECT  6 as ID, 'Reserved 6 Step' AS [Description],										'Reserved 6 First Step' AS SP,							1 AS EventLogStatusTypeID, 6 AS SortOrder UNION
SELECT  7 as ID, 'Reserved 7 Step' AS [Description],										'Reserved 7 First Step' AS SP,							1 AS EventLogStatusTypeID, 7 AS SortOrder UNION
SELECT  8 as ID, 'Reserved 8 Step' AS [Description],										'Reserved 8 First Step' AS SP,							1 AS EventLogStatusTypeID, 8 AS SortOrder UNION
SELECT  9 as ID, 'Reserved 9 Step' AS [Description],										'Reserved 9 First Step' AS SP,							1 AS EventLogStatusTypeID, 9 AS SortOrder UNION
SELECT 	10 as ID, 'Started Break Count History Step' AS [Description],						'ImportBreakCountHistory First Step' AS SP,				2 AS EventLogStatusTypeID, 20 AS SortOrder UNION
SELECT 	11 as ID, 'Successful Break Count History Step' AS [Description],					'ImportBreakCountHistory Success Step' AS SP,			2 AS EventLogStatusTypeID, 30 AS SortOrder UNION
SELECT 	12 as ID, 'Started Channel And Conflict Stats Step' AS [Description],				'ImportChannelAndConflictStats First Step' AS SP,		2 AS EventLogStatusTypeID, 40 AS SortOrder UNION
SELECT 	13 as ID, 'Successful Channel And Conflict Stats Step' AS [Description],			'ImportChannelAndConflictStats Success Step' AS SP,		2 AS EventLogStatusTypeID, 50 AS SortOrder UNION
SELECT 	14 as ID, 'Started Traffic And Billing Data Step' AS [Description],					'ImportTrafficAndBillingData First Step' AS SP,			2 AS EventLogStatusTypeID, 60 AS SortOrder UNION
SELECT 	15 as ID, 'Successful Traffic And Billing Data Step' AS [Description],				'ImportTrafficAndBillingData Success Step' AS SP,		2 AS EventLogStatusTypeID, 70 AS SortOrder UNION
SELECT 	16 as ID, 'Started Import SDB Step' AS [Description],								'ImportSDB First Step' AS SP,							2 AS EventLogStatusTypeID, 80 AS SortOrder UNION
SELECT 	17 as ID, 'Successful Import SDB Step' AS [Description],							'ImportSDB Success Step' AS SP,							2 AS EventLogStatusTypeID, 90 AS SortOrder  UNION
SELECT 	18 as ID, 'Failed Import SDB Step' AS [Description],								'ImportSDB Fail Step' AS SP,							2 AS EventLogStatusTypeID, 100 AS SortOrder UNION
SELECT 	19 as ID, 'Started Saving CacheStatus Statistics Step' AS [Description],			'SaveCacheStatus First Step' AS SP,						2 AS EventLogStatusTypeID, 200 AS SortOrder UNION
SELECT 	20 as ID, 'Successful Saving CacheStatus Statistics Step' AS [Description],			'SaveCacheStatus Success Step' AS SP,					2 AS EventLogStatusTypeID, 210 AS SortOrder UNION
SELECT 	21 as ID, 'Failed Saving CacheStatus Statistics Step' AS [Description],				'SaveCacheStatus Fail Step' AS SP,						2 AS EventLogStatusTypeID, 220 AS SortOrder UNION
SELECT 	22 as ID, 'Started Saving Channel Statistics Step' AS [Description],				'SaveChannelStatus First Step' AS SP,					2 AS EventLogStatusTypeID, 230 AS SortOrder UNION
SELECT 	23 as ID, 'Successful Saving Channel Statistics Step' AS [Description],				'SaveChannelStatus Success Step' AS SP,					2 AS EventLogStatusTypeID, 240 AS SortOrder UNION
SELECT 	24 as ID, 'Failed Saving Channel Statistics Step' AS [Description],					'SaveChannelStatus Fail Step' AS SP,					2 AS EventLogStatusTypeID, 250 AS SortOrder UNION
SELECT 	25 as ID, 'Started Saving Conflicts Step' AS [Description],							'SaveConflict First Step' AS SP,						2 AS EventLogStatusTypeID, 260 AS SortOrder UNION
SELECT 	26 as ID, 'Successful Saving Conflicts Step' AS [Description],						'SaveConflict Success Step' AS SP,						2 AS EventLogStatusTypeID, 270 AS SortOrder UNION
SELECT 	27 as ID, 'Failed Saving Conflicts Step' AS [Description],							'SaveConflict Fail Step' AS SP,							2 AS EventLogStatusTypeID, 280 AS SortOrder UNION
SELECT 	28 as ID, 'Started Definitions Update Step' AS [Description],						'UpdateRegionalInfo First Step' AS SP,					3 AS EventLogStatusTypeID, 290 AS SortOrder UNION 
SELECT 	29 as ID, 'Successful Definitions Update Step' AS [Description],					'UpdateRegionalInfo Success Step' AS SP,				3 AS EventLogStatusTypeID, 300 AS SortOrder UNION 
SELECT 	30 as ID, 'Failed Definitions Update Step' AS [Description],						'UpdateRegionalInfo Fail Step' AS SP,					3 AS EventLogStatusTypeID, 310 AS SortOrder UNION 
SELECT 	31 as ID, 'Started Check for New SDBs Step' AS [Description],						'AddNewSDBNode First Step' AS SP,						3 AS EventLogStatusTypeID, 320 AS SortOrder UNION 
SELECT 	32 as ID, 'Successful Check for New SDBs Step' AS [Description],					'AddNewSDBNode Success Step' AS SP,						3 AS EventLogStatusTypeID, 330 AS SortOrder UNION 
SELECT 	33 as ID, 'Started Save Zone Step' AS [Description],								'SaveZone First Step' AS SP,							3 AS EventLogStatusTypeID, 340 AS SortOrder UNION 
SELECT 	34 as ID, 'Successful Save Zone Step' AS [Description],								'SaveZone Success Step' AS SP,							3 AS EventLogStatusTypeID, 350 AS SortOrder UNION 
SELECT 	35 as ID, 'Started Save IU Step' AS [Description],									'SaveIU First Step' AS SP,								3 AS EventLogStatusTypeID, 360 AS SortOrder UNION 
SELECT 	36 as ID, 'Successful Save IU Step' AS [Description],								'SaveIU Success Step' AS SP,							3 AS EventLogStatusTypeID, 370 AS SortOrder UNION 
SELECT 	37 as ID, 'Started Save Network Step' AS [Description],								'SaveNetwork First Step' AS SP,							3 AS EventLogStatusTypeID, 380 AS SortOrder UNION 
SELECT 	38 as ID, 'Successful Save Network Step' AS [Description],							'SaveNetwork Success Step' AS SP,						3 AS EventLogStatusTypeID, 390 AS SortOrder UNION 
SELECT 	39 as ID, 'Started Save Network IU Map Step' AS [Description],						'SaveNetwork_IU_Map First Step' AS SP,					3 AS EventLogStatusTypeID, 400 AS SortOrder UNION 
SELECT 	40 as ID, 'Successful Save Network IU Map Step' AS [Description],					'SaveNetwork_IU_Map Success Step' AS SP,				3 AS EventLogStatusTypeID, 410 AS SortOrder UNION 
SELECT 	41 as ID, 'Started Save SPOT CONFLICT STATUS Step' AS [Description],				'SaveSPOT_CONFLICT_STATUS First Step' AS SP,			3 AS EventLogStatusTypeID, 420 AS SortOrder UNION 
SELECT 	42 as ID, 'Successful Save SPOT CONFLICT STATUS Step' AS [Description],				'SaveSPOT_CONFLICT_STATUS Success Step' AS SP,			3 AS EventLogStatusTypeID, 430 AS SortOrder UNION 
SELECT 	43 as ID, 'Started Save SPOT STATUS Step' AS [Description],							'SaveSPOT_STATUS First Step' AS SP,						3 AS EventLogStatusTypeID, 440 AS SortOrder UNION 
SELECT 	44 as ID, 'Successful Save SPOT STATUS Step' AS [Description],						'SaveSPOT_STATUS Success Step' AS SP,					3 AS EventLogStatusTypeID, 450 AS SortOrder UNION
SELECT 	45 as ID, 'Started Save IE CONFLICT STATUS Step' AS [Description],					'SaveIE_CONFLICT_STATUS First Step' AS SP,				3 AS EventLogStatusTypeID, 460 AS SortOrder UNION 
SELECT 	46 as ID, 'Successful Save IE CONFLICT STATUS Step' AS [Description],				'SaveIE_CONFLICT_STATUS Success Step' AS SP,			3 AS EventLogStatusTypeID, 470 AS SortOrder UNION 
SELECT 	47 as ID, 'Started Save IE STATUS Step' AS [Description],							'SaveIE_STATUS First Step' AS SP,						3 AS EventLogStatusTypeID, 500 AS SortOrder UNION 
SELECT 	48 as ID, 'Successful Save IE STATUS Step' AS [Description],						'SaveIE_STATUS Success Step' AS SP,						3 AS EventLogStatusTypeID, 510 AS SortOrder UNION
SELECT 	49 as ID, 'Started Save VIDEO Step' AS [Description],								'SaveVIDEO First Step' AS SP,							3 AS EventLogStatusTypeID, 520 AS SortOrder UNION 
SELECT 	50 as ID, 'Successful Save VIDEO Step' AS [Description],							'SaveVIDEO Success Step' AS SP,							3 AS EventLogStatusTypeID, 530 AS SortOrder UNION
SELECT 	51 as ID, 'Started SDB_IESPOT Step' AS [Description],								'SaveSDB_IESPOT First Step' AS SP,						3 AS EventLogStatusTypeID, 540 AS SortOrder UNION 
SELECT 	52 as ID, 'Successful SDB_IESPOT Step' AS [Description],							'SaveSDB_IESPOT Success Step' AS SP,					3 AS EventLogStatusTypeID, 550 AS SortOrder UNION
SELECT 	53 as ID, 'Started SDB_Market Step' AS [Description],								'SaveSDB_Market First Step' AS SP,						3 AS EventLogStatusTypeID, 560 AS SortOrder UNION 
SELECT 	54 as ID, 'Successful SDB_Market Step' AS [Description],							'SaveSDB_Market Success Step' AS SP,					3 AS EventLogStatusTypeID, 570 AS SortOrder UNION
SELECT 	55 as ID, 'Started Purging SDB_IESPOT Step' AS [Description],						'PurgeSDB_IESPOT First Step' AS SP,						2 AS EventLogStatusTypeID, 580 AS SortOrder UNION
SELECT 	56 as ID, 'Successful Purging SDB_IESPOT Step' AS [Description],					'PurgeSDB_IESPOT Success Step' AS SP,					2 AS EventLogStatusTypeID, 590 AS SortOrder UNION
SELECT 	57 as ID, 'Failed Purging SDB_IESPOT Step' AS [Description],						'PurgeSDB_IESPOT Fail Step' AS SP,						2 AS EventLogStatusTypeID, 600 AS SortOrder UNION
SELECT 	58 as ID, 'Started Purging VIDEO Step' AS [Description],							'PurgeVideo First Step' AS SP,							2 AS EventLogStatusTypeID, 610 AS SortOrder UNION
SELECT 	59 as ID, 'Successful Purging VIDEO Step' AS [Description],							'PurgeVideo Success Step' AS SP,						2 AS EventLogStatusTypeID, 620 AS SortOrder UNION
SELECT 	60 as ID, 'Failed Purging VIDEO Step' AS [Description],								'PurgeVideo Fail Step' AS SP,							2 AS EventLogStatusTypeID, 630 AS SortOrder UNION
SELECT 	61 as ID, 'Primary MDB Failure' AS [Description],									'Primary MDB Failure' AS SP,							1 AS EventLogStatusTypeID, 640 AS SortOrder UNION
SELECT 	62 as ID, 'Secondary MDB Failure' AS [Description],									'Secondary MDB Failure' AS SP,							1 AS EventLogStatusTypeID, 650 AS SortOrder UNION
SELECT 	63 as ID, 'Primary SDB Failure' AS [Description],									'Primary SDB Failure' AS SP,							1 AS EventLogStatusTypeID, 660 AS SortOrder UNION
SELECT 	64 as ID, 'Secondary SDB Failure' AS [Description],									'Secondary SDB Failure' AS SP,							1 AS EventLogStatusTypeID, 670 AS SortOrder UNION
SELECT 	65 as ID, 'Started Maintenance Rebuild Index Step' AS [Description],				'MaintenanceRebuildIndex First Step' AS SP,				6 AS EventLogStatusTypeID, 680 AS SortOrder UNION
SELECT 	66 as ID, 'Successful Maintenance Rebuild Index Step' AS [Description],				'MaintenanceRebuildIndex Success Step' AS SP,			6 AS EventLogStatusTypeID, 690 AS SortOrder UNION
SELECT 	67 as ID, 'Started Maintenance DB Integrity Step' AS [Description],					'MaintenanceDBIntegrity First Step' AS SP,				6 AS EventLogStatusTypeID, 700 AS SortOrder UNION
SELECT 	68 as ID, 'Successful Maintenance DB Integrity Step' AS [Description],				'MaintenanceDBIntegrity Success Step' AS SP,			6 AS EventLogStatusTypeID, 710 AS SortOrder UNION
SELECT 	69 as ID, 'Started Maintenance Cleanup Step' AS [Description],						'MaintenanceCleanup First Step' AS SP,					6 AS EventLogStatusTypeID, 720 AS SortOrder UNION
SELECT 	70 as ID, 'Successful Maintenance Cleanup Step' AS [Description],					'MaintenanceCleanup Success Step' AS SP,				6 AS EventLogStatusTypeID, 730 AS SortOrder UNION
SELECT 	71 as ID, 'Started Maintenance Backup Transaction Log Step' AS [Description],		'MaintenanceBackupTransactionLog First Step' AS SP,		6 AS EventLogStatusTypeID, 740 AS SortOrder UNION
SELECT 	72 as ID, 'Successful Maintenance Backup Transaction Log Step' AS [Description],	'MaintenanceBackupTransactionLog Success Step' AS SP,	6 AS EventLogStatusTypeID, 750 AS SortOrder UNION
SELECT 	73 as ID, 'Started Maintenance Backup Full Step' AS [Description],					'MaintenanceBackupFull First Step' AS SP,				6 AS EventLogStatusTypeID, 760 AS SortOrder UNION
SELECT 	74 as ID, 'Successful Maintenance Backup Full Step' AS [Description],				'MaintenanceBackupFull Success Step' AS SP,				6 AS EventLogStatusTypeID, 770 AS SortOrder 

) x
join dbo.EventLogStatusType y
on x.EventLogStatusTypeID = y.EventLogStatusTypeID
Order by x.ID, x.SortOrder
select * from dbo.EventLogStatus
select * from dbo.EventLogStatusType

--truncate table dbo.EventLog
--truncate table dbo.EventLogStatus




