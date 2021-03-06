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
// Module:  DINGOSDB database data population script.
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

USE [DINGOSDB]
GO






---------------------------------------------------
--EventLogStatusType
---------------------------------------------------

INSERT dbo.EventLogStatusType ( Description )
SELECT x.[Description]
FROM (
SELECT 	'Universal' AS [Description], 1 AS SortOrder UNION
SELECT 	'Maintenance Job: Maintenance Tasks' AS [Description], 2 AS SortOrder UNION
SELECT 	'Replication' AS [Description], 3 AS SortOrder 
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
SELECT 	65 as ID, 'Started Maintenance Rebuild Index Step' AS [Description],				'MaintenanceRebuildIndex First Step' AS SP,				2 AS EventLogStatusTypeID, 680 AS SortOrder UNION
SELECT 	66 as ID, 'Successful Maintenance Rebuild Index Step' AS [Description],				'MaintenanceRebuildIndex Success Step' AS SP,			2 AS EventLogStatusTypeID, 690 AS SortOrder UNION
SELECT 	67 as ID, 'Started Maintenance DB Integrity Step' AS [Description],					'MaintenanceDBIntegrity First Step' AS SP,				2 AS EventLogStatusTypeID, 700 AS SortOrder UNION
SELECT 	68 as ID, 'Successful Maintenance DB Integrity Step' AS [Description],				'MaintenanceDBIntegrity Success Step' AS SP,			2 AS EventLogStatusTypeID, 710 AS SortOrder UNION
SELECT 	69 as ID, 'Started Maintenance Cleanup Step' AS [Description],						'MaintenanceCleanup First Step' AS SP,					2 AS EventLogStatusTypeID, 720 AS SortOrder UNION
SELECT 	70 as ID, 'Successful Maintenance Cleanup Step' AS [Description],					'MaintenanceCleanup Success Step' AS SP,				2 AS EventLogStatusTypeID, 730 AS SortOrder UNION
SELECT 	71 as ID, 'Started Maintenance Backup Transaction Log Step' AS [Description],		'MaintenanceBackupTransactionLog First Step' AS SP,		2 AS EventLogStatusTypeID, 740 AS SortOrder UNION
SELECT 	72 as ID, 'Successful Maintenance Backup Transaction Log Step' AS [Description],	'MaintenanceBackupTransactionLog Success Step' AS SP,	2 AS EventLogStatusTypeID, 750 AS SortOrder UNION
SELECT 	73 as ID, 'Started Maintenance Backup Full Step' AS [Description],					'MaintenanceBackupFull First Step' AS SP,				2 AS EventLogStatusTypeID, 760 AS SortOrder UNION
SELECT 	74 as ID, 'Successful Maintenance Backup Full Step' AS [Description],				'MaintenanceBackupFull Success Step' AS SP,				2 AS EventLogStatusTypeID, 770 AS SortOrder UNION
SELECT 	75 as ID, 'Started CheckSDBReplication Step' AS [Description],						'CheckSDBReplication First Step' AS SP,					3 AS EventLogStatusTypeID, 771 AS SortOrder UNION
SELECT 	76 as ID, 'Successful CheckSDBReplication Step' AS [Description],					'CheckSDBReplication Success Step' AS SP,				3 AS EventLogStatusTypeID, 772 AS SortOrder UNION
SELECT 	77 as ID, 'Failed CheckSDBReplication Step' AS [Description],						'CheckSDBReplication Fail Step' AS SP,					3 AS EventLogStatusTypeID, 773 AS SortOrder UNION
SELECT 	78 as ID, 'Started SetBackupSDBReplication Step' AS [Description],					'SetBackupSDBReplication First Step' AS SP,				3 AS EventLogStatusTypeID, 774 AS SortOrder UNION
SELECT 	79 as ID, 'Successful SetBackupSDBReplication Step' AS [Description],				'SetBackupSDBReplication Success Step' AS SP,			3 AS EventLogStatusTypeID, 775 AS SortOrder UNION
SELECT 	80 as ID, 'Failed SetBackupSDBReplication Step' AS [Description],					'SetBackupSDBReplication Fail Step' AS SP,				3 AS EventLogStatusTypeID, 776 AS SortOrder UNION
SELECT 	81 as ID, 'Started CreateSDBPushSubscription Step' AS [Description],				'CreateSDBPushSubscription First Step' AS SP,			3 AS EventLogStatusTypeID, 777 AS SortOrder UNION
SELECT 	82 as ID, 'Successful CreateSDBPushSubscription Step' AS [Description],				'CreateSDBPushSubscription Success Step' AS SP,			3 AS EventLogStatusTypeID, 778 AS SortOrder UNION
SELECT 	83 as ID, 'Failed CreateSDBPushSubscription Step' AS [Description],					'CreateSDBPushSubscription Fail Step' AS SP,			3 AS EventLogStatusTypeID, 779 AS SortOrder UNION
SELECT 	84 as ID, 'Started CreateSDBPullSubscription Step' AS [Description],				'CreateSDBPullSubscription First Step' AS SP,			3 AS EventLogStatusTypeID, 780 AS SortOrder UNION
SELECT 	85 as ID, 'Successful CreateSDBPullSubscription Step' AS [Description],				'CreateSDBPullSubscription Success Step' AS SP,			3 AS EventLogStatusTypeID, 781 AS SortOrder UNION
SELECT 	86 as ID, 'Failed CreateSDBPullSubscription Step' AS [Description],					'CreateSDBPullSubscription Fail Step' AS SP,			3 AS EventLogStatusTypeID, 782 AS SortOrder UNION
SELECT 	87 as ID, 'Started CreateSDBPublication Step' AS [Description],						'CreateSDBPublication First Step' AS SP,				3 AS EventLogStatusTypeID, 783 AS SortOrder UNION
SELECT 	88 as ID, 'Successful CreateSDBPublication Step' AS [Description],					'CreateSDBPublication Success Step' AS SP,				3 AS EventLogStatusTypeID, 784 AS SortOrder UNION
SELECT 	89 as ID, 'Failed CreateSDBPublication Step' AS [Description],						'CreateSDBPublication Fail Step' AS SP,					3 AS EventLogStatusTypeID, 785 AS SortOrder UNION
SELECT 	90 as ID, 'Started CreateSDBMPEGDB Step' AS [Description],							'CreateSDBMPEGDB First Step' AS SP,						3 AS EventLogStatusTypeID, 786 AS SortOrder UNION
SELECT 	91 as ID, 'Successful CreateSDBMPEGDB Step' AS [Description],						'CreateSDBMPEGDB Success Step' AS SP,					3 AS EventLogStatusTypeID, 787 AS SortOrder UNION
SELECT 	92 as ID, 'Failed CreateSDBMPEGDB Step' AS [Description],							'CreateSDBMPEGDB Fail Step' AS SP,						3 AS EventLogStatusTypeID, 788 AS SortOrder UNION
SELECT 	93 as ID, 'Started DropSDBMPEGDB Step' AS [Description],							'DropSDBMPEGDB First Step' AS SP,						3 AS EventLogStatusTypeID, 789 AS SortOrder UNION
SELECT 	94 as ID, 'Successful DropSDBMPEGDB Step' AS [Description],							'DropSDBMPEGDB Success Step' AS SP,						3 AS EventLogStatusTypeID, 790 AS SortOrder UNION
SELECT 	95 as ID, 'Failed DropSDBMPEGDB Step' AS [Description],								'DropSDBMPEGDB Fail Step' AS SP,						3 AS EventLogStatusTypeID, 791 AS SortOrder UNION
SELECT 	96 as ID, 'Started CreateSDBLinkedServer Step' AS [Description],					'CreateSDBLinkedServer First Step' AS SP,				3 AS EventLogStatusTypeID, 792 AS SortOrder UNION
SELECT 	97 as ID, 'Successful CreateSDBLinkedServer Step' AS [Description],					'CreateSDBLinkedServer Success Step' AS SP,				3 AS EventLogStatusTypeID, 793 AS SortOrder UNION
SELECT 	98 as ID, 'Failed CreateSDBLinkedServer Step' AS [Description],						'CreateSDBLinkedServer Fail Step' AS SP,				3 AS EventLogStatusTypeID, 794 AS SortOrder UNION
SELECT 	99 as ID, 'Started CreateSDBMPEGObjects Step' AS [Description],						'CreateSDBMPEGObjects First Step' AS SP,				3 AS EventLogStatusTypeID, 795 AS SortOrder UNION
SELECT 	100 as ID, 'Successful CreateSDBMPEGObjects Step' AS [Description],					'CreateSDBMPEGObjects Success Step' AS SP,				3 AS EventLogStatusTypeID, 796 AS SortOrder UNION
SELECT 	101 as ID, 'Failed CreateSDBMPEGObjects Step' AS [Description],						'CreateSDBMPEGObjects Fail Step' AS SP,					3 AS EventLogStatusTypeID, 797 AS SortOrder 




) x
left join dbo.EventLogStatus y
on x.SP = y.SP
Where y.EventLogStatusID IS NULL
Order by x.ID, x.SortOrder
--select * from dbo.EventLogStatus
--select * from dbo.EventLogStatusType
GO






---------------------------------------------------
--ReplicationJobType
---------------------------------------------------


INSERT dbo.ReplicationJobType ( Description )
SELECT x.[Description]
FROM (
SELECT 	'Universal' AS [Description], 1 AS SortOrder UNION
SELECT 	'Push Distribution Agent' AS [Description], 2 AS SortOrder UNION
SELECT 	'Pull Distribution Agent' AS [Description], 3 AS SortOrder UNION
SELECT 	'Log Reader Agent' AS [Description], 4 AS SortOrder UNION
SELECT 	'Snapshot Agent' AS [Description], 5 AS SortOrder UNION
SELECT 	'Publication Agent' AS [Description], 6 AS SortOrder UNION
SELECT 	'Distribution Agent' AS [Description], 7 AS SortOrder UNION
SELECT 	'Queue Reader Agent' AS [Description], 8 AS SortOrder UNION
SELECT 	'Maintenance Agent' AS [Description], 9 AS SortOrder
) x
LEFT JOIN dbo.ReplicationJobType y
ON x.Description = y.Description
where y.ReplicationJobTypeID IS NULL
Order by x.SortOrder
Select * from dbo.ReplicationJobType



---------------------------------------------------
--MPEGArticle
---------------------------------------------------


--truncate table dbo.MPEGArticle
INSERT dbo.MPEGArticle
	(
		CMD ,
		CMDType,
		CMDParam,
		Name,
		CreateDate,
		UpdateDate
	)

SELECT 
		CMD = x.CMD,
		CMDType = x.CMDType,
		CMDParam = x.CMDParam,
		Name = x.Name,
		CreateDate = GETUTCDATE(),
		UpdateDate = GETUTCDATE()
FROM (
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			--Table Articles
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''ALARM_EVENTS'', @source_owner = N''dbo'', @source_object = N''ALARM_EVENTS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''ALARM_EVENTS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_ALARM_EVENTS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_ALARM_EVENTS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_ALARM_EVENTS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'ALARM_EVENTS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CDCI_CONFIGLOG'', @source_owner = N''dbo'', @source_object = N''CDCI_CONFIGLOG'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CDCI_CONFIGLOG'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CDCI_CONFIGLOG]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CDCI_CONFIGLOG]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CDCI_CONFIGLOG]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CDCI_CONFIGLOG' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CDCI_STATLOG'', @source_owner = N''dbo'', @source_object = N''CDCI_STATLOG'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CDCI_STATLOG'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CDCI_STATLOG]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CDCI_STATLOG]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CDCI_STATLOG]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CDCI_STATLOG' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CDCI_TUNE_DATA'', @source_owner = N''dbo'', @source_object = N''CDCI_TUNE_DATA'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CDCI_TUNE_DATA'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CDCI_TUNE_DATA]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CDCI_TUNE_DATA]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CDCI_TUNE_DATA]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CDCI_TUNE_DATA' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CDCI_VERSION'', @source_owner = N''dbo'', @source_object = N''CDCI_VERSION'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CDCI_VERSION'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CDCI_VERSION]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CDCI_VERSION]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CDCI_VERSION]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CDCI_VERSION' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CDCI_VERSION_TYPE_TEXT'', @source_owner = N''dbo'', @source_object = N''CDCI_VERSION_TYPE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CDCI_VERSION_TYPE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CDCI_VERSION_TYPE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CDCI_VERSION_TYPE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CDCI_VERSION_TYPE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CDCI_VERSION_TYPE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CHANNELGROUP'', @source_owner = N''dbo'', @source_object = N''CHANNELGROUP'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CHANNELGROUP'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CHANNELGROUP]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CHANNELGROUP]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CHANNELGROUP]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CHANNELGROUP' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CNX_SUBTYPE_TEXT'', @source_owner = N''dbo'', @source_object = N''CNX_SUBTYPE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CNX_SUBTYPE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CNX_SUBTYPE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CNX_SUBTYPE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CNX_SUBTYPE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CNX_SUBTYPE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CNX_TYPE_TEXT'', @source_owner = N''dbo'', @source_object = N''CNX_TYPE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CNX_TYPE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CNX_TYPE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CNX_TYPE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CNX_TYPE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CNX_TYPE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CONFIG'', @source_owner = N''dbo'', @source_object = N''CONFIG'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CONFIG'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CONFIG]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CONFIG]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CONFIG]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CONFIG' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CONFLICT_CHECK'', @source_owner = N''dbo'', @source_object = N''CONFLICT_CHECK'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CONFLICT_CHECK'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CONFLICT_CHECK]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CONFLICT_CHECK]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CONFLICT_CHECK]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CONFLICT_CHECK' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''CONFLICT_CHECK_STATUS_TEXT'', @source_owner = N''dbo'', @source_object = N''CONFLICT_CHECK_STATUS_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''CONFLICT_CHECK_STATUS_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_CONFLICT_CHECK_STATUS_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_CONFLICT_CHECK_STATUS_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_CONFLICT_CHECK_STATUS_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'CONFLICT_CHECK_STATUS_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''ENC_PROFILE'', @source_owner = N''dbo'', @source_object = N''ENC_PROFILE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''ENC_PROFILE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_ENC_PROFILE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_ENC_PROFILE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_ENC_PROFILE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'ENC_PROFILE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''ID'', @source_owner = N''dbo'', @source_object = N''ID'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''ID'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_ID]'', @del_cmd = N''CALL [dbo].[sp_MSdel_ID]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_ID]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'ID' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''IE'', @source_owner = N''dbo'', @source_object = N''IE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''IE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_IE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_IE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_IE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'IE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''IECONFLICT_STATUS'', @source_owner = N''dbo'', @source_object = N''IECONFLICT_STATUS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''IECONFLICT_STATUS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_IECONFLICT_STATUS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_IECONFLICT_STATUS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_IECONFLICT_STATUS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'IECONFLICT_STATUS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''IE_NOTIFY'', @source_owner = N''dbo'', @source_object = N''IE_NOTIFY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''IE_NOTIFY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_IE_NOTIFY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_IE_NOTIFY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_IE_NOTIFY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'IE_NOTIFY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''IE_STATUS'', @source_owner = N''dbo'', @source_object = N''IE_STATUS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''IE_STATUS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_IE_STATUS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_IE_STATUS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_IE_STATUS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'IE_STATUS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''INFUSION_CHANNEL_NOTIFY'', @source_owner = N''dbo'', @source_object = N''INFUSION_CHANNEL_NOTIFY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''INFUSION_CHANNEL_NOTIFY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_INFUSION_CHANNEL_NOTIFY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_INFUSION_CHANNEL_NOTIFY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_INFUSION_CHANNEL_NOTIFY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'INFUSION_CHANNEL_NOTIFY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''INFUSION_SERVER_NOTIFY'', @source_owner = N''dbo'', @source_object = N''INFUSION_SERVER_NOTIFY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''INFUSION_SERVER_NOTIFY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_INFUSION_SERVER_NOTIFY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_INFUSION_SERVER_NOTIFY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_INFUSION_SERVER_NOTIFY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'INFUSION_SERVER_NOTIFY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''INFUSION_VIDEO_NOTIFY'', @source_owner = N''dbo'', @source_object = N''INFUSION_VIDEO_NOTIFY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''INFUSION_VIDEO_NOTIFY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_INFUSION_VIDEO_NOTIFY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_INFUSION_VIDEO_NOTIFY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_INFUSION_VIDEO_NOTIFY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'INFUSION_VIDEO_NOTIFY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''INTERCONNECT_SOURCE'', @source_owner = N''dbo'', @source_object = N''INTERCONNECT_SOURCE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''INTERCONNECT_SOURCE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_INTERCONNECT_SOURCE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_INTERCONNECT_SOURCE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_INTERCONNECT_SOURCE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'INTERCONNECT_SOURCE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''IU'', @source_owner = N''dbo'', @source_object = N''IU'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''IU'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_IU]'', @del_cmd = N''CALL [dbo].[sp_MSdel_IU]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_IU]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'IU' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''IU_EXTENDED_ATTRIBUTES'', @source_owner = N''dbo'', @source_object = N''IU_EXTENDED_ATTRIBUTES'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''IU_EXTENDED_ATTRIBUTES'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_IU_EXTENDED_ATTRIBUTES]'', @del_cmd = N''CALL [dbo].[sp_MSdel_IU_EXTENDED_ATTRIBUTES]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_IU_EXTENDED_ATTRIBUTES]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'IU_EXTENDED_ATTRIBUTES' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''IU_TONE_SERVER_MAP'', @source_owner = N''dbo'', @source_object = N''IU_TONE_SERVER_MAP'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''IU_TONE_SERVER_MAP'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_IU_TONE_SERVER_MAP]'', @del_cmd = N''CALL [dbo].[sp_MSdel_IU_TONE_SERVER_MAP]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_IU_TONE_SERVER_MAP]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'IU_TONE_SERVER_MAP' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''MAP_LINKS'', @source_owner = N''dbo'', @source_object = N''MAP_LINKS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''MAP_LINKS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_MAP_LINKS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_MAP_LINKS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_MAP_LINKS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'MAP_LINKS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''NETWORK'', @source_owner = N''dbo'', @source_object = N''NETWORK'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''NETWORK'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_NETWORK]'', @del_cmd = N''CALL [dbo].[sp_MSdel_NETWORK]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_NETWORK]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'NETWORK' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''NETWORK_ATTRIBUTE'', @source_owner = N''dbo'', @source_object = N''NETWORK_ATTRIBUTE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''NETWORK_ATTRIBUTE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_NETWORK_ATTRIBUTE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_NETWORK_ATTRIBUTE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_NETWORK_ATTRIBUTE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'NETWORK_ATTRIBUTE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''NETWORK_IU_MAP'', @source_owner = N''dbo'', @source_object = N''NETWORK_IU_MAP'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''NETWORK_IU_MAP'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_NETWORK_IU_MAP]'', @del_cmd = N''CALL [dbo].[sp_MSdel_NETWORK_IU_MAP]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_NETWORK_IU_MAP]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'NETWORK_IU_MAP' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''NEXT_ID'', @source_owner = N''dbo'', @source_object = N''NEXT_ID'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''NEXT_ID'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_NEXT_ID]'', @del_cmd = N''CALL [dbo].[sp_MSdel_NEXT_ID]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_NEXT_ID]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'NEXT_ID' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''NTP'', @source_owner = N''dbo'', @source_object = N''NTP'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''NTP'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_NTP]'', @del_cmd = N''CALL [dbo].[sp_MSdel_NTP]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_NTP]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'NTP' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''PASSWORD'', @source_owner = N''dbo'', @source_object = N''PASSWORD'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''PASSWORD'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_PASSWORD]'', @del_cmd = N''CALL [dbo].[sp_MSdel_PASSWORD]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_PASSWORD]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'PASSWORD' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''PATTERN'', @source_owner = N''dbo'', @source_object = N''PATTERN'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''PATTERN'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_PATTERN]'', @del_cmd = N''CALL [dbo].[sp_MSdel_PATTERN]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_PATTERN]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'PATTERN' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''PATTERN_TYPES_TEXT'', @source_owner = N''dbo'', @source_object = N''PATTERN_TYPES_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''PATTERN_TYPES_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_PATTERN_TYPES_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_PATTERN_TYPES_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_PATTERN_TYPES_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'PATTERN_TYPES_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''RCM_NATIONAL_CONFLICTS'', @source_owner = N''dbo'', @source_object = N''RCM_NATIONAL_CONFLICTS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''RCM_NATIONAL_CONFLICTS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_RCM_NATIONAL_CONFLICTS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_RCM_NATIONAL_CONFLICTS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_RCM_NATIONAL_CONFLICTS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'RCM_NATIONAL_CONFLICTS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''REACHABILITY_STATUS_TEXT'', @source_owner = N''dbo'', @source_object = N''REACHABILITY_STATUS_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''REACHABILITY_STATUS_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_REACHABILITY_STATUS_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_REACHABILITY_STATUS_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_REACHABILITY_STATUS_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'REACHABILITY_STATUS_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SEASTAT_DATA'', @source_owner = N''dbo'', @source_object = N''SEASTAT_DATA'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SEASTAT_DATA'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SEASTAT_DATA]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SEASTAT_DATA]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SEASTAT_DATA]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SEASTAT_DATA' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SERVERGROUP'', @source_owner = N''dbo'', @source_object = N''SERVERGROUP'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SERVERGROUP'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SERVERGROUP]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SERVERGROUP]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SERVERGROUP]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SERVERGROUP' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SETUP_APPS'', @source_owner = N''dbo'', @source_object = N''SETUP_APPS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SETUP_APPS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SETUP_APPS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SETUP_APPS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SETUP_APPS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SETUP_APPS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SETUP_KITS'', @source_owner = N''dbo'', @source_object = N''SETUP_KITS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SETUP_KITS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SETUP_KITS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SETUP_KITS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SETUP_KITS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SETUP_KITS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SETUP_MACHINE'', @source_owner = N''dbo'', @source_object = N''SETUP_MACHINE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SETUP_MACHINE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SETUP_MACHINE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SETUP_MACHINE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SETUP_MACHINE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SETUP_MACHINE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SETUP_NETWORK'', @source_owner = N''dbo'', @source_object = N''SETUP_NETWORK'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SETUP_NETWORK'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SETUP_NETWORK]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SETUP_NETWORK]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SETUP_NETWORK]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SETUP_NETWORK' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SETUP_PLUGIN'', @source_owner = N''dbo'', @source_object = N''SETUP_PLUGIN'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SETUP_PLUGIN'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SETUP_PLUGIN]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SETUP_PLUGIN]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SETUP_PLUGIN]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SETUP_PLUGIN' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SETUP_SDVL'', @source_owner = N''dbo'', @source_object = N''SETUP_SDVL'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SETUP_SDVL'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SETUP_SDVL]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SETUP_SDVL]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SETUP_SDVL]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SETUP_SDVL' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SITE'', @source_owner = N''dbo'', @source_object = N''SITE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SITE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SITE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SITE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SITE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SITE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SITE_MACHINE'', @source_owner = N''dbo'', @source_object = N''SITE_MACHINE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SITE_MACHINE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SITE_MACHINE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SITE_MACHINE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SITE_MACHINE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SITE_MACHINE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SITE_SECURITY'', @source_owner = N''dbo'', @source_object = N''SITE_SECURITY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SITE_SECURITY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SITE_SECURITY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SITE_SECURITY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SITE_SECURITY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SITE_SECURITY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SITE_TARGETS'', @source_owner = N''dbo'', @source_object = N''SITE_TARGETS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SITE_TARGETS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SITE_TARGETS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SITE_TARGETS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SITE_TARGETS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SITE_TARGETS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SPLICER'', @source_owner = N''dbo'', @source_object = N''SPLICER'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SPLICER'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SPLICER]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SPLICER]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SPLICER]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SPLICER' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SPLICER_EXTENDED_ATTRIBUTES'', @source_owner = N''dbo'', @source_object = N''SPLICER_EXTENDED_ATTRIBUTES'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SPLICER_EXTENDED_ATTRIBUTES'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SPLICER_EXTENDED_ATTRIBUTES]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SPLICER_EXTENDED_ATTRIBUTES]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SPLICER_EXTENDED_ATTRIBUTES]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SPLICER_EXTENDED_ATTRIBUTES' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SPLICER_PORT'', @source_owner = N''dbo'', @source_object = N''SPLICER_PORT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SPLICER_PORT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SPLICER_PORT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SPLICER_PORT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SPLICER_PORT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SPLICER_PORT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SPLICER_TYPE_TEXT'', @source_owner = N''dbo'', @source_object = N''SPLICER_TYPE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SPLICER_TYPE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SPLICER_TYPE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SPLICER_TYPE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SPLICER_TYPE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SPLICER_TYPE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SPOT'', @source_owner = N''dbo'', @source_object = N''SPOT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SPOT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SPOT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SPOT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SPOT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SPOT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SPOTCONFLICT_STATUS'', @source_owner = N''dbo'', @source_object = N''SPOTCONFLICT_STATUS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SPOTCONFLICT_STATUS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SPOTCONFLICT_STATUS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SPOTCONFLICT_STATUS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SPOTCONFLICT_STATUS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SPOTCONFLICT_STATUS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SPOT_STATUS'', @source_owner = N''dbo'', @source_object = N''SPOT_STATUS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SPOT_STATUS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SPOT_STATUS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SPOT_STATUS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SPOT_STATUS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SPOT_STATUS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''STREAMERS'', @source_owner = N''dbo'', @source_object = N''STREAMERS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''STREAMERS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_STREAMERS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_STREAMERS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_STREAMERS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'STREAMERS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SYSTEM_REACHABILITY'', @source_owner = N''dbo'', @source_object = N''SYSTEM_REACHABILITY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SYSTEM_REACHABILITY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SYSTEM_REACHABILITY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SYSTEM_REACHABILITY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SYSTEM_REACHABILITY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SYSTEM_REACHABILITY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''SYSTEM_TYPES_TEXT'', @source_owner = N''dbo'', @source_object = N''SYSTEM_TYPES_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''SYSTEM_TYPES_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_SYSTEM_TYPES_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_SYSTEM_TYPES_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_SYSTEM_TYPES_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'SYSTEM_TYPES_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_MODE_TEXT'', @source_owner = N''dbo'', @source_object = N''TB_MODE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_MODE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_MODE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_MODE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_MODE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_MODE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_PATH'', @source_owner = N''dbo'', @source_object = N''TB_PATH'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_PATH'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_PATH]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_PATH]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_PATH]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_PATH' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_REQUEST'', @source_owner = N''dbo'', @source_object = N''TB_REQUEST'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_REQUEST'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_REQUEST]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_REQUEST]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_REQUEST]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_REQUEST' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_REQUEST_TEXT'', @source_owner = N''dbo'', @source_object = N''TB_REQUEST_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_REQUEST_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_REQUEST_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_REQUEST_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_REQUEST_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_REQUEST_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_SERVICE'', @source_owner = N''dbo'', @source_object = N''TB_SERVICE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_SERVICE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_SERVICE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_SERVICE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_SERVICE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_SERVICE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_SERVICE_NOTIFY'', @source_owner = N''dbo'', @source_object = N''TB_SERVICE_NOTIFY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_SERVICE_NOTIFY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_SERVICE_NOTIFY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_SERVICE_NOTIFY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_SERVICE_NOTIFY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_SERVICE_NOTIFY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_SERVICE_TEXT'', @source_owner = N''dbo'', @source_object = N''TB_SERVICE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_SERVICE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_SERVICE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_SERVICE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_SERVICE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_SERVICE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_SOURCE_TEXT'', @source_owner = N''dbo'', @source_object = N''TB_SOURCE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_SOURCE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_SOURCE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_SOURCE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_SOURCE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_SOURCE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_STATUS_TEXT'', @source_owner = N''dbo'', @source_object = N''TB_STATUS_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_STATUS_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_STATUS_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_STATUS_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_STATUS_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_STATUS_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TB_TYPES_TEXT'', @source_owner = N''dbo'', @source_object = N''TB_TYPES_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TB_TYPES_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TB_TYPES_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TB_TYPES_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TB_TYPES_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TB_TYPES_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TIME_ZONE_TEXT'', @source_owner = N''dbo'', @source_object = N''TIME_ZONE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TIME_ZONE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TIME_ZONE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TIME_ZONE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TIME_ZONE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TIME_ZONE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TM_PATH'', @source_owner = N''dbo'', @source_object = N''TM_PATH'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TM_PATH'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TM_PATH]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TM_PATH]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TM_PATH]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TM_PATH' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TM_TRANSFER'', @source_owner = N''dbo'', @source_object = N''TM_TRANSFER'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TM_TRANSFER'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TM_TRANSFER]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TM_TRANSFER]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TM_TRANSFER]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TM_TRANSFER' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TONE'', @source_owner = N''dbo'', @source_object = N''TONE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TONE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TONE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TONE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TONE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TONE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TONE_DEFAULT'', @source_owner = N''dbo'', @source_object = N''TONE_DEFAULT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TONE_DEFAULT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TONE_DEFAULT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TONE_DEFAULT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TONE_DEFAULT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TONE_DEFAULT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TONE_GRID_STATUS'', @source_owner = N''dbo'', @source_object = N''TONE_GRID_STATUS'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TONE_GRID_STATUS'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TONE_GRID_STATUS]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TONE_GRID_STATUS]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TONE_GRID_STATUS]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TONE_GRID_STATUS' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TONE_GROUP'', @source_owner = N''dbo'', @source_object = N''TONE_GROUP'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TONE_GROUP'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TONE_GROUP]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TONE_GROUP]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TONE_GROUP]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TONE_GROUP' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TONE_SERVER'', @source_owner = N''dbo'', @source_object = N''TONE_SERVER'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TONE_SERVER'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TONE_SERVER]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TONE_SERVER]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TONE_SERVER]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TONE_SERVER' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TONE_SERVICES_NOTIFY'', @source_owner = N''dbo'', @source_object = N''TONE_SERVICES_NOTIFY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TONE_SERVICES_NOTIFY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TONE_SERVICES_NOTIFY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TONE_SERVICES_NOTIFY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TONE_SERVICES_NOTIFY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TONE_SERVICES_NOTIFY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TONE_SOURCE'', @source_owner = N''dbo'', @source_object = N''TONE_SOURCE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TONE_SOURCE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TONE_SOURCE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TONE_SOURCE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TONE_SOURCE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TONE_SOURCE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TSI_BW_LICENSE'', @source_owner = N''dbo'', @source_object = N''TSI_BW_LICENSE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TSI_BW_LICENSE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TSI_BW_LICENSE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TSI_BW_LICENSE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TSI_BW_LICENSE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TSI_BW_LICENSE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TSI_BW_STATUS_TEXT'', @source_owner = N''dbo'', @source_object = N''TSI_BW_STATUS_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TSI_BW_STATUS_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TSI_BW_STATUS_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TSI_BW_STATUS_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TSI_BW_STATUS_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TSI_BW_STATUS_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TSI_SUBTYPE'', @source_owner = N''dbo'', @source_object = N''TSI_SUBTYPE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TSI_SUBTYPE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TSI_SUBTYPE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TSI_SUBTYPE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TSI_SUBTYPE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TSI_SUBTYPE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''TSI_SUBTYPE_TEXT'', @source_owner = N''dbo'', @source_object = N''TSI_SUBTYPE_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''TSI_SUBTYPE_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_TSI_SUBTYPE_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_TSI_SUBTYPE_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_TSI_SUBTYPE_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'TSI_SUBTYPE_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEO'', @source_owner = N''dbo'', @source_object = N''VIDEO'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEO'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEO]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEO]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEO]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEO' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEOS_ARCHIVED'', @source_owner = N''dbo'', @source_object = N''VIDEOS_ARCHIVED'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEOS_ARCHIVED'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEOS_ARCHIVED]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEOS_ARCHIVED]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEOS_ARCHIVED]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEOS_ARCHIVED' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEOS_ARCHIVED_TEXT'', @source_owner = N''dbo'', @source_object = N''VIDEOS_ARCHIVED_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEOS_ARCHIVED_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEOS_ARCHIVED_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEOS_ARCHIVED_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEOS_ARCHIVED_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEOS_ARCHIVED_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEO_AGENT_TEXT'', @source_owner = N''dbo'', @source_object = N''VIDEO_AGENT_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEO_AGENT_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEO_AGENT_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEO_AGENT_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEO_AGENT_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEO_AGENT_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEO_EXTRA_ATTRIBUTE'', @source_owner = N''dbo'', @source_object = N''VIDEO_EXTRA_ATTRIBUTE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEO_EXTRA_ATTRIBUTE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEO_EXTRA_ATTRIBUTE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEO_EXTRA_ATTRIBUTE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEO_EXTRA_ATTRIBUTE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEO_EXTRA_ATTRIBUTE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEO_NOTIFY'', @source_owner = N''dbo'', @source_object = N''VIDEO_NOTIFY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEO_NOTIFY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEO_NOTIFY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEO_NOTIFY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEO_NOTIFY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEO_NOTIFY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEO_PID'', @source_owner = N''dbo'', @source_object = N''VIDEO_PID'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEO_PID'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEO_PID]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEO_PID]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEO_PID]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEO_PID' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEO_REPLACE'', @source_owner = N''dbo'', @source_object = N''VIDEO_REPLACE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEO_REPLACE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEO_REPLACE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEO_REPLACE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEO_REPLACE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEO_REPLACE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEO_REPLACE_STATUS_TEXT'', @source_owner = N''dbo'', @source_object = N''VIDEO_REPLACE_STATUS_TEXT'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEO_REPLACE_STATUS_TEXT'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEO_REPLACE_STATUS_TEXT]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEO_REPLACE_STATUS_TEXT]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEO_REPLACE_STATUS_TEXT]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEO_REPLACE_STATUS_TEXT' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''VIDEO_X_COMPUTER'', @source_owner = N''dbo'', @source_object = N''VIDEO_X_COMPUTER'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''VIDEO_X_COMPUTER'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_VIDEO_X_COMPUTER]'', @del_cmd = N''CALL [dbo].[sp_MSdel_VIDEO_X_COMPUTER]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_VIDEO_X_COMPUTER]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'VIDEO_X_COMPUTER' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''ZONE'', @source_owner = N''dbo'', @source_object = N''ZONE'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''ZONE'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_ZONE]'', @del_cmd = N''CALL [dbo].[sp_MSdel_ZONE]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_ZONE]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'ZONE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''ZONE_PRIORITY'', @source_owner = N''dbo'', @source_object = N''ZONE_PRIORITY'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''ZONE_PRIORITY'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_ZONE_PRIORITY]'', @del_cmd = N''CALL [dbo].[sp_MSdel_ZONE_PRIORITY]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_ZONE_PRIORITY]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'ZONE_PRIORITY' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''ZONE_TIME_ZONE_MAP'', @source_owner = N''dbo'', @source_object = N''ZONE_TIME_ZONE_MAP'', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000000CCF3, @identityrangemanagementoption = N''none'', @destination_table = N''ZONE_TIME_ZONE_MAP'', @destination_owner = N''dbo'', @status = 16, @vertical_partition = N''false'', @ins_cmd = N''CALL [dbo].[sp_MSins_ZONE_TIME_ZONE_MAP]'', @del_cmd = N''CALL [dbo].[sp_MSdel_ZONE_TIME_ZONE_MAP]'', @upd_cmd = N''CALL [dbo].[sp_MSupd_ZONE_TIME_ZONE_MAP]'' ', CMDParam			= NULL, 'CMD' as CMDType, 'ZONE_TIME_ZONE_MAP' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''sp_MSupd_IE'', @source_owner = N''dbo'', @source_object = N''sp_MSupd_IE'', @type = N''proc schema only'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x0000000008000001, @destination_table = N''sp_MSupd_IE'', @destination_owner = N''dbo'', @status = 16 ', CMDParam			= NULL, 'CMD' as CMDType, 'sp_MSupd_IE' as Name  UNION ALL 
 			SELECT		CMD			= N'exec token.mpeg.dbo.sp_addarticle @publication = N''Spot+mpegPublication Backup'', @article = N''sp_MSupd_SPOT'', @source_owner = N''dbo'', @source_object = N''sp_MSupd_SPOT'', @type = N''proc schema only'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x0000000008000001, @destination_table = N''sp_MSupd_SPOT'', @destination_owner = N''dbo'', @status = 16 ', CMDParam			= NULL, 'CMD' as CMDType, 'sp_MSupd_SPOT' as Name  




) x
LEFT JOIN dbo.MPEGArticle y
ON x.Name = y.Name
AND x.CMDType = y.CMDType
WHERE y.Name IS NULL




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			--Insert-Execute commands
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--truncate table dbo.MPEGArticle
INSERT dbo.MPEGArticle
	(
		CMD ,
		CMDType,
		CMDParam,
		Name,
		CreateDate,
		UpdateDate
	)

SELECT 
		CMD = x.CMD,
		CMDType = x.CMDType,
		CMDParam = x.CMDParam,
		Name = x.Name,
		CreateDate = GETUTCDATE(),
		UpdateDate = GETUTCDATE()
FROM (


			--SSRS Reports
			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, VideoID, Channel, ZoneName, NetworkName, Position, BreakStatus, BreakConflictStatus, SpotStatus, SpotConflictStatus, SCHED_DATE_TIME ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_1_SpotReport @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @ChannelName, @MarketID, @ZoneName, @NetworkName, @ICProviderID, @ROCID, @IEStatus, @IEConflictStatus, @SPOTStatus, @SPOTConflictStatus, @StartDate, @EndDate ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @ChannelName VARCHAR(50), @MarketID INT, @ZoneName VARCHAR(50), @NetworkName VARCHAR(50), @ICProviderID INT, @ROCID INT, @IEStatus VARCHAR(500), @IEConflictStatus VARCHAR(500), @SPOTStatus VARCHAR(500), @SPOTConflictStatus VARCHAR(500), @StartDate DATETIME, @EndDate DATETIME ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_1_SpotReport' UNION ALL


			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, Channel, ZoneName, NetworkName, IU_ID, IE_ID, IESourceID, IEStatus, IEConflictStatus, SpotStatus, SpotConflictStatus, LastScheduleLoad, SCHED_DATE, SCHED_DATE_TIME, ICScheduleLoaded, ICScheduleBreakCount, ICMissingMedia, ICMediaPrefixErrors, ICMediaDurationErrors, ICMediaFormatErrors, ATTScheduleLoaded,	 ATTScheduleBreakCount, ATTMissingMedia, ATTMediaPrefixErrors, ATTMediaDurationErrors, ATTMediaFormatErrors ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_3_FutureReadiness @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @ChannelName, @MarketID, @ZoneName, @NetworkName, @ICProviderID, @ROCID, @StartDateTime, @EndDateTime ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @ChannelName VARCHAR(50), @MarketID INT, @ZoneName VARCHAR(50), @NetworkName VARCHAR(50), @ICProviderID INT, @ROCID INT, @StartDateTime DATETIME, @EndDateTime DATETIME ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_3_FutureReadiness' UNION ALL



			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, ZoneName, AssetID, Duration, Ingested  ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_4_AssetSummaryDetails @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @ICProviderID, @ROCID, @AssetID, @MinDuration, @MaxDuration, @StartDateTime, @EndDateTime ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @ICProviderID INT, @ROCID INT, @AssetID VARCHAR(50), @MinDuration INT, @MaxDuration INT, @StartDateTime DATETIME, @EndDateTime DATETIME ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_4_AssetSummaryDetails' UNION ALL



			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, ZoneName, AssetID, Duration ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_4_AssetSummaryDuration @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @MinDuration, @MaxDuration, @StartDateTime, @EndDateTime ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @MinDuration INT, @MaxDuration INT, @StartDateTime DATETIME, @EndDateTime DATETIME ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_4_AssetSummaryDuration' UNION ALL



			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, ZoneName, AssetID, Ingested  ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_4_AssetSummaryICROC @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @ICProviderID, @ROCID, @StartDateTime, @EndDateTime ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @ICProviderID INT, @ROCID INT, @StartDateTime DATETIME, @EndDateTime DATETIME ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_4_AssetSummaryICROC' UNION ALL



			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, NetworkName, ZoneName, Channel, TotalSpots, TotalSpotsPlayed, TotalSpotsFailed, TotalSpotsNoTone, TotalSpotsError, TotalSpotsMissing, TotalICSpots, TotalICSpotsPlayed, TotalICSpotsFailed, TotalICSpotsNoTone, TotalICSpotsError, TotalICSpotsMissing, TotalATTSpots, TotalATTSpotsPlayed, TotalATTSpotsFailed, TotalATTSpotsNoTone, TotalATTSpotsError, TotalATTSpotsMissing ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_5_RunRate @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @MarketID, @ZoneName, @NetworkName, @ICProviderID, @ROCID, @ChannelName, @ScheduleDate ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @MarketID INT, @ZoneName VARCHAR(50), @NetworkName VARCHAR(50), @ICProviderID INT, @ROCID INT, @ChannelName VARCHAR(50), @ScheduleDate DATE ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_5_RunRate' UNION ALL



			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, ZoneName, NetworkName, Channel, ScheduleDate, AssetID, Duration   ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_7_VideoDurationMismatch @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @MarketID, @ZoneName, @NetworkName, @ICProviderID, @ROCID, @ChannelName, @ScheduleDate, @AssetID ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @MarketID INT, @ZoneName VARCHAR(50), @NetworkName VARCHAR(50), @ICProviderID INT, @ROCID INT, @ChannelName VARCHAR(100), @ScheduleDate DATE, @AssetID VARCHAR(50) ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_7_VideoDurationMismatch' UNION ALL



			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, ZoneName, NetworkName, Channel, ScheduleDate, AssetID, VideoFormat   ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_7_VideoFormatMismatch @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @MarketID, @ZoneName, @NetworkName, @ICProviderID, @ROCID, @ChannelName, @ScheduleDate, @AssetID ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @MarketID INT, @ZoneName VARCHAR(50), @NetworkName VARCHAR(50), @ICProviderID INT, @ROCID INT, @ChannelName VARCHAR(100), @ScheduleDate DATE, @AssetID VARCHAR(50) ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_7_VideoFormatMismatch' UNION ALL



			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, ZoneName, NetworkName, Channel, ScheduleDate, ScheduleLoadDateTime ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_8_ScheduleLoadEvents @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @MarketID, @ZoneName, @NetworkName, @ICProviderID, @ROCID, @ChannelName, @ScheduleDate ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @MarketID VARCHAR(50), @ZoneName VARCHAR(50), @NetworkName VARCHAR(50), @ICProviderID VARCHAR(50),	 @ROCID VARCHAR(50), @ChannelName VARCHAR(12), @ScheduleDate DATE ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_8_ScheduleLoadEvents' UNION ALL



			SELECT			CMD			=	'INSERT INTO #ResultAllSpots (RegionID, SDBSourceID, SDB, DBSource, Reason, FileName, ScheduledDateTime ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_9_FailedVideoIngests @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @FileName, @StartDateTime, @EndDateTime ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @FileName VARCHAR(100), @StartDateTime DATETIME,  @EndDateTime DATETIME ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_9_FailedVideoIngests' UNION ALL




			SELECT			CMD			=	'INSERT INTO #tmp_AllSpots (RegionID, SDBSourceID, SDB, DBSource, ZoneName, NetworkName, Channel, Position, AssetID, SpotStatus, SpotConflictStatus, ScheduleLoadDateTime ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.Report_2_10_10_MissingMedia @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @UseUTC, @SortOrder, @Channel, @MarketID, @ZoneName, @NetworkName, @ICProviderID, @ROCID,	 @SpotStatusID, @SpotConflictStatusID, @StartDateTime, @EndDateTime ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @UseUTC INT, @SortOrder INT, @Channel VARCHAR(12), @MarketID INT, @ZoneName VARCHAR(50), @NetworkName INT, @ICProviderID INT, @ROCID INT, @SpotStatusID INT, @SpotConflictStatusID INT, @StartDateTime DATETIME, @EndDateTime DATETIME ',
							CMDType		=	'INSERT-EXEC', Name = 'Report_2_10_10_MissingMedia' UNION ALL










			--DINGODW SPs to ETL for reporting

			SELECT			CMD			=	'INSERT INTO #tmp_AllSpots ( RegionID, SDBSourceID, SDBName, UTCOffset, ZoneName, Spot_ID, VIDEO_ID, DURATION, CUSTOMER, TITLE, NSTATUS, CONFLICT_STATUS, RATE, CODE, NOTES, SERIAL, IDSpot, IE_ID, Spot_ORDER, RUN_DATE_TIME, RUN_LENGTH, VALUE, ORDER_ID, BONUS_FLAG, SOURCE_ID, TS, NSTATUSValue, CONFLICT_STATUSValue, SOURCE_ID_INTERCONNECT_NAME, IESCHED_DATE, IESCHED_DATE_TIME, IU_ID, NetworkID, NetworkName, UTCSPOTDatetime, UTCSPOTDate, UTCSPOTDateYear, UTCSPOTDateMonth, UTCSPOTDateDay, UTCSPOTDayOfYearPartitionKey ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.ETLDimSpot @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @StartingDate, @EndingDate ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @StartingDate DATE, @EndingDate DATE ',
							CMDType		=	'INSERT-EXEC', Name = 'ETLDimSpot' UNION ALL

								


			SELECT			CMD			=	'INSERT INTO #tmp_AllSpots ( RegionID, SDBSourceID, SDBName, UTCOffset, ZoneName, TSI, ChannelName, SCHED_DATE_TIME, IE_ID, IU_ID, NSTATUS, NSTATUSValue, CONFLICT_STATUS, CONFLICT_STATUSValue, SPOTS, DURATION, RUN_DATE_TIME, START_TRIGGER, END_TRIGGER, AWIN_START, AWIN_END, VALUE, BREAK_INWIN, AWIN_START_DT, AWIN_END_DT, EVENT_ID, TS, SOURCE_ID, SOURCE_IDName, TB_TYPE, TB_TYPEName, NetworkID, NetworkName, UTCIEDatetime, UTCIEDate, UTCIEDateYear, UTCIEDateMonth, UTCIEDateDay, UTCIEDayOfYearPartitionKey ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.ETLDimIE @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @StartingDate, @EndingDate ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @StartingDate DATE, @EndingDate DATE ',
							CMDType		=	'INSERT-EXEC', Name = 'ETLDimIE' UNION ALL



			SELECT			CMD			=	'INSERT INTO #tmp_AllSpots ( RegionID, SDBSourceID, SDBName, UTCOffset, IU_ID, ZoneName, CHANNEL, CHAN_NAME, ChannelName, DELAY, START_TRIGGER, END_TRIGGER, AWIN_START, AWIN_END, VALUE, MASTER_NAME, COMPUTER_NAME, PARENT_ID, SYSTEM_TYPE, COMPUTER_PORT, MIN_DURATION, MAX_DURATION, START_OF_DAY, RESCHEDULE_WINDOW, IC_CHANNEL, VSM_SLOT, DECODER_PORT, TC_ID, IGNORE_VIDEO_ERRORS, IGNORE_AUDIO_ERRORS, COLLISION_DETECT_ENABLED, TALLY_NORMALLY_HIGH, PLAY_OVER_COLLISIONS, PLAY_COLLISION_FUDGE, TALLY_COLLISION_FUDGE, TALLY_ERROR_FUDGE, LOG_TALLY_ERRORS, TBI_START, TBI_END, CONTINUOUS_PLAY_FUDGE, TONE_GROUP, IGNORE_END_TONES, END_TONE_FUDGE, MAX_AVAILS, RESTART_TRIES, RESTART_BYTE_SKIP, RESTART_TIME_REMAINING, GENLOCK_FLAG, SKIP_HEADER, GPO_IGNORE, GPO_NORMAL, GPO_TIME, DECODER_SHARING, HIGH_PRIORITY, SPLICER_ID, PORT_ID, VIDEO_PID, SERVICE_PID, DVB_CARD, SPLICE_ADJUST, POST_BLACK, SWITCH_CNT, DECODER_CNT, DVB_CARD_CNT, DVB_PORTS_PER_CARD, DVB_CHAN_PER_PORT, USE_ISD, NO_NETWORK_VIDEO_DETECT, NO_NETWORK_PLAY, IP_TONE_THRESHOLD, USE_GIGE, GIGE_IP, IS_ACTIVE_IND, SYSTEM_TYPEName, IESCHED_DATE, IESCHED_DATE_TIME, NetworkID, NetworkName, UTCIEDatetime, UTCIEDate, UTCIEDateYear, UTCIEDateMonth, UTCIEDateDay, UTCIEDayOfYearPartitionKey ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.ETLDimIU @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @StartingDate, @EndingDate ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @StartingDate DATE, @EndingDate DATE ',
							CMDType		=	'INSERT-EXEC', Name = 'ETLDimIU' UNION ALL



			SELECT			CMD			=	'INSERT INTO #tmp_AllSpots ( RegionID, SDBSourceID, SDBName, UTCOffset, TB_ID, ZONE_ID, IU_ID, TB_REQUEST, TB_MODE, TB_TYPE, TB_DAYPART, TB_FILE, TB_FILE_DATE, STATUS, EXPLANATION, TB_MACHINE, TB_MACHINE_TS, TB_MACHINE_THREAD, REQUESTING_MACHINE, REQUESTING_PORT, SOURCE_ID, MSGNR, TS, ZoneName, TB_MODE_NAME, REQUEST_NAME, SOURCE_ID_NAME, STATUS_NAME, TYPE_NAME, DAYPART_DATE, DAYPART_DATE_TIME, NetworkID, NetworkName, UTCIEDatetime, UTCIEDate, UTCIEDateYear, UTCIEDateMonth, UTCIEDateDay, UTCIEDayOfYearPartitionKey ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.ETLDimTB_REQUEST @RegionID, @SDBSourceID, @SDBName, @UTCOffset, @StartingDate, @EndingDate ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @StartingDate DATE, @EndingDate DATE ',
							CMDType		=	'INSERT-EXEC', Name = 'ETLDimTB_REQUEST' UNION ALL



			SELECT			CMD			=	'INSERT INTO #tmp_AllSpots ( RegionID, SDBSourceID, SDBName, UTCOffset, AssetID, VIDEO_ID, FRAMES, CODE, DESCRIPTION, VALUE, FPS, Length ) ' +
											'EXEC [@ReplicationCluster].MPEGN.dbo.ETLDimAsset @RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @Override ',
							CMDParam	=	'@RegionID INT, @SDBSourceID INT, @SDBName VARCHAR(64), @UTCOffset INT, @Override BIT ',
							CMDType		=	'INSERT-EXEC', Name = 'ETLDimAsset' 






) x
LEFT JOIN dbo.MPEGArticle y
ON x.Name = y.Name
AND x.CMDType = y.CMDType
WHERE y.Name IS NULL




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			--SP Articles (MPEG Native SPs)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--truncate table dbo.MPEGArticle
INSERT dbo.MPEGArticle
	(
		CMD ,
		CMDType,
		CMDParam,
		Name,
		CreateDate,
		UpdateDate
	)

SELECT 
		CMD = x.CMD,
		CMDType = x.CMDType,
		CMDParam = x.CMDParam,
		Name = x.Name,
		CreateDate = GETUTCDATE(),
		UpdateDate = GETUTCDATE()
FROM (


			SELECT		CMD			= 
N'create procedure [dbo].[sp_MSupd_IE]
		@c1 int,
		@c2 int,
		@c3 datetime,
		@c4 char(5),
		@c5 char(5),
		@c6 int,
		@c7 int,
		@c8 int,
		@c9 int,
		@c10 datetime,
		@c11 int,
		@c12 int,
		@c13 int,
		@c14 int,
		@c15 datetime,
		@c16 datetime,
		@c17 int,
		@c18 int,
		@c19 int,
		@c20 binary(8),
		@pkc1 int
as
begin  
if not exists (select 1 from IE where [IE_ID] = @c1)
begin 
insert into [dbo].[IE] ([IE_ID], [IU_ID],[SCHED_DATE_TIME],	[START_TRIGGER] ,[END_TRIGGER],	[NSTATUS],	[CONFLICT_STATUS],[SPOTS],[DURATION],[RUN_DATE_TIME],[AWIN_START],[AWIN_END],[VALUE],[BREAK_INWIN],	[AWIN_START_DT],[AWIN_END_DT],	[SOURCE_ID],[TB_TYPE],	[EVENT_ID],	[TS])
values (@c1, @c2, @c3, @c4, @c5, @c6, @c7, @c8, @c9, @c10, @c11, @c12, @c13, @c14, @c15, @c16, @c17, @c18, @c19, @c20)
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[IE] set
		[IU_ID] = @c2,
		[SCHED_DATE_TIME] = @c3,
		[START_TRIGGER] = @c4,
		[END_TRIGGER] = @c5,
		[NSTATUS] = @c6,
		[CONFLICT_STATUS] = @c7,
		[SPOTS] = @c8,
		[DURATION] = @c9,
		[RUN_DATE_TIME] = @c10,
		[AWIN_START] = @c11,
		[AWIN_END] = @c12,
		[VALUE] = @c13,
		[BREAK_INWIN] = @c14,
		[AWIN_START_DT] = @c15,
		[AWIN_END_DT] = @c16,
		[SOURCE_ID] = @c17,
		[TB_TYPE] = @c18,
		[EVENT_ID] = @c19,
		[TS] = @c20
where [IE_ID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end 
end 
', CMDParam			= NULL, 'SP' as CMDType, 'sp_MSupd_IE' as Name UNION ALL


			SELECT		CMD			= 
N'create procedure [dbo].[sp_MSupd_SPOT]
		@c1 int,
		@c2 varchar(32),
		@c3 int,
		@c4 varchar(80),
		@c5 varchar(254),
		@c6 int,
		@c7 int,
		@c8 float,
		@c9 varchar(12),
		@c10 varchar(254),
		@c11 varchar(32),
		@c12 varchar(32),
		@c13 int,
		@c14 int,
		@c15 datetime,
		@c16 int,
		@c17 int,
		@c18 int,
		@c19 int,
		@c20 int,
		@c21 binary(8),
		@pkc1 int
as
begin  
if not exists (select 1 from SPOT where [SPOT_ID] = @c1)
begin 
insert into [dbo].[SPOT] ([SPOT_ID],[VIDEO_ID],[DURATION],[CUSTOMER],[TITLE],[NSTATUS],[CONFLICT_STATUS],[RATE] ,[CODE] ,[NOTES],[SERIAL],[ID],[IE_ID],[SPOT_ORDER] ,[RUN_DATE_TIME],[RUN_LENGTH] ,[VALUE] ,[ORDER_ID],[BONUS_FLAG],[SOURCE_ID] ,[TS])
values(@c1, @c2, @c3, @c4, @c5, @c6, @c7, @c8, @c9, @c10, @c11, @c12, @c13, @c14, @c15, @c16, @c17, @c18, @c19, @c20, @c21)
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[SPOT] set
		[VIDEO_ID] = @c2,
		[DURATION] = @c3,
		[CUSTOMER] = @c4,
		[TITLE] = @c5,
		[NSTATUS] = @c6,
		[CONFLICT_STATUS] = @c7,
		[RATE] = @c8,
		[CODE] = @c9,
		[NOTES] = @c10,
		[SERIAL] = @c11,
		[ID] = @c12,
		[IE_ID] = @c13,
		[SPOT_ORDER] = @c14,
		[RUN_DATE_TIME] = @c15,
		[RUN_LENGTH] = @c16,
		[VALUE] = @c17,
		[ORDER_ID] = @c18,
		[BONUS_FLAG] = @c19,
		[SOURCE_ID] = @c20,
		[TS] = @c21
where [SPOT_ID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end 
end 
', CMDParam			= NULL, 'SP' as CMDType, 'sp_MSupd_SPOT' as Name  UNION ALL



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			--SP Articles (ETL SPs)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			SELECT		CMD			= 
'
CREATE PROCEDURE [dbo].[ImportBreakCountHistory]
				@SDBUTCOffset				INT,
				@SDBSourceID				INT,
				@Day						DATETIME = NULL,
				@ErrorID					INT OUTPUT,
				@ErrMsg						VARCHAR(200) OUTPUT
AS
BEGIN


				SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET			NOCOUNT ON;

				DECLARE		@StartDayIESPOT					DATE
				DECLARE		@EndDayIESPOT					DATE
				DECLARE		@StartDayBreakCount				DATE
				DECLARE		@EndDayBreakCount				DATE
				DECLARE		@NowSDBTime						DATETIME

				SELECT		@StartDayIESPOT					= ISNULL(@Day, DATEADD(HOUR, @SDBUTCOffset, GETUTCDATE()) ),
							@EndDayIESPOT					= DATEADD(DAY, 2, @StartDayIESPOT)

				SELECT		@NowSDBTime						= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
				SELECT		@StartDayBreakCount				= DATEADD( DAY, -6, @NowSDBTime ),
							@EndDayBreakCount				= DATEADD( DAY, 2, @NowSDBTime )


				IF			EXISTS(SELECT TOP 1 1 FROM sys.tables WHERE name IN (''IE'')) 
							SELECT			IU_BREAKS.BREAK_DATE, 
											IU_BREAKS.IU_ID AS IU_ID, 
											IU_BREAKS.SOURCE_ID AS SOURCE_ID, 
											IU_BREAKS.BREAK_COUNT, 
											@SDBSourceID AS SDBSourceID 
							FROM 
										( 
											SELECT  
														CONVERT( DATE, IE.SCHED_DATE_TIME ) AS BREAK_DATE, 
														IE.IU_ID AS IU_ID, 
														IE.SOURCE_ID, 
														COUNT(1) AS BREAK_COUNT  
											FROM		dbo.IE IE WITH (NOLOCK) 
											WHERE		IE.SCHED_DATE_TIME  >= @StartDayBreakCount 
											AND			IE.SCHED_DATE_TIME < @EndDayBreakCount 
											AND			IE.NSTATUS <> 15
											GROUP BY	CONVERT( DATE, IE.SCHED_DATE_TIME ), IE.IU_ID, IE.SOURCE_ID  
										)	AS IU_BREAKS


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'ImportBreakCountHistory' as Name  UNION ALL

			SELECT		CMD			= 
'
CREATE PROCEDURE [dbo].[ImportChannelAndConflictStats]
				@SDBUTCOffset				INT,
				@SDBSourceID				INT,
				@Day						DATETIME = NULL,
				@ErrorID					INT OUTPUT,
				@ErrMsg						VARCHAR(200) OUTPUT
AS
BEGIN


				SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET			NOCOUNT ON;

				DECLARE		@StartDayIESPOT					DATE
				DECLARE		@EndDayIESPOT					DATE
				DECLARE		@StartDayBreakCount				DATE
				DECLARE		@EndDayBreakCount				DATE
				DECLARE		@NowSDBTime						DATETIME

				SELECT		@StartDayIESPOT					= ISNULL(@Day, DATEADD(HOUR, @SDBUTCOffset, GETUTCDATE()) ),
							@EndDayIESPOT					= DATEADD(DAY, 2, @StartDayIESPOT)

				SELECT		@NowSDBTime						= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
				SELECT		@StartDayBreakCount				= DATEADD( DAY, -6, @NowSDBTime ),
							@EndDayBreakCount				= DATEADD( DAY, 2, @NowSDBTime )

				IF			( SELECT COUNT(1) FROM sys.tables WHERE name IN (''IE'',''SPOT'') ) = 2
							SELECT	
											@SDBSourceID AS SDBSourceID, 
											SPOT.SPOT_ID, 
											IE.IE_ID, 
											IE.IU_ID, 
											CONVERT(DATE, IE.SCHED_DATE_TIME), 
											IE.SCHED_DATE_TIME,  
											IE.NSTATUS, 
											IE.CONFLICT_STATUS, 
											IE.AWIN_END_DT, 
											IE.SOURCE_ID, 
											SPOT.VIDEO_ID, 
											SPOT.TITLE + '' - '' + SPOT.CUSTOMER	AS ASSET_DESC, 
											SPOT.NSTATUS, 
											SPOT.CONFLICT_STATUS, 
											SPOT.SPOT_ORDER,  
											SPOT.RUN_DATE_TIME
							FROM			dbo.IE IE WITH (NOLOCK) 
							JOIN			dbo.SPOT SPOT WITH (NOLOCK) 
							ON				IE.IE_ID = SPOT.IE_ID 
							WHERE			IE.SCHED_DATE_TIME >= @StartDayIESPOT
							AND				IE.SCHED_DATE_TIME < @EndDayIESPOT
							AND				IE.NSTATUS <> 15



END
'
, CMDParam			= NULL, 'SP' as CMDType, 'ImportChannelAndConflictStats' as Name  UNION ALL
			SELECT		CMD			= 
'
CREATE PROCEDURE [dbo].[ImportTrafficAndBillingData]
				@SDBUTCOffset				INT,
				@SDBSourceID				INT,
				@Day						DATETIME = NULL,
				@ErrorID					INT OUTPUT,
				@ErrMsg						VARCHAR(200) OUTPUT
AS
BEGIN


				SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET			NOCOUNT ON;

				DECLARE		@StartDayIESPOT					DATE
				DECLARE		@EndDayIESPOT					DATE
				DECLARE		@StartDayBreakCount				DATE
				DECLARE		@EndDayBreakCount				DATE
				DECLARE		@NowSDBTime						DATETIME

				SELECT		@StartDayIESPOT					= ISNULL(@Day, DATEADD(HOUR, @SDBUTCOffset, GETUTCDATE()) ),
							@EndDayIESPOT					= DATEADD(DAY, 2, @StartDayIESPOT)

				SELECT		@NowSDBTime						= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
				SELECT		@StartDayBreakCount				= DATEADD( DAY, -6, @NowSDBTime ),
							@EndDayBreakCount				= DATEADD( DAY, 2, @NowSDBTime )


				IF			EXISTS(SELECT TOP 1 1 FROM sys.tables WHERE name IN (''TB_REQUEST'')) 
							SELECT 
											CONVERT(DATE,TB_DAYPART) AS SCHED_DATE, 
											CONVERT( DATE, DATEADD(hour, @SDBUTCOffset, TB_DAYPART)) AS UTC_SCHED_DATE, 
											SUBSTRING(TBR.TB_FILE,CHARINDEX(''\SCH\'',TBR.TB_FILE,0)+5,12) AS FILENAME, 
											TBR.TB_FILE_DATE AS [FILE_DATETIME], 
											DATEADD( hour, @SDBUTCOffset, TBR.TB_FILE_DATE ) AS UTC_FILE_DATETIME, 
											TBR.TB_MACHINE_TS AS PROCESSED, 
											TBR.SOURCE_ID, 
											TBR.STATUS, 
											TBR.IU_ID, 
											@SDBSourceID AS SDBSourceID 
							FROM			dbo.TB_REQUEST TBR WITH (NOLOCK)  
							WHERE			TBR.TB_MODE = 3 
							AND				TBR.TB_REQUEST = 2


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'ImportTrafficAndBillingData' as Name   




) x
LEFT JOIN dbo.MPEGArticle y
ON x.Name = y.Name
AND x.CMDType = y.CMDType
WHERE y.Name IS NULL




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			--SP Articles (SSRS SPs)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Query to script SP text
/*


SELECT		SPName = o.name,
			SQLStr = '			SELECT		CMD			= ''' + -- Char(10) + -- char(13)
					REPLACE(c.text,'''', '''''') +
					'''
, CMDParam			= NULL, ''SP'' as CMDType, '''+o.name+''' as Name  UNION ALL '
from sysobjects o
join syscomments c
on o.id = c.id
where xtype = 'P'  
and o.name like 'Report%'
--and c.text like '%sp_execute%'
order by o.name



			SELECT		CMD			= ''
, CMDParam			= NULL, 'SP' as CMDType, '' as Name  




*/



--truncate table dbo.MPEGArticle
INSERT dbo.MPEGArticle
	(
		CMD ,
		CMDType,
		CMDParam,
		Name,
		CreateDate,
		UpdateDate
	)

SELECT 
		CMD = x.CMD,
		CMDType = x.CMDType,
		CMDParam = x.CMDParam,
		Name = x.Name,
		CreateDate = GETUTCDATE(),
		UpdateDate = GETUTCDATE()
FROM (


			SELECT		CMD			= '
CREATE PROCEDURE dbo.ETLDimAsset 
								@RegionID			INT,
								@SDBSourceID		INT,
								@SDBName			VARCHAR(64),
								@UTCOffset			INT,
								@Override			BIT
AS
BEGIN


								SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
								SET				NOCOUNT ON


								IF				(@Override = 1) 
								BEGIN


												SELECT			RegionID								= @RegionID,
																SDBSourceID								= @SDBSourceID,
																SDBName									= @SDBName,
																UTCOffset								= @UTCOffset,
																AssetID									= v.VIDEO_ID,
																VIDEO_ID								= v.VIDEO_ID,
																FRAMES									= v.FRAMES,
																CODE									= v.CODE,
																DESCRIPTION								= v.DESCRIPTION,
																VALUE									= v.VALUE,
																FPS										= v.FPS,
																Length									= CASE WHEN ISNULL(v.FPS,0) <> 0 THEN v.FRAMES/v.FPS ELSE 1 END
												FROM			dbo.VIDEO v WITH (NOLOCK)


								END
								ELSE			IF				(OBJECT_ID(''cdc.dbo_VIDEO_CT'') IS NOT NULL)
								BEGIN


												SELECT			RegionID								= @RegionID,
																SDBSourceID								= @SDBSourceID,
																SDBName									= @SDBName,
																UTCOffset								= @UTCOffset,
																AssetID									= v.VIDEO_ID,
																VIDEO_ID								= v.VIDEO_ID,
																FRAMES									= v.FRAMES,
																CODE									= v.CODE,
																DESCRIPTION								= v.DESCRIPTION,
																VALUE									= v.VALUE,
																FPS										= v.FPS,
																Length									= CASE WHEN ISNULL(v.FPS,0) <> 0 THEN v.FRAMES/v.FPS ELSE 1 END
												FROM			cdc.dbo_VIDEO_CT v WITH (NOLOCK)


								END
								ELSE			IF				NOT EXISTS	( 
																				SELECT	TOP 1 1
																				FROM	cdc.change_tables ct
																				JOIN	sysobjects o	ON ct.source_object_id = o.id
																				WHERE	name			= ''VIDEO''
																			) 
																AND			(OBJECT_ID(''dbo.VIDEO'') IS NOT NULL) 
								BEGIN

																EXEC sys.sp_cdc_enable_table
																		@source_schema					= N''dbo'',
																		@source_name   					= N''VIDEO'',
																		@role_name    					= NULL,
																		@supports_net_changes 			= 1

								END




END

'
, CMDParam			= NULL, 'SP' as CMDType, 'ETLDimAsset' as Name  UNION ALL 


			SELECT		CMD			= '
CREATE PROCEDURE dbo.ETLDimIE 
				@RegionID			INT,
				@SDBSourceID		INT,
				@SDBName			VARCHAR(64),
				@UTCOffset			INT,
				@StartingDate		DATE,
				@EndingDate			DATE
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@StartingDayDateTime										DATETIME = @StartingDate
				DECLARE			@EndingDayDateTime											DATETIME = @EndingDate
				DECLARE			@TimeZoneDateStampStart										DATETIME = DATEADD( HOUR,	@UTCOffset,	@StartingDayDateTime )
				DECLARE			@TimeZoneDateStampEnd										DATETIME = DATEADD( HOUR,	@UTCOffset,	@EndingDayDateTime )

				--				This check is done at the parent stored procedure but also checked here as a precaution.
				--				Make sure the UTC day is over before continuing.
				IF				( @TimeZoneDateStampEnd > GETUTCDATE() )	RETURN


				SELECT
								RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDBName														= @SDBName,
								UTCOffset													= @UTCOffset,
								ZoneName													= IU.ZONE_NAME,
								ChannelName													= IU.CHAN_NAME,
								TSI															= IU.COMPUTER_NAME,
								SCHED_DATE_TIME												= IE.SCHED_DATE_TIME,
								IE_ID														= IE.IE_ID,
								IU_ID														= IE.IU_ID,
								NSTATUS														= IE.NSTATUS,
								NSTATUSValue												= IES.VALUE,
								CONFLICT_STATUS												= IE.CONFLICT_STATUS,
								CONFLICT_STATUSValue										= IECS.VALUE,
								SPOTS														= IE.SPOTS,
								DURATION													= IE.DURATION,
								RUN_DATE_TIME												= IE.RUN_DATE_TIME,

								START_TRIGGER												= IE.START_TRIGGER,
								END_TRIGGER													= IE.END_TRIGGER,
								AWIN_START													= IE.AWIN_START,
								AWIN_END													= IE.AWIN_END,
								VALUE														= IE.VALUE,
								BREAK_INWIN													= IE.BREAK_INWIN,
								AWIN_START_DT												= IE.AWIN_START_DT,
								AWIN_END_DT													= IE.AWIN_END_DT,
								EVENT_ID													= IE.EVENT_ID,
								TS															= IE.TS,

								SOURCE_ID													= IE.SOURCE_ID,
								SOURCE_IDName												= TST.NAME,
								TB_TYPE														= IE.TB_TYPE,
								TB_TYPEName													= TTT.NAME,
								NetworkID													= net.ID,
								NetworkName													= net.NAME,

								UTCIEDatetime												= DATEADD ( HOUR,	@UTCOffset, IE.SCHED_DATE_TIME ),
								UTCIEDate													= CONVERT ( DATE,	(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )), 121 ),
								UTCIEDateYear												= DATEPART( YEAR,	(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )) ),
								UTCIEDateMonth												= DATEPART( MONTH,	(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )) ),
								UTCIEDateDay												= DATEPART( DAY,	(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )) ),
								UTCIEDayOfYearPartitionKey									= DATEPART( DY,		(DATEADD( HOUR, -@UTCOffset, IE.SCHED_DATE_TIME )) )

				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.TB_SOURCE_TEXT TST (NOLOCK)								ON IE.SOURCE_ID = TST.SOURCE_ID
				INNER JOIN		dbo.TB_TYPES_TEXT TTT (NOLOCK)								ON IE.TB_TYPE = TTT.TYPE
				LEFT JOIN		dbo.IU IU (NOLOCK)											ON IE.IU_ID = IU.IU_ID
				LEFT JOIN		dbo.NETWORK_IU_MAP netmap (NOLOCK)							ON IE.IU_ID = netmap.IU_ID
				LEFT JOIN		dbo.NETWORK net (NOLOCK)									ON netmap.NETWORK_ID = net.ID
				LEFT JOIN		dbo.IE_STATUS IES (NOLOCK)									ON IE.NSTATUS = IES.NSTATUS
				LEFT JOIN		dbo.IECONFLICT_STATUS IECS (NOLOCK)							ON IE.CONFLICT_STATUS = IECS.NSTATUS
				WHERE			IE.SCHED_DATE_TIME											>= @TimeZoneDateStampStart
				AND				IE.SCHED_DATE_TIME											< @TimeZoneDateStampEnd


END

'
, CMDParam			= NULL, 'SP' as CMDType, 'ETLDimIE' as Name  UNION ALL 


			SELECT		CMD			= '
CREATE PROCEDURE dbo.ETLDimIU 
				@RegionID			INT,
				@SDBSourceID		INT,
				@SDBName			VARCHAR(64),
				@UTCOffset			INT,
				@StartingDate		DATE,
				@EndingDate			DATE
AS
BEGIN


	SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET				NOCOUNT ON

	DECLARE			@StartingDayDateTime		DATETIME = @StartingDate
	DECLARE			@EndingDayDateTime			DATETIME = @EndingDate
	DECLARE			@TimeZoneDateStampStart		DATETIME = DATEADD( HOUR,	@UTCOffset,	@StartingDayDateTime )
	DECLARE			@TimeZoneDateStampEnd		DATETIME = DATEADD( HOUR,	@UTCOffset,	@EndingDayDateTime )

	--				This check is done at the parent stored procedure but also checked here as a precaution.
	--				Make sure the UTC day is over before continuing.
	IF				( @TimeZoneDateStampEnd > GETUTCDATE() )	RETURN

	SELECT
					RegionID					= @RegionID,
					SDBSourceID					= @SDBSourceID,
					SDBName						= @SDBName,
					UTCOffset					= @UTCOffset,
					IU_ID						= IU.IU_ID,
					ZoneName					= IU.ZONE_NAME,
					Channel						= IU.CHANNEL,
					CHAN_NAME					= IU.CHAN_NAME,
					ChannelName					=	'''',
					DELAY						= IU.DELAY,
					START_TRIGGER				= IU.START_TRIGGER,
					END_TRIGGER					= IU.END_TRIGGER,
					AWIN_START					= IU.AWIN_START,
					AWIN_END					= IU.AWIN_END,
					VALUE						= IU.VALUE,
					MASTER_NAME					= IU.MASTER_NAME,
					COMPUTER_NAME				= IU.COMPUTER_NAME,
					PARENT_ID					= IU.PARENT_ID,
					SYSTEM_TYPE					= IU.SYSTEM_TYPE,
					COMPUTER_PORT				= IU.COMPUTER_PORT,
					MIN_DURATION				= IU.MIN_DURATION,
					MAX_DURATION				= IU.MAX_DURATION,
					START_OF_DAY				= IU.START_OF_DAY,
					RESCHEDULE_WINDOW			= IU.RESCHEDULE_WINDOW,
					IC_CHANNEL					= IU.IC_CHANNEL,
					VSM_SLOT					= IU.VSM_SLOT,
					DECODER_PORT				= IU.DECODER_PORT,
					TC_ID						= IU.TC_ID,
					IGNORE_VIDEO_ERRORS			= IU.IGNORE_VIDEO_ERRORS,
					IGNORE_AUDIO_ERRORS			= IU.IGNORE_AUDIO_ERRORS,
					COLLISION_DETECT_ENABLED	= IU.COLLISION_DETECT_ENABLED,
					TALLY_NORMALLY_HIGH			= IU.TALLY_NORMALLY_HIGH,
					PLAY_OVER_COLLISIONS		= IU.PLAY_OVER_COLLISIONS,
					PLAY_COLLISION_FUDGE		= IU.PLAY_COLLISION_FUDGE,
					TALLY_COLLISION_FUDGE		= IU.TALLY_COLLISION_FUDGE,
					TALLY_ERROR_FUDGE			= IU.TALLY_ERROR_FUDGE,
					LOG_TALLY_ERRORS			= IU.LOG_TALLY_ERRORS,
					TBI_START					= IU.TBI_START,
					TBI_END						= IU.TBI_END,
					CONTINUOUS_PLAY_FUDGE		= IU.CONTINUOUS_PLAY_FUDGE,
					TONE_GROUP					= IU.TONE_GROUP,
					IGNORE_END_TONES			= IU.IGNORE_END_TONES,
					END_TONE_FUDGE				= IU.END_TONE_FUDGE,
					MAX_AVAILS					= IU.MAX_AVAILS,
					RESTART_TRIES				= IU.RESTART_TRIES,
					RESTART_BYTE_SKIP			= IU.RESTART_BYTE_SKIP,
					RESTART_TIME_REMAINING		= IU.RESTART_TIME_REMAINING,
					GENLOCK_FLAG				= IU.GENLOCK_FLAG,
					SKIP_HEADER					= IU.SKIP_HEADER,
					GPO_IGNORE					= IU.GPO_IGNORE,
					GPO_NORMAL					= IU.GPO_NORMAL,
					GPO_TIME					= IU.GPO_TIME,
					DECODER_SHARING				= IU.DECODER_SHARING,
					HIGH_PRIORITY				= IU.HIGH_PRIORITY,
					SPLICER_ID					= IU.SPLICER_ID,
					PORT_ID						= IU.PORT_ID,
					VIDEO_PID					= IU.VIDEO_PID,
					SERVICE_PID					= IU.SERVICE_PID,
					DVB_CARD					= IU.DVB_CARD,
					SPLICE_ADJUST				= IU.SPLICE_ADJUST,
					POST_BLACK					= IU.POST_BLACK,
					SWITCH_CNT					= IU.SWITCH_CNT,
					DECODER_CNT					= IU.DECODER_CNT,
					DVB_CARD_CNT				= IU.DVB_CARD_CNT,
					DVB_PORTS_PER_CARD			= IU.DVB_PORTS_PER_CARD,
					DVB_CHAN_PER_PORT			= IU.DVB_CHAN_PER_PORT,
					USE_ISD						= IU.USE_ISD,
					NO_NETWORK_VIDEO_DETECT		= IU.NO_NETWORK_VIDEO_DETECT,
					NO_NETWORK_PLAY				= IU.NO_NETWORK_PLAY,
					IP_TONE_THRESHOLD			= IU.IP_TONE_THRESHOLD,
					USE_GIGE					= IU.USE_GIGE,
					GIGE_IP						= IU.GIGE_IP,
					IS_ACTIVE_IND				= IU.IS_ACTIVE_IND,

					SYSTEM_TYPEName				= STT.NAME,
					IESCHED_DATE				= x.SCHED_DATE,
					IESCHED_DATE_TIME			= x.MIN_SCHED_DATE_TIME,
					NetworkID					= net.ID,
					NetworkName					= net.NAME,

					UTCIEDatetime				= DATEADD ( HOUR,	@UTCOffset, x.MIN_SCHED_DATE_TIME ),
					UTCIEDate					= CONVERT ( DATE,	(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )), 121 ),
					UTCIEDateYear				= DATEPART( YEAR,	(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )) ),
					UTCIEDateMonth				= DATEPART( MONTH,	(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )) ),
					UTCIEDateDay				= DATEPART( DAY,	(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )) ),
					UTCIEDayOfYearPartitionKey	= DATEPART( DY,		(DATEADD( HOUR, -@UTCOffset, x.MIN_SCHED_DATE_TIME )) )
	FROM			
				(
					SELECT		IU.IU_ID, 
								CONVERT(DATE,IE.SCHED_DATE_TIME,121) AS SCHED_DATE,
								MIN(IE.SCHED_DATE_TIME) AS MIN_SCHED_DATE_TIME
					FROM		dbo.IE IE (NOLOCK)
					JOIN		dbo.IU IU (NOLOCK)			ON IE.IU_ID = IU.IU_ID
					WHERE		IE.SCHED_DATE_TIME			>= @TimeZoneDateStampStart
					AND			IE.SCHED_DATE_TIME			< @TimeZoneDateStampEnd
					GROUP BY	IU.IU_ID, CONVERT(DATE,IE.SCHED_DATE_TIME,121) 
				) x
	JOIN			dbo.IU IU (NOLOCK)						ON x.IU_ID = IU.IU_ID
	LEFT JOIN		dbo.SYSTEM_TYPES_TEXT STT (NOLOCK)		ON IU.SYSTEM_TYPE = STT.TYPE
	LEFT JOIN		dbo.NETWORK_IU_MAP netmap (NOLOCK)		ON IU.IU_ID = netmap.IU_ID
	LEFT JOIN		dbo.NETWORK net (NOLOCK)				ON netmap.NETWORK_ID = net.ID

END

'
, CMDParam			= NULL, 'SP' as CMDType, 'ETLDimIU' as Name  UNION ALL 




			SELECT		CMD			= '
CREATE PROCEDURE dbo.ETLDimSpot 
				@RegionID			INT,
				@SDBSourceID		INT,
				@SDBName			VARCHAR(64),
				@UTCOffset			INT,
				@StartingDate		DATE,
				@EndingDate			DATE
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@StartingDayDateTime										DATETIME = @StartingDate
				DECLARE			@EndingDayDateTime											DATETIME = @EndingDate
				DECLARE			@TimeZoneDateStampStart										DATETIME = DATEADD( HOUR,	@UTCOffset,	@StartingDayDateTime )
				DECLARE			@TimeZoneDateStampEnd										DATETIME = DATEADD( HOUR,	@UTCOffset,	@EndingDayDateTime )

				--				This check is done at the parent stored procedure but also checked here as a precaution.
				--				Make sure the UTC day is over before continuing.
				IF				( @TimeZoneDateStampEnd > GETUTCDATE() )	RETURN

				SELECT
								RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDBName														= @SDBName,
								UTCOffset													= @UTCOffset,
								ZoneName													= IU.ZONE_NAME,
								Spot_ID														= SPOT.SPOT_ID,
								VIDEO_ID													= SPOT.VIDEO_ID,
								DURATION													= SPOT.DURATION,
								CUSTOMER													= SPOT.CUSTOMER,
								TITLE														= SPOT.TITLE,
								NSTATUS														= SPOT.NSTATUS,
								CONFLICT_STATUS												= SPOT.CONFLICT_STATUS,
								RATE														= SPOT.RATE,
								CODE														= SPOT.CODE,
								NOTES														= SPOT.NOTES,
								SERIAL														= SPOT.SERIAL,
								IDSpot														= SPOT.ID,
								IE_ID														= SPOT.IE_ID,
								Spot_ORDER													= SPOT.SPOT_ORDER,
								RUN_DATE_TIME												= SPOT.RUN_DATE_TIME,
								RUN_LENGTH													= SPOT.RUN_LENGTH,
								VALUE														= SPOT.VALUE,
								ORDER_ID													= SPOT.ORDER_ID,
								BONUS_FLAG													= SPOT.BONUS_FLAG,
								SOURCE_ID													= SPOT.SOURCE_ID,
								TS															= SPOT.TS,

								NSTATUSValue												= SS.VALUE,
								CONFLICT_STATUSValue										= SCS.VALUE,
								SOURCE_ID_INTERCONNECT_NAME									= ICS.INTERCONNECT_NAME,
								IESCHED_DATE												= CONVERT(DATE,IE.SCHED_DATE_TIME,121),
								IESCHED_DATE_TIME											= IE.SCHED_DATE_TIME,
								IU_ID														= IU.IU_ID,
								NetworkID													= net.ID,
								NetworkName													= net.NAME,
								
								UTCSPOTDatetime												= DATEADD ( HOUR,	@UTCOffset, SPOT.RUN_DATE_TIME ),
								UTCSPOTDate													= CONVERT ( DATE,	(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )), 121 ),
								UTCSPOTDateYear												= DATEPART( YEAR,	(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )) ),
								UTCSPOTDateMonth											= DATEPART( MONTH,	(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )) ),
								UTCSPOTDateDay												= DATEPART( DAY,	(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )) ),
								UTCSPOTDayOfYearPartitionKey								= DATEPART( DY,		(DATEADD( HOUR, -@UTCOffset, SPOT.RUN_DATE_TIME )) )

				FROM			dbo.SPOT SPOT WITH (NOLOCK)
				JOIN			dbo.IE IE WITH (NOLOCK)										ON SPOT.IE_ID = IE.IE_ID
				LEFT JOIN		dbo.IU IU WITH (NOLOCK)										ON IE.IU_ID = IU.IU_ID
				LEFT JOIN		dbo.INTERCONNECT_SOURCE ICS WITH (NOLOCK)					ON SPOT.SOURCE_ID = ICS.SOURCE_ID
				LEFT JOIN		dbo.SPOT_STATUS SS WITH (NOLOCK)							ON SPOT.NSTATUS = SS.NSTATUS
				LEFT JOIN		dbo.SPOTCONFLICT_STATUS SCS WITH (NOLOCK)					ON SPOT.CONFLICT_STATUS = SCS.NSTATUS
				LEFT JOIN		dbo.NETWORK_IU_MAP netmap WITH (NOLOCK)						ON IU.IU_ID = netmap.IU_ID
				LEFT JOIN		dbo.NETWORK net WITH (NOLOCK)								ON netmap.NETWORK_ID = net.ID
				WHERE			IE.SCHED_DATE_TIME											>= @TimeZoneDateStampStart
				AND				IE.SCHED_DATE_TIME											< @TimeZoneDateStampEnd



END
'
, CMDParam			= NULL, 'SP' as CMDType, 'ETLDimSpot' as Name  UNION ALL 


			SELECT		CMD			= '
CREATE PROCEDURE dbo.ETLDimTB_REQUEST 
				@RegionID			INT,
				@SDBSourceID		INT,
				@SDBName			VARCHAR(64),
				@UTCOffset			INT,
				@StartingDate		DATE,
				@EndingDate			DATE
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@StartingDayDateTime										DATETIME = @StartingDate
				DECLARE			@EndingDayDateTime											DATETIME = @EndingDate
				DECLARE			@TimeZoneDateStampStart										DATETIME = DATEADD( HOUR,	@UTCOffset,	@StartingDayDateTime )
				DECLARE			@TimeZoneDateStampEnd										DATETIME = DATEADD( HOUR,	@UTCOffset,	@EndingDayDateTime )

				--				This check is done at the parent stored procedure but also checked here as a precaution.
				--				Make sure the UTC day is over before continuing.
				IF				( @TimeZoneDateStampEnd > GETUTCDATE() )	RETURN


				SELECT
								RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDBName														= @SDBName,
								UTCOffset													= @UTCOffset,
								TB_ID														= tb.TB_ID,
								ZONE_ID														= tb.ZONE_ID,
								IU_ID														= tb.IU_ID,
								TB_REQUEST													= tb.TB_REQUEST,
								TB_MODE														= tb.TB_MODE,
								TB_TYPE														= tb.TB_TYPE,
								TB_DAYPART													= tb.TB_DAYPART,
								TB_FILE														= tb.TB_FILE,
								TB_FILE_DATE												= tb.TB_FILE_DATE,
								STATUS														= tb.STATUS,
								EXPLANATION													= tb.EXPLANATION,
								TB_MACHINE													= tb.TB_MACHINE,
								TB_MACHINE_TS												= tb.TB_MACHINE_TS,
								TB_MACHINE_THREAD											= tb.TB_MACHINE_THREAD,
								REQUESTING_MACHINE											= tb.REQUESTING_MACHINE,
								REQUESTING_PORT												= tb.REQUESTING_PORT,
								SOURCE_ID													= tb.SOURCE_ID,
								MSGNR														= tb.MSGNR,
								TS															= tb.TS,

								ZoneName													= z.ZONE_NAME,
								TB_MODE_NAME												= tmt.NAME,
								REQUEST_NAME												= trt.NAME,
								SOURCE_ID_NAME												= tst1.NAME,
								STATUS_NAME													= tst2.NAME,
								TYPE_NAME													= ttt.NAME,
								DAYPART_DATE												= CONVERT( DATE,tb.TB_DAYPART,121 ),
								DAYPART_DATE_TIME											= tb.TB_DAYPART,
								NetworkID													= net.ID,
								NetworkName													= net.NAME,

								UTCIEDatetime												= DATEADD ( HOUR,	@UTCOffset, tb.TB_DAYPART ),
								UTCIEDate													= CONVERT ( DATE,	(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )), 121 ),
								UTCIEDateYear												= DATEPART( YEAR,	(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )) ),
								UTCIEDateMonth												= DATEPART( MONTH,	(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )) ),
								UTCIEDateDay												= DATEPART( DAY,	(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )) ),
								UTCIEDayOfYearPartitionKey									= DATEPART( DY,		(DATEADD( HOUR, -@UTCOffset, tb.TB_DAYPART )) )

				FROM			dbo.TB_REQUEST tb WITH (NOLOCK)
				JOIN			dbo.ZONE z WITH (NOLOCK)									ON tb.ZONE_ID = z.ZONE_ID
				JOIN			dbo.TB_MODE_TEXT tmt WITH (NOLOCK)							ON tb.TB_MODE = tmt.MODE
				JOIN			dbo.TB_REQUEST_TEXT trt WITH (NOLOCK)						ON tb.TB_REQUEST = trt.REQUEST
				JOIN			dbo.TB_SOURCE_TEXT tst1 WITH (NOLOCK)						ON tb.SOURCE_ID = tst1.SOURCE_ID
				JOIN			dbo.TB_STATUS_TEXT tst2 WITH (NOLOCK)						ON tb.STATUS = tst2.STATUS
				LEFT JOIN		dbo.TB_TYPES_TEXT ttt WITH (NOLOCK)							ON tb.TB_TYPE = ttt.TYPE
				LEFT JOIN		dbo.NETWORK_IU_MAP netmap (NOLOCK)							ON tb.IU_ID = netmap.IU_ID
				LEFT JOIN		dbo.NETWORK net (NOLOCK)									ON netmap.NETWORK_ID = net.ID
				WHERE			tb.TB_DAYPART												>= @TimeZoneDateStampStart
				AND				tb.TB_DAYPART												< @TimeZoneDateStampEnd


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'ETLDimTB_REQUEST' as Name  




) x
LEFT JOIN dbo.MPEGArticle y
ON x.Name = y.Name
AND x.CMDType = y.CMDType
WHERE y.Name IS NULL





--truncate table dbo.MPEGArticle
INSERT dbo.MPEGArticle
	(
		CMD ,
		CMDType,
		CMDParam,
		Name,
		CreateDate,
		UpdateDate
	)

SELECT 
		CMD = x.CMD,
		CMDType = x.CMDType,
		CMDParam = x.CMDParam,
		Name = x.Name,
		CreateDate = GETUTCDATE(),
		UpdateDate = GETUTCDATE()
FROM (


			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_1_SpotReport] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ChannelName				VARCHAR(100)	= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,		--Regional Interconnect OR Local
				@ROCID						INT				= NULL,
				@IEStatusID					INT				= NULL,
				@IEConflictStatusID			INT				= NULL,
				@SPOTStatusID				INT				= NULL,
				@SPOTConflictStatusID		INT				= NULL,
				@StartDateTime				DATETIME,
				@EndDateTime				DATETIME

AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@StartDateTime												= CASE  WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@StartDateTime ) ELSE @StartDateTime END,
								@EndDateTime												= CASE  WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@StartDateTime ) ELSE @StartDateTime END


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								DBSource													= ''MPEG'',
								VideoID	 													= s.VIDEO_ID,
								CHANNEL														= IU.CHAN_NAME, 
								ZONE	 													= IU.ZONE_NAME,
								NETWORK														= NET.NAME,
								Position													= s.SPOT_ORDER,
								BreakStatus 												= IES.VALUE,
								BreakConflictStatus											= ICS.VALUE,
								SpotStatus 													= SS.VALUE,
								SpotConflictStatus											= SC.VALUE,
								SCHED_DATE_TIME												= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,-@UTCOffset,ie.SCHED_DATE_TIME )
																									ELSE ie.SCHED_DATE_TIME
																								END
				FROM			dbo.IE ie (NOLOCK)
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK)									ON ie.NSTATUS = IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK)							ON ie.CONFLICT_STATUS = ICS.NSTATUS
				INNER JOIN		dbo.SPOT s (NOLOCK)											ON ie.IE_ID = s.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK)							ON s.CONFLICT_STATUS = SC.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)									ON s.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.IU (NOLOCK)												ON ie.IU_ID = IU.IU_ID
				INNER JOIN		dbo.NETWORK_IU_MAP NETMAP (NOLOCK)							ON IU.IU_ID = NETMAP.IU_ID
				INNER JOIN		dbo.NETWORK NET (NOLOCK)									ON NETMAP.NETWORK_ID = NET.ID
				WHERE			ie.SCHED_DATE_TIME											BETWEEN @StartDateTime AND @EndDateTime
				AND				IU.ZONE_NAME												= ISNULL(@ZoneName, IU.ZONE_NAME)
				AND				NET.NAME 													= ISNULL(@NetworkName, NET.NAME)
				AND				IU.CHAN_NAME 												= ISNULL(@ChannelName, IU.CHAN_NAME)
				AND				ie.NSTATUS													= ISNULL( @IEStatusID,ie.NSTATUS )
				AND				ie.CONFLICT_STATUS											= ISNULL( @IEConflictStatusID,ie.CONFLICT_STATUS )
				AND				s.NSTATUS													= ISNULL( @SpotStatusID,s.NSTATUS )
				AND				s.CONFLICT_STATUS											= ISNULL( @SpotConflictStatusID,s.CONFLICT_STATUS )


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_1_SpotReport' as Name  UNION ALL 


			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_10_MissingMedia] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ChannelName				VARCHAR(50)		= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@SpotStatusID				INT				= NULL,
				@SpotConflictStatusID		INT				= NULL,
				@StartDateTime				DATETIME,
				@EndDateTime				DATETIME
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@StartDateTime								=	CASE WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@StartDateTime ) ELSE @StartDateTime END,
								@EndDateTime								=	CASE WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@EndDateTime ) ELSE @EndDateTime END

				IF				( OBJECT_ID(''dbo.SPOT'') IS NOT NULL AND OBJECT_ID(''dbo.IE'') IS NOT NULL AND OBJECT_ID(''dbo.IU'') IS NOT NULL )	--Make sure the tables exist
				SELECT			
								RegionID									= @RegionID,
								SDBSourceID									= @SDBSourceID,
								SDB											= @SDBName,
								DBSource									= ''MPEG'',
								ZoneName									= iu.ZONE_NAME,
								NetworkName									= iu.CHAN_NAME,
								Channel										= iu.CHANNEL,
								Position									= s.SPOT_ORDER,
								AssetID										= s.VIDEO_ID,
								SpotStatus									= ss.VALUE,
								SpotConflictStatus							= scs.VALUE,
								ScheduledDateTime							= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,ie.SCHED_DATE_TIME ) 
																					ELSE ie.SCHED_DATE_TIME
																				END
				FROM			dbo.SPOT s WITH (NOLOCK)
				JOIN			dbo.IE ie WITH (NOLOCK)						ON s.IE_ID = ie.IE_ID
				JOIN			dbo.IU iu WITH (NOLOCK)						ON ie.IU_ID = iu.IU_ID
				JOIN			dbo.SPOT_STATUS ss WITH (NOLOCK)			ON s.NSTATUS = ss.NSTATUS
				JOIN			dbo.SPOTCONFLICT_STATUS scs WITH (NOLOCK)	ON s.CONFLICT_STATUS = scs.NSTATUS
				WHERE			ie.SCHED_DATE_TIME							BETWEEN @StartDateTime AND @EndDateTime
				AND				iu.ZONE_NAME								= ISNULL(@ZoneName,iu.ZONE_NAME)
				AND				iu.CHAN_NAME								= ISNULL(@NetworkName,iu.CHAN_NAME)
				AND				s.NSTATUS									= ISNULL(@SpotStatusID,s.NSTATUS)
				AND				s.CONFLICT_STATUS							= ISNULL(@SpotConflictStatusID,s.CONFLICT_STATUS)

				
END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_10_MissingMedia' as Name  UNION ALL 




			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_3_FutureReadiness] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ChannelName				VARCHAR(50)		= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,		--Regional Interconnect OR Local
				@ROCID						INT				= NULL,
				@StartDateTime				DATETIME,
				@EndDateTime				DATETIME
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@UseUTC														= ISNULL(@UseUTC,1)

				IF				( @UseUTC = 1 )
								SELECT		@StartDateTime									= DATEADD( HOUR,@UTCOffset,@StartDateTime ),
											@EndDateTime									= DATEADD( HOUR,@UTCOffset,@EndDateTime )


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								DBSource													= ''MPEG'',
								CHANNEL														= IU.CHAN_NAME, 
								ZoneName	 												= IU.ZONE_NAME,
								NetworkName													= NET.NAME,
								IU_ID														= IE.IU_ID,
								IE_ID														= IE.IE_ID,
								IESourceID													= IE.SOURCE_ID,
								IEStatus 													= IE.NSTATUS,
								IEConflictStatus											= IE.CONFLICT_STATUS,
								SpotStatus 													= SPOT.NSTATUS,
								SpotConflictStatus											= SPOT.CONFLICT_STATUS,
								LastScheduleLoad											= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,-@UTCOffset,TB.TB_FILE_DATE )
																									ELSE TB.TB_FILE_DATE
																								END,
								SCHED_DATE													= CASE	WHEN @UseUTC = 1 THEN CONVERT( DATE,DATEADD(HOUR,-@UTCOffset,IE.SCHED_DATE_TIME),101 )
																									ELSE CONVERT( DATE,IE.SCHED_DATE_TIME,101 )
																								END,
								SCHED_DATE_TIME												= CASE	WHEN @UseUTC = 1 THEN DATEADD(HOUR,-@UTCOffset,IE.SCHED_DATE_TIME)
																									ELSE IE.SCHED_DATE_TIME
																								END,
								ICScheduleLoaded											= NULL,
								ICScheduleBreakCount										= 0,
								ICMissingMedia												= 0,
								ICMediaPrefixErrors											= 0,
								ICMediaDurationErrors										= 0,
								ICMediaFormatErrors											= 0,
								ATTScheduleLoaded											= NULL,
								ATTScheduleBreakCount										= 0,
								ATTMissingMedia												= 0,
								ATTMediaPrefixErrors										= 0,
								ATTMediaDurationErrors										= 0,
								ATTMediaFormatErrors										= 0

				FROM			dbo.IE (NOLOCK)
				INNER JOIN		dbo.SPOT (NOLOCK)											ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.IU (NOLOCK)												ON IE.IU_ID = IU.IU_ID
				INNER JOIN		
							(
								SELECT		IU_ID, SOURCE_ID, MAX(TB_FILE_DATE) TB_FILE_DATE
								FROM		dbo.TB_REQUEST WITH (NOLOCK)	
								GROUP BY	IU_ID, SOURCE_ID
							)	TB															ON IU.IU_ID = TB.IU_ID
																							AND IE.SOURCE_ID = TB.SOURCE_ID
				INNER JOIN		dbo.NETWORK_IU_MAP NETMAP (NOLOCK)							ON IU.IU_ID = NETMAP.IU_ID
				INNER JOIN		dbo.NETWORK NET (NOLOCK)									ON NETMAP.NETWORK_ID = NET.ID
				WHERE			IE.SCHED_DATE_TIME											BETWEEN @StartDateTime AND @EndDateTime
				AND				IU.ZONE_NAME												= ISNULL(@ZoneName, IU.ZONE_NAME)
				AND				NET.NAME 													= ISNULL(@Networkname, NET.NAME)
				AND				IU.CHAN_NAME 												= ISNULL(@ChannelName, IU.CHAN_NAME)


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_3_FutureReadiness' as Name  UNION ALL 



			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_4_AssetInfoDuration] 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@MinDuration				INT				= NULL,
				@MaxDuration				INT				= NULL,
				@StartDate					DATETIME		= NULL,
				@EndDate					DATETIME		= NULL
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@StartDate								=	CASE	
																				WHEN @UseUTC = 1 AND @StartDate IS NOT NULL THEN  DATEADD( HOUR,@UTCOffset,@StartDate )
																				WHEN @UseUTC = 1 AND @StartDate IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @StartDate,GETUTCDATE() )
																			END,
								@EndDate								=	CASE
																				WHEN @UseUTC = 1 AND @EndDate IS NOT NULL THEN  DATEADD( HOUR,@UTCOffset,@EndDate )
																				WHEN @UseUTC = 1 AND @EndDate IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @EndDate,DATEADD(HOUR,1,GETUTCDATE()) )
																			END


				IF				( OBJECT_ID(''dbo.SPOT'') IS NOT NULL AND OBJECT_ID(''dbo.VIDEO'') IS NOT NULL )	--Make sure the tables exist
				SELECT			
								RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								DBSource								= ''MPEG'',
								SpotID									= s.SPOT_ID,
								AssetID									= s.VIDEO_ID,
								Duration  								= CASE WHEN ISNULL(v.FPS,0) <> 0 THEN v.FRAMES/v.FPS ELSE 1 END,
								Ingested								= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,s.RUN_DATE_TIME ) 
																				ELSE s.RUN_DATE_TIME
																			END

				FROM			dbo.SPOT s WITH (NOLOCK)
				JOIN			dbo.VIDEO v WITH (NOLOCK)
				ON				s.VIDEO_ID								= v.VIDEO_ID
				WHERE			s.RUN_DATE_TIME							BETWEEN @StartDate AND @EndDate
				--AND				s.RUN_LENGTH							BETWEEN ISNULL( @MinDuration,s.RUN_LENGTH ) AND ISNULL( @MaxDuration,s.RUN_LENGTH )
				AND				s.VIDEO_ID								IS NOT NULL

				
END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_4_AssetInfoDuration' as Name  UNION ALL 



			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_4_AssetInfoICROC] 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@StartDate					DATETIME		= NULL,
				@EndDate					DATETIME		= NULL
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@StartDate								=	CASE	
																				WHEN @UseUTC = 1 AND @StartDate IS NOT NULL THEN  DATEADD( HOUR,@UTCOffset,@StartDate )
																				WHEN @UseUTC = 1 AND @StartDate IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @StartDate,GETUTCDATE() )
																			END,
								@EndDate								=	CASE
																				WHEN @UseUTC = 1 AND @EndDate IS NOT NULL THEN  DATEADD( HOUR,@UTCOffset,@EndDate )
																				WHEN @UseUTC = 1 AND @EndDate IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @EndDate,DATEADD(HOUR,1,GETUTCDATE()) )
																			END


				IF				( OBJECT_ID(''dbo.SPOT'') IS NOT NULL )	--Make sure the tables exist
				SELECT			
								RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								DBSource								= ''MPEG'',
								SpotID									= s.SPOT_ID,
								AssetID									= s.VIDEO_ID,
								Ingested								= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,s.RUN_DATE_TIME ) 
																				ELSE s.RUN_DATE_TIME
																			END

				FROM			dbo.SPOT s (NOLOCK)
				WHERE			s.RUN_DATE_TIME							BETWEEN @StartDate AND @EndDate
				AND				s.VIDEO_ID								IS NOT NULL

				
END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_4_AssetInfoICROC' as Name  UNION ALL 



			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_4_AssetSummaryDetails] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@AssetID					VARCHAR(50)		= NULL,
				@MinDuration				INT				= NULL,
				@MaxDuration				INT				= NULL,
				@StartDateTime				DATETIME		= NULL,
				@EndDateTime				DATETIME		= NULL
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@StartDateTime								=	CASE	
																				WHEN @UseUTC = 1 AND @StartDateTime IS NOT NULL THEN  DATEADD( HOUR,@UTCOffset,@StartDateTime )
																				WHEN @UseUTC = 1 AND @StartDateTime IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @StartDateTime,GETUTCDATE() )
																			END,
								@EndDateTime								=	CASE
																				WHEN @UseUTC = 1 AND @EndDateTime IS NOT NULL THEN  DATEADD( HOUR,@UTCOffset,@EndDateTime )
																				WHEN @UseUTC = 1 AND @EndDateTime IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @EndDateTime,DATEADD(HOUR,1,GETUTCDATE()) )
																			END


				IF				( OBJECT_ID(''dbo.SPOT'') IS NOT NULL AND OBJECT_ID(''dbo.IE'') IS NOT NULL AND OBJECT_ID(''dbo.IU'') IS NOT NULL AND OBJECT_ID(''dbo.VIDEO'') IS NOT NULL )	--Make sure the tables exist
				SELECT			
								RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								DBSource								= ''MPEG'',
								ZoneName								= iu.ZONE_NAME,
								AssetID									= s.VIDEO_ID,
								Duration  								= CASE WHEN ISNULL(v.FPS,0) <> 0 THEN v.FRAMES/v.FPS ELSE 1 END,
								Ingested								= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,s.RUN_DATE_TIME ) 
																				ELSE s.RUN_DATE_TIME
																			END

				FROM			dbo.SPOT s (NOLOCK)
				JOIN			dbo.VIDEO v WITH (NOLOCK)				ON s.VIDEO_ID = v.VIDEO_ID
				JOIN			dbo.IE ie WITH (NOLOCK)					ON s.IE_ID = ie.IE_ID
				JOIN			dbo.IU iu  WITH (NOLOCK)				ON ie.IU_ID = iu.IU_ID
				WHERE			s.RUN_DATE_TIME							BETWEEN @StartDateTime AND @EndDateTime
				AND				s.VIDEO_ID								IS NOT NULL
				AND				v.VIDEO_ID								BETWEEN ISNULL( @AssetID,v.VIDEO_ID ) AND ISNULL( @AssetID,v.VIDEO_ID )
				--AND				s.RUN_LENGTH							BETWEEN ISNULL( @MinDuration,s.RUN_LENGTH ) AND ISNULL( @MaxDuration,s.RUN_LENGTH )

				
END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_4_AssetSummaryDetails' as Name  UNION ALL 




			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_4_AssetSummaryDuration] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@MinDuration				INT				= NULL,
				@MaxDuration				INT				= NULL,
				@StartDateTime				DATETIME		= NULL,
				@EndDateTime				DATETIME		= NULL
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@StartDateTime								=	CASE	
																				WHEN @UseUTC = 1 AND @StartDateTime IS NOT NULL THEN  DATEADD( HOUR,@UTCOffset,@StartDateTime )
																				WHEN @UseUTC = 1 AND @StartDateTime IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @StartDateTime,GETUTCDATE() )
																			END,
								@EndDateTime								=	CASE
																				WHEN @UseUTC = 1 AND @EndDateTime IS NOT NULL THEN  DATEADD( HOUR,@UTCOffset,@EndDateTime )
																				WHEN @UseUTC = 1 AND @EndDateTime IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @EndDateTime,DATEADD(HOUR,1,GETUTCDATE()) )
																			END


				IF				( OBJECT_ID(''dbo.SPOT'') IS NOT NULL AND OBJECT_ID(''dbo.VIDEO'') IS NOT NULL )	--Make sure the tables exist
				SELECT			
								RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								DBSource								= ''MPEG'',
								AssetID									= s.VIDEO_ID,
								Duration  								= CASE WHEN ISNULL(v.FPS,0) <> 0 THEN v.FRAMES/v.FPS ELSE 1 END
				FROM			dbo.SPOT s WITH (NOLOCK)
				JOIN			dbo.VIDEO v WITH (NOLOCK)
				ON				s.VIDEO_ID								= v.VIDEO_ID
				WHERE			s.RUN_DATE_TIME							BETWEEN @StartDateTime AND @EndDateTime
				AND				s.VIDEO_ID								IS NOT NULL
				--AND				s.RUN_LENGTH							BETWEEN ISNULL( @MinDuration,s.RUN_LENGTH ) AND ISNULL( @MaxDuration,s.RUN_LENGTH )

				
END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_4_AssetSummaryDuration' as Name  UNION ALL 



			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_4_AssetSummaryICROC] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@StartDateTime				DATETIME		= NULL,
				@EndDateTime				DATETIME		= NULL
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@StartDateTime								=	CASE WHEN @UseUTC = 1 THEN  DATEADD( HOUR,@UTCOffset,@StartDateTime ) ELSE @StartDateTime END,
								@EndDateTime								=	CASE WHEN @UseUTC = 1 THEN  DATEADD( HOUR,@UTCOffset,@EndDateTime ) ELSE @EndDateTime END


				IF				( OBJECT_ID(''dbo.SPOT'') IS NOT NULL AND OBJECT_ID(''dbo.IE'') IS NOT NULL AND OBJECT_ID(''dbo.IU'') IS NOT NULL )	--Make sure the tables exist
				SELECT			
								RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								DBSource								= ''MPEG'',
								ZoneName								= iu.ZONE_NAME,
								AssetID									= s.VIDEO_ID
				FROM			dbo.SPOT s (NOLOCK)
				JOIN			dbo.IE ie WITH (NOLOCK)					ON s.IE_ID = ie.IE_ID
				JOIN			dbo.IU iu  WITH (NOLOCK)				ON ie.IU_ID = iu.IU_ID
				WHERE			s.RUN_DATE_TIME							BETWEEN ISNULL( @StartDateTime,s.RUN_DATE_TIME ) AND ISNULL( @EndDateTime,s.RUN_DATE_TIME )
				AND				s.VIDEO_ID								IS NOT NULL

				
END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_4_AssetSummaryICROC' as Name  UNION ALL 



			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_4_VideoInfoReport] 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@MinLength					INT				= NULL,
				@MaxLength					INT				= NULL,
				@StartDate					DATETIME		= NULL,
				@EndDate					DATETIME		= NULL
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SELECT			@StartDate								=	CASE	
																				WHEN @UseUTC = 1 AND @StartDate IS NOT NULL THEN  DATEADD( DAY,@UTCOffset,@StartDate )
																				WHEN @UseUTC = 1 AND @StartDate IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @StartDate,GETUTCDATE() )
																			END,
								@EndDate								=	CASE
																				WHEN @UseUTC = 1 AND @EndDate IS NOT NULL THEN  DATEADD( DAY,@UTCOffset,@EndDate )
																				WHEN @UseUTC = 1 AND @EndDate IS NULL THEN  GETUTCDATE()
																				ELSE ISNULL( @EndDate,DATEADD(HOUR,1,GETUTCDATE()) )
																			END


				IF				( OBJECT_ID(''dbo.SPOT'') IS NOT NULL AND OBJECT_ID(''dbo.INTERCONNECT_SOURCE'') IS NOT NULL )	--Make sure the tables exist
				SELECT			
								RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								DBSource								= ''MPEG'',
								SPOT_ID									= s.SPOT_ID,
								IE_ID									= s.IE_ID,
								VIDEO_ID								= s.VIDEO_ID,
								SOURCE_ID 								= s.SOURCE_ID,
								INTERCONNECT_NAME						= i.INTERCONNECT_NAME,
								RUN_DATE_TIME 							= s.RUN_DATE_TIME,
								RUN_LENGTH  							= s.RUN_LENGTH			--v.FRAMES / v.FPS FLength
				FROM			dbo.SPOT s (NOLOCK)
				JOIN			dbo.INTERCONNECT_SOURCE i (NOLOCK)
				ON				s.SOURCE_ID								= i.SOURCE_ID
				WHERE			s.RUN_DATE_TIME							>= @StartDate
				AND				s.RUN_DATE_TIME							< @EndDate
				AND				s.IE_ID									IS NOT NULL
				AND				s.RUN_LENGTH							BETWEEN ISNULL(@MinLength,s.RUN_LENGTH) AND	ISNULL(@MaxLength,s.RUN_LENGTH)


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_4_VideoInfoReport' as Name  UNION ALL 




			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_5_RunRate] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@ChannelName				VARCHAR(100)	= NULL,
				@ScheduleDate				DATE
AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				DECLARE			@ScheduleDateTime											DATETIME = @ScheduleDate
				DECLARE			@StartDateTime												DATETIME
				DECLARE			@EndDateTime												DATETIME 

				SELECT			@StartDateTime												= CASE  WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@ScheduleDateTime ) ELSE @ScheduleDateTime END,
								@EndDateTime												= DATEADD( DAY,1,@StartDateTime )
				SELECT			@EndDateTime												= DATEADD( SECOND,-1,@EndDateTime )



				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								DBSource													= ''MPEG'',
								NetworkName													= iu.CHAN_NAME,
								ZoneName	 												= iu.ZONE_NAME,
								Channel 													= NULL,
								TotalSpots													= 0.0, --f1.DTM_OTHERTotal			+ f1.DTM_ICTotal		+ f1.DTM_ATTTotal,
								TotalSpotsPlayed											= 0.0, --f1.DTM_OTHERPlayed		+ f1.DTM_ICPlayed		+ f1.DTM_ATTPlayed,
								TotalSpotsFailed											= 0.0, --f1.DTM_OTHERFailed		+ f1.DTM_ICFailed		+ f1.DTM_ATTFailed,
								TotalSpotsNoTone											= 0.0, --f1.DTM_OTHERNoTone		+ f1.DTM_ICNoTone		+ f1.DTM_ATTNoTone,
								TotalSpotsError												= 0.0, --f1.DTM_OTHERMpegError		+ f1.DTM_ICMpegError	+ f1.DTM_ATTMpegError,
								TotalSpotsMissing											= 0.0, --f1.DTM_OTHERMissingCopy	+ f1.DTM_ICMissingCopy	+ f1.DTM_ATTMissingCopy,
								TotalICSpots												= 0.0, --f1.DTM_ICTotal,
								TotalICSpotsPlayed											= 0.0, --f1.DTM_ICPlayed,
								TotalICSpotsFailed											= 0.0, --f1.DTM_ICFailed,
								TotalICSpotsNoTone											= 0.0, --f1.DTM_ICNoTone,
								TotalICSpotsError											= 0.0, --f1.DTM_ICMpegError,
								TotalICSpotsMissing											= 0.0, --f1.DTM_ICMissingCopy,
								TotalATTSpots												= 0.0, --f1.DTM_ATTTotal,
								TotalATTSpotsPlayed											= 0.0, --f1.DTM_ATTPlayed,
								TotalATTSpotsFailed											= 0.0, --f1.DTM_ATTFailed,
								TotalATTSpotsNoTone											= 0.0, --f1.DTM_ATTNoTone,
								TotalATTSpotsError											= 0.0, --f1.DTM_ATTMpegError,
								TotalATTSpotsMissing										= 0.0 --f1.DTM_ATTMissingCopy
				FROM			dbo.SPOT s (NOLOCK)
				INNER JOIN		dbo.IE ie (NOLOCK)											ON s.IE_ID = ie.IE_ID
				INNER JOIN		dbo.IU iu (NOLOCK)											ON ie.IU_ID = iu.IU_ID
				WHERE			ie.SCHED_DATE_TIME											BETWEEN @StartDateTime AND @EndDateTime
				AND				iu.CHAN_NAME												= ISNULL(@NetworkName,iu.CHAN_NAME)
				AND				iu.ZONE_NAME												= ISNULL(@ZoneName,iu.ZONE_NAME)



END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_5_RunRate' as Name  UNION ALL 



			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_7_VideoDurationMismatch] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@ChannelName				VARCHAR(100)	= NULL,
				@ScheduleDate				DATE			= NULL,
				@AssetID					VARCHAR(50)		= NULL

AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				DECLARE			@ScheduleDateTime				DATETIME = @ScheduleDate
				DECLARE			@StartDateTime					DATETIME
				DECLARE			@EndDateTime					DATETIME 


				SELECT			@StartDateTime					= CASE  WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@ScheduleDateTime ) ELSE @ScheduleDateTime END,
								@EndDateTime					= DATEADD( DAY,1,@StartDateTime )
				SELECT			@EndDateTime					= DATEADD( SECOND,-1,@EndDateTime )


				SELECT			RegionID						= @RegionID,
								SDBSourceID						= @SDBSourceID,
								SDB								= @SDBName,
								DBSource						= ''MPEG'',
								ZoneName	 					= iu.ZONE_NAME,
								NetworkName						= iu.CHAN_NAME,
								Channel							= iu.CHANNEL,
								ScheduleDate					= @ScheduleDate,
								AssetID							= s.VIDEO_ID,
								Duration						= v.FRAMES * v.FPS
				FROM			dbo.IE  ie (NOLOCK)
				INNER JOIN		dbo.SPOT s (NOLOCK)				ON ie.IE_ID = s.IE_ID
				INNER JOIN		dbo.VIDEO v (NOLOCK)			ON s.VIDEO_ID = s.VIDEO_ID
				INNER JOIN		dbo.IU iu (NOLOCK)				ON ie.IU_ID = iu.IU_ID
				WHERE			ie.SCHED_DATE_TIME				BETWEEN @StartDateTime AND @EndDateTime
				AND				iu.ZONE_NAME					= ISNULL(@ZoneName,iu.ZONE_NAME)
				AND				iu.CHAN_NAME					= ISNULL(@NetworkName,iu.CHAN_NAME)



END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_7_VideoDurationMismatch' as Name  UNION ALL 




			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_7_VideoFormatMismatch] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@ChannelName				VARCHAR(50)		= NULL,
				@AssetID					VARCHAR(50)		= NULL,
				@ScheduleDate				DATE			= NULL

AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				DECLARE			@ScheduleDateTime				DATETIME = @ScheduleDate
				DECLARE			@StartDateTime					DATETIME
				DECLARE			@EndDateTime					DATETIME 

				SELECT			@UseUTC							= ISNULL(@UseUTC,1)

				SELECT			@StartDateTime					= CASE  WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@ScheduleDateTime ) ELSE @ScheduleDateTime END,
								@EndDateTime					= DATEADD( DAY,1,@StartDateTime )
				SELECT			@EndDateTime					= DATEADD( SECOND,-1,@EndDateTime )


				SELECT			RegionID						= @RegionID,
								SDBSourceID						= @SDBSourceID,
								SDB								= @SDBName,
								DBSource						= ''MPEG'',
								ZoneName	 					= iu.ZONE_NAME,
								NetworkName						= iu.CHAN_NAME,
								Channel							= iu.CHANNEL,
								ScheduleDate					= @ScheduleDate,
								AssetID							= s.VIDEO_ID,
								VideoFormat						= ''VideoFormat''

				FROM			dbo.IE  ie (NOLOCK)
				JOIN			dbo.SPOT s (NOLOCK)				ON ie.IE_ID = s.IE_ID
				JOIN			dbo.IU iu (NOLOCK)				ON ie.IU_ID = iu.IU_ID
				WHERE			ie.SCHED_DATE_TIME				BETWEEN @StartDateTime AND @EndDateTime
				AND				iu.ZONE_NAME					= ISNULL(@ZoneName,iu.ZONE_NAME)
				AND				iu.CHAN_NAME					= ISNULL(@NetworkName,iu.CHAN_NAME)



END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_7_VideoFormatMismatch' as Name  UNION ALL 




			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_8_ScheduleLoadEvents] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@ChannelName				VARCHAR(100)	= NULL,
				@ScheduleDate				DATE			= NULL

AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				DECLARE			@ScheduleStartDateTime					DATETIME = @ScheduleDate
				DECLARE			@ScheduleEndDateTime					DATETIME

				SELECT			@ScheduleStartDateTime					= CASE  WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@ScheduleStartDateTime ) ELSE @ScheduleStartDateTime END,
								@ScheduleEndDateTime					= DATEADD( DAY,1,@ScheduleStartDateTime )
				SELECT			@ScheduleEndDateTime					= DATEADD( SECOND,-1,@ScheduleEndDateTime )

				SELECT			RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								DBSource								= ''MPEG'',
								ZoneName								= iu.ZONE_NAME,
								NetworkName								= iu.CHAN_NAME,
								Channel									= iu.CHANNEL,
								ScheduleDate							= @ScheduleDate,
								ScheduleLoadDateTime					= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,ie.SCHED_DATE_TIME ) 
																				ELSE ie.SCHED_DATE_TIME
																			END
				FROM			dbo.IE  ie (NOLOCK)
				INNER JOIN		dbo.IU iu (NOLOCK)						ON ie.IU_ID = iu.IU_ID
				WHERE			ie.SCHED_DATE_TIME						BETWEEN @ScheduleStartDateTime AND @ScheduleEndDateTime
				AND				iu.ZONE_NAME							= ISNULL(@ZoneName,iu.ZONE_NAME)
				AND				iu.CHAN_NAME							= ISNULL(@NetworkName,iu.CHAN_NAME)


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_8_ScheduleLoadEvents' as Name  UNION ALL 





			SELECT		CMD			= '
CREATE PROCEDURE [dbo].[Report_2_10_9_FailedVideoIngests] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@FileName					VARCHAR(100)	= NULL,
				@StartDateTime				DATETIME		= NULL,
				@EndDateTime				DATETIME		= NULL

AS
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				SELECT			@UseUTC														= ISNULL(@UseUTC,1)

				SELECT			@StartDateTime												= CASE  WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,@StartDateTime ) ELSE @StartDateTime END,
								@EndDateTime												= DATEADD( DAY,1,@StartDateTime )
				SELECT			@EndDateTime												= DATEADD( SECOND,-1,@EndDateTime )

				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								DBSource													= ''MPEG'',
								Reason	 													= ''Reason''+ISNULL(s.VIDEO_ID,''''),
								FileName													= ''FileName''+ISNULL(s.VIDEO_ID,''''),
								ScheduledDateTime											= CASE	WHEN @UseUTC = 1 THEN DATEADD( HOUR,@UTCOffset,ie.SCHED_DATE_TIME )
																									ELSE ie.SCHED_DATE_TIME
																								END

				FROM			dbo.IE  ie (NOLOCK)
				INNER JOIN		dbo.SPOT s (NOLOCK)											ON ie.IE_ID = s.IE_ID
				INNER JOIN		dbo.VIDEO v (NOLOCK)										ON s.VIDEO_ID = s.VIDEO_ID
				WHERE			ie.SCHED_DATE_TIME											BETWEEN @StartDateTime AND @EndDateTime
				AND				ie.NSTATUS													= 14
				AND				ie.CONFLICT_STATUS											IN (107)
				AND				s.VIDEO_ID													= ISNULL(@FileName, s.VIDEO_ID)


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'Report_2_10_9_FailedVideoIngests' as Name  UNION ALL 























			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportAllSpotReport 
				@RegionID			INT,
				@SDBSourceID		INT,
				@SDBName			VARCHAR(64),
				@UTCOffset			INT,
				@Date				DATE = NULL,
				@Debug				INT = 0
AS
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
// Module:  dbo.ReportAllSpotReport
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AllSpotReport report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportAllSpotReport.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportAllSpotReport	
//									@RegionID			= 1,
//									@SDBSourceID		= 1,
//									@SDBName			= '''',
//									@UTCOffset			= 1,
//									@Date				= '''',
//									@Debug				= 3
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				IF @DATE IS NULL SET @DATE = GETDATE()

				SELECT
								RegionID				= @RegionID,
								SDBSourceID				= @SDBSourceID,
								DB						= @SDBName,
								ZONE					= IU.ZONE_NAME,
								CHANNEL					= IU.CHAN_NAME,
								SCHED_DATE_TIME			= IE.SCHED_DATE_TIME,
								IE_ID					= IE.IE_ID,
								IE_NSTATUS				= IE.NSTATUS,
								IE_CONFLICT_STATUS		= IE.CONFLICT_STATUS,
								IE_SPOTS				= IE.SPOTS,
								IE_DURATION				= IE.DURATION,
								IE_RUN_DATE_TIME		= IE.RUN_DATE_TIME,
								SOURCE_ID				= IE.SOURCE_ID,
								VIDEO_ID				= SPOT.VIDEO_ID,
								SPOT_DURATION			= SPOT.DURATION,
								SPOT_NSTATUS			= SPOT.NSTATUS,
								SPOT_CONFLICT_STATUS	= SPOT.CONFLICT_STATUS,
								SPOT_RUN_DATE_TIME		= SPOT.RUN_DATE_TIME,
								SPOT_RUN_LENGTH			= SPOT.RUN_LENGTH 	
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.SPOT SPOT (NOLOCK) ON SPOT.IE_ID = IE.IE_ID
				INNER JOIN		dbo.IU IU (NOLOCK) ON IU.IU_ID = IE.IU_ID
				WHERE			CONVERT(DATE,IE.SCHED_DATE_TIME) = CONVERT(CHAR(10),@DATE,120)


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportAllSpotReport' as Name  UNION ALL 



			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportArchiveData 
				@RegionID			INT,
				@SDBSourceID		INT,
				@SDBName			VARCHAR(64),
				@UTCOffset			INT,
				@VideoID			VARCHAR(50) 
AS
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
// Module:  dbo.ReportArchiveData
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate ArchiveData report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportArchiveData.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportArchiveData	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '''',
//								@UTCOffset			= NULL,
//								@VideoID			= ''123''
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				IF				( (SELECT COUNT(1) FROM sys.tables WHERE name in (''VIDEOS_ARCHIVED'',''VIDEOS_ARCHIVED_TEXT'')) = 2 )
				SELECT
								RegionID					= @RegionID,
								SDBSourceID					= @SDBSourceID,
								SDB							= @SDBName,
								VideoID						= VA.VIDEO_ID,
								FRAMES						= FRAMES,
								Sts							= VAT.VALUE,
								MVLStatus					= CASE WHEN CREATED_DATE IS NULL THEN ''Removed from MVL'' ELSE ''Exists on MVL'' END,
								NearlineDate				= NEARLINE_DATE
				FROM			dbo.VIDEOS_ARCHIVED VA (NOLOCK)
				INNER JOIN		dbo.VIDEOS_ARCHIVED_TEXT VAT (NOLOCK) 
				ON				VA.STATUS					= VAT.STATUS
				WHERE			VA.VIDEO_ID					= @VideoID COLLATE Latin1_General_BIN  --SQL_Latin1_General_CP1_CI_AS


END
'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportArchiveData' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportCheckSchedules 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@ServerAddress				VARCHAR(50)		= ''MSSNKNSDBP015'',
				@DATE						DATE			= ''1970-01-01'',
				@VHO						VARCHAR(50)		= ''Louisville, KY'',
				@ServerName					VARCHAR(50)		= ''SDBP015'',
				@GIVEBACKS					VARCHAR(200)	= ''''''ECL'''',''''FSCLHD'''',''''FSOHCL'''',''''GALA'''',''''STO'''',''''STYLE'''',''''TV_1'''',''''None''''''
AS
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
// Module:  dbo.ReportCheckSchedules
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportCheckSchedules.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportCheckSchedules	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '''',
//								@UTCOffset			= NULL,
//								@ServerAddress		= '''',
//								@DATE				= ''2013-09-23'',
//								@VHO				= '''',
//								@ServerName			= '''',
//								@GIVEBACKS			= ''''''ECL'''',''''FSCLHD'''',''''FSOHCL'''',''''GALA'''',''''STO'''',''''STYLE'''',''''TV_1'''',''''None''''''
//
*/ 
BEGIN

				--SELECT			@Title								= @ServerName + '' - '' + @VHO

				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				IF				( @DATE = ''1970-01-01'' )			
				SET				@DATE													= DATEADD(DAY, 1, GETDATE())

				DECLARE			@DATEPlus1Day											DATE = DATEADD(DAY, 1, @DATE)

				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								VHO														= x.VHO,
								Ntwrk													= x.Ntwrk,
								CH														= x.CH,
								LocalValue												= x.LocalSUM,
								ICValue													= CASE WHEN x.GiveBack = 1 THEN CAST( x.ICSUM AS VARCHAR(50) ) + '' - GB'' ELSE CAST( x.ICSUM AS VARCHAR(50) ) END,
								Conflict												= x.Conflict,
								LocalFlag												= CASE WHEN x.LocalSUM <> 0 THEN 1 ELSE 0 END,
								ICFlag													= CASE WHEN x.ICSUM <> 0 THEN 1 ELSE 0 END,
								GiveBack												= x.GiveBack 
				FROM			(
									SELECT
													VHO									= IU.ZONE_NAME,
													Ntwrk								= IU.CHAN_NAME,
													CH									= IU.CHANNEL,
													LocalSUM							= SUM(CASE WHEN IE.SOURCE_ID = 1 THEN 1 ELSE 0 END),
													ICSUM								= SUM(CASE WHEN IE.SOURCE_ID = 2 THEN 1 ELSE 0 END),
													Conflict							= SUM(CASE WHEN IE.CONFLICT_STATUS IN (103, 107) THEN 1 ELSE 0 END),
													GiveBack							= CASE WHEN CHARINDEX('''''''' + IU.CHAN_NAME + '''''''',@GIVEBACKS) > 0 THEN 1 ELSE 0 END
									FROM			(SELECT DISTINCT IU_ID FROM dbo.IE (NOLOCK)) IE2
									INNER JOIN		dbo.IU (NOLOCK) 
									ON				IE2.IU_ID							= IU.IU_ID
									LEFT JOIN		dbo.IE (NOLOCK) 
									ON				IE.IU_ID							= IE2.IU_ID
									--AND				CONVERT(DATE,ISNULL(IE.SCHED_DATE_TIME,@DATE)) = CONVERT(DATE,@DATE) BETWEEN @DATE AND @DATE
									WHERE			(
													IE.SCHED_DATE_TIME					>= @DATE 
													AND	IE.SCHED_DATE_TIME				< @DATEPlus1Day
													OR IE.SCHED_DATE_TIME				IS NULL
													)
									AND				IU.ZONE_NAME						= @VHO 
									AND				IU.CHAN_NAME						NOT LIKE ''%ALT%''
									GROUP BY		IU.ZONE_NAME,
													IU.CHAN_NAME, 
													IU.CHANNEL
								) x


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportCheckSchedules' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportCheckSchedules_TB 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@ServerAddress				VARCHAR(50)		= ''MSSNKNSDBP017'',
				@DATE						DATE			= ''1970-01-01'',
				@VHO						VARCHAR(50)		= ''Houston, TX'',
				@ServerName					VARCHAR(50)		= NULL

AS
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
// Module:  dbo.ReportCheckSchedules_TB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules_TB report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportCheckSchedules_TB.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportCheckSchedules_TB	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '''',
//								@UTCOffset			= NULL,
//								@ServerAddress		= '''',
//								@DATE				= ''2013-09-23'',
//								@VHO				= '''',
//								@ServerName			= ''''
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				IF				( @DATE = ''1970-01-01'' )			
				SET				@DATE								= DATEADD(DAY, 1, GETDATE())

				IF				( @ServerName IS NULL )
				SET				@ServerName							= @ServerAddress

				--SELECT			@Title								= @ServerName + '' - '' + @VHO + '' - '' + @DATE


				DECLARE			@DATEPlus1Day						DATE = DATEADD(DAY, 1, @DATE)

				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								VHO														= x.VHO,
								Ntwrk													= x.Ntwrk,
								CH														= x.CH,
								ScheduleDate											= x.ScheduleDate,
								LocalLoaded												= x.LocalLoaded,
								ICLoaded												= x.ICLoaded,
								LocalSUM												= x.LocalSUM,
								ICSUM													= x.ICSUM,
								Conflict												= x.Conflict,
								LocalFlag												= CASE WHEN x.LocalSUM <> 0 THEN 1 ELSE 0 END,
								ICFlag													= CASE WHEN x.ICSUM <> 0 THEN 1 ELSE 0 END 
				FROM			(

									SELECT
													VHO									= IU.ZONE_NAME,
													Ntwrk								= IU.CHAN_NAME,
													CH									= IU.CHANNEL,
													ScheduleDate						= SUB2.ScheduleDate,
													LocalLoaded							= MAX(CASE WHEN SUB2.SOURCE_ID = 1 THEN SUB2.LoadedAt ELSE NULL END),
													ICLoaded							= MAX(CASE WHEN SUB2.SOURCE_ID = 2 THEN SUB2.LoadedAt ELSE NULL END),
													LocalSUM							= SUM(CASE WHEN IE.SOURCE_ID = 1 THEN 1 ELSE 0 END),
													ICSUM								= SUM(CASE WHEN IE.SOURCE_ID = 2 THEN 1 ELSE 0 END),
													Conflict							= SUM(CASE WHEN IE.CONFLICT_STATUS IN (103, 107) THEN 1 ELSE 0 END)
									FROM			(SELECT DISTINCT IU_ID FROM dbo.IE (NOLOCK)) IE2
									INNER JOIN		dbo.IU (NOLOCK) 
									ON				IE2.IU_ID							= IU.IU_ID
									LEFT JOIN		dbo.IE (NOLOCK) 
									ON				IE.IU_ID							= IE2.IU_ID
									LEFT JOIN		(
														SELECT		TB.IU_ID, 
																	TB.SOURCE_ID, 
																	TBMT.NAME Mode, 
																	TBRT.NAME,
																	CONVERT(DATE,TB.TB_DAYPART) AS ScheduleDate,
																	TB.TB_FILE_DATE AS LoadedAt
														FROM		dbo.TB_REQUEST (NOLOCK) TB
														INNER JOIN	dbo.TB_MODE_TEXT (NOLOCK) TBMT 
														ON			TB.TB_MODE			= TBMT.MODE
														INNER JOIN	dbo.TB_REQUEST_TEXT (NOLOCK) TBRT 
														ON			TB.TB_REQUEST		= TBRT.REQUEST
														INNER JOIN	(
																		SELECT		TB2.IU_ID, 
																					TB2.SOURCE_ID, 
																					TB2.TB_DAYPART, 
																					MAX(TB2.TB_FILE_DATE) MaxLoaded
																		FROM		dbo.TB_REQUEST TB2 (NOLOCK)
																		WHERE		(
																						TB2.TB_DAYPART					>= @DATE 
																						AND	TB2.TB_DAYPART				< @DATEPlus1Day
																					)
																		AND			TB2.TB_MODE <> 0 --EXCLUDE REPORTS, added 2011-09-22
																		GROUP BY	TB2.IU_ID, TB2.SOURCE_ID, TB2.TB_DAYPART
																	) SUB
														ON			TB.IU_ID			= SUB.IU_ID
														AND			TB.SOURCE_ID		= SUB.SOURCE_ID
														AND			TB.TB_DAYPART		= SUB.TB_DAYPART
														AND			TB.TB_FILE_DATE		= SUB.MaxLoaded
														GROUP BY	TB.IU_ID, 
																	TBMT.NAME, 
																	TBRT.NAME, 
																	TB.SOURCE_ID, 
																	TB.TB_DAYPART, 
																	TB.TB_FILE_DATE
													) SUB2
									ON				SUB2.IU_ID							= IE2.IU_ID 
									AND				ISNULL(IE.SOURCE_ID,SUB2.SOURCE_ID) = SUB2.SOURCE_ID				
									WHERE			IU.ZONE_NAME						= @VHO 
									AND				(
													IE.SCHED_DATE_TIME					>= @DATE 
													AND	IE.SCHED_DATE_TIME				< @DATEPlus1Day
													)
									GROUP BY 
													IU.ZONE_NAME,
													IU.CHAN_NAME, 
													IU.CHANNEL,
													SUB2.ScheduleDate
								) x


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportCheckSchedules_TB' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportCheckSchedules_TB_20110922 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@ServerAddress				VARCHAR(50)		= ''MSSNKNSDBP017'',
				@DATE						DATE			= ''1970-01-01'',
				@VHO						VARCHAR(50)		= ''Houston, TX'',
				@ServerName					VARCHAR(50)		= NULL

AS
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
// Module:  dbo.ReportCheckSchedules_TB_20110922
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules_TB_20110922 report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportCheckSchedules_TB_20110922.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportCheckSchedules_TB_20110922	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '''',
//								@UTCOffset			= NULL,
//								@ServerAddress		= '''',
//								@DATE				= ''2013-09-23'',
//								@VHO				= '''',
//								@ServerName			= ''''
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				IF				( @DATE = ''1970-01-01'' )			
				SET				@DATE													= DATEADD(DAY, 1, GETDATE())

				IF				( @ServerName IS NULL )
				SET				@ServerName												= @ServerAddress

				--SELECT			@Title								= @ServerName + '' - '' + @VHO + '' - '' + @DATE


				DECLARE			@DATEPlus1Day											DATE = DATEADD(DAY, 1, @DATE)

				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								VHO														= x.VHO,
								Ntwrk													= x.Ntwrk,
								CH														= x.CH,
								ScheduleDate											= x.ScheduleDate,
								LocalLoaded												= x.LocalLoaded,
								ICLoaded												= x.ICLoaded,
								LocalSUM												= x.LocalSUM,
								ICSUM													= x.ICSUM,
								Conflict												= x.Conflict,
								LocalFlag												= CASE WHEN x.LocalSUM <> 0 THEN 1 ELSE 0 END,
								ICFlag													= CASE WHEN x.ICSUM <> 0 THEN 1 ELSE 0 END 
				FROM			(

									SELECT
													VHO									= IU.ZONE_NAME,
													Ntwrk								= IU.CHAN_NAME,
													CH									= IU.CHANNEL,
													ScheduleDate						= SUB2.ScheduleDate,
													LocalLoaded							= MAX(CASE WHEN SUB2.SOURCE_ID = 1 THEN SUB2.LoadedAt ELSE NULL END),
													ICLoaded							= MAX(CASE WHEN SUB2.SOURCE_ID = 2 THEN SUB2.LoadedAt ELSE NULL END),
													LocalSUM							= SUM(CASE WHEN IE.SOURCE_ID = 1 THEN 1 ELSE 0 END),
													ICSUM								= SUM(CASE WHEN IE.SOURCE_ID = 2 THEN 1 ELSE 0 END),
													Conflict							= SUM(CASE WHEN IE.CONFLICT_STATUS IN (103, 107) THEN 1 ELSE 0 END)
									FROM			(SELECT DISTINCT IU_ID FROM dbo.IE (NOLOCK)) IE2
									INNER JOIN		dbo.IU (NOLOCK) 
									ON				IE2.IU_ID							= IU.IU_ID
									LEFT JOIN		dbo.IE (NOLOCK) 
									ON				IE.IU_ID							= IE2.IU_ID
									LEFT JOIN		(
														SELECT		TB.IU_ID, 
																	TB.SOURCE_ID, 
																	TBMT.NAME Mode, 
																	TBRT.NAME,
																	CONVERT(DATE,TB.TB_DAYPART) AS ScheduleDate,
																	TB.TB_FILE_DATE AS LoadedAt
														FROM		dbo.TB_REQUEST (NOLOCK) TB
														INNER JOIN	dbo.TB_MODE_TEXT (NOLOCK) TBMT 
														ON			TB.TB_MODE			= TBMT.MODE
														INNER JOIN	dbo.TB_REQUEST_TEXT (NOLOCK) TBRT 
														ON			TB.TB_REQUEST		= TBRT.REQUEST
														INNER JOIN	(
																		SELECT		TB2.IU_ID, 
																					TB2.SOURCE_ID, 
																					TB2.TB_DAYPART, 
																					MAX(TB2.TB_FILE_DATE) MaxLoaded
																		FROM		dbo.TB_REQUEST TB2 (NOLOCK)
																		WHERE		(
																						TB2.TB_DAYPART					>= @DATE 
																						AND	TB2.TB_DAYPART				< @DATEPlus1Day
																					)
																		GROUP BY	TB2.IU_ID, TB2.SOURCE_ID, TB2.TB_DAYPART
																	) SUB
														ON			TB.IU_ID			= SUB.IU_ID
														AND			TB.SOURCE_ID		= SUB.SOURCE_ID
														AND			TB.TB_DAYPART		= SUB.TB_DAYPART
														AND			TB.TB_FILE_DATE		= SUB.MaxLoaded
														GROUP BY	TB.IU_ID, 
																	TBMT.NAME, 
																	TBRT.NAME, 
																	TB.SOURCE_ID, 
																	TB.TB_DAYPART, 
																	TB.TB_FILE_DATE
													) SUB2
									ON				SUB2.IU_ID							= IE2.IU_ID 
									AND				ISNULL(IE.SOURCE_ID,SUB2.SOURCE_ID) = SUB2.SOURCE_ID				
									WHERE			IU.ZONE_NAME						= @VHO 
									AND				(
													IE.SCHED_DATE_TIME					>= @DATE 
													AND	IE.SCHED_DATE_TIME				< @DATEPlus1Day
													)
									GROUP BY 
													IU.ZONE_NAME,
													IU.CHAN_NAME, 
													IU.CHANNEL,
													SUB2.ScheduleDate
								) x


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportCheckSchedules_TB_20110922' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportCheckSchedules20110718 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@ServerAddress				VARCHAR(50)		= ''192.168.88.144'',
				@DATE						DATE			= ''1970-01-01'',
				@VHO						VARCHAR(50)		= ''Houston, TX'',
				@ServerName					VARCHAR(50)		= NULL

AS
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
// Module:  dbo.ReportCheckSchedules20110718
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules20110718 report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportCheckSchedules20110718.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportCheckSchedules20110718	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '''',
//								@UTCOffset			= NULL,
//								@ServerAddress		= '''',
//								@DATE				= ''2013-09-23'',
//								@VHO				= '''',
//								@ServerName			= ''''
//
*/ 
BEGIN

				IF				( @DATE = ''1970-01-01'' )			
				SET				@DATE								= DATEADD(DAY, 1, GETDATE())

				IF				( @ServerName IS NULL )
				SET				@ServerName							= @ServerAddress
				--SELECT			@Title								= @ServerName + '' - '' + @VHO + '' - '' + @DATE

				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				DECLARE			@DATEPlus1Day						DATE = DATEADD(DAY, 1, @DATE)


				SELECT			RegionID							= @RegionID,
								SDBSourceID							= @SDBSourceID,
								SDB									= @SDBName,
								ZONE_NAME							= x.ZONE_NAME,
								NETWORK								= x.NETWORK, 
								CH									= x.CH,
								SumLocalEVENTFLAG					= SUM(x.LocalEVENTFLAG),
								SumRegionEVENTFLAG					= SUM(x.RegionEVENTFLAG),
								SumConflict							= SUM(x.CONFLICT)
				FROM			(
									SELECT
													ZONE_NAME		= IU.ZONE_NAME,
													NETWORK			= IU.CHAN_NAME, 
													NETWORKPreFix	= LEFT(IU.CHAN_NAME,2),
													CH				= IU.CHANNEL,
													TBSNAME			= TBS.NAME,
													CONFLICTSTATUS	= SUB.VALUE,
													CONFLICT		= CASE WHEN SUB.VALUE = ''Video Conflict'' THEN 1 ELSE 0 END, 
													LocalEVENTFLAG	= CASE WHEN SUB.VALUE IS NOT NULL AND TBS.NAME = ''Local'' THEN 1 ELSE 0 END,
													RegionEVENTFLAG	= CASE WHEN SUB.VALUE IS NOT NULL AND TBS.NAME = ''Regional Interconnect'' THEN 1 ELSE 0 END
									FROM			dbo.IU (NOLOCK)
									CROSS JOIN		(SELECT * FROM dbo.TB_SOURCE_TEXT  (NOLOCK)  WHERE	NAME IN (''Local'', ''Regional Interconnect'')) TBS
									LEFT JOIN		(
														SELECT		IE.IU_ID, IE.SOURCE_ID, ICS.VALUE
														FROM		dbo.IE (NOLOCK) 
														INNER JOIN	dbo.IECONFLICT_STATUS ICS (NOLOCK) 
														ON			IE.CONFLICT_STATUS	= ICS.NSTATUS
														WHERE		IE.SCHED_DATE_TIME	>= @DATE 
														AND			IE.SCHED_DATE_TIME	< @DATEPlus1Day
													) SUB
									ON				IU.IU_ID							= SUB.IU_ID 
									AND				TBS.SOURCE_ID						= SUB.SOURCE_ID
									WHERE			IU.ZONE_NAME						= @VHO
								) x
				WHERE			x.NETWORKPreFix											<> ''CH''
				GROUP BY
								x.ZONE_NAME,
								x.NETWORK, 
								x.CH
				--ORDER BY		x.NETWORK COLLATE Latin1_General_CS_AI		--Collation styles define sorting rules for special characters


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportCheckSchedules20110718' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportCheckSchedules20110719 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@ServerAddress				VARCHAR(50)		= ''192.168.88.144'',
				@DATE						DATE			= ''1970-01-01'',
				@VHO						VARCHAR(50)		= ''Houston, TX'',
				@ServerName					VARCHAR(50)		= NULL

AS
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
// Module:  dbo.ReportCheckSchedules20110719
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules20110719 report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportCheckSchedules20110719.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportCheckSchedules20110719	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '''',
//								@UTCOffset			= NULL,
//								@ServerAddress		= '''',
//								@DATE				= ''2013-09-23'',
//								@VHO				= '''',
//								@ServerName			= ''''
//
*/ 
BEGIN

				IF				( @DATE = ''1970-01-01'' )			
				SET				@DATE								= DATEADD(DAY, 1, GETDATE())

				IF				( @ServerName IS NULL )
				SET				@ServerName							= @ServerAddress

				--SELECT			@Title								= @ServerName + '' - '' + @VHO + '' - '' + @DATE

				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATEPlus1Day						DATE = DATEADD(DAY, 1, @DATE)
				DECLARE			@SourceValue						VARCHAR(50)
				DECLARE			@CMD								NVARCHAR(500)


				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								VHO														= x.ZONE_NAME,
								Ntwrk													= x.NETWORK, 
								CH														= x.CH,
								LocalValue												= SUM(x.LocalEVENTFLAG),
								ICValue													= SUM(x.RegionEVENTFLAG),
								Conflict												= SUM(x.CONFLICT)
				FROM			(
									SELECT
													ZONE_NAME							= IU.ZONE_NAME,
													[SOURCE]							= TBS.NAME,
													NETWORK								= IU.CHAN_NAME, 
													NETWORKPreFix						= LEFT(IU.CHAN_NAME,2),
													CH									= IU.CHANNEL,
													CONFLICTSTATUS						= SUB.VALUE,
													CONFLICT							= CASE WHEN SUB.VALUE = ''Video Conflict'' THEN 1 ELSE 0 END, 
													LocalEVENTFLAG						= CASE WHEN SUB.VALUE IS NOT NULL AND TBS.NAME = ''Local'' THEN 1 ELSE 0 END,
													RegionEVENTFLAG						= CASE WHEN SUB.VALUE IS NOT NULL AND TBS.NAME = ''Regional Interconnect'' THEN 1 ELSE 0 END
									FROM			dbo.IU (NOLOCK)
									--FULL JOIN		dbo.TB_SOURCE_TEXT TBS (NOLOCK) 
									--ON				TBS.NAME IN (''Local'', ''Regional Interconnect'')
									CROSS JOIN		(SELECT * FROM dbo.TB_SOURCE_TEXT  (NOLOCK)  WHERE	NAME IN (''Local'', ''Regional Interconnect'')) TBS
									LEFT JOIN		(
														SELECT		IE.IU_ID, IE.SOURCE_ID, ICS.VALUE
														FROM		dbo.IE (NOLOCK) 
														INNER JOIN	dbo.IECONFLICT_STATUS ICS (NOLOCK) 
														ON			IE.CONFLICT_STATUS	= ICS.NSTATUS
														WHERE		IE.SCHED_DATE_TIME	>= @DATE 
														AND			IE.SCHED_DATE_TIME	< @DATEPlus1Day
													) SUB
									ON				IU.IU_ID							= SUB.IU_ID 
									AND				TBS.SOURCE_ID						= SUB.SOURCE_ID
									WHERE			IU.ZONE_NAME						= @VHO
								) x
				WHERE			x.NETWORKPreFix											<> ''CH''
				GROUP BY
								x.ZONE_NAME,
								x.NETWORK, 
								x.CH
				--ORDER BY		x.NETWORK COLLATE Latin1_General_CS_AI		--Collation styles define sorting rules for special characters


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportCheckSchedules20110719' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportCheckSchedules20110822 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@ServerAddress				VARCHAR(50)		= ''MSSNKNSDBP017'',
				@DATE						DATE			= ''1970-01-01'',
				@VHO						VARCHAR(50)		= ''Houston, TX'',
				@ServerName					VARCHAR(50)		= NULL

AS
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
// Module:  dbo.ReportCheckSchedules20110822
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules20110822 report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportCheckSchedules20110822.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportCheckSchedules20110822	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '''',
//								@UTCOffset			= NULL,
//								@ServerAddress		= '''',
//								@DATE				= ''2013-09-23'',
//								@VHO				= '''',
//								@ServerName			= ''''
//
*/ 
BEGIN

				IF				( @DATE = ''1970-01-01'' )			
				SET				@DATE								= DATEADD(DAY, 1, GETDATE())

				IF				( @ServerName IS NULL )
				SET				@ServerName							= @ServerAddress

				--SELECT			@Title								= @ServerName + '' - '' + @VHO + '' - '' + @DATE

				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				DECLARE			@DATEPlus1Day						DATE = DATEADD(DAY, 1, @DATE)

				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								VHO														= x.VHO,
								Ntwrk													= x.Ntwrk,
								CH														= x.CH,
								LocalValue												= x.LocalSUM,
								ICValue													= ICSUM,
								Conflict												= x.Conflict,
								LocalFlag												= CASE WHEN x.LocalSUM <> 0 THEN 1 ELSE 0 END,
								ICFlag													= CASE WHEN x.ICSUM <> 0 THEN 1 ELSE 0 END 
				FROM			(
									SELECT
													VHO									= IU.ZONE_NAME,
													Ntwrk								= IU.CHAN_NAME,
													CH									= IU.CHANNEL,
													LocalSUM							= SUM(CASE WHEN IE.SOURCE_ID = 1 THEN 1 ELSE 0 END),
													ICSUM								= SUM(CASE WHEN IE.SOURCE_ID = 2 THEN 1 ELSE 0 END),
													Conflict							= SUM(CASE WHEN IE.CONFLICT_STATUS IN (103, 107) THEN 1 ELSE 0 END)
									FROM			(SELECT DISTINCT IU_ID FROM dbo.IE (NOLOCK)) IE2
									INNER JOIN		dbo.IU (NOLOCK) 
									ON				IE2.IU_ID							= IU.IU_ID
									LEFT JOIN		dbo.IE (NOLOCK) 
									ON				IE.IU_ID							= IE2.IU_ID
									--AND				CONVERT(DATE,ISNULL(IE.SCHED_DATE_TIME,@DATE)) = CONVERT(DATE,@DATE) BETWEEN @DATE AND @DATE
									WHERE			(
													IE.SCHED_DATE_TIME					>= @DATE 
													AND	IE.SCHED_DATE_TIME				< @DATEPlus1Day
													OR IE.SCHED_DATE_TIME				IS NULL
													)
									AND				IU.ZONE_NAME						= @VHO 
									AND				IU.CHAN_NAME						NOT LIKE ''%ALT%''
									GROUP BY		IU.ZONE_NAME,
													IU.CHAN_NAME, 
													IU.CHANNEL
								) x


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportCheckSchedules20110822' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportCurrentViewRecentFailures 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@Hours						INT				= 4,
				@StaleMinutes				INT				= 4
AS
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
// Module:  dbo.ReportCurrentViewRecentFailures
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportCurrentViewRecentFailures.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportCurrentViewRecentFailures	
//								@RegionID								= 1,
//								@SDBSourceID							= 1,
//								@SDBName								= '''',
//								@UTCOffset								= NULL,
//								@Hours									= 4,
//								@StaleMinutes							= 4
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								NETWORK													= x.NETWORK,
								MARKET													= x.MARKET,
								ZONE													= x.ZONE,
								CHANNEL													= x.CHANNEL,
								FAILED													= COUNT(DISTINCT x.IE_ID),
								TOTAL													= NULL
				FROM		(
								SELECT			RegionID												= @RegionID,
												SDBSourceID												= @SDBSourceID,
												SDB														= @SDBName,
												NETWORK													= NET.NAME,
												MARKET													= SUBSTRING(IU.ZONE_NAME,1,6),
												ZONE													= IU.ZONE_NAME,
												CHANNEL													= IU.CHAN_NAME,
												IE_ID													= IE.IE_ID
												--IE_NSTATUS												= IE.NSTATUS,
												--IE_CONFLICT_STATUS										= IE.CONFLICT_STATUS,
												--SPOT_NSTATUS											= SPOT.NSTATUS,
												--SPOT_CONFLICT_STATUS									= SPOT.CONFLICT_STATUS,
												--VIDEO_ID												= SPOT.VIDEO_ID
								FROM			dbo.IE IE (NOLOCK)
								INNER JOIN		dbo.SPOT SPOT (NOLOCK)									ON IE.IE_ID = SPOT.IE_ID
								INNER JOIN		dbo.IU IU (NOLOCK) 										ON IE.IU_ID = IU.IU_ID
								INNER JOIN		dbo.NETWORK_IU_MAP NIM (NOLOCK) 						ON IU.IU_ID = NIM.IU_ID
								INNER JOIN		dbo.NETWORK NET (NOLOCK) 								ON NIM.NETWORK_ID = NET.ID
								WHERE			DATEDIFF(HOUR,IE.RUN_DATE_TIME, GETDATE())				< @HOURS
								AND				IE.NSTATUS												NOT IN (13, 15)	--15 --don''t count deleted breaks
							) x
				GROUP BY		x.NETWORK, x.MARKET, x.ZONE, x.CHANNEL



END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportCurrentViewRecentFailures' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportCurrentViewUpcomingIssues 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@Hours						INT				= 4,
				@StaleMinutes				INT				= 5
AS
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
// Module:  dbo.ReportCurrentViewUpcomingIssues
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportCurrentViewUpcomingIssues.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportCurrentViewUpcomingIssues	
//								@RegionID								= 1,
//								@SDBSourceID							= 1,
//								@SDBName								= '''',
//								@UTCOffset								= NULL,
//								@Hours									= 4,
//								@StaleMinutes							= 5
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								NETWORK													= x.NETWORK,
								MARKET													= x.MARKET,
								ZONE													= x.ZONE,
								CHANNEL													= x.CHANNEL,
								ISSUES													= COUNT(DISTINCT x.IE_ID),
								TOTAL													= NULL
				FROM		(
								SELECT			RegionID												= @RegionID,
												SDBSourceID												= @SDBSourceID,
												SDB														= @SDBName,
												NETWORK													= NET.NAME,
												MARKET													= SUBSTRING(IU.ZONE_NAME,1,6),
												ZONE													= IU.ZONE_NAME,
												CHANNEL													= IU.CHAN_NAME,
												IE_ID													= IE.IE_ID
												--IE_NSTATUS												= IE.NSTATUS,
												--IE_CONFLICT_STATUS										= IE.CONFLICT_STATUS,
												--SPOT_NSTATUS											= SPOT.NSTATUS,
												--SPOT_CONFLICT_STATUS									= SPOT.CONFLICT_STATUS,
												--VIDEO_ID												= SPOT.VIDEO_ID
								FROM			dbo.IE IE (NOLOCK)
								INNER JOIN		dbo.SPOT SPOT (NOLOCK)									ON IE.IE_ID = SPOT.IE_ID
								INNER JOIN		dbo.IU IU (NOLOCK) 										ON IE.IU_ID = IU.IU_ID
								INNER JOIN		dbo.NETWORK_IU_MAP NIM (NOLOCK) 						ON IU.IU_ID = NIM.IU_ID
								INNER JOIN		dbo.NETWORK NET (NOLOCK) 								ON NIM.NETWORK_ID = NET.ID
								WHERE			DATEDIFF(HOUR,GETDATE(),IE.SCHED_DATE_TIME)				< @HOURS
								AND				IE.NSTATUS												NOT IN (4,7,9,13,15,16)
								AND				IE.RUN_DATE_TIME										IS NULL
							) x
				GROUP BY		x.NETWORK, x.MARKET, x.ZONE, x.CHANNEL


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportCurrentViewUpcomingIssues' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportDailySummaryReport 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@DATE						DATE			= NULL,
				@BEGINDATE					DATE			= NULL,
				@ENDDATE					DATE			= NULL,
				@ZONE						VARCHAR(64)		= NULL
AS
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
// Module:  dbo.ReportDailySummaryReport
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportDailySummaryReport.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportDailySummaryReport	
//								@RegionID								= 1,
//								@SDBSourceID							= 1,
//								@SDBName								= '''',
//								@UTCOffset								= NULL,
//								@DATE									= NULL,
//								@BEGINDATE								= NULL,
//								@ENDDATE								= NULL,
//								@ZONE									= NULL
//
*/ 
BEGIN



				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME												DATETIME = @DATE
				DECLARE			@DATETIMEBEGIN											DATETIME = @BEGINDATE
				DECLARE			@DATETIMEEND											DATETIME = @ENDDATE

				IF				( @DATE IS NOT NULL )
				BEGIN
								
								SET			@DATE										= DATEADD(HOUR, @UTCOffset, @DATETIME)
								SELECT		@BEGINDATE									= @DATE,
											@ENDDATE									= @DATE

				END
				ELSE
				BEGIN
								
								SELECT		@BEGINDATE									= DATEADD(HOUR, @UTCOffset, @DATETIMEBEGIN),
											@ENDDATE									= DATEADD(HOUR, @UTCOffset, @DATETIMEEND)

				END



				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								RUN_DATE												= a.RUN_DATE,
								ZONE_NAME												= a.ZONE_NAME,
								/* TOTAL */
								Total													= SUM(a.CNT),
								/* played: SPOT_STATUS = Done */
								Played													= SUM(CASE WHEN a.SPOT_STATUS_CODE = 5 THEN a.CNT ELSE 0 END),
								/* no tone: SPOT_STATUS = Error, SPOTCONFLICT_STATUS = No Tone */
								NoTone													= SUM(CASE WHEN a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE = 14 THEN a.CNT ELSE 0 END),
								/* mpeg errors: defined in SeaChange run rate report, icrpt_runrate */
								MpegError												= SUM(CASE WHEN a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE IN (2, 4, 115, 128) THEN a.CNT ELSE 0 END),
								/* missing copy: SPOT_STATUS = ERROR, SPOTCONFLICT_STATUS = Video Not Found or Late Copy */
								MissingCopy												= SUM(CASE WHEN a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE IN (1, 13) THEN a.CNT ELSE 0 END),
								/* same as above for IC''s */
								ICTotal													= SUM(CASE WHEN a.SOURCE = ''Regional Interconnect'' THEN a.CNT ELSE 0 END),
								ICPlayed												= SUM(CASE WHEN a.SOURCE = ''Regional Interconnect'' AND a.SPOT_STATUS_CODE = 5 THEN a.CNT ELSE 0 END),
								ICNoTone												= SUM(CASE WHEN a.SOURCE = ''Regional Interconnect'' AND a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE = 14 THEN a.CNT ELSE 0 END),
								ICMpegError												= SUM(CASE WHEN a.SOURCE = ''Regional Interconnect'' AND a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE IN (2, 4, 115, 128) THEN a.CNT ELSE 0 END),
								ICMissingCopy											= SUM(CASE WHEN a.SOURCE = ''Regional Interconnect'' AND a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE IN (1, 13) THEN a.CNT ELSE 0 END),
								/* same as above for Local */
								ATTTotal												= SUM(CASE WHEN a.SOURCE = ''Local'' THEN a.CNT ELSE 0 END),
								ATTPlayed												= SUM(CASE WHEN a.SOURCE = ''Local'' AND a.SPOT_STATUS_CODE = 5 THEN a.CNT ELSE 0 END),
								ATTNoTone												= SUM(CASE WHEN a.SOURCE = ''Local'' AND a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE = 14 THEN a.CNT ELSE 0 END),
								ATTMpegError											= SUM(CASE WHEN a.SOURCE = ''Local'' AND a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE IN (2, 4, 115, 128) THEN a.CNT ELSE 0 END),
								ATTMissingCopy											= SUM(CASE WHEN a.SOURCE = ''Local'' AND a.SPOT_STATUS_CODE = 6 AND a.SPOTCONFLICT_STATUS_CODE IN (1, 13) THEN a.CNT ELSE 0 END)
								/* grab the color code */
								--ROC_Color								= ISNULL(b.ROC_Color,'''') 
				FROM		(
								SELECT			
												RUN_DATE								= CONVERT(DATE,SPOT.RUN_DATE_TIME),
												ZONE_NAME								= IU.ZONE_NAME,
												SOURCE									= ICS.INTERCONNECT_NAME,
												IE_STATUS_CODE							= IE.NSTATUS,
												SPOT_STATUS_CODE						= SPOT.NSTATUS,
												SPOTCONFLICT_STATUS_CODE				= SPOT.CONFLICT_STATUS,
												CNT										= 1
								FROM			dbo.IE IE (NOLOCK)
								INNER JOIN		dbo.SPOT SPOT (NOLOCK)					ON IE.IE_ID = SPOT.IE_ID
								INNER JOIN		dbo.IU IU (NOLOCK) 						ON IE.IU_ID = IU.IU_ID
								--INNER JOIN		dbo.IE_STATUS IES (NOLOCK)				ON IE.NSTATUS = IES.NSTATUS
								--INNER JOIN		dbo.IECONFLICT_STATUS IECS (NOLOCK)		ON IE.CONFLICT_STATUS = IECS.NSTATUS
								--INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)				ON SPOT.NSTATUS = SS.NSTATUS
								--INNER JOIN		dbo.SPOTCONFLICT_STATUS SCS (NOLOCK)	ON SPOT.CONFLICT_STATUS = SCS.NSTATUS
								--INNER JOIN		dbo.TB_SOURCE_TEXT TST (NOLOCK)			ON IE.SOURCE_ID = TST.SOURCE_ID
								INNER JOIN		dbo.INTERCONNECT_SOURCE ICS (NOLOCK)	ON SPOT.SOURCE_ID = ICS.SOURCE_ID
							) a
				WHERE			a.IE_STATUS_CODE										IN (10,11,12,13,14)
				AND				a.SPOT_STATUS_CODE										IS NOT NULL
				AND				a.SPOTCONFLICT_STATUS_CODE								IS NOT NULL
				--AND				a.RUN_DATE												= ISNULL(@DATE, a.RUN_DATE)
				AND				a.RUN_DATE												BETWEEN ISNULL(@BEGINDATE, a.RUN_DATE) AND ISNULL(@ENDDATE, a.RUN_DATE)
				AND				a.ZONE_NAME												= ISNULL(@ZONE, a.ZONE_NAME)
				GROUP BY		a.RUN_DATE, a.ZONE_NAME --, b.ROC_Color



END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportDailySummaryReport' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportDash 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@ServerAddress				VARCHAR(50)		= ''MSSNKNSDBP017'',
				@DATE						DATE			= NULL,
				@VHO						VARCHAR(50)		= ''San Antonio, TX'',
				@ServerName					VARCHAR(50)		= ''SDBP017'',
				@WarnThreshold				FLOAT			= 0.99,		--Threshold to generate warning color
				@CriticalThreshold			FLOAT			= 0.98,		--Threshold to generate critical color
				@VHOName					VARCHAR(50)		= NULL,
				@NoToneThreshold			FLOAT			= 0.05
AS
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
// Module:  dbo.ReportDash
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate Dash report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportDash.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportDash	
//								@RegionID			= NULL,
//								@SDBSourceID		= NULL,
//								@SDBName			= NULL,
//								@UTCOffset			= NULL,
//								@ServerAddress		= '''',
//								@DATE				= ''2013-09-23'',
//								@VHO				= '''',
//								@ServerName			= NULL,
//								@WarnThreshold		= 0.99,		--Threshold to generate warning color
//								@CriticalThreshold	= 0.98,		--Threshold to generate critical color
//								@VHOName			= NULL,
//								@NoToneThreshold	= 0.05
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME								DATETIME = @DATE

				SET				@DATE									= ISNULL( DATEADD(HOUR, @UTCOffset, @DATETIME) , GETUTCDATE() )

				IF				( @VHOName IS NULL )
				SET				@VHOName								= @VHO

				DECLARE			@DATEPlus1Day							DATE = DATEADD(DAY, 1, @DATE)


				SELECT			RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								EventStatus								= IES.VALUE,
								EventConflict							= ICS.VALUE,
								SpotStatus								= SS.VALUE,
								SpotConflict							= SC.VALUE,
								CNT										= COUNT(1),
								Status									=	CASE	WHEN IES.VALUE = ''Conflict''	AND ICS.VALUE = ''Time Error'' THEN ''Time Conflict''
																					WHEN SS.VALUE = ''Done'' AND SC.VALUE = ''None'' THEN ''Played''
																					WHEN SS.VALUE = ''Done'' AND SC.VALUE = ''Video Not Found'' THEN ''Error''
																					WHEN SS.VALUE = ''Done'' THEN SC.VALUE
																					WHEN SS.VALUE = ''Conflict'' AND IES.VALUE = ''Expired'' THEN ''No Tone''
																					WHEN SS.VALUE = ''Conflict'' THEN ''Video Conflict''
																					WHEN SS.VALUE = ''Copied'' AND SC.VALUE = ''Video Not Found'' THEN ''Copied - Conflict''
																					WHEN SS.VALUE = ''Copied'' THEN ''Upcoming''
																					WHEN SS.VALUE IN (''Idle'',''Loaded'') THEN ''Upcoming''
																					WHEN SS.VALUE = ''Error'' AND SC.VALUE = ''Video Not Found'' THEN ''Video Conflict''
																					WHEN SS.VALUE = ''Error'' AND SC.VALUE = ''No Tone'' THEN ''No Tone''
																					WHEN SS.VALUE = ''Error'' THEN ''Error''
																					ELSE SS.VALUE
																			END

				FROM			dbo.IE (NOLOCK)
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK) 
				ON				IE.NSTATUS								= IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK) 
				ON				IE.CONFLICT_STATUS						= ICS.NSTATUS
				INNER JOIN		dbo.SPOT (NOLOCK) 
				ON				IE.IE_ID								= SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK) 
				ON				SPOT.CONFLICT_STATUS					= SC.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK) 
				ON				SPOT.NSTATUS							= SS.NSTATUS
				INNER JOIN		dbo.IU (NOLOCK) 
				ON				IE.IU_ID								= IU.IU_ID
				WHERE			(
									IE.SCHED_DATE_TIME					>= @DATE 
									AND	IE.SCHED_DATE_TIME				< @DATEPlus1Day
								)
				AND				IU.ZONE_NAME							= ISNULL(@VHO, IU.ZONE_NAME)
				AND				IU.CHAN_NAME							NOT LIKE ''%ALT%''
				GROUP BY		IES.VALUE, ICS.VALUE, SS.VALUE, SC.VALUE



END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportDash' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportDetails 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@DATE 						DATETIME		= NULL,
				@VHO 						VARCHAR(64)		= NULL,
				@Source 					VARCHAR(64)		= NULL,
				@EventStatus 				VARCHAR(64)		= NULL,
				@EventConflict 				VARCHAR(64)		= NULL,
				@SpotStatus 				VARCHAR(64)		= NULL,
				@SpotConflict 				VARCHAR(64)		= NULL,
				@ChanName 					VARCHAR(64)		= NULL,
				@VideoID					VARCHAR(64)		= NULL
AS
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
// Module:  dbo.ReportDetails
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate Details report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportDetails.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportDetails	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@DATE 								= NULL,
//									@VHO 								= NULL,
//									@Source 							= NULL,
//									@EventStatus 						= NULL,
//									@EventConflict 						= NULL,
//									@SpotStatus 						= NULL,
//									@SpotConflict 						= NULL,
//									@ChanName 							= NULL,
//									@VideoID							= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME								DATETIME = @DATE

				SET				@DATE									= DATEADD(HOUR, @UTCOffset, @DATETIME) 


				SELECT			RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								ZONE_NAME								= IU.ZONE_NAME,
								NAME									= TBS.NAME,
								CHAN_NAME								= IU.CHAN_NAME,
								CHANNEL									= IU.CHANNEL,
								EventStatus								= IES.VALUE,
								EventConflict							= ICS.VALUE,
								SpotStatus								= SS.VALUE,
								SpotConflict							= SC.VALUE,
								WindowOpen								= IE.AWIN_START_DT,
								Scheduled								= IE.SCHED_DATE_TIME,
								EventRunTime							= IE.RUN_DATE_TIME,
								SpotRunTime								= SPOT.RUN_DATE_TIME,
								WindowClose								= IE.AWIN_END_DT,
								VIDEO_ID								= SPOT.VIDEO_ID,
								TC_ID									= IU.TC_ID,
								COMPUTER_NAME							= IU.COMPUTER_NAME
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK)				ON IE.NSTATUS				= IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK)		ON IE.CONFLICT_STATUS		= ICS.NSTATUS
				INNER JOIN		dbo.TB_SOURCE_TEXT TBS (NOLOCK)			ON IE.SOURCE_ID				= TBS.SOURCE_ID
				INNER JOIN		dbo.SPOT SPOT (NOLOCK)					ON IE.IE_ID					= SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK)		ON SPOT.CONFLICT_STATUS		= SC.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)				ON SPOT.NSTATUS				= SS.NSTATUS
				INNER JOIN		dbo.IU IU (NOLOCK)						ON IE.IU_ID					= IU.IU_ID
				WHERE			( CONVERT(DATE,IE.SCHED_DATE_TIME)		= CONVERT(DATE,@DATE,121) OR @DATE IS NULL )
				AND				( IU.ZONE_NAME							= ISNULL(@VHO, IU.ZONE_NAME) )
				AND				( TBS.NAME								= ISNULL(@Source, TBS.NAME) )
				AND				( IES.VALUE								= ISNULL(@EventStatus, IES.VALUE) )
				AND				( ICS.VALUE								= ISNULL(@EventConflict, ICS.VALUE) )
				AND				( SS.VALUE								= ISNULL(@SpotStatus, SS.VALUE) )
				AND				( SC.VALUE								= ISNULL(@SpotConflict, SC.VALUE) )
				AND				( IU.CHAN_NAME							= ISNULL(@ChanName, IU.CHAN_NAME) )
				AND				( SPOT.VIDEO_ID							= ISNULL(@VideoID, SPOT.VIDEO_ID) )


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportDetails' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportFailedSpots 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@ERRORCODE					INT,
				@ZONE_NAME					VARCHAR(64)		= NULL,
				@DATE						DATE			= NULL
AS
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
// Module:  dbo.ReportFailedSpots
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate Details report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportFailedSpots.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportFailedSpots	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@ERRORCODE							= 1,
//									@ZONE_NAME							= NULL,
//									@DATE								= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				--DECLARE			@DATETIME								DATETIME = GETUTCDATE()
				--SET				@DATE									= DATEADD( HOUR, -1, @DATETIME ) 
				--SET				@DATE									= DATEADD( DD, -1, @DATETIME ) 

				SELECT			RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								VIDEO_ID								= SPOT.VIDEO_ID, 
								SPOT_STATUS								= SS.VALUE, 
								CONFLICT_STATUS							= SPOT.CONFLICT_STATUS,
								SPOTCONFLICT_STATUS						= SCS.VALUE,
								CHAN_NAME								= IU.CHAN_NAME,
								ZONE_NAME								= IU.ZONE_NAME,
								RUN_DATE_TIME							= SPOT.RUN_DATE_TIME, 
								TC_ID									= IU.TC_ID, 
								COMPUTER_NAME							= IU.COMPUTER_NAME
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.SPOT SPOT (NOLOCK)					ON IE.IE_ID					= SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SCS (NOLOCK)	ON SPOT.CONFLICT_STATUS		= SCS.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)				ON SPOT.NSTATUS				= SS.NSTATUS
				INNER JOIN		dbo.IU IU (NOLOCK)						ON IE.IU_ID					= IU.IU_ID
				WHERE			SPOT.CONFLICT_STATUS					= CONVERT(VARCHAR(8),@ERRORCODE) 
				AND				SPOT.RUN_DATE_TIME						>= ISNULL( @DATE, DATEADD(DD,-1,GETUTCDATE()) )
				AND				IU.CHAN_NAME							NOT LIKE ''%ALT%''
				AND				IU.ZONE_NAME							= ISNULL( @ZONE_NAME,IU.ZONE_NAME )


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportFailedSpots' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportNewConflict 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@DATE 						DATETIME		= NULL
AS
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
// Module:  dbo.ReportNewConflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate Main report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportNewConflict.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportNewConflict	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@DATE 								= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				SET				@DATE														= ISNULL( DATEADD(HOUR,@UTCOffset,@DATE), GETDATE() )

				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME 													= IU.ZONE_NAME,
								CHAN_NAME 													= IU.CHAN_NAME,
								SCHED_DATE_TIME 											= IE.SCHED_DATE_TIME,
								SPOT_STATUS 												= SS.VALUE,
								SPOTCONFLICT_STATUS 										= SC.VALUE,
								VIDEO_ID 													= SPOT.VIDEO_ID
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.SPOT SPOT (NOLOCK)										ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK)							ON SPOT.CONFLICT_STATUS = SC.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)									ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.IU IU (NOLOCK)											ON IE.IU_ID = IU.IU_ID
				WHERE			SPOT.NSTATUS												= 7 
				AND				SPOT.CONFLICT_STATUS 										= 1
				AND				IE.AWIN_END_DT 												> @DATE
				AND				IU.CHAN_NAME 												NOT LIKE ''%ALT%''


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportNewConflict' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportRecentFailureDetails 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@HOURS						INT				= 4,
				@NETWORK					VARCHAR(64)		= NULL,
				@MARKET 					VARCHAR(64)		= NULL,
				@ZONE 						VARCHAR(64)		= NULL,
				@CHANNEL 					VARCHAR(64)		= NULL

AS
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
// Module:  dbo.ReportRecentFailureDetails
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate RecentFailureDetails report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportRecentFailureDetails.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportRecentFailureDetails	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@HOURS 								= NULL,
//									@NETWORK							= NULL,
//									@MARKET 							= NULL,
//									@ZONE 								= NULL,
//									@CHANNEL 							= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME													DATETIME
				--SET				@DATE														= ISNULL( DATEADD(HOUR,@UTCOffset,@DATE), GETDATE() )
				SET				@DATETIME													= DATEADD( HOUR,-@HOURS,GETDATE() )
				


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								NETWORK														= NET.NAME,
								MARKET														= SUBSTRING(IU.ZONE_NAME,1,6),
								ZONE	 													= IU.ZONE_NAME,
								CHANNEL 													= IU.CHAN_NAME,
								IE_ID														= IE.IE_ID,
								IE_STATUS													= IES.VALUE, 
								IE_CONFLICT_STATUS											= ICS.VALUE, 
								SPOT_STATUS													= SS.VALUE, 
								SPOT_CONFLICT_STATUS										= SCS.VALUE,
								VIDEO_ID 													= SPOT.VIDEO_ID
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.SPOT SPOT (NOLOCK)										ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.IU IU (NOLOCK)											ON IE.IU_ID = IU.IU_ID
				INNER JOIN		dbo.NETWORK_IU_MAP NIM (NOLOCK)								ON IU.IU_ID = NIM.IU_ID
				INNER JOIN		dbo.NETWORK NET (NOLOCK)									ON NIM.NETWORK_ID = NET.ID
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK) ON IE.NSTATUS = IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK) ON IE.CONFLICT_STATUS = ICS.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK) ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SCS (NOLOCK) ON SPOT.CONFLICT_STATUS = SCS.NSTATUS
				WHERE			IE.RUN_DATE_TIME											>= @DATETIME
				AND				IE.NSTATUS													<> 13
				AND				NET.NAME 													= ISNULL(@NETWORK, NET.NAME)
				AND 			SUBSTRING(IU.ZONE_NAME,1,6)									= ISNULL(@MARKET, SUBSTRING(IU.ZONE_NAME,1,6)) 
				AND 			IU.ZONE_NAME 												= ISNULL(@ZONE, IU.ZONE_NAME)
				AND 			IU.CHAN_NAME 												= ISNULL(@CHANNEL, IU.CHAN_NAME)



END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportRecentFailureDetails' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportScheduleCompare 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@DATE						DATE,
				@THRESHOLD					FLOAT
AS
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
// Module:  dbo.ReportScheduleCompare
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate RecentFailureDetails report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportScheduleCompare.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportScheduleCompare	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@DATE								= ''2014-01-01'',
//									@THRESHOLD							= 1.1
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME													DATETIME
				DECLARE			@MINDATE													DATE
				DECLARE			@MAXDATE 													DATE

				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				SET				@MINDATE													= CONVERT(DATE,DATEADD(DAY,-6,GETDATE()))
				SET 			@MAXDATE 													= CONVERT(DATE,DATEADD(DAY,-1,GETDATE()))

				IF				ISNULL(OBJECT_ID(''tempdb..#tmp_BreakCounts''), 0) > 0 
								DROP TABLE #tmp_BreakCounts
				CREATE TABLE	#tmp_BreakCounts
								(
									ID				INT IDENTITY(1,1),
									SERVER_NAME		VARCHAR(32),
									SCHED_DATE		DATE,
									ZONE_NAME		VARCHAR(32),
									CHAN_NAME		VARCHAR(32),
									SOURCE_ID		INT,
									TOTAL			INT
								)

				IF				ISNULL(OBJECT_ID(''tempdb..#tmp_BreakCountsSummary''), 0) > 0 
								DROP TABLE #tmp_BreakCountsSummary
				CREATE TABLE	#tmp_BreakCountsSummary
								(
									ID				INT IDENTITY(1,1),
									SERVER_NAME		VARCHAR(32),
									ZONE_NAME		VARCHAR(32),
									CHAN_NAME		VARCHAR(32),
									SOURCE_ID		INT,
									AVGTOTAL		INT
								)


				INSERT			#tmp_BreakCounts (SERVER_NAME, SCHED_DATE, ZONE_NAME, CHAN_NAME, SOURCE_ID, TOTAL)
				SELECT			SERVER_NAME													= @SDBName,
								SCHED_DATE													= CONVERT(DATE,IE.SCHED_DATE_TIME),
								ZONE_NAME 													= IU.ZONE_NAME,
								CHAN_NAME 													= IU.CHAN_NAME,
								SOURCE_ID													= IE.SOURCE_ID,
								TOTAL														= COUNT(1)
				FROM			dbo.IE IE WITH (NOLOCK)
				INNER JOIN		dbo.IU IU WITH (NOLOCK)										ON IE.IU_ID = IU.IU_ID
				WHERE			IU.CHAN_NAME												NOT LIKE ''%ALT%''
				GROUP BY		CONVERT(DATE,IE.SCHED_DATE_TIME), IU.ZONE_NAME, IU.CHAN_NAME, IE.SOURCE_ID


				INSERT			#tmp_BreakCountsSummary ( SERVER_NAME, ZONE_NAME, CHAN_NAME, SOURCE_ID, AVGTOTAL )
				SELECT			SERVER_NAME,
								ZONE_NAME,
								CHAN_NAME,
								SOURCE_ID,
								AVGTOTAL													= AVG(TOTAL)
				FROM			#tmp_BreakCounts
				WHERE			SCHED_DATE													BETWEEN @MINDATE AND @MAXDATE
				GROUP BY		SERVER_NAME, ZONE_NAME, CHAN_NAME, SOURCE_ID


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								SERVER_NAME													= T1.SERVER_NAME,
								SCHED_DATE													= @DATE ,
								ZONE_NAME													= T1.ZONE_NAME,
								CHAN_NAME													= T1.CHAN_NAME,
								SOURCE														= CASE WHEN T1.SOURCE_ID = 2 THEN ''Interconnect'' ELSE ''Local'' END,
								Breaks														= ISNULL(T2.TOTAL,0),
								AVGBreaks													= T1.AVGTOTAL 
				FROM			#tmp_BreakCountsSummary T1
				LEFT JOIN		#tmp_BreakCounts T2 
				ON				T1.SERVER_NAME												= T2.SERVER_NAME
				AND				T1.ZONE_NAME 												= T2.ZONE_NAME
				AND				T1.CHAN_NAME 												= T2.CHAN_NAME
				AND				T1.SOURCE_ID 												= T2.SOURCE_ID
				AND				T2.SCHED_DATE												= @DATE
				WHERE			(ISNULL(T2.TOTAL,0)											< ( @THRESHOLD * T1.AVGTOTAL)
				OR				ISNULL(T2.TOTAL,0)											> ( (2 - @THRESHOLD) * T1.AVGTOTAL))
	

				DROP TABLE		#tmp_BreakCountsSummary
				DROP TABLE		#tmp_BreakCounts


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportScheduleCompare' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportScheduleCount 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@DATE						DATE,
				@CHAN_NAME					VARCHAR(32)		= NULL
AS
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
// Module:  dbo.ReportScheduleCount
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate RecentFailureDetails report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportScheduleCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportScheduleCount	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@DATE								= ''2014-01-01'',
//									@CHAN_NAME							= ''CHAN_NAME''
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME													= IU.ZONE_NAME,
								CHAN_NAME													= IU.CHAN_NAME,
								IC_BREAKS													= SUM(CASE WHEN IE.SOURCE_ID = 2 THEN 1 ELSE 0 END),
								ATT_BREAKS													= SUM(CASE WHEN IE.SOURCE_ID = 1 THEN 1 ELSE 0 END),
								TOTAL														= COUNT(1)
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.IU IU (NOLOCK)											ON IE.IU_ID = IU.IU_ID
				WHERE			CONVERT(DATE,IE.SCHED_DATE_TIME)							= @DATE
				AND				IU.CHAN_NAME												= ISNULL(@CHAN_NAME, IU.CHAN_NAME)
				GROUP BY		IU.ZONE_NAME, IU.CHAN_NAME


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportScheduleCount' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportScheduleStats 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@SCHED_DATE					DATE			= NULL,
				@ZONE						VARCHAR(64)		= NULL
AS
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
// Module:  dbo.ReportScheduleStats
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate RecentFailureDetails report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportScheduleStats.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportScheduleStats	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@SCHED_DATE							= ''2014-01-01'',
//									@ZONE								= ''CHAN_NAME''
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )

				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								CHANNEL 													= IU.CHAN_NAME,
								ZONE 														= IU.ZONE_NAME,
								SOURCE 														= TST.NAME,
								STATUS 														= TSTT.NAME,
								SCHED_DATE 													= CONVERT(DATE,TB_DAYPART),
								MINUTES 													= DATEDIFF(MI,TBR.TB_FILE_DATE,TBR.TB_MACHINE_TS),
								FILE_DATETIME												= TBR.TB_FILE_DATE,
								PROCESSED 													= TBR.TB_MACHINE_TS,
								FILENAME 													= SUBSTRING(TBR.TB_FILE,CHARINDEX(''\SCH\'',TBR.TB_FILE,0)+5,12)
				FROM			dbo.TB_REQUEST TBR (NOLOCK)
				INNER JOIN		dbo.TB_SOURCE_TEXT TST (NOLOCK)								ON TBR.SOURCE_ID = TST.SOURCE_ID
				INNER JOIN		dbo.TB_STATUS_TEXT TSTT (NOLOCK)							ON TBR.STATUS = TSTT.STATUS
				LEFT JOIN		dbo.IU IU (NOLOCK)											ON IU.IU_ID = TBR.IU_ID
				WHERE			TBR.TB_MODE													= 3 
				AND				TBR.TB_REQUEST 												= 2
				AND				CONVERT(DATE,TBR.TB_DAYPART) 								= ISNULL(@SCHED_DATE, CONVERT(DATE,TBR.TB_DAYPART))
				AND				ISNULL(IU.ZONE_NAME,'''') 									= ISNULL(@ZONE, IU.ZONE_NAME)



END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportScheduleStats' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportSDBDashboard 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@SDB						VARCHAR(128)	= NULL,
				@DATE						DATETIME,
				@VHO						VARCHAR(128)	= NULL

AS
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
// Module:  dbo.ReportSDBDashboard
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate SDBDashboard report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportSDBDashboard.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportSDBDashboard	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@SDB								= NULL,
//									@DATE								= NULL,
//									@VHO								= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATEONLY													DATE
				DECLARE			@DATEONLYNextDay											DATE
				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				SELECT			@DATEONLY													= @DATE,
								@DATEONLYNextDay											= DATEADD( DAY,1,@DATE )


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME 													= IU.ZONE_NAME,
								Name 														= TBS.NAME,
								EventStatus 												= IES.VALUE,
								EventConflict 												= ICS.VALUE,
								SpotStatus 													= SS.VALUE,
								SpotConflict 												= SC.VALUE,
								CNT															= COUNT(1) 
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK)									ON IE.NSTATUS = IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK) 							ON IE.CONFLICT_STATUS = ICS.NSTATUS
				INNER JOIN		dbo.TB_SOURCE_TEXT TBS (NOLOCK) 							ON IE.SOURCE_ID = TBS.SOURCE_ID
				INNER JOIN		dbo.SPOT SPOT (NOLOCK) 										ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK) 						ON SPOT.CONFLICT_STATUS = SC.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK) 								ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.IU IU (NOLOCK) 											ON IE.IU_ID = IU.IU_ID
				WHERE			IE.SCHED_DATE_TIME											= @DATEONLY 
				AND				IE.SCHED_DATE_TIME											< @DATEONLYNextDay
				AND				IU.ZONE_NAME												= ISNULL(@VHO,IU.ZONE_NAME)
				AND				IU.CHAN_NAME												NOT LIKE ''%ALT%''
				GROUP BY
								IU.ZONE_NAME,
								TBS.NAME,
								IES.VALUE,
								ICS.VALUE,
								SS.VALUE,
								SC.VALUE


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportSDBDashboard' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportShowConflict 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@ServerAddress				VARCHAR(50)		= NULL,
				@VHO						VARCHAR(50)		= NULL,
				@DATE						DATETIME		= NULL,
				@ENDDATE					DATETIME		= NULL,
				@ServerName					VARCHAR(50)		= NULL,
				@MDBServerAddress			VARCHAR(50)		= NULL
AS
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
// Module:  dbo.ReportShowConflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportShowConflict.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportShowConflict	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '''',
//								@UTCOffset			= NULL,
//								@ServerAddress		= NULL,
//								@VHO				= '''',
//								@DATE				= ''2013-09-23'',
//								@ENDDATE			= ''2013-09-23''
//								@ServerName			= NULL,
//								@MDBServerAddress	= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SET				@DATE													= ISNULL( DATEADD(HOUR, @UTCOffset, @DATE) , GETUTCDATE() )

				IF				( @ENDDATE IS NOT NULL ) SET @ENDDATE					= DATEADD(HOUR, @UTCOffset, @ENDDATE)

				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								ZONE_NAME												= IU.ZONE_NAME,
								NAME													= TBS.NAME,
								CHAN_NAME												= IU.CHAN_NAME,
								CHANNEL													= IU.CHANNEL,
								EventStatus												= IES.VALUE,
								SpotConflict											= SC.VALUE,
								Scheduled												= IE.SCHED_DATE_TIME,
								VIDEO_ID												= SPOT.VIDEO_ID
				FROM			dbo.IE (NOLOCK)
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK)								ON IE.NSTATUS = IES.NSTATUS
				INNER JOIN		dbo.TB_SOURCE_TEXT TBS (NOLOCK)							ON IE.SOURCE_ID = TBS.SOURCE_ID
				INNER JOIN		dbo.SPOT (NOLOCK)										ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK)						ON SPOT.CONFLICT_STATUS = SC.NSTATUS
				INNER JOIN		dbo.IU (NOLOCK)											ON IE.IU_ID = IU.IU_ID
				WHERE			CONVERT(DATE,IE.SCHED_DATE_TIME)						BETWEEN @DATE AND ISNULL(@ENDDATE, CONVERT(DATE,IE.SCHED_DATE_TIME))
				AND				IU.ZONE_NAME											= ISNULL(@VHO, IU.ZONE_NAME)
				AND				SC.NSTATUS												= 1
				AND				IE.AWIN_END_DT											> GETDATE()


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportShowConflict' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportSmallWindow 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@LENGTH						INT,
				@INCLUDE_PLAYED				INT				= 1,
				@INCLUDE_PAST				INT				= 1

AS
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
// Module:  dbo.ReportSmallWindow
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate SDBDashboard report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportSmallWindow.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportSmallWindow	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@LENGTH								= 5,
//									@INCLUDE_PLAYED						= 1,
//									@INCLUDE_PAST						= 1
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )

				DECLARE			@IESVALUE													VARCHAR(20) = NULL
				DECLARE			@Now														DATETIME = NULL

				IF				@INCLUDE_PLAYED <> 1										SET @IESVALUE = ''Played''
				IF				@INCLUDE_PAST <> 1											SET @Now = GETDATE()


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME 													= IU.ZONE_NAME,
								SOURCE 														= TBS.NAME,
								CHAN_NAME 													= IU.CHAN_NAME,
								SCHEDULED_TIME 												= IE.SCHED_DATE_TIME,
								RUN_TIME 													= IE.RUN_DATE_TIME,
								WINDOW_LENGTH 												= IE.AWIN_END + IE.AWIN_START,
								WINDOW_OPEN 												= IE.AWIN_START_DT,
								WINDOW_CLOSE 												= IE.AWIN_END_DT,
								SPOT 														= SPOT.VIDEO_ID,
								IE_STATUS 													= IES.VALUE,
								IECONFLICT_STATUS 											= ICS.VALUE,
								SPOT_STATUS 												= SS.VALUE,
								SPOTCONFLICT_STATUS 										= SC.VALUE
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK)									ON IE.NSTATUS = IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK) 							ON IE.CONFLICT_STATUS = ICS.NSTATUS
				INNER JOIN		dbo.TB_SOURCE_TEXT TBS (NOLOCK) 							ON IE.SOURCE_ID = TBS.SOURCE_ID
				INNER JOIN		dbo.SPOT SPOT (NOLOCK) 										ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK) 						ON SPOT.CONFLICT_STATUS = SC.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK) 								ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.IU IU (NOLOCK) 											ON IE.IU_ID = IU.IU_ID
				WHERE			(IE.AWIN_END + IE.AWIN_START) 								<= @LENGTH 
				AND				IU.CHAN_NAME												NOT LIKE ''%ALT%''
				AND				IES.VALUE													= ISNULL(@IESVALUE, IES.VALUE) --<> ''Played''
				AND				IES.VALUE													=	( 
																									CASE	WHEN @IESVALUE IS NULL THEN IES.VALUE 
																											WHEN IES.VALUE <> @IESVALUE THEN IES.VALUE 
																											ELSE NULL 
																									END
																								)
				AND				IE.SCHED_DATE_TIME											=	( 
																									CASE	WHEN @Now IS NULL THEN IE.SCHED_DATE_TIME
																											WHEN IE.SCHED_DATE_TIME > @Now THEN IE.SCHED_DATE_TIME
																											ELSE NULL 
																									END
																								)
				--AND				IES.VALUE													<> ''Played''
				--AND				IE.SCHED_DATE_TIME											> GETDATE()


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportSmallWindow' as Name UNION ALL
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportSpotReport 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@SOURCE						VARCHAR(32)		= NULL,
				@DATE						DATETIME,
				@VHO						VARCHAR(128)	= NULL
AS
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
// Module:  dbo.ReportSpotReport
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate SDBDashboard report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportSpotReport.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportSpotReport	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@SOURCE								= NULL,
//									@DATE								= ''2014-01-01'',
//									@VHO								= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATEONLY													DATE
				DECLARE			@DATEONLYNextDay											DATE
				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				SELECT			@DATEONLY													= @DATE,
								@DATEONLYNextDay											= DATEADD( DAY,1,@DATE )


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME 													= IU.ZONE_NAME,
								Name 														= TBS.NAME,
								EventStatus 												= IES.VALUE,
								EventConflict 												= ICS.VALUE,
								SpotStatus 													= SS.VALUE,
								SpotConflict 												= SC.VALUE
				FROM			dbo.IE (NOLOCK)
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK)									ON IE.NSTATUS = IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK)							ON IE.CONFLICT_STATUS = ICS.NSTATUS
				INNER JOIN		dbo.TB_SOURCE_TEXT TBS (NOLOCK)								ON IE.SOURCE_ID = TBS.SOURCE_ID
				INNER JOIN		dbo.SPOT (NOLOCK)											ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK)							ON SPOT.CONFLICT_STATUS = SC.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)									ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.IU (NOLOCK)												ON IE.IU_ID = IU.IU_ID
				WHERE			IE.SCHED_DATE_TIME											= @DATEONLY 
				AND				IE.SCHED_DATE_TIME											< @DATEONLYNextDay
				AND				IU.ZONE_NAME												= ISNULL(@VHO, IU.ZONE_NAME)
				AND				TBS.NAME 													= ISNULL(@SOURCE, TBS.NAME)
				AND				IU.CHAN_NAME 												NOT LIKE ''%ALT%''


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportSpotReport' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportSummary 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@STARTDATE					DATE,
				@ENDDATE					DATE,
				@VHO						VARCHAR(128)	= NULL
AS
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
// Module:  dbo.ReportSummary
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate Summary report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportSummary.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportSummary	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@STARTDATE							= ''2014-01-01'',
//									@ENDDATE							= ''2014-01-02'',
//									@VHO								= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME 													= IU.ZONE_NAME,
								Name 														= TBS.NAME,
								SCHED_DATE 													= CONVERT(DATE,IE.SCHED_DATE_TIME),
									/* TOTAL  minus Playing*/
								Total														= SUM(CASE WHEN SPOT.NSTATUS <> 4 THEN 1 ELSE 0 END),
									/* played: SPOT_STATUS = Done */
								Played														= SUM(CASE WHEN SPOT.NSTATUS = 5 THEN 1 ELSE 0 END),
									/* no tone: SPOT_STATUS = Error, SPOTCONFLICT_STATUS = No Tone */
								NoTone 														= SUM(CASE WHEN SPOT.NSTATUS = 6 AND SPOT.CONFLICT_STATUS = 14 THEN 1 ELSE 0 END),
									/* mpeg errors: defined in SeaChange run rate report, icrpt_runrate */
								MpegError													= SUM(CASE WHEN SPOT.NSTATUS = 6 AND SPOT.CONFLICT_STATUS IN (2, 4, 115, 128) THEN 1 ELSE 0 END) ,
									/* missing copy: SPOT_STATUS = ERROR, SPOTCONFLICT_STATUS = Video Not Found or Late Copy */
								MissingCopy													= SUM(CASE WHEN SPOT.NSTATUS = 6 AND SPOT.CONFLICT_STATUS IN (1, 13) THEN 1 ELSE 0 END) 
				FROM			dbo.IE (NOLOCK)
				INNER JOIN		dbo.SPOT (NOLOCK)											ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.IU (NOLOCK) 											ON IE.IU_ID = IU.IU_ID
				INNER JOIN		dbo.TB_SOURCE_TEXT TBS (NOLOCK) 							ON IE.SOURCE_ID = TBS.SOURCE_ID
				WHERE			SCHED_DATE_TIME												BETWEEN @STARTDATE AND @ENDDATE
				AND				IU.ZONE_NAME												= ISNULL(@VHO, IU.ZONE_NAME)
				AND				IU.CHAN_NAME												NOT LIKE ''%ALT%''
				AND				DATEADD(SECOND,IE.DURATION,IE.RUN_DATE_TIME)				< GETDATE()
				GROUP BY		IU.ZONE_NAME,
								TBS.NAME,
								CONVERT(DATE,IE.SCHED_DATE_TIME)


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportSummary' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportSummary20120202 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@STARTDATE					DATE,
				@ENDDATE					DATE,
				@VHO						VARCHAR(128)	= NULL
AS
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
// Module:  dbo.ReportSummary20120202
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate Summary report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportSummary20120202.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportSummary20120202	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@STARTDATE							= ''2014-01-01'',
//									@ENDDATE							= ''2014-01-02'',
//									@VHO								= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME 													= IU.ZONE_NAME,
								Name 														= TBS.NAME,
								SCHED_DATE 													= CONVERT(DATE,IE.SCHED_DATE_TIME),
								EventStatus 												= IES.VALUE,
								EventConflict 												= ICS.VALUE,
								SpotStatus 													= SS.VALUE,
								SpotConflict 												= SC.VALUE
				FROM			dbo.IE (NOLOCK)
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK) 									ON IE.NSTATUS = IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK) 							ON IE.CONFLICT_STATUS = ICS.NSTATUS
				INNER JOIN		dbo.SPOT (NOLOCK) 											ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SC (NOLOCK) 						ON SPOT.CONFLICT_STATUS = SC.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK) 								ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.IU (NOLOCK)												ON IE.IU_ID = IU.IU_ID
				INNER JOIN		dbo.TB_SOURCE_TEXT TBS (NOLOCK) 							ON IE.SOURCE_ID = TBS.SOURCE_ID
				WHERE			SCHED_DATE_TIME												BETWEEN @STARTDATE AND @ENDDATE
				AND				IU.ZONE_NAME												= ISNULL(@VHO, IU.ZONE_NAME)
				AND				IU.CHAN_NAME												NOT LIKE ''%ALT%''


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportSummary20120202' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportTroubleNetworks 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@DATE						DATE,
				@TYPE						VARCHAR(128) --Failed, Played, NULL

AS
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
// Module:  dbo.ReportTroubleNetworks
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate TroubleSpots report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportTroubleNetworks.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportTroubleNetworks	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@DATE								= ''2014-01-01'',
//									@TYPE								= ''Failed''
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATEONLY													DATE
				DECLARE			@DATEONLYNextDay											DATE
				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				SELECT			@DATEONLY													= @DATE,
								@DATEONLYNextDay											= DATEADD( DAY,1,@DATE )


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME 													= IU.ZONE_NAME,
								VIDEO_ID 													= SPOT.VIDEO_ID,
								SPOT_STATUS 												= SS.VALUE,
								CONFLICT_STATUS 											= SPOT.CONFLICT_STATUS,
								SPOTCONFLICT_STATUS 										= SCS.VALUE,
								CHAN_NAME 													= IU.CHAN_NAME
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.SPOT SPOT (NOLOCK)										ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)									ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SCS (NOLOCK)						ON SPOT.CONFLICT_STATUS = SCS.NSTATUS
				INNER JOIN		dbo.IU IU (NOLOCK) 											ON IE.IU_ID = IU.IU_ID
				WHERE			1															=		CASE	
																											WHEN	@TYPE IS NULL THEN 1
																											WHEN	@TYPE = ''Played'' AND SPOT.RUN_DATE_TIME IS NOT NULL THEN 1
																											WHEN	@TYPE = ''Played'' AND SPOT.RUN_DATE_TIME IS NULL THEN 0
																											WHEN	@TYPE = ''Failed'' AND SPOT.CONFLICT_STATUS <> 0 THEN 1
																											WHEN	@TYPE = ''Failed'' AND SPOT.CONFLICT_STATUS = 0 THEN 0
																											ELSE	0
																									END
				AND				SPOT.RUN_DATE_TIME											BETWEEN ISNULL(@DATEONLY, SPOT.RUN_DATE_TIME) AND ISNULL(@DATEONLYNextDay, SPOT.RUN_DATE_TIME)



END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportTroubleNetworks' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportTroubleSpots 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@DATE						DATE

AS
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
// Module:  dbo.ReportTroubleSpots
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate TroubleSpots report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportTroubleSpots.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportTroubleSpots	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@DATE								= ''2014-01-01''
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATEONLY													DATE
				DECLARE			@DATEONLYNextDay											DATE
				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				SELECT			@DATEONLY													= @DATE,
								@DATEONLYNextDay											= DATEADD( DAY,1,@DATE )


				SELECT			RegionID													= @RegionID,
								SDBSourceID													= @SDBSourceID,
								SDB															= @SDBName,
								ZONE_NAME 													= IU.ZONE_NAME,
								VIDEO_ID 													= SPOT.VIDEO_ID,
								SPOT_STATUS 												= SS.VALUE,
								CONFLICT_STATUS 											= SPOT.CONFLICT_STATUS,
								SPOTCONFLICT_STATUS 										= SCS.VALUE,
								CHAN_NAME 													= IU.CHAN_NAME
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.SPOT SPOT (NOLOCK)										ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)									ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SCS (NOLOCK)						ON SPOT.CONFLICT_STATUS = SCS.NSTATUS
				INNER JOIN		dbo.IU IU (NOLOCK) 											ON IE.IU_ID = IU.IU_ID
				WHERE			SPOT.CONFLICT_STATUS										<> 0
				AND				SPOT.RUN_DATE_TIME											BETWEEN ISNULL(@DATEONLY, SPOT.RUN_DATE_TIME) AND ISNULL(@DATEONLYNextDay, SPOT.RUN_DATE_TIME)


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportTroubleSpots' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportUnusedVideos 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@COUNT						INT				= 10000,
				@MAXDATE					DATETIME		= NULL,
				@PREFIX						CHAR(1)			= NULL
AS
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
// Module:  dbo.ReportUnusedVideos
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate UnusedVideos report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportUnusedVideos.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportUnusedVideos	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@COUNT								= 10000,
//									@MAXDATE							= NULL,
//									@PREFIX								= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@DATETIME								DATETIME
				SET				@DATETIME								= DATEADD( HOUR,@UTCOffset,ISNULL(@MAXDATE,GETUTCDATE()) )

				SET				@MAXDATE								= ISNULL(@MAXDATE,GETDATE())

				IF				( OBJECT_ID(''dbo.VIDEOS_ARCHIVED'') IS NOT NULL ) AND ( OBJECT_ID(''dbo.SPOT'') IS NOT NULL )	--Make sure the tables exist
				SELECT			--TOP (@COUNT)
								RegionID								= @RegionID,
								SDBSourceID								= @SDBSourceID,
								SDB										= @SDBName,
								VIDEO_ID_Arch							= va.VIDEO_ID,
								VIDEO_ID_SPOT							= SPOT.VIDEO_ID,
								NEARLINE_DATE 							= va.NEARLINE_DATE
				FROM			
							(
								SELECT		DISTINCT VIDEO_ID 
								FROM		dbo.SPOT (NOLOCK)
								WHERE		VIDEO_ID IS NOT NULL
							)	SPOT
				FULL JOIN		
							(
								SELECT		VIDEO_ID, NEARLINE_DATE
								FROM		dbo.VIDEOS_ARCHIVED (NOLOCK)
								WHERE		NEARLINE_DATE				< @MAXDATE
								AND			SUBSTRING(VIDEO_ID,1,1)		= ISNULL(@PREFIX, SUBSTRING(VIDEO_ID,1,1)) 
							)	va
				ON				SPOT.VIDEO_ID							= va.VIDEO_ID COLLATE DATABASE_DEFAULT
				--WHERE			va.VIDEO_ID								IS NULL
				ORDER BY		va.NEARLINE_DATE ASC


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportUnusedVideos' as Name  UNION ALL 
			SELECT		CMD			= '
CREATE PROCEDURE dbo.ReportUpcomingIssuesDetails 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@NETWORK					VARCHAR(64)		= NULL,
				@MARKET 					VARCHAR(64)		= NULL,
				@ZONE 						VARCHAR(64)		= NULL,
				@CHANNEL 					VARCHAR(64)		= NULL,
				@Hours						INT				= 4,
				@StaleMinutes				INT				= 5
AS
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
// Module:  dbo.ReportUpcomingIssuesDetails
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ReportUpcomingIssuesDetails.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ReportUpcomingIssuesDetails	
//								@RegionID								= 1,
//								@SDBSourceID							= 1,
//								@SDBName								= '''',
//								@UTCOffset								= NULL,
//								@NETWORK								= NULL,
//								@MARKET 								= NULL,
//								@ZONE 									= NULL,
//								@CHANNEL 								= NULL,
//								@Hours									= 4,
//								@StaleMinutes							= 5
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				SELECT			RegionID												= @RegionID,
								SDBSourceID												= @SDBSourceID,
								SDB														= @SDBName,
								NETWORK													= NET.NAME,
								MARKET													= SUBSTRING(IU.ZONE_NAME,1,6),
								ZONE													= IU.ZONE_NAME,
								CHANNEL													= IU.CHAN_NAME,
								IE_ID													= IE.IE_ID,
								IE_STATUS 												= IES.VALUE, 
								IE_CONFLICT_STATUS 										= ICS.VALUE, 
								SPOT_STATUS 											= SS.VALUE, 
								SPOT_CONFLICT_STATUS 									= SCS.VALUE,
								VIDEO_ID												= SPOT.VIDEO_ID
				FROM			dbo.IE IE (NOLOCK)
				INNER JOIN		dbo.SPOT SPOT (NOLOCK)									ON IE.IE_ID = SPOT.IE_ID
				INNER JOIN		dbo.IU IU (NOLOCK) 										ON IE.IU_ID = IU.IU_ID
				INNER JOIN		dbo.NETWORK_IU_MAP NIM (NOLOCK) 						ON IU.IU_ID = NIM.IU_ID
				INNER JOIN		dbo.NETWORK NET (NOLOCK) 								ON NIM.NETWORK_ID = NET.ID
				INNER JOIN		dbo.IE_STATUS IES (NOLOCK)								ON IE.NSTATUS = IES.NSTATUS
				INNER JOIN		dbo.IECONFLICT_STATUS ICS (NOLOCK)						ON IE.CONFLICT_STATUS = ICS.NSTATUS
				INNER JOIN		dbo.SPOT_STATUS SS (NOLOCK)								ON SPOT.NSTATUS = SS.NSTATUS
				INNER JOIN		dbo.SPOTCONFLICT_STATUS SCS (NOLOCK)					ON SPOT.CONFLICT_STATUS = SCS.NSTATUS
				WHERE			DATEDIFF(HOUR,GETDATE(),IE.SCHED_DATE_TIME)				< @HOURS
				AND				IE.NSTATUS												NOT IN (4,7,9,13,15,16)
				AND				IE.RUN_DATE_TIME										IS NULL
				AND				( NET.NAME												= @NETWORK		OR @NETWORK IS NULL )
				AND 			( SUBSTRING(IU.ZONE_NAME,1,6) 							= @MARKET		OR @MARKET IS NULL ) 
				AND 			( IU.ZONE_NAME											= @ZONE			OR @MARKET IS NULL )
				AND 			( IU.CHAN_NAME											= @CHANNEL		OR @MARKET IS NULL )


END


'
, CMDParam			= NULL, 'SP' as CMDType, 'ReportUpcomingIssuesDetails' as Name  



) x
LEFT JOIN dbo.MPEGArticle y
ON x.Name = y.Name
AND x.CMDType = y.CMDType
WHERE y.Name IS NULL



			DECLARE			@RCID INT
			DECLARE			@Domain NVARCHAR(100)
			DECLARE			@FQDomainName NVARCHAR(200)
			DECLARE			@ServerName NVARCHAR(200)
			DECLARE			@ServerIPAddress NVARCHAR(50)
			EXEC			master.dbo.xp_regread 'HKEY_LOCAL_MACHINE', 'SYSTEM\CurrentControlSet\services\Tcpip\Parameters', N'Domain',@Domain OUTPUT
			SELECT			@ServerName				= @@SERVERNAME,
							@FQDomainName			= Cast(SERVERPROPERTY('MachineName') as nvarchar) + '.' + @Domain 
			SELECT TOP 1	@ServerIPAddress		= dec.local_net_address
			FROM			sys.dm_exec_connections AS dec
			WHERE			dec.local_tcp_port IS NOT NULL


			IF				NOT EXISTS(SELECT TOP 1 1 FROM [DINGODB_HOST].DINGODB.dbo.ReplicationCluster WHERE Name = @ServerName OR NameFQ = @FQDomainName OR VIP = @ServerIPAddress ) 
			BEGIN

							INSERT		[DINGODB_HOST].DINGODB.dbo.ReplicationCluster 
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
							SELECT 
										Name							= @ServerName,
										NameFQ							= @FQDomainName,
										VIP								= ISNULL(@ServerIPAddress, @ServerName),
										ModuloValue						= Null,
										Description						= 'Modulo Value of ',
										Enabled							= 1,
										CreateDate						= GETUTCDATE(),
										UpdateDate						= GETUTCDATE()

							SELECT		@RCID							= SCOPE_IDENTITY()

							UPDATE		[DINGODB_HOST].DINGODB.dbo.ReplicationCluster 
							SET			ModuloValue						= ReplicationClusterID,
										Description						= Description + CAST( ReplicationClusterID AS VARCHAR(50))
							WHERE		ReplicationClusterID			= @RCID

			END


			IF				NOT EXISTS(SELECT TOP 1 1 FROM [DINGODB_HOST].master.sys.servers WHERE name = @ServerName) 
			BEGIN

							EXEC		[DINGODB_HOST].master.sys.sp_addlinkedserver  
												@server					= @ServerName,  
												@provider				= N'SQLNCLI', -- sql native client.
												@srvproduct				= N'MSDASQL',
												@dataSrc				= @ServerName 

							EXEC		[DINGODB_HOST].master.sys.sp_serveroption		@server=@ServerName, @optname=N'data access', @optvalue=N'true'
							EXEC		[DINGODB_HOST].master.sys.sp_serveroption 		@server=@ServerName, @optname=N'rpc', @optvalue=N'true'
							EXEC		[DINGODB_HOST].master.sys.sp_serveroption 		@server=@ServerName, @optname=N'rpc out', @optvalue=N'true'
							EXEC		[DINGODB_HOST].master.sys.sp_serveroption 		@server=@ServerName, @optname=N'use remote collation', @optvalue=N'true'
							EXEC		[DINGODB_HOST].master.sys.sp_serveroption 		@server=@ServerName, @optname=N'remote proc transaction promotion', @optvalue=N'true'

			END






