

Use DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.AddNewDINGODBNode'), 0) > 0 
	DROP PROCEDURE dbo.AddNewDINGODBNode
GO

CREATE PROCEDURE dbo.AddNewDINGODBNode
		@DINGODBAlias				NVARCHAR(50) = N'DINGODB_HOST',
		@DINGODBComputerName		NVARCHAR(50)
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
// Module:  dbo.AddNewDINGODBNode
// Created: 2014-Aug-01
// Author:  Tony Lew
// 
// Purpose: Adds a new DINGODB node.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.AddNewDINGODBNode.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	dbo.AddNewDINGODBNode	
//								@DINGODBAlias				= N'DINGODB_HOST',
//								@DINGODBComputerName		= N'MSSNKNLMDB001P'
//
*/ 
-- =============================================
BEGIN


			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SET NOCOUNT ON;



			IF			NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @DINGODBAlias) 
			BEGIN

						EXEC		sp_addlinkedserver  
											@server					= @DINGODBAlias,  
											@provider				= N'SQLNCLI', -- sql native client.
											@srvproduct				= N'MSDASQL',
											@dataSrc				= @DINGODBComputerName 

						EXEC		sp_serveroption					@server=@DINGODBAlias, @optname=N'data access', @optvalue=N'true'

						EXEC		sp_serveroption 				@server=@DINGODBAlias, @optname=N'rpc', @optvalue=N'true'

						EXEC		sp_serveroption 				@server=@DINGODBAlias, @optname=N'rpc out', @optvalue=N'true'

						EXEC		sp_serveroption 				@server=@DINGODBAlias, @optname=N'use remote collation', @optvalue=N'true'

						EXEC		sp_serveroption 				@server=@DINGODBAlias, @optname=N'remote proc transaction promotion', @optvalue=N'true'


			END

END


GO
