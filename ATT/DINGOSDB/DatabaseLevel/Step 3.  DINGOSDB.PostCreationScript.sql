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
// Module:  DINGOSDB linked server creation of DINGODB.
// Created: 2014-Mar-10
// Author:  Tony Lew
// 
// Purpose: DINGODB Database linked server creation.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: Step 3.  DINGODB.PostCreationScript.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//
*/ 


--USE DINGOSDB
--GO



			DECLARE			@DINGODBAlias								NVARCHAR(50)  = N'DINGODB_HOST',
							@DINGODBComputerName						NVARCHAR(50)  = N'TAIMON-SQL06'


			IF				NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @DINGODBAlias) 
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

GO






