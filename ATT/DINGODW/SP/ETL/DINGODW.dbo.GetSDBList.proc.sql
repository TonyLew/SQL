



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.GetSDBList'), 0) > 0 
	DROP PROCEDURE dbo.GetSDBList
GO

CREATE PROCEDURE dbo.GetSDBList 
				--@TotalCount		INT OUTPUT
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
// Module:  dbo.GetSDBList
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.XSEU table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.GetSDBList.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.GetSDBList	
//
*/ 
BEGIN


				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON


				SELECT				d.SDBSourceID
				FROM				dbo.DimSDBSource d WITH (NOLOCK)
				--JOIN				DINGODB.dbo.SDBSource a WITH (NOLOCK)
				--ON					d.SDBSourceID											= a.SDBSourceID
				--JOIN				DINGODB.dbo.SDBSourceSystem b WITH (NOLOCK)
				--ON					a.SDBSourceID											= b.SDBSourceID
				WHERE				d.Enabled												= 1
				--AND					b.Role													= CASE WHEN a.SDBStatus = 1 THEN 1 WHEN a.SDBStatus = 5 THEN 2 END
				--SELECT				@TotalCount												= @@ROWCOUNT

END
GO