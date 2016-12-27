



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimTB_REQUEST'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimTB_REQUEST
GO

CREATE PROCEDURE [dbo].[ETLDimTB_REQUEST] 
							@RegionID			INT = NULL,
							@SDBSourceID		INT = NULL,
							@SDBName			VARCHAR(64) = NULL,
							@UTCOffset			INT = NULL,
							@StartingDate		DATE,
							@EndingDate			DATE
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
// Module:  dbo.ETLDimTB_REQUEST
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimTB_REQUEST.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimTB_REQUEST	
//												@RegionID			= NULL,
//												@SDBSourceID		= NULL,
//												@SDBName			= NULL,
//												@UTCOffset			= NULL,
//												@StartingDate		= '2014-06-01',
//												@EndingDate			= '2014-06-05'
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON


							DECLARE				@DimID														INT
							DECLARE				@DimName													VARCHAR(50) = 'TB_REQUEST'
							DECLARE				@InsertedRows												TABLE ( ID int identity(1,1), DimTB_REQUESTID int, UTCIEDayOfYearPartitionKey int, UTCIEDate date, SDBSourceID int )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )	DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID int IDENTITY(1,1), DimID int, DimName varchar(50), DayOfYearPartitionKey int, UTCDate date, SDBSourceID int, TotalRecords int )

							SELECT				@DimID														= d.DimensionID
							FROM				dbo.Dimension d WITH (NOLOCK)
							WHERE				d.Name														= @DimName

							DECLARE				@SPParamValuesIN											UDT_VarChar500 
							DECLARE				@SDBIDIN													UDT_Int
							DECLARE				@ProcID														INT = @@PROCID --OBJECT_ID('ETLDimTB_REQUEST')
							DECLARE				@TotalSDB													INT

							--Create a tmp table to store the data from each SDB. We're grabbing/storing the statuses as codes and joining to status tables locally.
							IF					OBJECT_ID('tempdb..#tmp_AllSpots') IS NOT NULL DROP TABLE #tmp_AllSpots
							CREATE TABLE		#tmp_AllSpots 
											(
												ID															INT IDENTITY(1,1),
												RegionID													INT NOT NULL,
												SDBSourceID 												INT NOT NULL,
												SDBName 													VARCHAR(64) NOT NULL,
												UTCOffset 													INT NOT NULL,
												TB_ID														INT NOT NULL,
												ZONE_ID														INT NOT NULL,
												IU_ID														INT NOT NULL,
												TB_REQUEST													INT NOT NULL,
												TB_MODE														INT NOT NULL,
												TB_TYPE														INT NULL,
												TB_DAYPART													DATETIME NOT NULL,
												TB_FILE														VARCHAR(128) NOT NULL,
												TB_FILE_DATE												DATETIME NOT NULL,
												STATUS														INT NOT NULL,
												EXPLANATION													VARCHAR(128) NULL,
												TB_MACHINE													VARCHAR(32) NULL,
												TB_MACHINE_TS												DATETIME NULL,
												TB_MACHINE_THREAD											INT NULL,
												REQUESTING_MACHINE											VARCHAR(32) NULL,
												REQUESTING_PORT												INT NULL,
												SOURCE_ID													INT NOT NULL,
												MSGNR														INT NULL,
												TS															BINARY(8) NOT NULL,

												--Derived Columns
												ZoneName													VARCHAR(32) NOT NULL,
												TB_MODE_NAME												VARCHAR(32) NOT NULL,
												REQUEST_NAME												VARCHAR(32) NOT NULL,
												SOURCE_ID_NAME												VARCHAR(32) NOT NULL,
												STATUS_NAME													VARCHAR(32) NOT NULL,
												TYPE_NAME													VARCHAR(32) NOT NULL,
												DAYPART_DATE												DATE NOT NULL,
												DAYPART_DATE_TIME											DATETIME NOT NULL,
												NetworkID 													INT NULL,
												NetworkName 												VARCHAR(32) NULL,

												UTCIEDatetime												DATETIME,
												UTCIEDate													DATE,
												UTCIEDateYear												INT,
												UTCIEDateMonth												INT,
												UTCIEDateDay												INT,
												UTCIEDayOfYearPartitionKey									INT

											)


							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DateDay DATE, SDBSourceID INT )


							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DateDay,SDBSourceID )
							SELECT				d.DayOfYearPartitionKey, d.DateDay, d.SDBSourceID
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			UTCIEDayOfYearPartitionKey,UTCIEDate,SDBSourceID
												FROM			dbo.DimTB_REQUEST  WITH (NOLOCK)
												GROUP BY		UTCIEDayOfYearPartitionKey,UTCIEDate,SDBSourceID
											) xs															ON		d.DateDay					= xs.UTCIEDate
																											AND		d.DayOfYearPartitionKey		= xs.UTCIEDayOfYearPartitionKey
																											AND		d.SDBSourceID				= xs.SDBSourceID
							WHERE				xs.UTCIEDayOfYearPartitionKey								IS NULL


							--					Populate the temp table #tmp_AllSpots ONLY from SDB sources where we do not have any data for the specified date range
							INSERT				@SDBIDIN ( Value )
							SELECT				DISTINCT sdb.SDBSourceID
							FROM				#DayOfYearPartitionSubset sdb WITH (NOLOCK)
							SELECT				@TotalSDB													= SCOPE_IDENTITY()


							--					Exit if there are NO SDB's that need to be queried.
							IF					( ISNULL(@TotalSDB,0) <= 0  ) RETURN


							INSERT				@SPParamValuesIN (Value ) VALUES ( CAST( @StartingDate AS VARCHAR(500)) )
							INSERT				@SPParamValuesIN (Value ) VALUES ( CAST( @EndingDate AS VARCHAR(500)) )


							EXEC				dbo.ETLAllSpotExecute			
														@ParentProcID			= @ProcID, 
														@SPParamValues			= @SPParamValuesIN, 
														@SDBID					= @SDBIDIN



							BEGIN TRAN

												INSERT				dbo.DimTB_REQUEST 
																(
																	RegionID,
																	SDBSourceID,
																	SDBName,
																	UTCOffset,
																	TB_ID,
																	ZONE_ID,
																	IU_ID,
																	TB_REQUEST,
																	TB_MODE,
																	TB_TYPE,
																	TB_DAYPART,
																	TB_FILE,
																	TB_FILE_DATE,
																	STATUS,
																	EXPLANATION,
																	TB_MACHINE,
																	TB_MACHINE_TS,
																	TB_MACHINE_THREAD,
																	REQUESTING_MACHINE,
																	REQUESTING_PORT,
																	SOURCE_ID,
																	MSGNR,
																	TS,

																	ZoneName,
																	TB_MODE_NAME,
																	REQUEST_NAME,
																	SOURCE_ID_NAME,
																	STATUS_NAME,
																	TYPE_NAME,

																	--Derived columns for reporting purposes
																	UTCTB_FILE_DATE,
																	UTCTB_FILE_DATE_TIME,
																	UTCIEDatetime,
																	UTCIEDate,
																	UTCIEDateYear,
																	UTCIEDateMonth,
																	UTCIEDateDay,			
																	UTCIEDayOfYearPartitionKey,
																	IEDate,
																	IEDateYear,
																	IEDateMonth,
																	IEDateDay,
																	IEDayOfYearPartitionKey,
																	RegionName,
																	MDBSourceID,
																	MDBName,
																	MarketID,
																	MarketName,
																	ICProviderID,
																	ICProviderName,
																	ROCID,
																	ROCName,
																	NetworkID,
																	NetworkName,
																	CreateDate
																)
												OUTPUT				INSERTED.DimTB_REQUESTID, INSERTED.UTCIEDayOfYearPartitionKey, INSERTED.UTCIEDate, INSERTED.SDBSourceID
												INTO				@InsertedRows
												SELECT				
																	RegionID													= x.RegionID,
																	SDBSourceID													= x.SDBSourceID,
																	SDBName														= x.SDBName,
																	UTCOffset													= x.UTCOffset,
																	TB_ID														= x.TB_ID,
																	ZONE_ID														= x.ZONE_ID,
																	IU_ID														= x.IU_ID,
																	TB_REQUEST													= x.TB_REQUEST,
																	TB_MODE														= x.TB_MODE,
																	TB_TYPE														= x.TB_TYPE,
																	TB_DAYPART													= x.TB_DAYPART,
																	TB_FILE														= x.TB_FILE,
																	TB_FILE_DATE												= x.TB_FILE_DATE,
																	STATUS														= x.STATUS,
																	EXPLANATION													= x.EXPLANATION,
																	TB_MACHINE													= x.TB_MACHINE,
																	TB_MACHINE_TS												= x.TB_MACHINE_TS,
																	TB_MACHINE_THREAD											= x.TB_MACHINE_THREAD,
																	REQUESTING_MACHINE											= x.REQUESTING_MACHINE,
																	REQUESTING_PORT												= x.REQUESTING_PORT,
																	SOURCE_ID													= x.SOURCE_ID,
																	MSGNR														= x.MSGNR,
																	TS															= x.TS,

																	ZoneName													= x.ZoneName,
																	TB_MODE_NAME												= x.TB_MODE_NAME,
																	REQUEST_NAME												= x.REQUEST_NAME,
																	SOURCE_ID_NAME												= x.SOURCE_ID_NAME,
																	STATUS_NAME													= x.STATUS_NAME,
																	TYPE_NAME													= x.TYPE_NAME,

																	--Derived columns for reporting purposes
																	UTCTB_FILE_DATE												= CONVERT ( DATE,	(DATEADD( HOUR, -x.UTCOffset, x.DAYPART_DATE_TIME )), 121 ),
																	UTCTB_FILE_DATE_TIME										= DATEADD ( HOUR,	x.UTCOffset, x.TB_FILE_DATE ),
																	UTCIEDatetime												= x.UTCIEDatetime,
																	UTCIEDate													= x.UTCIEDate,
																	UTCIEDateYear												= x.UTCIEDateYear,
																	UTCIEDateMonth												= x.UTCIEDateMonth,
																	UTCIEDateDay												= x.UTCIEDateDay,
																	UTCIEDayOfYearPartitionKey									= x.UTCIEDayOfYearPartitionKey,
																	IEDate														= CONVERT ( DATE,	x.DAYPART_DATE, 121 ),
																	IEDateYear													= DATEPART( YEAR,	x.DAYPART_DATE ),
																	IEDateMonth													= DATEPART( MONTH,	x.DAYPART_DATE ),
																	IEDateDay													= DATEPART( DAY,	x.DAYPART_DATE ),
																	IEDayOfYearPartitionKey										= DATEPART( DY,		x.DAYPART_DATE ),
																	RegionName													= ISNULL(iu.RegionName,''),
																	MDBSourceID													= ISNULL(iu.MDBSourceID, 0),
																	MDBName														= ISNULL(iu.MDBName,''),
																	MarketID													= ISNULL(iu.MarketID, 0),
																	MarketName													= ISNULL(iu.MarketName,''),
																	ICProviderID  												= ISNULL(iu.ICProviderID, 0),
																	ICProviderName 												= ISNULL(iu.ICProviderName,''),
																	ROCID 														= ISNULL(iu.ROCID, 0),
																	ROCName														= ISNULL(iu.ROCName,''),
																	NetworkID													= ISNULL(iu.NetworkID, 0),
																	NetworkName													= ISNULL(iu.NetworkName,''),
																	CreateDate													= GETUTCDATE()
												FROM				#tmp_AllSpots x
												JOIN				#DayOfYearPartitionSubset d									ON		x.UTCIEDayOfYearPartitionKey	= d.DayOfYearPartitionKey
																																AND		x.UTCIEDate						= d.DateDay
												LEFT JOIN			dbo.DimIU iu WITH (NOLOCK)									ON		x.UTCIEDayOfYearPartitionKey	= iu.UTCIEDayOfYearPartitionKey
																																AND		x.UTCIEDate						= iu.UTCIEDate
																																AND		x.RegionID						= iu.RegionID
																																AND		x.IU_ID							= iu.IU_ID
												ORDER BY			x.DAYPART_DATE, x.TB_DAYPART


												INSERT				#TotalCountByDay ( DimID, DimName, DayOfYearPartitionKey, UTCDate, SDBSourceID, TotalRecords )
												SELECT				DimID														= @DimID,
																	DimName														= @DimName,
																	DayOfYearPartitionKey										= x.UTCIEDayOfYearPartitionKey, 
																	UTCDate														= x.UTCIEDate, 
																	SDBSourceID													= x.SDBSourceID, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCIEDayOfYearPartitionKey, x.UTCIEDate, x.SDBSourceID

												--					Uses temp table #TotalCountByDay
												EXEC				dbo.SaveDimRecordCount	

							COMMIT

							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#tmp_AllSpots
							DROP TABLE			#TotalCountByDay

END

GO
