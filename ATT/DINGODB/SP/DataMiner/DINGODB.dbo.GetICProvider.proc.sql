USE DINGODB
GO


IF ISNULL(OBJECT_ID('dbo.GetICProvider'), 0) > 0 
	DROP PROCEDURE dbo.GetICProvider
GO

CREATE PROCEDURE [dbo].[GetICProvider]
		@ICProviderID		UDT_Int READONLY,
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
// Module:  dbo.GetICProvider
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the IC Provider information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetICProvider.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @ICProviderID_TBL	UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetICProvider 
//						@ICProviderID		= @ICProviderID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@ICProviderID_COUNT INT

		SELECT				TOP 1 @ICProviderID_COUNT = ID FROM @ICProviderID

		SELECT
							ICProviderID,
							Name,
							Description,
							CreateDate,
							UpdateDate
		FROM				dbo.ICProvider a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @ICProviderID	WHERE Value = a.ICProviderID)		OR ISNULL(@ICProviderID_COUNT,-1) = -1 )
		ORDER BY			Name
		
		SET					@Return = @@ERROR

END




GO

