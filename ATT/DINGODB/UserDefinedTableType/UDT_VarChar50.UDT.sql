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
// Module:  UDT_VarChar50
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: User defined table type to allow for parameterized stored procedure using an ordered list of varchar(50) values.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: UDT_VarChar50.UDT.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

Create Type UDT_VarChar50 AS TABLE 
( ID INT Identity(1,1), Value VARCHAR(50))

