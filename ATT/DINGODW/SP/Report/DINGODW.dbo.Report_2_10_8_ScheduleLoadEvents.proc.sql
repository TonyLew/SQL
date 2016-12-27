

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_8_ScheduleLoadEvents'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_8_ScheduleLoadEvents
GO

CREATE PROCEDURE dbo.Report_2_10_8_ScheduleLoadEvents 
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
// Module:  dbo.Report_2_10_8_ScheduleLoadEvents
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate FutureReadiness report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_8_ScheduleLoadEvents.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_8_ScheduleLoadEvents	
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
//									@ScheduleDate				= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimIEID BIGINT, DimIUID BIGINT, UTCDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimIEID, DimIUID, UTCDayOfYearPartitionKey)
								SELECT			x.DimIEID, x.DimIUID, d.DayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							= @ScheduleDate
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimIU iu WITH (NOLOCK)					ON x.DimIUID = iu.DimIUID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			iu.UTCIEDate								= @ScheduleDate
				ELSE
								INSERT			#DayDateSubset ( DimIEID, DimIUID, UTCDayOfYearPartitionKey)
								SELECT			x.DimIEID, x.DimIUID, d.DayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							= @ScheduleDate
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimIU iu WITH (NOLOCK)					ON x.DimIUID = iu.DimIUID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			iu.IEDate									= @ScheduleDate



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
								ScheduleLoadDateTime
							)
				SELECT			RegionID													= iu.RegionID,
								SDBSourceID													= iu.SDBSourceID,
								SDB															= iu.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= iu.RegionName,				
								MarketName													= iu.MarketName,				
								ZoneName													= iu.ZoneName,
								NetworkName													= iu.NetworkName,
								ICProviderName												= iu.ICProviderName,				
								ROCName														= iu.ROCName,				
								ChannelName													= iu.ChannelName,
								ScheduleDate												= @ScheduleDate,
								ScheduleLoadDateTime										= CASE WHEN @UseUTC = 1 THEN ie.UTCIEDatetime ELSE ie.SCHED_DATE_TIME END

				FROM			#DayDateSubset x
				JOIN			dbo.DimIE ie WITH (NOLOCK)									ON x.DimIEID = ie.DimIEID
																							AND x.UTCDayOfYearPartitionKey = ie.UTCIEDayOfYearPartitionKey
				JOIN			dbo.DimIU iu WITH (NOLOCK)									ON x.DimIUID = iu.DimIUID
																							AND x.UTCDayOfYearPartitionKey = iu.UTCIEDayOfYearPartitionKey
				WHERE			iu.RegionID													= ISNULL(@RegionID,iu.RegionID)
				AND				iu.ZoneName													= ISNULL(@ZoneName,iu.ZoneName)
				AND				iu.CHAN_NAME												= ISNULL(@NetworkName,iu.CHAN_NAME)
				AND				ie.MarketID													= ISNULL(@MarketID,ie.MarketID)
				AND				ie.ICProviderID												= ISNULL(@ICProviderID,ie.ICProviderID)
				AND				ie.ROCID													= ISNULL(@ROCID,ie.ROCID)

				DROP TABLE		#DayDateSubset


END


GO


