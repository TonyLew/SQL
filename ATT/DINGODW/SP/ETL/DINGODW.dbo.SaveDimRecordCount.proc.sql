



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.SaveDimRecordCount'), 0) > 0 
	DROP PROCEDURE dbo.SaveDimRecordCount
GO

CREATE PROCEDURE [dbo].[SaveDimRecordCount] 
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
// Module:  dbo.SaveDimRecordCount
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.CountDimensionDate table to save record counts for each date and each SDBSourceID for each dimension.  
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.SaveDimRecordCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.SaveDimRecordCount	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON



				UPDATE				dbo.CountDimensionDate
				SET					DimensionCount												= r.TotalRecords,
									UpdateDate													= GETUTCDATE()
				FROM				#TotalCountByDay r
				WHERE				CountDimensionDate.SDBSourceID								= r.SDBSourceID
				AND					CountDimensionDate.UTCDateStored							= r.UTCDATE
				AND					CountDimensionDate.DimensionID								= r.DimID
				AND					CountDimensionDate.DimensionCount							<> r.TotalRecords


				INSERT				dbo.CountDimensionDate
								(
									SDBSourceID,
									UTCDateStored,
									DimensionID,
									DimensionCount,
									CreateDate
								)
				SELECT
									SDBSourceID													= r.SDBSourceID,
									UTCDateStored												= r.UTCDATE,
									DimensionID													= r.DimID,
									DimensionCount												= r.TotalRecords,
									CreateDate													= GETUTCDATE()
				FROM				#TotalCountByDay r
				LEFT JOIN			dbo.CountDimensionDate s WITH (NOLOCK)
				ON					r.SDBSourceID												= s.SDBSourceID
				AND					r.UTCDATE 													= s.UTCDateStored
				AND					r.DimID														= s.DimensionID
				WHERE				s.CountDimensionDateID 										IS NULL
				ORDER BY			r.UTCDATE,r.DimID



END

GO