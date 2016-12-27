



/*

--Drop SPs

IF OBJECT_ID('InsertEventLog', 'p') IS NOT NULL								DROP PROCEDURE dbo.InsertEventLog
IF OBJECT_ID('InsertEvent', 'p') IS NOT NULL								DROP PROCEDURE dbo.InsertEvent
IF OBJECT_ID('GetEventLog', 'p') IS NOT NULL								DROP PROCEDURE dbo.GetEventLog
IF OBJECT_ID('GetEventStatus', 'p') IS NOT NULL								DROP PROCEDURE dbo.GetEventStatus

IF OBJECT_ID('UpsertDRJSON', 'p') IS NOT NULL								DROP PROCEDURE dbo.UpsertDRJSON
IF OBJECT_ID('GetDRJSON', 'p') IS NOT NULL									DROP PROCEDURE dbo.GetDRJSON
IF OBJECT_ID('GetDRDocument', 'p') IS NOT NULL								DROP PROCEDURE dbo.GetDRDocument
IF OBJECT_ID('DeleteDR', 'p') IS NOT NULL									DROP PROCEDURE dbo.DeleteDR
IF OBJECT_ID('ArchiveDRJSON', 'p') IS NOT NULL								DROP PROCEDURE dbo.ArchiveDRJSON

IF OBJECT_ID('GetDRCreativeExecutive', 'p') IS NOT NULL						DROP PROCEDURE dbo.GetDRCreativeExecutive
IF OBJECT_ID('GetDepartmentExecutive', 'p') IS NOT NULL						DROP PROCEDURE dbo.GetDepartmentExecutive
IF OBJECT_ID('UpsertDRService', 'p') IS NOT NULL							DROP PROCEDURE dbo.UpsertDRService
IF OBJECT_ID('GetDRService', 'p') IS NOT NULL								DROP PROCEDURE dbo.GetDRService
IF OBJECT_ID('DeleteDRService', 'p') IS NOT NULL							DROP PROCEDURE dbo.DeleteDRService

IF OBJECT_ID('UpdateDRToSubmitted', 'p') IS NOT NULL						DROP PROCEDURE dbo.UpdateDRToSubmitted
IF OBJECT_ID('UpdateDRToFinal', 'p') IS NOT NULL							DROP PROCEDURE dbo.UpdateDRToFinal

IF OBJECT_ID('UpdateDRServiceToAssigned', 'p') IS NOT NULL					DROP PROCEDURE dbo.UpdateDRServiceToAssigned
IF OBJECT_ID('UpdateDRServiceInSelectica', 'p') IS NOT NULL					DROP PROCEDURE dbo.UpdateDRServiceInSelectica
IF OBJECT_ID('UpdateDRServiceToFinal', 'p') IS NOT NULL						DROP PROCEDURE dbo.UpdateDRServiceToFinal

IF OBJECT_ID('UpdateDRServiceCAToCompleted', 'p') IS NOT NULL				DROP PROCEDURE dbo.UpdateDRServiceCAToCompleted

--IF OBJECT_ID('UpdateDRFinancialStatusToPending', 'p') IS NOT NULL			DROP PROCEDURE dbo.UpdateDRFinancialStatusToPending
IF OBJECT_ID('UpdateDRFinancialStatusToFinal', 'p') IS NOT NULL				DROP PROCEDURE dbo.UpdateDRFinancialStatusToFinal
IF OBJECT_ID('UpsertDocumentContact', 'p') IS NOT NULL						DROP PROCEDURE dbo.UpsertDocumentContact

IF OBJECT_ID('GetDMSArtistProject', 'p') IS NOT NULL						DROP PROCEDURE dbo.GetDMSArtistProject
IF OBJECT_ID('GetDMSArtistContact', 'p') IS NOT NULL						DROP PROCEDURE dbo.GetDMSArtistContact
IF OBJECT_ID('GetDMSNetworkCreativeExecutive', 'p') IS NOT NULL				DROP PROCEDURE dbo.GetDMSNetworkCreativeExecutive
IF OBJECT_ID('GetWorkingTitle', 'p') IS NOT NULL							DROP PROCEDURE dbo.GetWorkingTitle
IF OBJECT_ID('UpsertDMSProductionDocument', 'p') IS NOT NULL				DROP PROCEDURE dbo.UpsertDMSProductionDocument

--IF OBJECT_ID('GetAllUsers', 'p') IS NOT NULL								DROP PROCEDURE dbo.GetAllUsers
--IF OBJECT_ID('GetLookupData', 'p') IS NOT NULL								DROP PROCEDURE dbo.GetLookupData
--IF OBJECT_ID('GetUserProfileByLogin', 'p') IS NOT NULL						DROP PROCEDURE dbo.GetUserProfileByLogin
--IF OBJECT_ID('UpdateUser', 'p') IS NOT NULL									DROP PROCEDURE dbo.UpdateUser

IF OBJECT_ID('JSONEscaped', 'tf') IS NOT NULL 								DROP FUNCTION dbo.JSONEscaped
IF OBJECT_ID('parseJSON', 'tf') IS NOT NULL 								DROP FUNCTION dbo.parseJSON
IF OBJECT_ID('ToJSON', 'tf') IS NOT NULL 									DROP FUNCTION dbo.ToJSON


----User-Defined table types
--if exists(
--				select top 1 1
--				from sys.types
--				where name = 'UDT_GUID'
--				and name = 'UDT_GUID'
--			)
--		drop type UDT_GUID
--GO


--if exists(
--				select top 1 1
--				from sys.types
--				where name = 'UDT_DocumentContact'
--			)
--		drop type UDT_DocumentContact
--GO


--if exists(
--				select top 1 1
--				from sys.types
--				where name = 'Hierarchy'
--			)
--		drop type Hierarchy
--GO


--if exists(
--				select top 1 1
--				from sys.types
--				where name = 'UDT_SelecticaService'
--			)
--		drop type UDT_SelecticaService
--GO


----Drop/Truncate Table Order
IF ( OBJECT_ID('XDRServiceDMSService', 'u') IS NOT NULL )						Drop Table dbo.XDRServiceDMSService
--IF ( OBJECT_ID('EmailMessageTemplate', 'u') IS NOT NULL )						Drop Table dbo.EmailMessageTemplate
--IF ( OBJECT_ID('EmailMessageTemplateType', 'u') IS NOT NULL )					Drop Table dbo.EmailMessageTemplateType

IF ( OBJECT_ID('EmailMessage', 'u') IS NOT NULL )								Drop Table dbo.EmailMessage
IF ( OBJECT_ID('EmailMessageType', 'u') IS NOT NULL )							Drop Table dbo.EmailMessageType

IF ( OBJECT_ID('SelecticaTemplate', 'u') IS NOT NULL )							Drop Table dbo.SelecticaTemplate
IF ( OBJECT_ID('SelecticaTemplateType', 'u') IS NOT NULL )						Drop Table dbo.SelecticaTemplateType
IF ( OBJECT_ID('SelecticaConflict', 'u') IS NOT NULL )							Drop Table dbo.SelecticaConflict
IF ( OBJECT_ID('SelecticaConflictType', 'u') IS NOT NULL )						Drop Table dbo.SelecticaConflictType
IF ( OBJECT_ID('SelecticaConflictStatusType', 'u') IS NOT NULL )				Drop Table dbo.SelecticaConflictStatusType

IF ( OBJECT_ID('DRAttachment', 'u') IS NOT NULL )								Drop Table dbo.DRAttachment
IF ( OBJECT_ID('AttachmentType', 'u') IS NOT NULL )								Drop Table dbo.AttachmentType


IF ( OBJECT_ID('DRCreativeExecutive', 'u') IS NOT NULL )						Drop Table dbo.DRCreativeExecutive
IF ( OBJECT_ID('DRServiceWritingStep', 'u') IS NOT NULL )						Drop Table dbo.DRServiceWritingStep
IF ( OBJECT_ID('DRService', 'u') IS NOT NULL )									Drop Table dbo.DRService
IF ( OBJECT_ID('DRServiceType', 'u') IS NOT NULL )								Drop Table dbo.DRServiceType
IF ( OBJECT_ID('DRServiceGroupType', 'u') IS NOT NULL )							Drop Table dbo.DRServiceGroupType
IF ( OBJECT_ID('DRServiceStatusType', 'u') IS NOT NULL )						Drop Table dbo.DRServiceStatusType
IF ( OBJECT_ID('DRServiceContractAdminStatusType', 'u') IS NOT NULL )			Drop Table dbo.DRServiceContractAdminStatusType
IF ( OBJECT_ID('WritingStep', 'u') IS NOT NULL )								Drop Table dbo.WritingStep
IF ( OBJECT_ID('Level', 'u') IS NOT NULL )										Drop Table dbo.Level

IF ( OBJECT_ID('DR', 'u') IS NOT NULL )											Drop Table dbo.DR
IF ( OBJECT_ID('DRStatusType', 'u') IS NOT NULL )								Drop Table dbo.DRStatusType
IF ( OBJECT_ID('DRPriorityType', 'u') IS NOT NULL )								Drop Table dbo.DRPriorityType
IF ( OBJECT_ID('DRFinancialStatus', 'u') IS NOT NULL )							Drop Table dbo.DRFinancialStatus
IF ( OBJECT_ID('FormatGenre', 'u') IS NOT NULL )								Drop Table dbo.FormatGenre
IF ( OBJECT_ID('LengthProgramType', 'u') IS NOT NULL )							Drop Table dbo.LengthProgramType

IF ( OBJECT_ID('EventStatus', 'u') IS NOT NULL )								Drop Table dbo.EventStatus
IF ( OBJECT_ID('EventStatusType', 'u') IS NOT NULL )							Drop Table dbo.EventStatusType
IF ( OBJECT_ID('EventLog', 'u') IS NOT NULL )									Drop Table dbo.EventLog
IF ( OBJECT_ID('EventLogType', 'u') IS NOT NULL )								Drop Table dbo.EventLogType
IF ( OBJECT_ID('Event', 'u') IS NOT NULL )										Drop Table dbo.Event
IF ( OBJECT_ID('EventType', 'u') IS NOT NULL )									Drop Table dbo.EventType
GO

*/



----Custom Scripting
IF ( OBJECT_ID('EventLogTBD', 'u') IS NULL ) 
BEGIN
		EXEC sp_rename 'EventLog','EventLogTBD','OBJECT'
END
go

IF ( OBJECT_ID('EventLog_Insert', 'p') IS NOT NULL )
BEGIN
		EXEC sp_rename 'EventLog_Insert','EventLog_InsertTBD','OBJECT'
END
go


