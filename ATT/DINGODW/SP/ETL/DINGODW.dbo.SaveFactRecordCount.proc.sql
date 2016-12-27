



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.SaveFactRecordCount'), 0) > 0 
	DROP PROCEDURE dbo.SaveFactRecordCount
GO

CREATE PROCEDURE [dbo].[SaveFactRecordCount] 
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
// Module:  dbo.SaveFactRecordCount
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.CountFactDate table to save record counts for each date for each Fact.  
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.SaveFactRecordCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.SaveFactRecordCount	
//
*/ 
BEGIN


				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON


				UPDATE				dbo.CountFactDate
				SET					FactCount													= r.TotalRecords,
									UpdateDate													= GETUTCDATE()
				FROM				#TotalCountByDay r
				WHERE				CountFactDate.UTCDateStored									= r.UTCDATE
				AND					CountFactDate.FactID										= r.FactID
				AND					CountFactDate.FactCount										<> r.TotalRecords


				INSERT				dbo.CountFactDate
								(
									UTCDateStored,
									FactID,
									FactCount,
									CreateDate
								)
				SELECT
									UTCDateStored												= r.UTCDATE,
									FactID														= r.FactID,
									FactCount													= r.TotalRecords,
									CreateDate													= GETUTCDATE()
				FROM				#TotalCountByDay r
				LEFT JOIN			dbo.CountFactDate f WITH (NOLOCK)
				ON					r.UTCDATE 													= f.UTCDateStored
				AND					r.FactID													= f.FactID
				WHERE				f.CountFactDateID 											IS NULL
				ORDER BY			r.UTCDATE,r.FactID


END

GO



