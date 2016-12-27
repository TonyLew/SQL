
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveCacheStatus'), 0) > 0 
	DROP PROCEDURE dbo.SaveCacheStatus
GO

CREATE PROCEDURE [dbo].[SaveCacheStatus]
		@SDBSourceID		INT,
		@CacheType			VARCHAR(32),
		@ErrorID			INT = 0 OUTPUT
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
// Module:  dbo.SaveCacheStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Saves Cache Status of the logical SDB for the given cache type.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveCacheStatus.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveCacheStatus 
//								@SDBSourceID		= 1,
//								@CacheType			= 'ChannelStatus'  --Two types: ChannelStatus, Conflict
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@CacheStatusTypeID		INT
		SET			@ErrorID = 1
		
		SELECT		TOP 1 @CacheStatusTypeID					= CacheStatusTypeID			
		FROM		dbo.CacheStatusType a (NOLOCK)
		WHERE		a.Description								= @CacheType

		IF		( @CacheStatusTypeID IS NULL ) RETURN

		IF		EXISTS	(
							SELECT		TOP 1 1			
							FROM		dbo.CacheStatus a (NOLOCK)
							WHERE		a.SDBSourceID								= @SDBSourceID  
							AND			a.CacheStatusTypeID							= @CacheStatusTypeID
						)
		BEGIN
						UPDATE			dbo.CacheStatus 
						SET				UpdateDate									= b.LatestUpdateDate
						FROM			(
											SELECT		SDBSourceID, MAX(UpdateDate) AS LatestUpdateDate
											FROM		dbo.ChannelStatus 
											GROUP BY	SDBSourceID
										) b
						WHERE			CacheStatus.SDBSourceID						= b.SDBSourceID
						AND				CacheStatus.SDBSourceID						= @SDBSourceID
						AND				CacheStatusTypeID							= @CacheStatusTypeID
										
		END
		ELSE
		BEGIN
						INSERT			dbo.CacheStatus 
											(
												SDBSourceID,
												CacheStatusTypeID,
												CreateDate
											)
						SELECT			@SDBSourceID								AS SDBSourceID,
										@CacheStatusTypeID							AS CacheStatusTypeID,
										GETUTCDATE()								AS CreateDate
		END
		SET					@ErrorID												= 0		--SUCCESS

END


GO

