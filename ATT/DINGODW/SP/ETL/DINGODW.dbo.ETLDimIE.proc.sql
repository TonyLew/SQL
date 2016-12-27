



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimIE'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimIE
GO

CREATE PROCEDURE [dbo].[ETLDimIE] 
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
// Module:  dbo.ETLDimIE
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimIE.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimIE	
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
							DECLARE				@DimName													VARCHAR(50) = 'IE'
							DECLARE				@InsertedRows												TABLE ( ID int identity(1,1), DimIEID int, UTCIEDayOfYearPartitionKey int, UTCIEDate date, SDBSourceID int )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )	DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID int IDENTITY(1,1), DimID int, DimName varchar(50), DayOfYearPartitionKey int, UTCDate date, SDBSourceID int, TotalRecords int )

							SELECT				@DimID														= d.DimensionID
							FROM				dbo.Dimension d WITH (NOLOCK)
							WHERE				d.Name														= @DimName


							DECLARE				@SPParamValuesIN											UDT_VarChar500 
							DECLARE				@SDBIDIN													UDT_Int
							DECLARE				@ProcID														INT = @@PROCID --OBJECT_ID('ETLDimIE')
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
												ZoneName 													VARCHAR(32) NULL,
												TSI 														VARCHAR(32) NULL,
												ChannelName 												VARCHAR(32) NULL,
												SCHED_DATE_TIME 											DATETIME NULL,
												IE_ID 														INT NOT NULL,
												IU_ID 														INT NULL,
												NSTATUS 													INT NULL,
												CONFLICT_STATUS 											INT NULL,
												SPOTS														INT NULL,
												DURATION 													INT NULL,
												RUN_DATE_TIME 												DATETIME NULL,
												SOURCE_ID 													INT NOT NULL,
												TB_TYPE 													INT NOT NULL,

												START_TRIGGER 												CHAR(5) NULL,
												END_TRIGGER 												CHAR(5) NULL,
												AWIN_START 													INT NULL,
												AWIN_END 													INT NULL,
												VALUE 														INT NULL,
												BREAK_INWIN 												INT NULL,
												AWIN_START_DT 												DATETIME NULL,
												AWIN_END_DT 												DATETIME NULL,
												EVENT_ID 													INT NULL,
												TS 															BINARY(8) NOT NULL,

												NSTATUSValue 												VARCHAR(50) NULL,
												CONFLICT_STATUSValue 										VARCHAR(50) NULL,
												SOURCE_IDName												VARCHAR(32) NOT NULL,
												TB_TYPEName													VARCHAR(32) NOT NULL,
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
												FROM			dbo.DimIE  WITH (NOLOCK)
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


												INSERT				dbo.DimIE
																(
																	RegionID,
																	SDBSourceID,
																	SDBName,
																	UTCOffset,
																	ZoneName,
																	TSI,
																	ChannelName,
																	SCHED_DATE_TIME,
																	IE_ID,
																	IU_ID,
																	NSTATUS,
																	NSTATUSValue,
																	CONFLICT_STATUS,
																	CONFLICT_STATUSValue,
																	SPOTS,
																	DURATION,
																	RUN_DATE_TIME,
																	SOURCE_ID,
																	SOURCE_IDName,
																	TB_TYPE,
																	TB_TYPEName,
																	START_TRIGGER,
																	END_TRIGGER,
																	AWIN_START,
																	AWIN_END,
																	VALUE,
																	BREAK_INWIN,
																	AWIN_START_DT,
																	AWIN_END_DT,
																	EVENT_ID,
																	TS,

																	--Derived columns for reporting purposes
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
																	DimIEStatusID,
																	DimIEConflictStatusID,	
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
												OUTPUT				INSERTED.DimIEID, INSERTED.UTCIEDayOfYearPartitionKey, INSERTED.UTCIEDate, INSERTED.SDBSourceID
												INTO				@InsertedRows
												SELECT				
																	RegionID													= x.RegionID,
																	SDBSourceID													= x.SDBSourceID,
																	SDBName														= x.SDBName,
																	UTCOffset													= x.UTCOffset,
																	ZoneName													= x.ZoneName,
																	TSI															= x.TSI,
																	ChannelName													= iu.ChannelName,
																	SCHED_DATE_TIME												= x.SCHED_DATE_TIME,
																	IE_ID														= x.IE_ID,
																	IU_ID														= x.IU_ID,
																	NSTATUS														= x.NSTATUS,
																	NSTATUSValue												= x.NSTATUSValue,
																	CONFLICT_STATUS												= x.CONFLICT_STATUS,
																	CONFLICT_STATUSValue										= x.CONFLICT_STATUSValue,
																	SPOTS														= x.SPOTS,
																	DURATION													= x.DURATION,
																	RUN_DATE_TIME												= x.RUN_DATE_TIME,
																	SOURCE_ID													= x.SOURCE_ID,
																	SOURCE_IDName												= x.SOURCE_IDName,
																	TB_TYPE														= x.TB_TYPE,
																	TB_TYPEName													= x.TB_TYPEName,
																	START_TRIGGER 												= x.START_TRIGGER,
																	END_TRIGGER 												= x.END_TRIGGER,
																	AWIN_START 													= x.AWIN_START,
																	AWIN_END 													= x.AWIN_END,
																	VALUE 														= x.VALUE,
																	BREAK_INWIN 												= x.BREAK_INWIN,
																	AWIN_START_DT 												= x.AWIN_START_DT,
																	AWIN_END_DT 												= x.AWIN_END_DT,
																	EVENT_ID 													= x.EVENT_ID,
																	TS 															= x.TS,

																	--Derived columns for reporting purposes
																	UTCIEDatetime												= x.UTCIEDatetime,
																	UTCIEDate													= x.UTCIEDate,
																	UTCIEDateYear												= x.UTCIEDateYear,
																	UTCIEDateMonth												= x.UTCIEDateMonth,
																	UTCIEDateDay												= x.UTCIEDateDay,
																	UTCIEDayOfYearPartitionKey									= x.UTCIEDayOfYearPartitionKey,
																	IEDate														= CONVERT ( DATE,	x.SCHED_DATE_TIME, 121 ),
																	IEDateYear													= DATEPART( YEAR,	x.SCHED_DATE_TIME ),
																	IEDateMonth													= DATEPART( MONTH,	x.SCHED_DATE_TIME ),
																	IEDateDay													= DATEPART( DAY,	x.SCHED_DATE_TIME ),
																	IEDayOfYearPartitionKey										= DATEPART( DY,		x.SCHED_DATE_TIME ),
																	DimIEStatusID												= IES.DimIEStatusID,
																	DimIEConflictStatusID										= IECS.DimIEConflictStatusID,	
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
												LEFT JOIN			dbo.DimIEStatus IES WITH (NOLOCK) 							ON		x.NSTATUS						= IES.IEStatusID
																																AND		x.NSTATUSValue					= IES.IEStatusValue
												LEFT JOIN			dbo.DimIEConflictStatus IECS WITH (NOLOCK)					ON		x.CONFLICT_STATUS				= IECS.IEConflictStatusID
																																AND		x.CONFLICT_STATUSValue			= IECS.IEConflictStatusValue
												ORDER BY			x.SCHED_DATE_TIME


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

