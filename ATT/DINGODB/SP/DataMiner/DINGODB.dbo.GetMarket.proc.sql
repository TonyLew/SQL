Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetMarket'), 0) > 0 
	DROP PROCEDURE dbo.GetMarket
GO

CREATE PROCEDURE [dbo].[GetMarket]
		@MarketID			UDT_Int READONLY,
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
// Module:  dbo.GetMarket
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Market information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetMarket.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @MarketID_TBL		UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetMarket 
//						@MarketID			= @MarketID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@MarketID_COUNT INT

		SELECT				TOP 1 @MarketID_COUNT = ID FROM @MarketID

		SELECT
							MarketID,
							Name,
							Description,
							CreateDate,
							UpdateDate
		FROM				dbo.Market a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @MarketID	WHERE Value = a.MarketID)		OR ISNULL(@MarketID_COUNT,-1) = -1 )
		ORDER BY			Name
		
		SET					@Return = @@ERROR

END

GO


