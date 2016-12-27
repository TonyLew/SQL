



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimSDBSource'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimSDBSource
GO

CREATE PROCEDURE dbo.ETLDimSDBSource 
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
// Module:  dbo.ETLDimSDBSource
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimSDBSource table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimSDBSource.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimSDBSource	
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON


							INSERT				dbo.DimSDBSource 
											( 
												SDBSourceID,
												SDBName,
												MDBSourceID,
												MDBName,
												RegionID,
												RegionName,
												UTCOffset,
												Enabled,
												CreateDate
											) 
							SELECT				SDBSourceID													= s1.SDBSourceID,
												SDBName														= s1.SDBComputerNamePrefix,
												MDBSourceID													= m.MDBSourceID,
												MDBName														= m.MDBComputerNamePrefix,
												RegionID													= r.RegionID,
												RegionName													= r.Name,
												UTCOffset													= s1.UTCOffset,
												Enabled														= 1,
												CreateDate													= GETUTCDATE()
							FROM				DINGODB.dbo.SDBSource s1 WITH (NOLOCK)
							JOIN			(
												SELECT		SDBSourceID
												FROM		DINGODB.dbo.SDBSourceSystem WITH (NOLOCK)
												WHERE		Enabled											= 1
												GROUP BY	SDBSourceID
											) ss															ON		s1.SDBSourceID					= ss.SDBSourceID
							JOIN				DINGODB.dbo.MDBSource m WITH (NOLOCK)						ON		s1.MDBSourceID					= m.MDBSourceID
							JOIN				DINGODB.dbo.Region r WITH (NOLOCK)							ON		m.RegionID						= r.RegionID
							LEFT JOIN			dbo.DimSDBSource s2 WITH (NOLOCK)							ON		s1.SDBSourceID					= s2.SDBSourceID
							WHERE				s2.DimSDBSourceID											IS NULL



END
GO



