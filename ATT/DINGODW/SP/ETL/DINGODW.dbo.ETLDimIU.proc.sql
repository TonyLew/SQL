



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimIU'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimIU
GO

CREATE PROCEDURE [dbo].[ETLDimIU] 
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
// Module:  dbo.ETLDimIU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimIU.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimIU	
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


							DECLARE				@IUDimID													INT
							DECLARE				@IUDimName													VARCHAR(50) = 'IU'
							DECLARE				@ChannelMapDimID											INT
							DECLARE				@ChannelMapDimName											VARCHAR(50) = 'ChannelMap'
							DECLARE				@IUInsertedRows												TABLE ( ID int identity(1,1), DimIUID bigint, IU_ID int, UTCIEDayOfYearPartitionKey int, UTCIEDate date, SDBSourceID int, RegionID int )
							DECLARE				@ChannelMapInsertedRows										TABLE ( ID int identity(1,1), DimChannelMapID bigint, IU_ID int, RegionID int )
							DECLARE				@LatestDayOfYearPartitionKey								INT = DATEPART( DAYOFYEAR,@EndingDate )
							DECLARE				@LatestDate													DATE = @EndingDate


							IF					( ISNULL(OBJECT_ID('tempdb..#ChannelMap'), 0) > 0 )	DROP TABLE #ChannelMap
							CREATE TABLE		#ChannelMap 
														( 
																ID int IDENTITY(1,1), 
																IU_ID int, 
																Channel varchar(12),
																ChannelName varchar(40),
																ZoneName varchar(50),
																RegionID int, 
																RegionName varchar(50), 
																NetworkID int, 
																NetworkName varchar(50), 
																MarketID int, 
																MarketName varchar(50), 
																ICProviderID int, 
																ICProviderName varchar(50), 
																ROCID int, 
																ROCName varchar(50)
														)



							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )	DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID int IDENTITY(1,1), DimID int, DimName varchar(50), DayOfYearPartitionKey int, UTCDate date, SDBSourceID int, TotalRecords int )

							SELECT				@IUDimID													= d.DimensionID
							FROM				dbo.Dimension d WITH (NOLOCK)
							WHERE				d.Name														= @IUDimName

							SELECT				@ChannelMapDimID											= d.DimensionID
							FROM				dbo.Dimension d WITH (NOLOCK)
							WHERE				d.Name														= @ChannelMapDimName

							DECLARE				@SPParamValuesIN											UDT_VarChar500 
							DECLARE				@SDBIDIN													UDT_Int
							DECLARE				@ProcID														INT = @@PROCID --OBJECT_ID('ETLDimIU')
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
												IU_ID 														INT NOT NULL,
												ZoneName													VARCHAR(32) NOT NULL,
												CHANNEL														VARCHAR(12) NOT NULL,
												CHAN_NAME													VARCHAR(32) NOT NULL,
												ChannelName													VARCHAR(32) NOT NULL,
												DELAY 														INT NOT NULL,
												START_TRIGGER												CHAR(5) NOT NULL,
												END_TRIGGER													CHAR(5) NOT NULL,
												AWIN_START 													INT NULL,
												AWIN_END 													INT NULL,
												VALUE														INT NULL,
												MASTER_NAME													VARCHAR(32) NULL,
												COMPUTER_NAME												VARCHAR(32) NULL,
												PARENT_ID													INT NULL,
												SYSTEM_TYPE													INT NULL,
												COMPUTER_PORT 												INT NOT NULL,
												MIN_DURATION 												INT NOT NULL,
												MAX_DURATION 												INT NOT NULL,
												START_OF_DAY												CHAR(8) NOT NULL,
												RESCHEDULE_WINDOW											INT NOT NULL,
												IC_CHANNEL													VARCHAR(12) NULL,
												VSM_SLOT													INT NULL,
												DECODER_PORT												INT NULL,
												TC_ID														INT NULL,
												IGNORE_VIDEO_ERRORS											INT NULL,
												IGNORE_AUDIO_ERRORS											INT NULL,
												COLLISION_DETECT_ENABLED									INT NULL,
												TALLY_NORMALLY_HIGH											INT NULL,
												PLAY_OVER_COLLISIONS										INT NULL,
												PLAY_COLLISION_FUDGE										INT NULL,
												TALLY_COLLISION_FUDGE										INT NULL,
												TALLY_ERROR_FUDGE											INT NULL,
												LOG_TALLY_ERRORS											INT NULL,
												TBI_START													DATETIME NULL,
												TBI_END														DATETIME NULL,
												CONTINUOUS_PLAY_FUDGE										INT NULL,
												TONE_GROUP													VARCHAR(64) NULL,
												IGNORE_END_TONES											INT NULL,
												END_TONE_FUDGE												INT NULL,
												MAX_AVAILS													INT NULL,
												RESTART_TRIES												INT NULL,
												RESTART_BYTE_SKIP											INT NULL,
												RESTART_TIME_REMAINING										INT NULL,
												GENLOCK_FLAG												INT NULL,
												SKIP_HEADER													INT NULL,
												GPO_IGNORE													INT NULL,
												GPO_NORMAL													INT NULL,
												GPO_TIME													INT NULL,
												DECODER_SHARING												INT NULL,
												HIGH_PRIORITY												INT NULL,
												SPLICER_ID													INT NULL,
												PORT_ID														INT NULL,
												VIDEO_PID													INT NULL,
												SERVICE_PID													INT NULL,
												DVB_CARD													INT NULL,
												SPLICE_ADJUST												INT NOT NULL,
												POST_BLACK													INT NOT NULL,
												SWITCH_CNT													INT NULL,
												DECODER_CNT													INT NULL,
												DVB_CARD_CNT												INT NULL,
												DVB_PORTS_PER_CARD											INT NULL,
												DVB_CHAN_PER_PORT											INT NULL,
												USE_ISD														INT NULL,
												NO_NETWORK_VIDEO_DETECT										INT NULL,
												NO_NETWORK_PLAY												INT NULL,
												IP_TONE_THRESHOLD											INT NULL,
												USE_GIGE													INT NULL,
												GIGE_IP														VARCHAR(24) NULL,
												IS_ACTIVE_IND												BIT NOT NULL,
												SYSTEM_TYPEName												VARCHAR(64) NULL,
												IESCHED_DATE												DATE NOT NULL,
												IESCHED_DATE_TIME											DATETIME NOT NULL,
												NETWORKID													INT NULL,
												NETWORKNAME													VARCHAR(32) NULL,

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
												FROM			dbo.DimIU  WITH (NOLOCK)
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
														@ParentProcID					= @ProcID, 
														@SPParamValues					= @SPParamValuesIN, 
														@SDBID							= @SDBIDIN


							INSERT				#ChannelMap 
											( 
												IU_ID, 
												Channel,
												ChannelName, 
												RegionID, 
												RegionName,
												NetworkID,
												NetworkName,
												ZoneName,
												MarketID,
												MarketName,
												ICProviderID,
												ICProviderName,
												ROCID,
												ROCName
											)
							SELECT
												IU_ID									= x.IU_ID,
												Channel									= x.Channel,
												ChannelName								= dbo.DeriveChannelName( zm.MarketName,x.NetworkName,x.Channel,zm.ZoneName ), -- zm.MarketName + '-' + x.ChannelName
												RegionID								= r.RegionID,
												RegionName								= r.Name,
												NetworkID								= x.NetworkID,
												NetworkName								= x.NetworkName,
												ZoneName								= zm.ZoneName,
												MarketID								= zm.MarketID,
												MarketName								= zm.MarketName,
												ICProviderID  							= zm.ICProviderID,
												ICProviderName 							= zm.ICProviderName,
												ROCID 									= zm.ROCID,
												ROCName									= zm.ROCName

							FROM				#tmp_AllSpots x
							JOIN				DINGODB.dbo.Region r WITH (NOLOCK)		ON x.RegionID = r.RegionID
							JOIN				dbo.DimZoneMap zm WITH (NOLOCK)			ON x.ZoneName = zm.ZoneName
							GROUP BY
												x.IU_ID,
												x.Channel,
												r.RegionID,
												r.Name,
												x.NetworkID,
												x.NetworkName,
												zm.ZoneName,
												zm.MarketID,
												zm.MarketName,
												zm.ICProviderID,
												zm.ICProviderName,
												zm.ROCID,
												zm.ROCName


							BEGIN TRAN


												INSERT				dbo.DimChannelMap
																(
																	IU_ID,
																	ChannelName,
																	Channel,
																	RegionID,
																	RegionName,
																	NetworkID,
																	NetworkName,
																	ZoneName,
																	MarketID,
																	MarketName,
																	ICProviderID,
																	ICProviderName,
																	ROCID,
																	ROCName,
																	CreateDate
																)
												OUTPUT				INSERTED.DimChannelMapID, INSERTED.IU_ID, INSERTED.RegionID
												INTO				@ChannelMapInsertedRows
												SELECT				
																	IU_ID														= cm.IU_ID,
																	ChannelName													= cm.ChannelName, 
																	Channel														= cm.CHANNEL,
																	RegionID													= cm.RegionID,
																	RegionName													= cm.RegionName,
																	NetworkID													= cm.NetworkID,
																	NetworkName													= cm.NetworkName,
																	ZoneName													= cm.ZoneName,
																	MarketID													= cm.MarketID,
																	MarketName													= cm.MarketName,
																	ICProviderID  												= cm.ICProviderID,
																	ICProviderName 												= cm.ICProviderName,
																	ROCID 														= cm.ROCID,
																	ROCName														= cm.ROCName,
																	CreateDate													= GETUTCDATE()
												FROM				#ChannelMap cm
												LEFT JOIN			dbo.DimChannelMap dcm WITH (NOLOCK)							ON cm.ChannelName = dcm.ChannelName
												WHERE				dcm.DimChannelMapID											IS NULL
												GROUP BY			cm.IU_ID, 
																	cm.ChannelName, 
																	cm.CHANNEL, 
																	cm.RegionID,
																	cm.RegionName,
																	cm.NetworkID,
																	cm.NetworkName,
																	cm.ZoneName,
																	cm.MarketID,
																	cm.MarketName,
																	cm.ICProviderID,
																	cm.ICProviderName,
																	cm.ROCID,
																	cm.ROCName


												INSERT				#TotalCountByDay ( DimID, DimName, DayOfYearPartitionKey, UTCDate, SDBSourceID, TotalRecords )
												SELECT				DimID														= @ChannelMapDimID,
																	DimName														= @ChannelMapDimName,
																	DayOfYearPartitionKey										= @LatestDayOfYearPartitionKey, 
																	UTCDate														= @LatestDate, 
																	SDBSourceID													= 0, 
																	TotalRecords												= ISNULL(MAX(x.ID), 0)
												FROM				@ChannelMapInsertedRows x



												INSERT				dbo.DimIU
																(
																	RegionID,
																	SDBSourceID,
																	SDBName,
																	UTCOffset,
																	IU_ID,
																	ZoneName,
																	Channel,
																	CHAN_NAME,
																	ChannelName,
																	DELAY,
																	START_TRIGGER,
																	END_TRIGGER,
																	AWIN_START,
																	AWIN_END,
																	VALUE,
																	MASTER_NAME,
																	COMPUTER_NAME,
																	PARENT_ID,
																	SYSTEM_TYPE,
																	COMPUTER_PORT,
																	MIN_DURATION,
																	MAX_DURATION,
																	START_OF_DAY,
																	RESCHEDULE_WINDOW,
																	IC_CHANNEL,
																	VSM_SLOT,
																	DECODER_PORT,
																	TC_ID,
																	IGNORE_VIDEO_ERRORS,
																	IGNORE_AUDIO_ERRORS,
																	COLLISION_DETECT_ENABLED,
																	TALLY_NORMALLY_HIGH,
																	PLAY_OVER_COLLISIONS,
																	PLAY_COLLISION_FUDGE,
																	TALLY_COLLISION_FUDGE,
																	TALLY_ERROR_FUDGE,
																	LOG_TALLY_ERRORS,
																	TBI_START,
																	TBI_END,
																	CONTINUOUS_PLAY_FUDGE,
																	TONE_GROUP,
																	IGNORE_END_TONES,
																	END_TONE_FUDGE,
																	MAX_AVAILS,
																	RESTART_TRIES,
																	RESTART_BYTE_SKIP,
																	RESTART_TIME_REMAINING,
																	GENLOCK_FLAG,
																	SKIP_HEADER,
																	GPO_IGNORE,
																	GPO_NORMAL,
																	GPO_TIME,
																	DECODER_SHARING,
																	HIGH_PRIORITY,
																	SPLICER_ID,
																	PORT_ID,
																	VIDEO_PID,
																	SERVICE_PID,
																	DVB_CARD,
																	SPLICE_ADJUST,
																	POST_BLACK,
																	SWITCH_CNT,
																	DECODER_CNT,
																	DVB_CARD_CNT,
																	DVB_PORTS_PER_CARD,
																	DVB_CHAN_PER_PORT,
																	USE_ISD,
																	NO_NETWORK_VIDEO_DETECT,
																	NO_NETWORK_PLAY,
																	IP_TONE_THRESHOLD,
																	USE_GIGE,
																	GIGE_IP,
																	IS_ACTIVE_IND,
																	SystemTypeName,

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
												OUTPUT				INSERTED.DimIUID, INSERTED.IU_ID, INSERTED.UTCIEDayOfYearPartitionKey, INSERTED.UTCIEDate, INSERTED.SDBSourceID, INSERTED.RegionID
												INTO				@IUInsertedRows
												SELECT				
																	RegionID													= x.RegionID,
																	SDBSourceID													= x.SDBSourceID,
																	SDBName														= x.SDBName,
																	UTCOffset													= x.UTCOffset,
																	IU_ID														= x.IU_ID,
																	ZoneName													= x.ZoneName,
																	Channel														= x.CHANNEL,
																	CHAN_NAME													= x.CHAN_NAME,
																	ChannelName													= cm.ChannelName,
																	DELAY														= x.DELAY,
																	START_TRIGGER												= x.START_TRIGGER,
																	END_TRIGGER													= x.END_TRIGGER,
																	AWIN_START													= x.AWIN_START,
																	AWIN_END													= x.AWIN_END,
																	VALUE														= x.VALUE,
																	MASTER_NAME													= x.MASTER_NAME,
																	COMPUTER_NAME												= x.COMPUTER_NAME,
																	PARENT_ID													= x.PARENT_ID,
																	SYSTEM_TYPE													= x.SYSTEM_TYPE,
																	COMPUTER_PORT												= x.COMPUTER_PORT,
																	MIN_DURATION												= x.MIN_DURATION,
																	MAX_DURATION												= x.MAX_DURATION,
																	START_OF_DAY												= x.START_OF_DAY,
																	RESCHEDULE_WINDOW											= x.RESCHEDULE_WINDOW,
																	IC_CHANNEL													= x.IC_CHANNEL,
																	VSM_SLOT													= x.VSM_SLOT,
																	DECODER_PORT												= x.DECODER_PORT,
																	TC_ID														= x.TC_ID,
																	IGNORE_VIDEO_ERRORS											= x.IGNORE_VIDEO_ERRORS,
																	IGNORE_AUDIO_ERRORS											= x.IGNORE_AUDIO_ERRORS,
																	COLLISION_DETECT_ENABLED									= x.COLLISION_DETECT_ENABLED,
																	TALLY_NORMALLY_HIGH											= x.TALLY_NORMALLY_HIGH,
																	PLAY_OVER_COLLISIONS										= x.PLAY_OVER_COLLISIONS,
																	PLAY_COLLISION_FUDGE										= x.PLAY_COLLISION_FUDGE,
																	TALLY_COLLISION_FUDGE										= x.TALLY_COLLISION_FUDGE,
																	TALLY_ERROR_FUDGE											= x.TALLY_ERROR_FUDGE,
																	LOG_TALLY_ERRORS											= x.LOG_TALLY_ERRORS,
																	TBI_START													= x.TBI_START,
																	TBI_END														= x.TBI_END,
																	CONTINUOUS_PLAY_FUDGE										= x.CONTINUOUS_PLAY_FUDGE,
																	TONE_GROUP													= x.TONE_GROUP,
																	IGNORE_END_TONES											= x.IGNORE_END_TONES,
																	END_TONE_FUDGE												= x.END_TONE_FUDGE,
																	MAX_AVAILS													= x.MAX_AVAILS,
																	RESTART_TRIES												= x.RESTART_TRIES,
																	RESTART_BYTE_SKIP											= x.RESTART_BYTE_SKIP,
																	RESTART_TIME_REMAINING										= x.RESTART_TIME_REMAINING,
																	GENLOCK_FLAG												= x.GENLOCK_FLAG,
																	SKIP_HEADER													= x.SKIP_HEADER,
																	GPO_IGNORE													= x.GPO_IGNORE,
																	GPO_NORMAL													= x.GPO_NORMAL,
																	GPO_TIME													= x.GPO_TIME,
																	DECODER_SHARING												= x.DECODER_SHARING,
																	HIGH_PRIORITY												= x.HIGH_PRIORITY,
																	SPLICER_ID													= x.SPLICER_ID,
																	PORT_ID														= x.PORT_ID,
																	VIDEO_PID													= x.VIDEO_PID,
																	SERVICE_PID													= x.SERVICE_PID,
																	DVB_CARD													= x.DVB_CARD,
																	SPLICE_ADJUST												= x.SPLICE_ADJUST,
																	POST_BLACK													= x.POST_BLACK,
																	SWITCH_CNT													= x.SWITCH_CNT,
																	DECODER_CNT													= x.DECODER_CNT,
																	DVB_CARD_CNT												= x.DVB_CARD_CNT,
																	DVB_PORTS_PER_CARD											= x.DVB_PORTS_PER_CARD,
																	DVB_CHAN_PER_PORT											= x.DVB_CHAN_PER_PORT,
																	USE_ISD														= x.USE_ISD,
																	NO_NETWORK_VIDEO_DETECT										= x.NO_NETWORK_VIDEO_DETECT,
																	NO_NETWORK_PLAY												= x.NO_NETWORK_PLAY,
																	IP_TONE_THRESHOLD											= x.IP_TONE_THRESHOLD,
																	USE_GIGE													= x.USE_GIGE,
																	GIGE_IP														= x.GIGE_IP,
																	IS_ACTIVE_IND												= x.IS_ACTIVE_IND,
																	SystemTypeName												= x.SYSTEM_TYPEName,

																	--Derived columns for reporting purposes
																	UTCIEDatetime												= x.UTCIEDatetime,
																	UTCIEDate													= x.UTCIEDate,
																	UTCIEDateYear												= x.UTCIEDateYear,
																	UTCIEDateMonth												= x.UTCIEDateMonth,
																	UTCIEDateDay												= x.UTCIEDateDay,
																	UTCIEDayOfYearPartitionKey									= x.UTCIEDayOfYearPartitionKey,
																	IEDate														= CONVERT ( DATE,	x.IESCHED_DATE, 121 ),
																	IEDateYear													= DATEPART( YEAR,	x.IESCHED_DATE ),
																	IEDateMonth													= DATEPART( MONTH,	x.IESCHED_DATE ),
																	IEDateDay													= DATEPART( DAY,	x.IESCHED_DATE ),
																	IEDayOfYearPartitionKey										= DATEPART( DY,		x.IESCHED_DATE ),
																	RegionName													= cm.RegionName,
																	MDBSourceID													= sdb.MDBSourceID,
																	MDBName														= sdb.MDBName,
																	MarketID													= cm.MarketID,
																	MarketName													= cm.MarketName,
																	ICProviderID  												= cm.ICProviderID,
																	ICProviderName 												= cm.ICProviderName,
																	ROCID 														= cm.ROCID,
																	ROCName														= cm.ROCName,
																	NetworkID													= x.NetworkID,
																	NetworkName													= x.NetworkName,
																	CreateDate													= GETUTCDATE()
												FROM				#tmp_AllSpots x
												JOIN				#DayOfYearPartitionSubset d									ON		x.UTCIEDayOfYearPartitionKey	= d.DayOfYearPartitionKey
																																AND		x.UTCIEDate						= d.DateDay
												JOIN				dbo.DimSDBSource sdb WITH (NOLOCK)							ON		x.SDBSourceID					= sdb.SDBSourceID
												JOIN				dbo.DimChannelMap cm WITH (NOLOCK)							ON		x.IU_ID							= cm.IU_ID
																																AND		x.RegionID						= cm.RegionID
												ORDER BY			x.IESCHED_DATE


												INSERT				#TotalCountByDay ( DimID, DimName, DayOfYearPartitionKey, UTCDate, SDBSourceID, TotalRecords )
												SELECT				DimID														= @IUDimID,
																	DimName														= @IUDimName,
																	DayOfYearPartitionKey										= x.UTCIEDayOfYearPartitionKey, 
																	UTCDate														= x.UTCIEDate, 
																	SDBSourceID													= x.SDBSourceID, 
																	TotalRecords												= COUNT(1)
												FROM				@IUInsertedRows x
												GROUP BY			x.UTCIEDayOfYearPartitionKey, x.UTCIEDate, x.SDBSourceID

												--					Uses temp table #TotalCountByDay
												EXEC				dbo.SaveDimRecordCount	


							COMMIT




							DROP TABLE			#ChannelMap
							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#tmp_AllSpots
							DROP TABLE			#TotalCountByDay


END
GO