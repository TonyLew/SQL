



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimZoneMap'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimZoneMap
GO

CREATE PROCEDURE dbo.ETLDimZoneMap 
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
// Module:  dbo.ETLDimZoneMap
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimSDBSource table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimZoneMap.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimZoneMap	
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON


							INSERT				dbo.DimZoneMap 
											( 
												ZoneMapID,
												ZoneName,
												MarketID,
												MarketName,
												ICProviderID,
												ICProviderName,
												ROCID,
												ROCName,
												Enabled,
												CreateDate
											) 
							SELECT				ZoneMapID													= zm1.ZONE_MAP_ID,
												ZoneName													= zm1.ZONE_NAME,
												MarketID													= zm1.MarketID,
												MarketName													= mkt.Name,
												ICProviderID												= zm1.ICProviderID,
												ICProviderName												= IC.Name,
												ROCID														= zm1.ROCID,
												ROCName														= r.Name,
												Enabled														= 1,
												CreateDate													= GETUTCDATE()
							FROM				DINGODB.dbo.ZONE_MAP zm1 WITH (NOLOCK)
							JOIN				DINGODB.dbo.Market mkt WITH (NOLOCK)						ON		zm1.MarketID					= mkt.MarketID
							JOIN				DINGODB.dbo.ICProvider IC WITH (NOLOCK)						ON		zm1.ICProviderID				= IC.ICProviderID
							JOIN				DINGODB.dbo.ROC r WITH (NOLOCK)								ON		zm1.ROCID						= r.ROCID
							LEFT JOIN			dbo.DimZoneMap zm2 WITH (NOLOCK)							ON		zm1.ZONE_NAME					= zm2.ZoneName
							WHERE				zm2.DimZoneMapID												IS NULL



END
GO



