Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetNetwork'), 0) > 0 
	DROP PROCEDURE dbo.GetNetwork
GO

CREATE PROCEDURE [dbo].[GetNetwork]
		@RegionID			UDT_Int READONLY,
		@NetworkID			UDT_Int READONLY,
		--@Name				UDT_VarChar50 READONLY,
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
// Module:  dbo.GetNetwork
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Network information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetNetwork.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @NetworkID_TBL		UDT_Int
//				DECLARE @Name_TBL			UDT_VarChar50
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetNetwork
//						@RegionID			= @RegionID_TBL,
//						@NetworkID			= @NetworkID_TBL,
//						@Name				= @Name_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue					
//		
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@NetworkID_COUNT INT
		--DECLARE				@Name_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @NetworkID_COUNT = ID FROM @NetworkID
		--SELECT				@Name_COUNT = COUNT(1) FROM @Name

		SELECT
							REGIONALIZED_NETWORK_ID,
							REGIONID,
							NETWORKID,
							NAME,
							DESCRIPTION,
							CreateDate,
							UpdateDate
		FROM				dbo.REGIONALIZED_NETWORK a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = a.REGIONID)	OR ISNULL(@RegionID_COUNT,0) = 0 )
		AND					( EXISTS(SELECT TOP 1 1 FROM @NetworkID	WHERE Value = a.NETWORKID)	OR ISNULL(@NetworkID_COUNT,0) = 0 )
		--AND					( EXISTS(SELECT TOP 1 1 FROM @Name	WHERE Value = a.Name)		OR ISNULL(@Name_COUNT,0) = 0 )
		ORDER BY			Name

		SET					@Return = @@ERROR

END
GO

