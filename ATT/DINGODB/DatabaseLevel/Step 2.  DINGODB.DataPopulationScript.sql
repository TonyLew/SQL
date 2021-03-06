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
// Module:  DINGODB database creation script.
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Database data population for definition tables.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 

---------------------------------------------------
--EventLogStatusType
---------------------------------------------------
USE [DINGODB]
GO

INSERT dbo.EventLogStatusType ( Description )
SELECT x.[Description]
FROM (
SELECT 	'Universal' AS [Description], 1 AS SortOrder UNION
SELECT 	'ETL Job: SDB Execute Job' AS [Description], 2 AS SortOrder UNION
SELECT 	'Maintenance Job: MDB Definition Table Update' AS [Description], 3 AS SortOrder UNION
SELECT 	'Maintenance Job: MDB Add SDB Node' AS [Description], 4 AS SortOrder UNION
SELECT 	'Maintenance Job: Update SDB Node' AS [Description], 5 AS SortOrder UNION
SELECT 	'Maintenance Job: Maintenance Tasks' AS [Description], 6 AS SortOrder UNION
SELECT 	'Replication' AS [Description], 7 AS SortOrder UNION
SELECT 	'Datawarehouse' AS [Description], 8 AS SortOrder
) x
left join dbo.EventLogStatusType y
on x.Description = y.Description
where y.EventLogStatusTypeID IS NULL
Order by x.SortOrder
--Select * from dbo.EventLogStatusType
GO





---------------------------------------------------
--EventLogStatus
---------------------------------------------------
USE [DINGODB]
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
SELECT 	58 as ID, 'Started Deleting SDB Step' AS [Description],								'DeleteSDB First Step' AS SP,							2 AS EventLogStatusTypeID, 610 AS SortOrder UNION
SELECT 	59 as ID, 'Successful Deleting SDB Step' AS [Description],							'DeleteSDB Success Step' AS SP,							2 AS EventLogStatusTypeID, 620 AS SortOrder UNION
SELECT 	60 as ID, 'Failed Deleting SDB Step' AS [Description],								'DeleteSDB Fail Step' AS SP,							2 AS EventLogStatusTypeID, 630 AS SortOrder UNION
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
SELECT 	74 as ID, 'Successful Maintenance Backup Full Step' AS [Description],				'MaintenanceBackupFull Success Step' AS SP,				6 AS EventLogStatusTypeID, 770 AS SortOrder UNION
SELECT 	75 as ID, 'Started CheckSDBReplication Step' AS [Description],						'CheckSDBReplication First Step' AS SP,					7 AS EventLogStatusTypeID, 771 AS SortOrder UNION
SELECT 	76 as ID, 'Successful CheckSDBReplication Step' AS [Description],					'CheckSDBReplication Success Step' AS SP,				7 AS EventLogStatusTypeID, 772 AS SortOrder UNION
SELECT 	77 as ID, 'Failed CheckSDBReplication Step' AS [Description],						'CheckSDBReplication Fail Step' AS SP,					7 AS EventLogStatusTypeID, 773 AS SortOrder UNION
SELECT 	78 as ID, 'Started SetBackupSDBReplication Step' AS [Description],					'SetBackupSDBReplication First Step' AS SP,				7 AS EventLogStatusTypeID, 774 AS SortOrder UNION
SELECT 	79 as ID, 'Successful SetBackupSDBReplication Step' AS [Description],				'SetBackupSDBReplication Success Step' AS SP,			7 AS EventLogStatusTypeID, 775 AS SortOrder UNION
SELECT 	80 as ID, 'Failed SetBackupSDBReplication Step' AS [Description],					'SetBackupSDBReplication Fail Step' AS SP,				7 AS EventLogStatusTypeID, 776 AS SortOrder UNION
SELECT 	81 as ID, 'Started CreateSDBPushSubscription Step' AS [Description],				'CreateSDBPushSubscription First Step' AS SP,			7 AS EventLogStatusTypeID, 777 AS SortOrder UNION
SELECT 	82 as ID, 'Successful CreateSDBPushSubscription Step' AS [Description],				'CreateSDBPushSubscription Success Step' AS SP,			7 AS EventLogStatusTypeID, 778 AS SortOrder UNION
SELECT 	83 as ID, 'Failed CreateSDBPushSubscription Step' AS [Description],					'CreateSDBPushSubscription Fail Step' AS SP,			7 AS EventLogStatusTypeID, 779 AS SortOrder UNION
SELECT 	84 as ID, 'Started CreateSDBPullSubscription Step' AS [Description],				'CreateSDBPullSubscription First Step' AS SP,			7 AS EventLogStatusTypeID, 780 AS SortOrder UNION
SELECT 	85 as ID, 'Successful CreateSDBPullSubscription Step' AS [Description],				'CreateSDBPullSubscription Success Step' AS SP,			7 AS EventLogStatusTypeID, 781 AS SortOrder UNION
SELECT 	86 as ID, 'Failed CreateSDBPullSubscription Step' AS [Description],					'CreateSDBPullSubscription Fail Step' AS SP,			7 AS EventLogStatusTypeID, 782 AS SortOrder UNION
SELECT 	87 as ID, 'Started CreateSDBPublication Step' AS [Description],						'CreateSDBPublication First Step' AS SP,				7 AS EventLogStatusTypeID, 783 AS SortOrder UNION
SELECT 	88 as ID, 'Successful CreateSDBPublication Step' AS [Description],					'CreateSDBPublication Success Step' AS SP,				7 AS EventLogStatusTypeID, 784 AS SortOrder UNION
SELECT 	89 as ID, 'Failed CreateSDBPublication Step' AS [Description],						'CreateSDBPublication Fail Step' AS SP,					7 AS EventLogStatusTypeID, 785 AS SortOrder UNION
SELECT 	90 as ID, 'Started CreateSDBMPEGDB Step' AS [Description],							'CreateSDBMPEGDB First Step' AS SP,						7 AS EventLogStatusTypeID, 786 AS SortOrder UNION
SELECT 	91 as ID, 'Successful CreateSDBMPEGDB Step' AS [Description],						'CreateSDBMPEGDB Success Step' AS SP,					7 AS EventLogStatusTypeID, 787 AS SortOrder UNION
SELECT 	92 as ID, 'Failed CreateSDBMPEGDB Step' AS [Description],							'CreateSDBMPEGDB Fail Step' AS SP,						7 AS EventLogStatusTypeID, 788 AS SortOrder UNION
SELECT 	93 as ID, 'Started DropSDBMPEGDB Step' AS [Description],							'DropSDBMPEGDB First Step' AS SP,						7 AS EventLogStatusTypeID, 789 AS SortOrder UNION
SELECT 	94 as ID, 'Successful DropSDBMPEGDB Step' AS [Description],							'DropSDBMPEGDB Success Step' AS SP,						7 AS EventLogStatusTypeID, 790 AS SortOrder UNION
SELECT 	95 as ID, 'Failed DropSDBMPEGDB Step' AS [Description],								'DropSDBMPEGDB Fail Step' AS SP,						7 AS EventLogStatusTypeID, 791 AS SortOrder UNION
SELECT 	96 as ID, 'Started CreateSDBLinkedServer Step' AS [Description],					'CreateSDBLinkedServer First Step' AS SP,				7 AS EventLogStatusTypeID, 792 AS SortOrder UNION
SELECT 	97 as ID, 'Successful CreateSDBLinkedServer Step' AS [Description],					'CreateSDBLinkedServer Success Step' AS SP,				7 AS EventLogStatusTypeID, 793 AS SortOrder UNION
SELECT 	98 as ID, 'Failed CreateSDBLinkedServer Step' AS [Description],						'CreateSDBLinkedServer Fail Step' AS SP,				7 AS EventLogStatusTypeID, 794 AS SortOrder UNION
SELECT 	99 as ID, 'Started CreateSDBMPEGObjects Step' AS [Description],						'CreateSDBMPEGObjects First Step' AS SP,				7 AS EventLogStatusTypeID, 795 AS SortOrder UNION
SELECT 	100 as ID, 'Successful CreateSDBMPEGObjects Step' AS [Description],					'CreateSDBMPEGObjects Success Step' AS SP,				7 AS EventLogStatusTypeID, 796 AS SortOrder UNION
SELECT 	101 as ID, 'Failed CreateSDBMPEGObjects Step' AS [Description],						'CreateSDBMPEGObjects Fail Step' AS SP,					7 AS EventLogStatusTypeID, 797 AS SortOrder UNION
SELECT 	102 as ID, 'Started DWETLParent Step' AS [Description],											'DWETLParent First Step' AS SP,									8 AS EventLogStatusTypeID, 798 AS SortOrder UNION
SELECT 	103 as ID, 'Successful DWETLParent Step' AS [Description],										'DWETLParent Success Step' AS SP,								8 AS EventLogStatusTypeID, 799 AS SortOrder UNION
SELECT 	104 as ID, 'Failed DWETLParent Step' AS [Description],											'DWETLParent Fail Step' AS SP,									8 AS EventLogStatusTypeID, 800 AS SortOrder UNION
SELECT 	105 as ID, 'Successful DWETLParent - SaveDimRecordCount Step'	 AS [Description],				'DWETLParent - SaveDimRecordCount Step'	 AS SP,					8 AS EventLogStatusTypeID, 801 AS SortOrder UNION
SELECT 	106 as ID, 'Successful DWETLParent - SaveFactRecordCount Step'	 AS [Description],				'DWETLParent - SaveFactRecordCount Step'	 AS SP,				8 AS EventLogStatusTypeID, 802 AS SortOrder UNION
SELECT 	107 as ID, 'Successful DWETLParent - ETLDimSDBSource Step'	 AS [Description],					'DWETLParent - ETLDimSDBSource Step'	 AS SP,					8 AS EventLogStatusTypeID, 803 AS SortOrder UNION
SELECT 	108 as ID, 'Successful DWETLParent - ETLDimZoneMap Step'	 AS [Description],					'DWETLParent - ETLDimZoneMap Step'	 AS SP,						8 AS EventLogStatusTypeID, 804 AS SortOrder UNION
SELECT 	109 as ID, 'Successful DWETLParent - ETLDimAsset Step'	 AS [Description],						'DWETLParent - ETLDimAsset Step'	 AS SP,						8 AS EventLogStatusTypeID, 805 AS SortOrder UNION
SELECT 	110 as ID, 'Successful DWETLParent - ETLDimSpotStatus Step'	 AS [Description],					'DWETLParent - ETLDimSpotStatus Step'	 AS SP,					8 AS EventLogStatusTypeID, 806 AS SortOrder UNION
SELECT 	111 as ID, 'Successful DWETLParent - ETLDimSpotConflictStatus Step' AS [Description],			'DWETLParent - ETLDimSpotConflictStatus Step' AS SP,			8 AS EventLogStatusTypeID, 807 AS SortOrder UNION
SELECT 	112 as ID, 'Successful DWETLParent - ETLDimIEStatus Step'	 AS [Description],					'DWETLParent - ETLDimIEStatus Step'	 AS SP,						8 AS EventLogStatusTypeID, 808 AS SortOrder UNION
SELECT 	113 as ID, 'Successful DWETLParent - ETLDimIEConflictStatus Step'	 AS [Description],			'DWETLParent - ETLDimIEConflictStatus Step'	 AS SP,				8 AS EventLogStatusTypeID, 809 AS SortOrder UNION
SELECT 	114 as ID, 'Successful DWETLParent - ETLDimSpot Step'	 AS [Description],						'DWETLParent - ETLDimSpot Step'	 AS SP,							8 AS EventLogStatusTypeID, 810 AS SortOrder UNION
SELECT 	115 as ID, 'Successful DWETLParent - ETLDimIE Step'	 AS [Description],							'DWETLParent - ETLDimIE Step'	 AS SP,							8 AS EventLogStatusTypeID, 811 AS SortOrder UNION
SELECT 	116 as ID, 'Successful DWETLParent - ETLDimIU Step'	 AS [Description],							'DWETLParent - ETLDimIU Step'	 AS SP,							8 AS EventLogStatusTypeID, 812 AS SortOrder UNION
SELECT 	117 as ID, 'Successful DWETLParent - ETLDimTB_REQUEST Step'	 AS [Description],					'DWETLParent - ETLDimTB_REQUEST Step'	 AS SP,					8 AS EventLogStatusTypeID, 813 AS SortOrder UNION
SELECT 	118 as ID, 'Successful DWETLParent - PopulateXSEU Step'	 AS [Description],						'DWETLParent - PopulateXSEU Step'	 AS SP,						8 AS EventLogStatusTypeID, 814 AS SortOrder UNION
SELECT 	119 as ID, 'Successful DWETLParent - PopulateTempTableFactSummary1 Step' AS [Description],		'DWETLParent - PopulateTempTableFactSummary1 Step'	 AS SP,		8 AS EventLogStatusTypeID, 815 AS SortOrder UNION
SELECT 	120 as ID, 'Successful DWETLParent - PopulateFactBreakMovingAverage Step'	 AS [Description],	'DWETLParent - PopulateFactBreakMovingAverage Step'	AS SP,		8 AS EventLogStatusTypeID, 816 AS SortOrder UNION
SELECT 	121 as ID, 'Successful DWETLParent - PopulateFactAssetSummary Step'	 AS [Description],			'DWETLParent - PopulateFactAssetSummary Step'  AS SP,			8 AS EventLogStatusTypeID, 817 AS SortOrder UNION
SELECT 	122 as ID, 'Successful DWETLParent - PopulateFactSpotSummary Step'	 AS [Description],			'DWETLParent - PopulateFactSpotSummary Step' AS SP,				8 AS EventLogStatusTypeID, 818 AS SortOrder UNION
SELECT 	123 as ID, 'Successful DWETLParent - PopulateFactIESummary Step'	 AS [Description],			'DWETLParent - PopulateFactIESummary Step'	 AS SP,				8 AS EventLogStatusTypeID, 819 AS SortOrder UNION
SELECT 	124 as ID, 'Successful DWETLParent - PopulateFactIUSummary Step'	 AS [Description],			'DWETLParent - PopulateFactIUSummary Step'	 AS SP,				8 AS EventLogStatusTypeID, 820 AS SortOrder



) x
left join dbo.EventLogStatus y
on x.SP = y.SP
Where y.EventLogStatusID IS NULL
Order by x.ID, x.SortOrder
--select * from dbo.EventLogStatus
--select * from dbo.EventLogStatusType
GO


---------------------------------------------------
--CacheStatusType
---------------------------------------------------
USE [DINGODB]
GO

--------Truncate Table dbo.CacheStatusType
--------DELETE dbo.CacheStatusType 
INSERT dbo.CacheStatusType( Description )
SELECT x.[Description]
FROM (
SELECT 	'Channel Status' AS [Description], 10 AS SortOrder UNION
SELECT 	'Media Status' AS [Description], 20 AS SortOrder 
) x
Order by x.SortOrder
--select * from dbo.CacheStatusType
GO


-----------------------------------------------------
----Region
-----------------------------------------------------
--USE [DINGODB]
--GO

----------Truncate Table dbo.Region
----------DELETE dbo.Region 
--INSERT dbo.Region ( Name )
--SELECT x.[Name]
--FROM (
--SELECT 	'Region 1' AS [Name], 20 AS SortOrder UNION
--SELECT 	'Region 2' AS [Name], 30 AS SortOrder 
--) x
--Order by x.SortOrder
----select * from dbo.Region
--GO




---------------------------------------------------
--ROC
---------------------------------------------------
USE [DINGODB]
GO

------Truncate Table dbo.ROC
------DELETE dbo.ROC 
INSERT dbo.ROC ( Name, CreateDate, UpdateDate )
SELECT x.[Name], GETUTCDATE() AS CreateDate, GETUTCDATE() AS UpdateDate
FROM (
SELECT 	'n/a' AS [Name], 1 AS SortOrder UNION
SELECT 	'AT&T' AS [Name], 20 AS SortOrder UNION
SELECT 	'BH' AS [Name], 20 AS SortOrder UNION
SELECT 	'CC' AS [Name], 20 AS SortOrder UNION
SELECT 	'Charter' AS [Name], 20 AS SortOrder UNION
SELECT 	'Cox' AS [Name], 20 AS SortOrder UNION
SELECT 	'TWC (D)' AS [Name], 20 AS SortOrder UNION
SELECT 	'TWC (L)' AS [Name], 20 AS SortOrder UNION
SELECT 	'TWC (M)' AS [Name], 20 AS SortOrder UNION
SELECT 	'TWC (R)' AS [Name], 20 AS SortOrder 
) x
left join dbo.ROC y
ON x.Name = y.Name
where y.ROCID IS NULL
Order by x.SortOrder, x.Name
--select * from dbo.ROC
GO




---------------------------------------------------
--Market
---------------------------------------------------
USE [DINGODB]
GO

----Truncate Table dbo.Market
--------DELETE dbo.Market Where MarketID >= 1
INSERT dbo.Market ( Name, CILLI, ProfileID, Description, CreateDate, UpdateDate )
SELECT x.[Name], x.CILLI, x.ProfileID, x.Description, GETUTCDATE() AS CreateDate, GETUTCDATE() AS UpdateDate
FROM (
		SELECT 'n/a'	AS [Name], 'n/a'	AS [CILLI],	''		AS ProfileID,	     '' AS Description,				1 AS SortOrder UNION
		SELECT 'AUS2TX'	AS [Name], 'AUS2TX' AS [CILLI], '01400' AS ProfileID,		 'Austin, TX' AS Description,	30 AS SortOrder UNION
		SELECT 'BCVLOH'	AS [Name], 'BCVLOH' AS [CILLI], '01700' AS ProfileID,		 'Cleveland, OH' AS Description,	30 AS SortOrder UNION
		SELECT 'BKF2CA'	AS [Name], 'BKF2CA' AS [CILLI], '04800' AS ProfileID,		 'Bakersfield, CA' AS Description,	30 AS SortOrder UNION
		SELECT 'BRHMAL'	AS [Name], 'BRHMAL' AS [CILLI], '02900' AS ProfileID,		 'Birmingham, AL' AS Description,	30 AS SortOrder UNION
		SELECT 'BTRGLA'	AS [Name], 'BTRGLA' AS [CILLI], '03900' AS ProfileID,		 'Baton Rouge, LA' AS Description,	30 AS SortOrder UNION
		SELECT 'CHRLNC'	AS [Name], 'CHRLNC' AS [CILLI], '02400' AS ProfileID,		 'Charlotte, NC' AS Description,	30 AS SortOrder UNION
		SELECT 'CICRIL'	AS [Name], 'CICRIL' AS [CILLI], '00100' AS ProfileID,		 'Chicago, IL' AS Description,	30 AS SortOrder UNION
		SELECT 'CLMASC'	AS [Name], 'CLMASC' AS [CILLI], '04100' AS ProfileID,		 'Columbia, SC' AS Description,	30 AS SortOrder UNION
		SELECT 'CLMBOH'	AS [Name], 'CLMBOH' AS [CILLI], '02000' AS ProfileID,		 'Columbus, OH' AS Description,	30 AS SortOrder UNION
		SELECT 'CNTMOH'	AS [Name], 'CNTMOH' AS [CILLI], '03300' AS ProfileID,		 'Dayton, OH' AS Description,	30 AS SortOrder UNION
		SELECT 'DCTRIL'	AS [Name], 'DCTRIL' AS [CILLI], '05000' AS ProfileID,		 'Springfield, IL' AS Description,	30 AS SortOrder UNION
		SELECT 'DYBHFL'	AS [Name], 'DYBHFL' AS [CILLI], '01800' AS ProfileID,		 'Daytona Beach, FL' AS Description,	30 AS SortOrder UNION
		SELECT 'FROKCA'	AS [Name], 'FROKCA' AS [CILLI], '00900' AS ProfileID,		 'Sacramento, CA' AS Description,	30 AS SortOrder UNION
		SELECT 'FRS2CA'	AS [Name], 'FRS2CA' AS [CILLI], '03000' AS ProfileID,		 'Fresno, CA' AS Description,	30 AS SortOrder UNION
		SELECT 'FYVLAR'	AS [Name], 'FYVLAR' AS [CILLI], '04400' AS ProfileID,		 'Ft. Smith, AR' AS Description,	30 AS SortOrder UNION
		SELECT 'GDRPMI'	AS [Name], 'GDRPMI' AS [CILLI], '01900' AS ProfileID,		 'Grand Rapids, MI' AS Description,	30 AS SortOrder UNION
		SELECT 'GNVLSC'	AS [Name], 'GNVLSC' AS [CILLI], '03100' AS ProfileID,		 'Greenville, SC' AS Description,	30 AS SortOrder UNION
		SELECT 'HSTNTX'	AS [Name], 'HSTNTX' AS [CILLI], '00300' AS ProfileID,		 'Houston, TX' AS Description,	30 AS SortOrder UNION
		SELECT 'IPLSIN'	AS [Name], 'IPLSIN' AS [CILLI], '00800' AS ProfileID,		 'Indianapolis, IN' AS Description,	30 AS SortOrder UNION
		SELECT 'IRV2CA'	AS [Name], 'IRV2CA' AS [CILLI], '00400' AS ProfileID,		 'Irvine, CA' AS Description,	30 AS SortOrder UNION
		SELECT 'JCSNMS'	AS [Name], 'JCSNMS' AS [CILLI], '04000' AS ProfileID,		 'Jackson, MS' AS Description,	30 AS SortOrder UNION
		SELECT 'JCVLFL'	AS [Name], 'JCVLFL' AS [CILLI], '02200' AS ProfileID,		 'Jacksonville, FL' AS Description,	30 AS SortOrder UNION
		SELECT 'LIVNMI'	AS [Name], 'LIVNMI' AS [CILLI], '00500' AS ProfileID,		 'Detroit, MI' AS Description,	30 AS SortOrder UNION
		SELECT 'LNNGMI'	AS [Name], 'LNNGMI' AS [CILLI], '04600' AS ProfileID,		 'Lansing, MI' AS Description,	30 AS SortOrder UNION
		SELECT 'LSVLKY'	AS [Name], 'LSVLKY' AS [CILLI], '03800' AS ProfileID,		 'Louisville, KY' AS Description,	30 AS SortOrder UNION
		SELECT 'LTRKAR'	AS [Name], 'LTRKAR' AS [CILLI], '02800' AS ProfileID,		 'Little Rock, AR' AS Description,	30 AS SortOrder UNION
		SELECT 'MDS2WI'	AS [Name], 'MDS2WI' AS [CILLI], '04200' AS ProfileID,		 'Madison, WI' AS Description,	30 AS SortOrder UNION
		SELECT 'MIAMFL'	AS [Name], 'MIAMFL' AS [CILLI], '01100' AS ProfileID,		 'Miami, FL' AS Description,	30 AS SortOrder UNION
		SELECT 'MIL2WI'	AS [Name], 'MIL2WI' AS [CILLI], '01600' AS ProfileID,		 'Milwaukee, WI' AS Description,	30 AS SortOrder UNION
		SELECT 'MMPHTN'	AS [Name], 'MMPHTN' AS [CILLI], '03200' AS ProfileID,		 'Memphis, TN' AS Description,	30 AS SortOrder UNION
		SELECT 'MOBLAL'	AS [Name], 'MOBLAL' AS [CILLI], '03500' AS ProfileID,		 'Mobile, AL' AS Description,	30 AS SortOrder UNION
		SELECT 'MSSNKV'	AS [Name], 'MSSNKV' AS [CILLI], '02500' AS ProfileID,		 'Kansas City, KS' AS Description,	30 AS SortOrder UNION
		SELECT 'MTRYCA'	AS [Name], 'MTRYCA' AS [CILLI], '04500' AS ProfileID,		 'Monterey, CA' AS Description,	30 AS SortOrder UNION
		SELECT 'NSVLTN'	AS [Name], 'NSVLTN' AS [CILLI], '02300' AS ProfileID,		 'Nashville, TN' AS Description,	30 AS SortOrder UNION
		SELECT 'NWORLA'	AS [Name], 'NWORLA' AS [CILLI], '02600' AS ProfileID,		 'New Orleans, LA' AS Description,	30 AS SortOrder UNION
		SELECT 'OKCYOK'	AS [Name], 'OKCYOK' AS [CILLI], '03700' AS ProfileID,		 'Oklahoma City, OK' AS Description,	30 AS SortOrder UNION
		SELECT 'OSHKWI'	AS [Name], 'OSHKWI' AS [CILLI], '02700' AS ProfileID,		 'Oshkosh, WI' AS Description,	30 AS SortOrder UNION
		SELECT 'RCSNTX'	AS [Name], 'RCSNTX' AS [CILLI], '00200' AS ProfileID,		 'Dallas, TX' AS Description,	30 AS SortOrder UNION
		SELECT 'RENONV'	AS [Name], 'RENONV' AS [CILLI], '04900' AS ProfileID,		 'Reno, NC' AS Description,	30 AS SortOrder UNION
		SELECT 'RLGHNC'	AS [Name], 'RLGHNC' AS [CILLI], '03600' AS ProfileID,		 'Raleigh, NC' AS Description,	30 AS SortOrder UNION
		SELECT 'SGN2MI'	AS [Name], 'SGN2MI' AS [CILLI], '03400' AS ProfileID,		 'Saginaw, MI' AS Description,	30 AS SortOrder UNION
		SELECT 'SNANTX'	AS [Name], 'SNANTX' AS [CILLI], '01500' AS ProfileID,		 'San Antonio, TX' AS Description,	30 AS SortOrder UNION
		SELECT 'SND3CA'	AS [Name], 'SND3CA' AS [CILLI], '01000' AS ProfileID,		 'San Diego, CA' AS Description,	30 AS SortOrder UNION
		SELECT 'SNTCCA'	AS [Name], 'SNTCCA' AS [CILLI], '00600' AS ProfileID,		 'Santa Clara, CA' AS Description,	30 AS SortOrder UNION
		SELECT 'STL2MO'	AS [Name], 'STL2MO' AS [CILLI], '01200' AS ProfileID,		 'St Louis, MO' AS Description,	30 AS SortOrder UNION
		SELECT 'TOLDOH'	AS [Name], 'TOLDOH' AS [CILLI], '04700' AS ProfileID,		 'Toledo, OH' AS Description,	30 AS SortOrder UNION
		SELECT 'TUKRGV'	AS [Name], 'TUKRGV' AS [CILLI], '00700' AS ProfileID,		 'Atlanta, GA' AS Description,	30 AS SortOrder UNION
		SELECT 'WCH2KS'	AS [Name], 'WCH2KS' AS [CILLI], '04300' AS ProfileID,		 'Wichita, KS' AS Description,	30 AS SortOrder UNION
		SELECT 'WEPBFL'	AS [Name], 'WEPBFL' AS [CILLI], '02100' AS ProfileID,		 'West Palm Beach, FL' AS Description,	30 AS SortOrder UNION
		SELECT 'WLFRCT'	AS [Name], 'WLFRCT' AS [CILLI], '01300' AS ProfileID,		 'Wallingford, CT' AS Description,	30 AS SortOrder 
) x
left join dbo.Market y
on x.Name = y.Name
where y.MarketID is null
Order by x.SortOrder,x.Name
--select * from dbo.Market
GO


---------------------------------------------------
--ICProvider
---------------------------------------------------
USE [DINGODB]
GO

------Truncate Table dbo.ICProvider
--------DELETE dbo.ICProvider 
INSERT dbo.ICProvider ( Name, CreateDate, UpdateDate )
SELECT x.[Name], GETUTCDATE() AS CreateDate, GETUTCDATE() AS UpdateDate
FROM (
SELECT 	'n/a' AS [Name], 1 AS SortOrder UNION
SELECT 	'AT&T' AS [Name], 20 AS SortOrder UNION
SELECT 	'Comcast' AS [Name], 30 AS SortOrder UNION
SELECT 	'TWC' AS [Name], 40 AS SortOrder UNION
SELECT 	'Charter' AS [Name], 50 AS SortOrder UNION
SELECT 	'COX' AS [Name], 60 AS SortOrder UNION
SELECT 	'Bright House' AS [Name], 70 AS SortOrder 
) x
left join dbo.ICProvider y
ON x.Name = y.Name
where y.ICProviderID IS NULL
Order by x.SortOrder
--select * from dbo.ICProvider
GO



---------------------------------------------------
--ZONE_MAP
---------------------------------------------------
USE [DINGODB]
GO


Insert dbo.ZONE_MAP 
				(
				ZONE_NAME,
				MarketID,
				ICProviderID,
				ROCID
				)
select 
		x.ZoneName AS ZONE_NAME,
		ISNULL(b.MarketID, 0),
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
ON x.MarketDescription = b.Description
--ON x.MarketName = b.Name
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
GO


---------------------------------------------------
--ReplicationCluster
---------------------------------------------------
USE [DINGODB]
GO

			IF				NOT EXISTS(SELECT TOP 1 1 FROM DINGODB.dbo.ReplicationCluster WHERE Name = 'UnKnown' OR NameFQ = 'UnKnown' OR VIP = 'UnKnown' ) 
			BEGIN

							Insert dbo.ReplicationCluster 
									(
										Name,
										NameFQ,
										VIP,
										ModuloValue,
										Description,
										Enabled,
										CreateDate,
										UpdateDate
									)
							Select 
										Name				= 'UnKnown',
										NameFQ				= 'UnKnown',
										VIP					= 'UnKnown',
										ModuloValue			= 0,
										Description			= 'UnDetermined State',
										Enabled				= 0,
										CreateDate			= GETUTCDATE(),
										UpdateDate			= GETUTCDATE()

			END


