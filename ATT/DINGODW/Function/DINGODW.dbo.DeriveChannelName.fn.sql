

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.DeriveChannelName'), 0) > 0 
	DROP FUNCTION dbo.DeriveChannelName
GO

CREATE FUNCTION dbo.DeriveChannelName ( @MarketName AS Varchar(100), @NetworkName AS Varchar(100), @Channel AS Int, @ZoneName AS Varchar(100) )
RETURNS
      VARCHAR(40)
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
// Module:  dbo.DeriveChannelName
// Created: 2014-Jul-01
// Author:  Tony Lew
// 
// Purpose:			Derive channel name from inputs given.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.DeriveChannelName.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				SELECT			dbo.DeriveChannelName( 'MarketName','NetworkName',1,'ZoneName' )
//
*/ 
BEGIN

				DECLARE			@ChannelName  VARCHAR(40)

				SELECT			@ChannelName			=	@MarketName + '-' + @NetworkName + '/' + 
															SUBSTRING('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', ((CAST(@Channel AS INT) / 10) + 1), 1) +  
															CAST((CAST(@Channel AS INT) % 10) AS VARCHAR) + '-' + 
															RIGHT('00000'+CAST((CASE WHEN ISNUMERIC(RIGHT(@ZoneName, 5)) = 1 THEN RIGHT(@ZoneName, 5)ELSE 0 END) AS VARCHAR(5)),5)
				RETURN			( @ChannelName )


END



