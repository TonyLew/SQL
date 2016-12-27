

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_7_VideoFormatMismatch'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_7_VideoFormatMismatch
GO

CREATE PROCEDURE dbo.Report_2_10_7_VideoFormatMismatch 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@ChannelName				VARCHAR(50)		= NULL,
				@AssetID					VARCHAR(50)		= NULL,
				@ScheduleDate				DATE			= NULL

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
// Module:  dbo.Report_2_10_7_VideoFormatMismatch
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate FutureReadiness report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_7_VideoFormatMismatch.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_7_VideoFormatMismatch	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@MarketID					= NULL,
//									@ZoneName					= NULL,
//									@NetworkName				= NULL,
//									@ICProviderID				= NULL,	
//									@ROCID						= NULL,
//									@ChannelName				= NULL,
//									@AssetID					= NULL,
//									@ScheduleDate				= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimSPOTID BIGINT, UTCDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimSPOTID, UTCDayOfYearPartitionKey)
								SELECT			s.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							= @ScheduleDate
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCIEDate									= @ScheduleDate
				ELSE
								INSERT			#DayDateSubset ( DimSPOTID, UTCDayOfYearPartitionKey)
								SELECT			s.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							= @ScheduleDate
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.IEDate									= @ScheduleDate



				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								MarketName,
								ZoneName, 
								NetworkName, 
								ICProviderName,
								ROCName,
								ChannelName, 
								ScheduleDate,
								AssetID,
								VideoFormat
			
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName, 
								MarketName 													= s.MarketName,
								ZoneName	 												= s.ZoneName,
								NetworkName													= s.NetworkName,
								ICProviderName 												= s.ICProviderName,
								ROCName 													= s.ROCName,
								ChannelName													= s.ChannelName,
								ScheduleDate												= @ScheduleDate,
								AssetID														= s.VIDEO_ID,
								VideoFormat													= 'VideoFormat'+ISNULL(s.VIDEO_ID,'')

				FROM			#DayDateSubset x
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.UTCDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.MarketID													= ISNULL(@MarketID,s.MarketID)
				AND				s.ZoneName													= ISNULL(@ZoneName,s.ZoneName)
				AND				s.NetworkName												= ISNULL(@NetworkName,s.NetworkName)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)


				DROP TABLE		#DayDateSubset



END


GO


