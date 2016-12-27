

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_5_RunRate'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_5_RunRate
GO

CREATE PROCEDURE dbo.Report_2_10_5_RunRate 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@ChannelName				VARCHAR(100)	= NULL,
				@ScheduleDate				DATE

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
// Module:  dbo.Report_2_10_5_RunRate
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate FutureReadiness report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_5_RunRate.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_5_RunRate	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= 1,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@MarketID					= NULL,
//									@ZoneName					= NULL,
//									@NetworkName				= NULL,
//									@ICProviderID				= NULL,	
//									@ROCID						= NULL,
//									@ChannelName				= NULL,
//									@ScheduleDate				= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), FactSpotSummaryID BIGINT, DimSPOTID BIGINT, SPOTDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( FactSpotSummaryID, DimSPOTID, SPOTDayOfYearPartitionKey )
								SELECT			f1.FactSpotSummaryID, f1.DimSPOTID, f1.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							= @ScheduleDate 
											) d
								JOIN			dbo.FactSpotSummary f1 WITH (NOLOCK)		ON d.DimDate = f1.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f1.UTCSPOTDayOfYearPartitionKey
								GROUP BY		f1.FactSpotSummaryID, f1.DimSPOTID, f1.UTCSPOTDayOfYearPartitionKey
				ELSE
								INSERT			#DayDateSubset ( FactSpotSummaryID, DimSPOTID, SPOTDayOfYearPartitionKey )
								SELECT			f1.FactSpotSummaryID, f1.DimSPOTID, f1.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							= @ScheduleDate 
											) d
								JOIN			dbo.FactSpotSummary f1 WITH (NOLOCK)		ON d.DimDate = f1.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f1.SPOTDayOfYearPartitionKey
								GROUP BY		f1.FactSpotSummaryID, f1.DimSPOTID, f1.UTCSPOTDayOfYearPartitionKey


				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource,
								RegionName,
								NetworkName, 
								ZoneName, 
								MarketName,
								ICProviderName,
								ROCName,
								ChannelName, 
								TotalSpots,
								TotalSpotsPlayed,
								TotalSpotsFailed,
								TotalSpotsNoTone,
								TotalSpotsError,
								TotalSpotsMissing,
								TotalICSpots,
								TotalICSpotsPlayed,
								TotalICSpotsFailed,
								TotalICSpotsNoTone,
								TotalICSpotsError,
								TotalICSpotsMissing,
								TotalATTSpots,
								TotalATTSpotsPlayed,
								TotalATTSpotsFailed,
								TotalATTSpotsNoTone,
								TotalATTSpotsError,
								TotalATTSpotsMissing
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName, 
								NetworkName													= s.NetworkName,
								ZoneName	 												= s.ZoneName,
								MarketName 													= s.MarketName,
								ICProviderName 												= s.ICProviderName,
								ROCName 													= s.ROCName,
								ChannelName													= s.ChannelName,
								TotalSpots													= f1.DTM_OTHERTotal			+ f1.DTM_ICTotal		+ f1.DTM_ATTTotal,
								TotalSpotsPlayed											= f1.DTM_OTHERPlayed		+ f1.DTM_ICPlayed		+ f1.DTM_ATTPlayed,
								TotalSpotsFailed											= f1.DTM_OTHERFailed		+ f1.DTM_ICFailed		+ f1.DTM_ATTFailed,
								TotalSpotsNoTone											= f1.DTM_OTHERNoTone		+ f1.DTM_ICNoTone		+ f1.DTM_ATTNoTone,
								TotalSpotsError												= f1.DTM_OTHERMpegError		+ f1.DTM_ICMpegError	+ f1.DTM_ATTMpegError,
								TotalSpotsMissing											= f1.DTM_OTHERMissingCopy	+ f1.DTM_ICMissingCopy	+ f1.DTM_ATTMissingCopy,
								TotalICSpots												= f1.DTM_ICTotal,
								TotalICSpotsPlayed											= f1.DTM_ICPlayed,
								TotalICSpotsFailed											= f1.DTM_ICFailed,
								TotalICSpotsNoTone											= f1.DTM_ICNoTone,
								TotalICSpotsError											= f1.DTM_ICMpegError,
								TotalICSpotsMissing											= f1.DTM_ICMissingCopy,
								TotalATTSpots												= f1.DTM_ATTTotal,
								TotalATTSpotsPlayed											= f1.DTM_ATTPlayed,
								TotalATTSpotsFailed											= f1.DTM_ATTFailed,
								TotalATTSpotsNoTone											= f1.DTM_ATTNoTone,
								TotalATTSpotsError											= f1.DTM_ATTMpegError,
								TotalATTSpotsMissing										= f1.DTM_ATTMissingCopy
				FROM			#DayDateSubset x
				JOIN			dbo.FactSpotSummary f1 WITH (NOLOCK)						ON x.FactSpotSummaryID = f1.FactSpotSummaryID
																							AND x.SPOTDayOfYearPartitionKey = f1.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON f1.DimSpotID = s.DimSpotID
																							AND x.SPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				WHERE			s.ChannelName												= ISNULL(@ChannelName,s.ChannelName)
				AND				s.ZoneName													= ISNULL(@ZoneName,s.ZoneName)
				AND				s.MarketID													= ISNULL(@MarketID,s.MarketID)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)


				DROP TABLE		#DayDateSubset


END


GO


