Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetCacheStatus'), 0) > 0 
	DROP PROCEDURE dbo.GetCacheStatus
GO

CREATE PROCEDURE [dbo].[GetCacheStatus]
		@RegionID			UDT_Int READONLY,
		@NodeID				UDT_Int READONLY,
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
// Module:  dbo.GetCacheStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Cache Status for a given region and SDB Node ID.
//					Possible values for Cached_data column are "Channel Status" or "Media Status"
//					as specified in table column DINGODB.dbo.CacheStatusType.Description
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetCacheStatus.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @NodeID_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetCacheStatus 
//						@RegionID			= @RegionID_TBL,
//						@NodeID				= @NodeID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@NodeID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @NodeID_COUNT = ID FROM @NodeID

		SELECT
							Cached_data								= b.Description,
							Region									= r.Name,
							SDB										= c.SDBComputerNamePrefix,
							Modified_time							= a.UpdateDate
		FROM				dbo.CacheStatus a (NOLOCK)
		JOIN				dbo.CacheStatusType b (NOLOCK)
		ON					a.CacheStatusTypeID						= b.CacheStatusTypeID
		JOIN				dbo.SDBSource c (NOLOCK)
		ON					a.SDBSourceID							= c.SDBSourceID
		JOIN				dbo.MDBSource d (NOLOCK)
		ON					c.MDBSourceID							= d.MDBSourceID
		JOIN				dbo.Region r (NOLOCK)
		ON					d.RegionID								= r.RegionID
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = d.RegionID)		OR @RegionID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @NodeID	WHERE Value = c.SDBSourceID)	OR @NodeID_COUNT IS NULL )

		SET					@Return = @@ERROR

END



GO

