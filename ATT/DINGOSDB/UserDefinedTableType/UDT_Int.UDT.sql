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
// Module:  UDT_Int
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: User defined table type to allow for parameterized stored procedure using an ordered list of integer values.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: UDT_Int.UDT.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//
*/ 


Create Type UDT_Int AS TABLE 
( ID INT Identity(1,1), Value INT)

