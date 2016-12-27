



USE MPEG
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimAsset'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimAsset
GO

CREATE PROCEDURE dbo.ETLDimAsset 
								@RegionID			INT,
								@SDBSourceID		INT,
								@SDBName			VARCHAR(64),
								@UTCOffset			INT,
								@Override			BIT
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
// Module:  dbo.ETLDimAsset
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ETLDimAsset.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//								EXEC			dbo.ETLDimAsset	
//													@RegionID			= 1,
//													@SDBSourceID		= 1,
//													@SDBName			= '',
//													@UTCOffset			= 1,
//													@Override			= 0
//
*/ 
BEGIN


								SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
								SET				NOCOUNT ON


								IF				(@Override = 1) 
								BEGIN


												SELECT			RegionID								= @RegionID,
																SDBSourceID								= @SDBSourceID,
																SDBName									= @SDBName,
																UTCOffset								= @UTCOffset,
																AssetID									= v.VIDEO_ID,
																VIDEO_ID								= v.VIDEO_ID,
																FRAMES									= v.FRAMES,
																CODE									= v.CODE,
																DESCRIPTION								= v.DESCRIPTION,
																VALUE									= v.VALUE,
																FPS										= v.FPS,
																Length									= CASE WHEN ISNULL(v.FPS,0) <> 0 THEN v.FRAMES/v.FPS ELSE 1 END
												FROM			dbo.VIDEO v WITH (NOLOCK)


								END
								ELSE			IF				(OBJECT_ID('cdc.dbo_VIDEO_CT') IS NOT NULL) --SELECT 'EXISTENT'
								BEGIN


												SELECT			RegionID								= @RegionID,
																SDBSourceID								= @SDBSourceID,
																SDBName									= @SDBName,
																UTCOffset								= @UTCOffset,
																AssetID									= v.VIDEO_ID,
																VIDEO_ID								= v.VIDEO_ID,
																FRAMES									= v.FRAMES,
																CODE									= v.CODE,
																DESCRIPTION								= v.DESCRIPTION,
																VALUE									= v.VALUE,
																FPS										= v.FPS,
																Length									= CASE WHEN ISNULL(v.FPS,0) <> 0 THEN v.FRAMES/v.FPS ELSE 1 END
												FROM			cdc.dbo_VIDEO_CT v WITH (NOLOCK)


								END
								ELSE			IF				NOT EXISTS	( 
																				SELECT	TOP 1 1
																				FROM	cdc.change_tables ct
																				JOIN	sysobjects o	ON ct.source_object_id = o.id
																				WHERE	name			= 'VIDEO'
																			) 
																AND			(OBJECT_ID('dbo.VIDEO') IS NOT NULL) 
								BEGIN

																EXEC sys.sp_cdc_enable_table
																		@source_schema					= N'dbo',
																		@source_name   					= N'VIDEO',
																		@role_name    					= NULL,
																		@supports_net_changes 			= 1

								END




END
GO

