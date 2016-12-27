



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimAsset'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimAsset
GO

CREATE PROCEDURE dbo.ETLDimAsset 
							@RegionID			INT = NULL,
							@SDBSourceID		INT = NULL,
							@SDBName			VARCHAR(64) = NULL,
							@UTCOffset			INT = NULL,
							@Override			BIT = 0
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
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimAsset table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimAsset.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimAsset	
//												@RegionID				= 1,
//												@SDBSourceID			= 1,
//												@SDBName				= '',
//												@UTCOffset				= 1,
//												@LastVideoID			= NULL
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@DimID														INT
							DECLARE				@DimName													VARCHAR(50) = 'Asset'
							DECLARE				@InsertedRows												TABLE ( ID int identity(1,1), DimAssetID int, RegionID int )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )	DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID int IDENTITY(1,1), DimID int, DimName varchar(50), DayOfYearPartitionKey int, UTCDate date, SDBSourceID int, TotalRecords int )

							SELECT				@DimID														= d.DimensionID
							FROM				dbo.Dimension d WITH (NOLOCK)
							WHERE				d.Name														= @DimName

							DECLARE				@SPParamValuesIN											UDT_VarChar500 
							DECLARE				@SDBIDIN													UDT_Int
							DECLARE				@ProcID														INT = @@PROCID --OBJECT_ID('ETLDimIE')
							DECLARE				@Now														DATETIME = GETUTCDATE()

							--Create a tmp table to store the data from each SDB. We're grabbing/storing the statuses as codes and joining to status tables locally.
							IF					OBJECT_ID('tempdb..#tmp_AllSpots') IS NOT NULL				DROP TABLE #tmp_AllSpots
							CREATE TABLE		#tmp_AllSpots 
											(
												ID															INT IDENTITY(1,1),
												RegionID													INT NOT NULL,
												SDBSourceID													INT NOT NULL,
												SDBName														VARCHAR(64) NOT NULL,
												UTCOffset													INT NOT NULL,
												AssetID 													VARCHAR(32) NOT NULL,
												VIDEO_ID 													VARCHAR(32) NOT NULL,
												FRAMES	 													INT NULL,
												CODE 														VARCHAR(65) NULL,
												DESCRIPTION													VARCHAR(65) NULL,
												VALUE 														INT NULL,
												FPS 														INT NULL,
												Length	 													INT NULL
											)


							IF					NOT EXISTS(SELECT TOP 1 1 FROM dbo.DimAsset WITH (NOLOCK) ORDER BY DimAssetID DESC)
												SELECT		@Override			= 1

							INSERT				@SPParamValuesIN (Value ) VALUES ( CAST( @Override AS VARCHAR(500)) )

							EXEC				dbo.ETLAllSpotExecute			
														@ParentProcID			= @ProcID, 
														@SPParamValues			= @SPParamValuesIN, 
														@SDBID					= @SDBIDIN
							

							BEGIN TRAN


												INSERT				dbo.DimAsset 
																( 
																	RegionID,
																	AssetID,
																	VIDEO_ID,
																	SDBSourceID,
																	FRAMES,
																	CODE,
																	DESCRIPTION,
																	VALUE,
																	FPS,
																	Length,
																	CreateDate
																) 
												OUTPUT				INSERTED.DimAssetID,  INSERTED.RegionID 
												INTO				@InsertedRows
												SELECT				RegionID													= t.RegionID,
																	AssetID														= t.AssetID,
																	VIDEO_ID													= t.VIDEO_ID,
																	SDBSourceID													= 0,
																	FRAMES														= MAX(t.FRAMES),
																	CODE														= MAX(t.CODE),
																	DESCRIPTION													= MAX(t.DESCRIPTION),
																	VALUE														= MAX(t.VALUE),
																	FPS															= MAX(t.FPS),
																	Length														= MAX(t.Length),
																	CreateDate													= @Now
												FROM				#tmp_AllSpots t 
												LEFT JOIN			dbo.DimAsset d
												ON					t.RegionID													= d.RegionID
												AND					t.AssetID													= d.AssetID
												WHERE				d.DimAssetID												IS NULL
												GROUP BY			t.RegionID, t.AssetID, t.VIDEO_ID
												ORDER BY			t.RegionID, t.AssetID, t.VIDEO_ID


												--					This is a dimension that is distinct by RegionID as opposed to SDBSourceID.  
												--					So it is recorded by RegionID in the dbo.CountDimensionDate table.
												INSERT				#TotalCountByDay ( DimID, DimName, DayOfYearPartitionKey, UTCDate, SDBSourceID, TotalRecords )
												SELECT				DimID														= @DimID,
																	DimName														= @DimName,
																	DayOfYearPartitionKey										= DATEPART( DAYOFYEAR,@Now ), 
																	UTCDate														= CONVERT( DATE,@Now,121 ), 
																	SDBSourceID													= s.SDBSourceID, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												JOIN				dbo.DimSDBSource s WITH (NOLOCK)
												ON					x.RegionID 													= s.RegionID 
												WHERE				s.Enabled													= 1
												GROUP BY			s.SDBSourceID


												--					Uses temp table #TotalCountByDay
												EXEC				dbo.SaveDimRecordCount	


							COMMIT

							DROP TABLE			#tmp_AllSpots
							DROP TABLE			#TotalCountByDay


END
GO


