USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetSDBList'), 0) > 0 
	DROP PROCEDURE dbo.GetSDBList
GO

CREATE PROCEDURE [dbo].[GetSDBList] 
  @MDBNameActive VARCHAR(50),
  @TotalRows INT OUTPUT 
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
// Module:  dbo.GetSDBList
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Populates a parent SPs temp table named #ResultsALLSDBLogical with all
//     SDBs of the given region's HAdb tables.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetSDBList.proc.sql 3914 2014-04-09 00:22:08Z tlew $
//    
//  Usage:
//
//    DECLARE   @TotalRows INT
//    DECLARE   @MDBNameActive VARCHAR(50) = 'MSSNKNSDBP033P'
//    EXEC   dbo.GetSDBList 
//        @MDBNameActive = @MDBNameActive,
//        @TotalRows  = @TotalRows OUTPUT 
//
*/ 
BEGIN

  DECLARE  @CMD NVARCHAR(2000)

  SET   @CMD = 
       'INSERT #ResultsALLSDBLogical ( SDBLogicalState, PrimaryComputerName, PRoleValue, PStatusValue, PSoftwareVersion, BackupComputerName, BRoleValue, BStatusValue, BSoftwareVersion ) ' +
       'SELECT   SDBLogicalState   = g.State, ' +
       '    PrimaryComputerName  = p.ComputerName ,  ' +
       '    PRoleValue    = 1, ' +
       '    PStatusValue   =  ' +
       '           CASE ' +
       '             WHEN g.State = 1 THEN 1 ' +
       '             WHEN g.State = 5 THEN 0 ' +
       '             ELSE 0 ' +
       '           END, ' +
       '    PSoftwareVersion  = ISNULL(p.SoftwareVersion, ''''), ' +
       '    BackupComputerName  = b.ComputerName, ' +
       '    BRoleValue    = 2, ' +
       '    BStatusValue   =  ' +
       '           CASE ' +
       '             WHEN g.State = 1 THEN 0 ' +
       '             WHEN g.State = 5 THEN 1 ' +
       '             ELSE 0 ' +
       '           END, ' +
       '    BSoftwareVersion  = ISNULL(b.SoftwareVersion, '''') ' +
       'FROM   [' + @MDBNameActive + '].HAdb.dbo.HAGroup g WITH (NOLOCK) ' +
       'LEFT JOIN  [' + @MDBNameActive + '].HAdb.dbo.HAMachine p WITH (NOLOCK) ' +
       'ON    g.Primary_ID = p.ID ' +
       'LEFT JOIN  [' + @MDBNameActive + '].HAdb.dbo.HAMachine b WITH (NOLOCK) ' +
       'ON    g.Backup_ID = b.ID ' +
       'WHERE   p.SystemType = 13 ' +
       'AND   b.SystemType = 13 ' +
	   'AND	ISNULL(p.SoftwareVersion, '''') <> ''''' +
	   'AND	ISNULL(b.SoftwareVersion, '''') <> ''''' 

  EXECUTE  sp_executesql @CMD 
  SELECT  @TotalRows  = @@ROWCOUNT

END

GO

