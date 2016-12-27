

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_3_FutureReadiness'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_3_FutureReadiness
GO

CREATE PROCEDURE dbo.Report_2_10_3_FutureReadiness 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ChannelName				VARCHAR(50)		= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,		--Regional Interconnect OR Local
				@ROCID						INT				= NULL,
				@StartDateTime				DATETIME		= NULL,
				@EndDateTime				DATETIME		= NULL

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
// Module:  dbo.Report_2_10_3_FutureReadiness
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate FutureReadiness report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_3_FutureReadiness.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_3_FutureReadiness	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@ChannelName				= NULL,
//									@MarketID					= NULL,
//									@ZoneName					= NULL,
//									@NetworkName				= NULL,
//									@ICProviderID				= NULL,		--Regional Interconnect OR Local
//									@ROCID						= NULL,
//									@StartDateTime				= NULL,
//									@EndDateTime				= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), FactSpotSummaryID BIGINT, DimSPOTID BIGINT, DimIEID BIGINT, UTCSPOTDayOfYearPartitionKey INT, UTCIEDayOfYearPartitionKey INT )

				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( FactSpotSummaryID, DimSPOTID, DimIEID, UTCSPOTDayOfYearPartitionKey, UTCIEDayOfYearPartitionKey )
								SELECT			x.FactSpotSummaryID, x.DimSPOTID, x.DimIEID, x.UTCSPOTDayOfYearPartitionKey, x.UTCIEDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDateTime AND @EndDateTime
											) d
								JOIN			dbo.FactSpotSummary x WITH (NOLOCK)			ON d.DimDate = x.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCIEDatetime								BETWEEN @StartDateTime AND @EndDateTime
				ELSE
								INSERT			#DayDateSubset ( FactSpotSummaryID, DimSPOTID, DimIEID, UTCSPOTDayOfYearPartitionKey, UTCIEDayOfYearPartitionKey )
								SELECT			x.FactSpotSummaryID, x.DimSPOTID, x.DimIEID, x.UTCSPOTDayOfYearPartitionKey, x.UTCIEDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDateTime AND @EndDateTime
											) d
								JOIN			dbo.FactSpotSummary x WITH (NOLOCK)			ON d.DimDate = x.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.IEDatetime								BETWEEN @StartDateTime AND @EndDateTime


				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								ChannelName, 
								MarketName,
								ZoneName, 
								NetworkName, 
								ICProviderName,
								ROCName,
								LastScheduleLoad, 
								SCHED_DATE ,
								SCHED_DATE_TIME,
								ICScheduleLoaded		,
								ICScheduleBreakCount	,
								ICMissingMedia			,
								ICMediaPrefixErrors		,
								ICMediaDurationErrors	,
								ICMediaFormatErrors		,
								ATTScheduleLoaded		,
								ATTScheduleBreakCount	,
								ATTMissingMedia			,
								ATTMediaPrefixErrors	,
								ATTMediaDurationErrors	,
								ATTMediaFormatErrors	
				
							)
				SELECT			RegionID													= IE.RegionID,
								SDBSourceID													= IE.SDBSourceID,
								SDB															= IE.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= IE.RegionName, 
								ChannelName													= IE.ChannelName, 
								MarketName													= IE.MarketName, 
								ZoneName 													= IE.ZoneName,
								NetworkName													= s.NetworkName,
								ICProviderName												= IE.ICProviderName, 
								ROCName														= IE.ROCName, 
								LastScheduleLoad											= CASE	WHEN @UseUTC = 1 THEN CONVERT( DATETIME,DATEADD(HOUR,TB.UTCOffset,TB.TB_FILE_DATE),101 )
																									ELSE CONVERT( DATETIME,TB.TB_FILE_DATE,101 )
																								END,
								SCHED_DATE													= CASE	WHEN @UseUTC = 1 THEN CONVERT( DATE,IE.UTCIEDate,101 )
																									ELSE CONVERT( DATE,IE.IEDate,101 )
																								END,
								SCHED_DATE_TIME												= CASE	WHEN @UseUTC = 1 THEN IE.UTCIEDatetime
																									ELSE IE.SCHED_DATE_TIME
																								END,
								ICScheduleLoaded											= f1.ICScheduleLoaded,
								ICScheduleBreakCount										= f1.ICScheduleBreakCount,
								ICMissingMedia												= f1.ICMissingMedia,
								ICMediaPrefixErrors											= f1.ICMediaPrefixErrors,
								ICMediaDurationErrors										= f1.ICMediaDurationErrors,
								ICMediaFormatErrors											= f1.ICMediaFormatErrors,
								ATTScheduleLoaded											= f1.ATTScheduleLoaded,
								ATTScheduleBreakCount										= f1.ATTScheduleBreakCount,
								ATTMissingMedia												= f1.ATTMissingMedia,
								ATTMediaPrefixErrors										= f1.ATTMediaPrefixErrors,
								ATTMediaDurationErrors										= f1.ATTMediaDurationErrors,
								ATTMediaFormatErrors										= f1.ATTMediaFormatErrors

				FROM			#DayDateSubset x
				JOIN			dbo.FactSpotSummary f1 WITH (NOLOCK)						ON x.FactSpotSummaryID = f1.FactSpotSummaryID
																							AND x.UTCSPOTDayOfYearPartitionKey = f1.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimIE IE WITH (NOLOCK)									ON x.DimIEID = IE.DimIEID
																							AND x.UTCIEDayOfYearPartitionKey = IE.UTCIEDayOfYearPartitionKey
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.UTCSPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				JOIN		(
								SELECT		IU_ID, 
											SOURCE_ID, 
											SDBSourceID,
											UTCOffset, 
											MAX(TB_FILE_DATE) TB_FILE_DATE
								FROM		dbo.DimTB_REQUEST WITH (NOLOCK)	
								GROUP BY	IU_ID, SOURCE_ID, SDBSourceID, UTCOffset
							)	TB															ON IE.SDBSourceID = TB.SDBSourceID
																							AND IE.IU_ID = TB.IU_ID
																							AND IE.SOURCE_ID = TB.SOURCE_ID
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.MarketID													= ISNULL(@MarketID,s.MarketID)
				AND				s.ZoneName													= ISNULL(@ZoneName,s.ZoneName)
				AND				s.NetworkName												= ISNULL(@NetworkName,s.NetworkName)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)


				DROP TABLE		#DayDateSubset



END


GO


