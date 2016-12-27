
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.CreateMDBLinkedServer'), 0) > 0 
	DROP PROCEDURE dbo.CreateMDBLinkedServer
GO
CREATE PROCEDURE [dbo].[CreateMDBLinkedServer]
		@MDBPrimaryName				NVARCHAR(50),
		@MDBSecondaryName			NVARCHAR(50),
		@JobOwnerLoginName			NVARCHAR(100),
		@JobOwnerLoginPWD			NVARCHAR(100)
AS
-- =============================================
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
// Module:  dbo.CreateMDBLinkedServer
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Linked Server for each physical MDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateMDBLinkedServer.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateMDBLinkedServer	
//								@MDBPrimaryName		= 'MSSNKNLMDB001P',
//								@MDBSecondaryName	= 'MSSNKNLMDB001B',
//								@JobOwnerLoginName	= N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD	= ''
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @MDBPrimaryName)
		BEGIN
						EXEC		sp_addlinkedserver @MDBPrimaryName, N'SQL Server'
						EXEC		sp_addlinkedsrvlogin 
											@rmtsrvname = @MDBPrimaryName, 
											@locallogin = N'sa', 
											@useself = N'False', 
											@rmtuser = @JobOwnerLoginName, 
											@rmtpassword = @JobOwnerLoginPWD
		END

		IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @MDBSecondaryName)
		BEGIN
						EXEC		sp_addlinkedserver @MDBSecondaryName, N'SQL Server'
						EXEC		sp_addlinkedsrvlogin 
											@rmtsrvname = @MDBSecondaryName, 
											@locallogin = N'sa', 
											@useself = N'False', 
											@rmtuser = @JobOwnerLoginName, 
											@rmtpassword = @JobOwnerLoginPWD
		END


END

GO

