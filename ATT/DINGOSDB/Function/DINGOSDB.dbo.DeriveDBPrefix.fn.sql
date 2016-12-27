USE DINGOSDB
GO

IF ISNULL(OBJECT_ID('dbo.DeriveDBPrefix'), 0) > 0 
	DROP FUNCTION dbo.DeriveDBPrefix
GO

CREATE FUNCTION dbo.DeriveDBPrefix ( @str VARCHAR(50), @token VARCHAR(5) )
	RETURNS VARCHAR(50)
	WITH EXECUTE AS CALLER
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
// Module:  dbo.DeriveDBPrefix
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Extract DB server name prefix
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DeriveDBPrefix.fn.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//	 Usage:
//				DECLARE			@str VARCHAR(50) = 'MSSNKNSDBP033'
//				DECLARE			@token VARCHAR(5) = 'p'
//				SELECT			dbo.DeriveDBPrefix	( @str, @token )
//
*/ 
BEGIN

		DECLARE		@strret VARCHAR(50)
		DECLARE		@ipos INT = CHARINDEX(@token,REVERSE(@str),1)
		SELECT		@strret = SUBSTRING(@str, 1, LEN(@str)- @ipos) +  CAST( SUBSTRING(@str, LEN(@str)-@ipos+2, LEN(@str) ) AS VARCHAR(50) ) 
		RETURN		(@strret)

END