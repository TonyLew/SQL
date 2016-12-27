USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.vwZONE_MAP'), 0) > 0 
	DROP VIEW dbo.vwZONE_MAP
GO

CREATE VIEW dbo.vwZONE_MAP
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
// Module:  dbo.vwZONE_MAP
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Provides an easy to read zone mapping.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.vwZONE_MAP.vw.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

		SELECT				
							zm.ZONE_NAME								AS ZoneName,
							r.Name										AS ROCName,
							m.Name										AS MarketName,
							--m.CILLI										AS CILLIName,
							ic.Name										AS ICProviderName
		FROM				dbo.ZONE_MAP zm (NOLOCK)
		JOIN				dbo.ROC r (NOLOCK)
		ON					zm.ROCID									= r.ROCID
		JOIN				dbo.Market m (NOLOCK)
		ON					zm.MarketID									= m.MarketID
		JOIN				dbo.ICProvider ic (NOLOCK) 
		ON					zm.ICProviderID								= ic.ICProviderID



