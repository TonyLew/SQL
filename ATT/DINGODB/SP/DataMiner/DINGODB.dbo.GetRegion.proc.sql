USE [DINGODB]
GO

IF ISNULL(OBJECT_ID('dbo.GetRegion'), 0) > 0 
	DROP PROCEDURE dbo.GetRegion
GO

CREATE PROCEDURE [dbo].[GetRegion]
		@RegionID			UDT_Int READONLY,
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
// Module:  dbo.GetRegion
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Region information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetRegion.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetRegion 
//						@RegionID			= @RegionID_TBL,
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

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID

		SELECT
							RegionID,
							Name,
							Description,
							CreateDate,
							UpdateDate
		FROM				dbo.Region a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = a.RegionID)		OR ISNULL(@RegionID_COUNT,0) = 0 )
		ORDER BY			Name
		
		SET					@Return = @@ERROR

END


GO


