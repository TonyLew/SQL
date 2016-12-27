Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetROC'), 0) > 0 
	DROP PROCEDURE dbo.GetROC
GO


CREATE PROCEDURE [dbo].[GetROC]
		@ROCID				UDT_Int READONLY,
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
// Module:  dbo.GetROC
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the ROC information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetROC.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE @ROCID_TBL			UDT_Int
//				DECLARE @Name_TBL			UDT_VarChar50
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetROC 
//						@ROCID				= @ROCID_TBL,
//						@Name				= @Name_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue							
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE				@ROCID_COUNT INT
		--DECLARE				@Name_COUNT INT

		SELECT				TOP 1 @ROCID_COUNT = ID FROM @ROCID
		--SELECT				TOP 1 @Name_COUNT = ID FROM @Name

		SELECT
							ROCID,
							Name,
							Description,
							CreateDate,
							UpdateDate
		FROM				dbo.ROC a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @ROCID	WHERE Value = a.ROCID)		OR ISNULL(@ROCID_COUNT,-1) = -1 )
		--AND					( EXISTS(SELECT TOP 1 1 FROM @Name	WHERE Value = a.Name)		OR ISNULL(@Name_COUNT,0) = 0 )
		ORDER BY			Name

		SET					@Return = @@ERROR

END

GO


