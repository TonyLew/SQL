Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetZone'), 0) > 0 
	DROP PROCEDURE dbo.GetZone
GO

CREATE PROCEDURE [dbo].[GetZone]
		@RegionID			UDT_Int READONLY,
		@ZoneID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
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
// Module:  dbo.GetZone
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the SPOT zone and the associated DINGODB zone id.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetZone.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @ZoneID_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetZone
//						@RegionID			= @RegionID_TBL,
//						@ZoneID				= @ZoneID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@ZoneID_COUNT INT

		SELECT				@RegionID_COUNT = COUNT(1) FROM @RegionID
		SELECT				@ZoneID_COUNT = COUNT(1) FROM @ZoneID

		SELECT
							a.REGIONALIZED_ZONE_ID,
							a.REGION_ID,
							a.ZONE_ID,
							b.ZONE_NAME,
							a.DATABASE_SERVER_NAME,
							--DB_ID,
							--SCHEDULE_RELOADED,
							--MAX_DAYS,
							--MAX_ROWS,
							--TB_TYPE,
							--LOAD_TTL,
							--LOAD_TOD,
							--ASRUN_TTL,
							--ASRUN_TOD,
							--IC_ZONE_ID,
							--PRIMARY_BREAK,
							--SECONDARY_BREAK
							a.CreateDate,
							a.UpdateDate
		FROM				dbo.REGIONALIZED_ZONE a (NOLOCK)
		JOIN				dbo.ZONE_MAP b (NOLOCK)
		ON					a.ZONE_NAME											= b.ZONE_NAME
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = a.REGION_ID)					OR ISNULL(@RegionID_COUNT,0) = 0 )
		AND					( EXISTS(SELECT TOP 1 1 FROM @ZoneID	WHERE Value = a.REGIONALIZED_ZONE_ID)		OR ISNULL(@ZoneID_COUNT,0) = 0 )
		ORDER BY			b.ZONE_NAME

		SET					@Return = @@ERROR

END

GO


