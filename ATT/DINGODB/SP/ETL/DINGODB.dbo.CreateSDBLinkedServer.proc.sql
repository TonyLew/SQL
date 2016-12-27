
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.CreateSDBLinkedServer'), 0) > 0 
	DROP PROCEDURE dbo.CreateSDBLinkedServer
GO


CREATE PROCEDURE [dbo].[CreateSDBLinkedServer]
		@SDBSourceID				INT,
		@LoginName					NVARCHAR(100) = NULL,
		@LoginPWD					NVARCHAR(100) = NULL
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
// Module:  dbo.CreateSDBLinkedServer
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Linked Server for each physical SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateSDBLinkedServer.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateSDBLinkedServer	
//								@SDBSourceID	= 1,
//								@LoginName		= N'nbrownett@mcc2-lailab',
//								@LoginPWD		= ''
//
*/ 
-- =============================================
BEGIN


		SET NOCOUNT ON;
		DECLARE			@SDBNamePrimaryIn NVARCHAR(100)
		DECLARE			@SDBNameSecondaryIn NVARCHAR(100)

		SELECT			@SDBNamePrimaryIn			= b.SDBComputerName
		FROM			dbo.SDBSource a (NOLOCK)
		JOIN			dbo.SDBSourceSystem b (NOLOCK)
		ON				a.SDBSourceID				= b.SDBSourceID
		WHERE 			a.SDBSourceID				= @SDBSourceID
		AND				b.Role						= 1

		SELECT			@SDBNameSecondaryIn			= b.SDBComputerName
		FROM			dbo.SDBSource a (NOLOCK)
		JOIN			dbo.SDBSourceSystem b (NOLOCK)
		ON				a.SDBSourceID				= b.SDBSourceID
		WHERE 			a.SDBSourceID				= @SDBSourceID
		AND				b.Role						= 2

		IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @SDBNamePrimaryIn)
		BEGIN

						EXEC		sp_addlinkedserver @SDBNamePrimaryIn, N'SQL Server'
						EXEC		sp_addlinkedsrvlogin 
											@rmtsrvname			= @SDBNamePrimaryIn, 
											@locallogin			= N'sa', 
											@useself			= N'False', 
											@rmtuser			= @LoginName, 
											@rmtpassword		= @LoginPWD

		END

		IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @SDBNameSecondaryIn)
		BEGIN

						EXEC		sp_addlinkedserver @SDBNameSecondaryIn, N'SQL Server'
						EXEC		sp_addlinkedsrvlogin 
											@rmtsrvname			= @SDBNameSecondaryIn, 
											@locallogin			= N'sa', 
											@useself			= N'False', 
											@rmtuser			= @LoginName, 
											@rmtpassword		= @LoginPWD

		END


END

GO

