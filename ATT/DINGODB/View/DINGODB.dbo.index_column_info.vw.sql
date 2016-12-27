USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.index_column_info'), 0) > 0 
	DROP VIEW dbo.index_column_info
GO


CREATE VIEW dbo.index_column_info
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
// Module:  dbo.index_column_info
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Provides detailed index information.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.index_column_info.vw.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

  SELECT object_name = object_name(ic.object_id),
				  index_id = i.index_id,
				  index_column_id = ic.index_column_id,
                  index_name = i.name,
                  'column' = c.name,
                  'column usage' = CASE ic.is_included_column
                               WHEN 0 then 'KEY'
                               ELSE 'INCLUDED'
                   END
   FROM sys.index_columns ic JOIN sys.columns c
              ON ic.object_id = c.object_id
              AND ic.column_id = c.column_id
       JOIN sys.indexes i
              ON i.object_id = ic.object_id
              AND i.index_id = ic.index_id