
REM Version 3.6.0.0

REM ------------------------------------------------------------
REM CHANGE THESE VARIABLES FOR YOUR SPECIFIC ENVIRONMENT
REM ------------------------------------------------------------


REM What to deploy.....(Local,GIT repository)
SET filepathout=D:\SQL\ContractDMS\Scripts\DB-V3.6.0.0Log
SET filepath=D:\GitRepos\DMS\Disney.ContractDMS.Database
REM SET filepath=D:\SQL\ContractDMS


REM Where to deploy.....(Local,Dev,QA)
SET servername=W28-64SQL2K8DEV
SET dbname=ContractDMSTony
REM SET servername=DATGLV-QDBW20
REM SET dbname=ContractDMS_QA
REM SET dbname=ContractDMS_Release


REM ------------------------------------------------------------
REM CHANGE THESE VARIABLES FOR YOUR SPECIFIC ENVIRONMENT
REM ------------------------------------------------------------

IF NOT EXIST %filepath% goto END



REM Custom Preparation Scripts
sqlcmd -S %servername% -d %dbname% -i %filepath%\Scripts\DB-V3.6.0.0-CustomPreparation.sql -o %filepathout%\DB-V3.6.0.0-CustomPreparationOut.txt


REM User Defined Tables
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.Hierarchy.udt.sql -o %filepathout%\HierarchyOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.MultiGidHierarchy.udt.sql -o %filepathout%\MultiGidHierarchyOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_GUIDNoId.udt.sql -o %filepathout%\UDT_GUIDNoIdOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_GUID.udt.sql -o %filepathout%\UDT_GUIDOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_GUID2.udt.sql -o %filepathout%\UDT_GUID2Out.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_GUIDVarchar300.udt.sql -o %filepathout%\UDT_GUIDVarchar300Out.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_GUIDVarchar300NoId.udt.sql -o %filepathout%\UDT_GUIDVarchar300NoIdOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_DocumentContact.udt.sql -o %filepathout%\UDT_DocumentContactOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_Contact.udt.sql -o %filepathout%\UDT_ContactOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_ContactNoId.udt.sql -o %filepathout%\UDT_ContactNoIdOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_SelecticaService.udt.sql -o %filepathout%\UDT_SelecticaServiceOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_SelecticaServiceNoId.udt.sql -o %filepathout%\UDT_SelecticaServiceNoIdOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_Talent.udt.sql -o %filepathout%\UDT_TalentOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_TalentNoId.udt.sql -o %filepathout%\UDT_TalentNoIdOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_Artist.udt.sql -o %filepathout%\UDT_ArtistOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\DB\ContractDMS.dbo.UDT_ArtistNoId.udt.sql -o %filepathout%\UDT_ArtistNoIdOut.txt



REM Physical Tables
REM Event tables
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EventType.tbl.sql -o %filepathout%\EventTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.Event.tbl.sql -o %filepathout%\EventOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EventLogType.tbl.sql -o %filepathout%\EventLogTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EventLog.tbl.sql -o %filepathout%\EventLogOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EventLogComment.tbl.sql -o %filepathout%\EventLogCommentOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EventStatusType.tbl.sql -o %filepathout%\EventStatusTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EventStatus.tbl.sql -o %filepathout%\EventStatusOut.txt


REM DR tables
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.InitialDevelopmentStep.tbl.sql -o %filepathout%\InitialDevelopmentStepOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.Network.tbl.sql -o %filepathout%\NetworkOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.FormatGenre.tbl.sql -o %filepathout%\FormatGenreOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.LengthProgramType.tbl.sql -o %filepathout%\LengthProgramTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRFinancialStatus.tbl.sql -o %filepathout%\DRFinancialStatusOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRStatusType.tbl.sql -o %filepathout%\DRStatusTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRPriorityType.tbl.sql -o %filepathout%\DRPriorityTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DR.tbl.sql -o %filepathout%\DROut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRCreativeExecutive.tbl.sql -o %filepathout%\DRCreativeExecutiveOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.AttachmentType.tbl.sql -o %filepathout%\AttachmentTypeOut.txt


REM DR Service level tables
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.Level.tbl.sql -o %filepathout%\LevelOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.WritingStep.tbl.sql -o %filepathout%\WritingStepOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRServiceStatusType.tbl.sql -o %filepathout%\DRServiceStatusTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRServiceContractAdminStatusType.tbl.sql -o %filepathout%\DRServiceContractAdminStatusTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRServiceLegalAffairsRepStatusType.tbl.sql -o %filepathout%\DRServiceLegalAffairsRepStatusTypeOut.txt

sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRServiceGroupType.tbl.sql -o %filepathout%\DRServiceGroupTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRServiceType.tbl.sql -o %filepathout%\DRServiceTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRService.tbl.sql -o %filepathout%\DRServiceOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRServiceWritingStep.tbl.sql -o %filepathout%\DRServiceWritingStepOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DRAttachment.tbl.sql -o %filepathout%\DRAttachmentOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DocumentArtistContact.tbl.sql -o %filepathout%\DocumentArtistContactOut.txt


REM Selectica Template tables
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.SelecticaTemplateType.tbl.sql -o %filepathout%\SelecticaTemplateTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.SelecticaTemplate.tbl.sql -o %filepathout%\SelecticaTemplateOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.SelecticaConflictStatusType.tbl.sql -o %filepathout%\SelecticaConflictStatusTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.SelecticaConflictType.tbl.sql -o %filepathout%\SelecticaConflictStatusOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.SelecticaConflict.tbl.sql -o %filepathout%\SelecticaConflictOut.txt


REM Email tables
REM sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EmailMessageTemplateType.tbl.sql -o %filepathout%\EmailMessageTemplateTypeOut.txt
REM sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EmailMessageTemplate.tbl.sql -o %filepathout%\EmailMessageTemplateOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EmailMessageType.tbl.sql -o %filepathout%\EmailMessageTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.EmailMessage.tbl.sql -o %filepathout%\EmailMessageOut.txt


REM DR to DMS Mapping tables
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.XDRServiceDMSService.tbl.sql -o %filepathout%\XDRServiceDMSServiceOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.Roles.tbl.sql -o %filepathout%\RolesOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.Users.tbl.sql -o %filepathout%\UsersOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.Executive.tbl.sql -o %filepathout%\ExecutiveOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.NetworkExecutive.tbl.sql -o %filepathout%\NetworkExecutiveOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.NetworkUser.tbl.sql -o %filepathout%\NetworkUserOut.txt

sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.HubExecutive.tbl.sql -o %filepathout%\HubExecutiveOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.ProjectCategory.tbl.sql -o %filepathout%\ProjectCategoryOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.XProjectStatusProjectCategory.tbl.sql -o %filepathout%\XProjectStatusProjectCategoryOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.DocumentSubType.tbl.sql -o %filepathout%\DocumentSubTypeOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\TBL\ContractDMS.dbo.LookupTables.tbl.sql -o %filepathout%\LookupTablesOut.txt




REM Functions
sqlcmd -S %servername% -d %dbname% -i %filepath%\FN\ContractDMS.dbo.JSONEscaped.fn.sql -o %filepathout%\JSONEscapedOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\FN\ContractDMS.dbo.ParseXML.fn.sql -o %filepathout%\ParseXMLOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\FN\ContractDMS.dbo.ParseJSON.fn.sql -o %filepathout%\ParseJSONOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\FN\ContractDMS.dbo.ToJSON.fn.sql -o %filepathout%\ToJSONOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\FN\ContractDMS.dbo.ToJSONMultiGid.fn.sql -o %filepathout%\ToJSONMultiGidOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\FN\ContractDMS.dbo.Fn_BAExecutiveTalentDeal.fn.sql -o %filepathout%\Fn_BAExecutiveTalentDealOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\FN\ContractDMS.dbo.Fn_DRServiceArtist.fn.sql -o %filepathout%\Fn_DRServiceArtistOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\FN\ContractDMS.dbo.Fn_DRServiceContact.fn.sql -o %filepathout%\Fn_DRServiceContactOut.txt



REM SPs
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.ValidateJSON.sp.sql -o %filepathout%\ValidateJSONOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.InsertEventLog.sp.sql -o %filepathout%\InsertEventLogOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.InsertEvent.sp.sql -o %filepathout%\InsertEventOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetEventLog.sp.sql -o %filepathout%\GetEventLogOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetEventStatus.sp.sql -o %filepathout%\GetEventStatusOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDRJSON.sp.sql -o %filepathout%\UpsertDRJSONOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDRJSON.sp.sql -o %filepathout%\GetDRJSONOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDRDocument.sp.sql -o %filepathout%\GetDRDocumentOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.DeleteDR.sp.sql -o %filepathout%\DeleteDROut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.ArchiveDRJSON.sp.sql -o %filepathout%\ArchiveDRJSONOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDRCreativeExecutive.sp.sql -o %filepathout%\UpsertDRCreativeExecutiveOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDRServiceWritingStep.sp.sql -o %filepathout%\UpsertDRServiceWritingStepOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDRServiceWritingStepJSON.sp.sql -o %filepathout%\UpsertDRServiceWritingStepJSONOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetXDRServiceDMSService.sp.sql -o %filepathout%\GetXDRServiceDMSServiceOut.txt


REM sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDRCreativeExecutive.sp.sql -o %filepathout%\GetDRCreativeExecutiveOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDepartmentExecutive.sp.sql -o %filepathout%\GetDepartmentExecutiveOut.txt
REM sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDRServiceWritingStep.sp.sql -o %filepathout%\GetDRServiceWritingStepOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDRService.sp.sql -o %filepathout%\UpsertDRServiceOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDRService.sp.sql -o %filepathout%\GetDRServiceOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.DeleteDRService.sp.sql -o %filepathout%\DeleteDRServiceOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.InsertEmailMessage.sp.sql -o %filepathout%\InsertEmailMessageOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDRAttachment.sp.sql -o %filepathout%\UpsertDRAttachmentOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDRAttachment.sp.sql -o %filepathout%\GetDRAttachmentOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSProject.sp.sql -o %filepathout%\UpsertDMSProjectOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSProjectExecutive.sp.sql -o %filepathout%\UpsertDMSProjectExecutiveOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.InsertSelecticaConflict.sp.sql -o %filepathout%\InsertSelecticaConflictOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.DeleteDMSAttachment.sp.sql -o %filepathout%\DeleteDMSAttachmentOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSProjectAttachment.sp.sql -o %filepathout%\UpsertDMSProjectAttachmentOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSArtist.sp.sql -o %filepathout%\UpsertDMSArtistOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSContact.sp.sql -o %filepathout%\UpsertDMSContactOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDRToDMS.sp.sql -o %filepathout%\UpsertDRToDMSOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDRServiceToDMS.sp.sql -o %filepathout%\UpsertDRServiceToDMSOut.txt


REM Set Status SPs
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRToSubmitted.sp.sql -o %filepathout%\UpdateDRToSubmittedOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRToFinal.sp.sql -o %filepathout%\UpdateDRToFinalOut.txt
REM sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRToWithdrawn.sp.sql -o %filepathout%\UpdateDRToWithdrawnOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRToCancelled.sp.sql -o %filepathout%\UpdateDRToCancelledOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRServiceToUnAssigned.sp.sql -o %filepathout%\UpdateDRServiceToUnAssignedOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRServiceToAssigned.sp.sql -o %filepathout%\UpdateDRServiceToAssignedOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRServiceStatusInSelectica.sp.sql -o %filepathout%\UpdateDRServiceInSelecticaOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRServiceToFinal.sp.sql -o %filepathout%\UpdateDRServiceToFinalOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRServiceCAToPending.sp.sql -o %filepathout%\UpdateDRServiceCAToPendingOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRServiceCAToCompleted.sp.sql -o %filepathout%\UpdateDRServiceCAToCompletedOut.txt
REM sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRServiceLAToAssigned.sp.sql -o %filepathout%\UpdateDRServiceLAToAssignedOut.txt


REM sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRFinancialStatusToPending.sp.sql -o %filepathout%\UpdateDRFinancialStatusToPendingOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRFinancialStatusToFinal.sp.sql -o %filepathout%\UpdateDRFinancialStatusToFinalOut.txt
REM sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRFinancialStatusToDisapproval.sp.sql -o %filepathout%\UpdateDRFinancialStatusToDisapprovalOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateDRFinancialStatusToRejected.sp.sql -o %filepathout%\UpdateDRFinancialStatusToRejectedOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSAdditionalTerm.sp.sql -o %filepathout%\UpsertDMSAdditionalTermOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSCreditApproval.sp.sql -o %filepathout%\UpsertDMSCreditApprovalOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSDocumentContact.sp.sql -o %filepathout%\UpsertDMSDocumentContactOut.txt

					
REM Get DMS SPs
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDMSArtistProject.sp.sql -o %filepathout%\GetDMSArtistProjectOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDMSArtistContact.sp.sql -o %filepathout%\GetDMSArtistContactOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDMSNetworkExecutive.sp.sql -o %filepathout%\GetDMSNetworkExecutiveOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDMSNetworkUser.sp.sql -o %filepathout%\GetDMSNetworkUserOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDMSProject.sp.sql -o %filepathout%\GGetDMSProjectOut.txt

REM sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDMSNetworkCreativeExecutive.sp.sql -o %filepathout%\GetDMSNetworkCreativeExecutiveOut.txt

sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetDRJSONArchived.sp.sql -o %filepathout%\GetDRJSONArchivedOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetWorkingTitle.sp.sql -o %filepathout%\GetWorkingTitleOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetEmailMessage.sp.sql -o %filepathout%\GetEmailMessageOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetSelecticaConflict.sp.sql -o %filepathout%\GetSelecticaConflictOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertDMSProductionDocument.sp.sql -o %filepathout%\UpsertDMSProductionDocumentOut.txt
REM sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetBAAssignmentCategory.sp.sql -o %filepathout%\GetBAAssignmentCategoryOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpsertExecutive.sp.sql -o %filepathout%\UpsertExecutiveOut.txt



REM Report
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetBAAssignmentCategoryLegend.sp.sql -o %filepathout%\GetBAAssignmentCategoryLegendOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.Report_BAAssignmentCategory.sp.sql -o %filepathout%\Report_BAAssignmentCategoryOut.txt


REM Existing DMS SPs
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetLookupData.sp.sql -o %filepathout%\GetLookupDataOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetAllUsers.sp.sql -o %filepathout%\GetAllUsersOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.GetUserProfileByLogin.sp.sql -o %filepathout%\GetUserProfileByLoginOut.txt
sqlcmd -S %servername% -d %dbname% -i %filepath%\SP\ContractDMS.dbo.UpdateUser.sp.sql -o %filepathout%\UpdateUserOut.txt


REM Post Execution Script
sqlcmd -S %servername% -d %dbname% -i %filepath%\Scripts\DB-V3.6.0.0-CustomPostExecution.sql -o %filepathout%\DB-V3.6.0.0-CustomPostExecutionOut.txt


:END


