

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ParseCSVToInt'), 0) > 0 
	DROP FUNCTION dbo.ParseCSVToInt
GO

CREATE FUNCTION dbo.ParseCSVToInt (@Input AS Varchar(8000) )
RETURNS
      @Result TABLE(Value INT)
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
// Module:  dbo.ParseCSVToInt
// Created: 2014-Apr-23
// Author:  Tony Lew
// 
// Purpose:			Generate Int table from a CSV string.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ParseCSVToInt.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				SELECT			* FROM dbo.ParseCSVToInt('4,6,54,23,89,0,654,3')
//
*/ 
BEGIN
				  DECLARE @str VARCHAR(500)
				  DECLARE @ind Int
				  IF(@Input is not null)
				  BEGIN
						SET @ind = CharIndex(',',@input)
						WHILE @ind > 0
						BEGIN
							  SET @str = SUBSTRING(@Input,1,@ind-1)
							  SET @Input = SUBSTRING(@Input,@ind+1,LEN(@Input)-@ind)
							  INSERT INTO @Result values (@str)
							  SET @ind = CharIndex(',',@Input)
						END
						SET @str = @Input
						INSERT INTO @Result values (@str)
				  END
				  RETURN
END



