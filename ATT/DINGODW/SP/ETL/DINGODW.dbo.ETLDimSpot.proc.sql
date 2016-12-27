



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimSPOT'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimSPOT
GO


CREATE PROCEDURE [dbo].[ETLDimSPOT] 
							@RegionID			INT = NULL,
							@SDBSourceID		INT = NULL,
							@SDBName			VARCHAR(64) = NULL,
							@UTCOffset			INT = NULL,
							@StartingDate		DATE,
							@EndingDate			DATE
							--@Day				DATE = NULL
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
// Module:  dbo.ETLDimSPOT
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimSPOT.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimSPOT	
//												@RegionID			= NULL,
//												@SDBSourceID		= NULL,
//												@SDBName			= NULL,
//												@UTCOffset			= NULL,
//												@StartingDate		= '2014-06-01',
//												@EndingDate			= '2014-06-05'
//												--@Day				= ''
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@DimID														INT
							DECLARE				@DimName													VARCHAR(50) = 'SPOT'
							DECLARE				@InsertedRows												TABLE ( ID int identity(1,1), DimSpotID int, UTCSPOTDayOfYearPartitionKey int, UTCSPOTDate date, SDBSourceID int )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )	DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID int IDENTITY(1,1), DimID int, DimName varchar(50), DayOfYearPartitionKey int, UTCDate date, SDBSourceID int, TotalRecords int )

							SELECT				@DimID														= d.DimensionID
							FROM				dbo.Dimension d WITH (NOLOCK)
							WHERE				d.Name														= @DimName

							DECLARE				@SPParamValuesIN											UDT_VarChar500 
							DECLARE				@SDBIDIN													UDT_Int
							DECLARE				@ProcID														INT = @@PROCID --OBJECT_ID('ETLDimSPOT')
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
												ZoneName													VARCHAR(32) NULL,
												Spot_ID														INT NOT NULL,
												VIDEO_ID													VARCHAR(32) NULL,
												DURATION													INT NULL,
												CUSTOMER													VARCHAR(80) NULL,
												TITLE														VARCHAR(254) NULL,
												NSTATUS														INT NULL,
												CONFLICT_STATUS												INT NULL,
												RATE														FLOAT NULL,
												CODE														VARCHAR(12) NULL,
												NOTES														VARCHAR(254) NULL,
												SERIAL														VARCHAR(32) NULL,
												IDSpot														VARCHAR(32) NULL,
												IE_ID														INT NULL,
												Spot_ORDER													INT NULL,
												RUN_DATE_TIME												DATETIME NULL,
												RUN_LENGTH													INT NULL,
												VALUE														INT NULL,
												ORDER_ID													INT NULL,
												BONUS_FLAG													INT NULL,
												SOURCE_ID													INT NULL,
												TS															BINARY(8) NULL,

												NSTATUSValue 												VARCHAR(50) NULL,
												CONFLICT_STATUSValue 										VARCHAR(50) NULL,
												SOURCE_ID_INTERCONNECT_NAME									VARCHAR(32) NULL,
												IESCHED_DATE												DATE NOT NULL,
												IESCHED_DATE_TIME											DATETIME NOT NULL,
												IU_ID														INT NULL,
												NetworkID 													INT NULL,
												NetworkName 												VARCHAR(32) NULL,

												UTCSPOTDatetime												DATETIME,
												UTCSPOTDate													DATE,
												UTCSPOTDateYear												INT,
												UTCSPOTDateMonth											INT,
												UTCSPOTDateDay												INT,
												UTCSPOTDayOfYearPartitionKey								INT
											)



							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DateDay DATE, SDBSourceID INT )


							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DateDay,SDBSourceID )
							SELECT				d.DayOfYearPartitionKey, d.DateDay, d.SDBSourceID
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			UTCSPOTDayOfYearPartitionKey,UTCSPOTDate,SDBSourceID
												FROM			dbo.DimSpot  WITH (NOLOCK)
												GROUP BY		UTCSPOTDayOfYearPartitionKey,UTCSPOTDate,SDBSourceID
											) xs															ON		d.DateDay					= xs.UTCSPOTDate
																											AND		d.DayOfYearPartitionKey		= xs.UTCSPOTDayOfYearPartitionKey
																											AND		d.SDBSourceID				= xs.SDBSourceID
							WHERE				xs.UTCSPOTDayOfYearPartitionKey								IS NULL


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


												INSERT				dbo.DimSpot
																(
																	RegionID,
																	SDBSourceID,
																	SDBName,
																	UTCOffset,
																	ZoneName,
																	Spot_ID,
																	VIDEO_ID,
																	DURATION,
																	CUSTOMER,
																	TITLE,
																	NSTATUS,
																	NSTATUSValue,
																	CONFLICT_STATUS,
																	CONFLICT_STATUSValue,
																	RATE,
																	CODE,
																	NOTES,
																	SERIAL,
																	ID,
																	IE_ID,
																	Spot_ORDER,
																	RUN_DATE_TIME,
																	RUN_LENGTH,
																	VALUE,
																	ORDER_ID,
																	BONUS_FLAG,
																	SOURCE_ID,
																	TS,

																	--Derived columns for reporting purposes
																	IU_ID,
																	ChannelName,
																	UTCSPOTDatetime,
																	UTCSPOTDate,
																	UTCSPOTDateYear,
																	UTCSPOTDateMonth,
																	UTCSPOTDateDay,			
																	UTCSPOTDayOfYearPartitionKey,
																	SPOTDate,
																	SPOTDateYear,
																	SPOTDateMonth,
																	SPOTDateDay,
																	SPOTDayOfYearPartitionKey,
																	UTCIEDatetime,
																	UTCIEDate,
																	UTCIEDateYear,
																	UTCIEDateMonth,
																	UTCIEDateDay,			
																	UTCIEDayOfYearPartitionKey,
																	IEDatetime,
																	IEDate,
																	IEDateYear,
																	IEDateMonth,
																	IEDateDay,
																	IEDayOfYearPartitionKey,
																	DimSpotStatusID,
																	DimSpotConflictStatusID,	
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
												OUTPUT				INSERTED.DimSpotID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDate, INSERTED.SDBSourceID
												INTO				@InsertedRows
												SELECT				
																	RegionID													= x.RegionID,
																	SDBSourceID													= x.SDBSourceID,
																	SDBName														= x.SDBName,
																	UTCOffset													= x.UTCOffset,
																	ZoneName													= x.ZoneName,
																	Spot_ID														= x.Spot_ID,
																	VIDEO_ID													= x.VIDEO_ID,
																	DURATION													= x.DURATION,
																	CUSTOMER													= x.CUSTOMER,
																	TITLE														= x.TITLE,
																	NSTATUS														= x.NSTATUS,
																	NSTATUSValue												= x.NSTATUSValue,
																	CONFLICT_STATUS												= x.CONFLICT_STATUS,
																	CONFLICT_STATUSValue										= x.CONFLICT_STATUSValue,
																	RATE														= x.RATE,
																	CODE														= x.CODE,
																	NOTES														= x.NOTES,
																	SERIAL														= x.SERIAL,
																	ID															= x.IDSpot,
																	IE_ID														= x.IE_ID,
																	Spot_ORDER													= x.Spot_ORDER,
																	RUN_DATE_TIME												= x.RUN_DATE_TIME,
																	RUN_LENGTH													= x.RUN_LENGTH,
																	VALUE														= x.VALUE,
																	ORDER_ID													= x.ORDER_ID,
																	BONUS_FLAG													= x.BONUS_FLAG,
																	SOURCE_ID													= x.SOURCE_ID,
																	TS															= x.TS,

																	--Derived columns for reporting purposes
																	IU_ID														= iu.IU_ID,
																	ChannelName													= iu.ChannelName,
																	UTCSPOTDatetime												= x.UTCSPOTDatetime,
																	UTCSPOTDate													= x.UTCSPOTDate,
																	UTCSPOTDateYear												= x.UTCSPOTDateYear,
																	UTCSPOTDateMonth											= x.UTCSPOTDateMonth,
																	UTCSPOTDateDay												= x.UTCSPOTDateDay,			
																	UTCSPOTDayOfYearPartitionKey								= x.UTCSPOTDayOfYearPartitionKey,
																	SPOTDate													= CONVERT ( DATE,	x.RUN_DATE_TIME, 121 ),
																	SPOTDateYear												= DATEPART( YEAR,	x.RUN_DATE_TIME ),
																	SPOTDateMonth												= DATEPART( MONTH,	x.RUN_DATE_TIME ),
																	SPOTDateDay													= DATEPART( DAY,	x.RUN_DATE_TIME ),
																	SPOTDayOfYearPartitionKey									= DATEPART( DY,		x.RUN_DATE_TIME ),
																	UTCIEDatetime												= DATEADD ( HOUR,	x.UTCOffset, x.IESCHED_DATE_TIME ),
																	UTCIEDate													= CONVERT ( DATE,	(DATEADD( HOUR, -x.UTCOffset, x.IESCHED_DATE_TIME )), 121 ),
																	UTCIEDateYear												= DATEPART( YEAR,	(DATEADD( HOUR, -x.UTCOffset, x.IESCHED_DATE_TIME )) ),
																	UTCIEDateMonth												= DATEPART( MONTH,	(DATEADD( HOUR, -x.UTCOffset, x.IESCHED_DATE_TIME )) ),
																	UTCIEDateDay												= DATEPART( DAY,	(DATEADD( HOUR, -x.UTCOffset, x.IESCHED_DATE_TIME )) ),
																	UTCIEDayOfYearPartitionKey									= DATEPART( DY,		(DATEADD( HOUR, -x.UTCOffset, x.IESCHED_DATE_TIME )) ),
																	IEDatetime													= x.IESCHED_DATE_TIME,
																	IEDate														= CONVERT ( DATE,	x.IESCHED_DATE, 121 ),
																	IEDateYear													= DATEPART( YEAR,	x.IESCHED_DATE ),
																	IEDateMonth													= DATEPART( MONTH,	x.IESCHED_DATE ),
																	IEDateDay													= DATEPART( DAY,	x.IESCHED_DATE ),
																	IEDayOfYearPartitionKey										= DATEPART( DY,		x.IESCHED_DATE ),
																	DimSpotStatusID												= SS.DimSpotStatusID,
																	DimSpotConflictStatusID										= SCS.DimSpotConflictStatusID,	
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
												JOIN				#DayOfYearPartitionSubset d									ON		x.UTCSPOTDayOfYearPartitionKey	= d.DayOfYearPartitionKey
																																AND		x.UTCSPOTDate					= d.DateDay
												LEFT JOIN			dbo.DimIU iu WITH (NOLOCK)									ON		x.UTCSPOTDayOfYearPartitionKey	= iu.UTCIEDayOfYearPartitionKey
																																AND		x.UTCSPOTDate					= iu.UTCIEDate
																																AND		x.RegionID						= iu.RegionID
																																AND		x.IU_ID							= iu.IU_ID
												LEFT JOIN			dbo.DimSpotStatus SS WITH (NOLOCK)							ON		SS.SpotStatusID 				= x.NSTATUS
																																AND		SS.SpotStatusValue 				= x.NSTATUSValue
												LEFT JOIN			dbo.DimSpotConflictStatus SCS WITH (NOLOCK)					ON		SCS.SpotConflictStatusID 		= x.CONFLICT_STATUS
																																AND		SCS.SpotConflictStatusValue		= x.CONFLICT_STATUSValue
												ORDER BY			x.IESCHED_DATE, x.RUN_DATE_TIME


												INSERT				#TotalCountByDay ( DimID, DimName, DayOfYearPartitionKey, UTCDate, SDBSourceID, TotalRecords )
												SELECT				DimID														= @DimID,
																	DimName														= @DimName,
																	DayOfYearPartitionKey										= x.UTCSPOTDayOfYearPartitionKey, 
																	UTCDate														= x.UTCSPOTDate, 
																	SDBSourceID													= x.SDBSourceID, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCSPOTDayOfYearPartitionKey, x.UTCSPOTDate, x.SDBSourceID

												--					Uses temp table #TotalCountByDay
												EXEC				dbo.SaveDimRecordCount	


							COMMIT

							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#tmp_AllSpots
							DROP TABLE			#TotalCountByDay


END

GO