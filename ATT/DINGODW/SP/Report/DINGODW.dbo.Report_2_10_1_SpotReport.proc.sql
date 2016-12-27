

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_1_SpotReport'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_1_SpotReport
GO

CREATE PROCEDURE dbo.Report_2_10_1_SpotReport 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ChannelName				VARCHAR(100)	= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,		--Regional Interconnect OR Local
				@ROCID						INT				= NULL,
				@IEStatusID					INT				= NULL,
				@IEConflictStatusID			INT				= NULL,
				@SPOTStatusID				INT				= NULL,
				@SPOTConflictStatusID		INT				= NULL,
				@StartDateTime				DATETIME,
				@EndDateTime				DATETIME

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
// Module:  dbo.Report_2_10_1_SpotReport
// Created: 2014-May-05
// Author:  Tony Lew
// 
// Purpose:			Generate SDBDashboard report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_1_SpotReport.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_1_SpotReport	
//									@RegionID					= NULL,
//									@SDBSourceID				= NULL,
//									@SDBName					= NULL,
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@ChannelName				= NULL,
//									@MarketName					= NULL,
//									@ZoneName					= NULL,
//									@NetworkName				= NULL,
//									@ICProviderID				= NULL,		--Regional Interconnect OR Local
//									@ROCID						= NULL,
//									@IEStatusID					= 'Error,Expired',		--CSV string
//									@IEConflictStatusID			= NULL,		--CSV string
//									@SPOTStatusID				= NULL,		--CSV string
//									@SPOTConflictStatusID		= NULL,		--CSV string
//									@StartDateTime				= NULL,
//									@EndDateTime				= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				
				DECLARE			@StartDay													DATE = @StartDateTime
				DECLARE			@EndDay														DATE = @EndDateTime


				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimSPOTID BIGINT, DimIEID BIGINT, UTCSPOTDayOfYearPartitionKey INT, UTCIEDayOfYearPartitionKey INT )

				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimSPOTID, DimIEID, UTCSPOTDayOfYearPartitionKey, UTCIEDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.DimIEID, s.UTCSPOTDayOfYearPartitionKey, s.UTCIEDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCIEDatetime								BETWEEN @StartDateTime AND @EndDateTime
				ELSE
								INSERT			#DayDateSubset ( DimSPOTID, DimIEID, UTCSPOTDayOfYearPartitionKey, UTCIEDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.DimIEID, s.UTCSPOTDayOfYearPartitionKey, s.UTCIEDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.SPOTDayDate
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
								SCHED_DATE_TIME,
								VideoID, 
								MarketName,
								ChannelName, 
								ZoneName, 
								NetworkName, 
								ICProviderName,
								ROCName,
								Position, 
								BreakStatus, 
								BreakConflictStatus, 
								SpotStatus, 
								SpotConflictStatus
							)
				SELECT			RegionID													= ie.RegionID,
								SDBSourceID													= ie.SDBSourceID,
								SDB															= ie.SDBName,
								DBSource													= 'DINGODW',
								SCHED_DATE_TIME												= CASE	WHEN @UseUTC = 1 THEN ie.UTCIEDatetime
																									ELSE ie.SCHED_DATE_TIME
																								END,
								VideoID	 													= s.VIDEO_ID,
								MarketName													= ie.MarketName, 
								ChannelName													= ie.ChannelName, 
								ZoneName													= ie.ZoneName,
								NetworkName													= s.NetworkName,
								ICProviderName												= ie.ICProviderName, 
								ROCName														= ie.ROCName, 
								Position													= s.Spot_ORDER,
								BreakStatus 												= ie.NSTATUSValue,
								BreakConflictStatus 										= ie.CONFLICT_STATUSValue,
								SpotStatus 													= s.NSTATUSValue,
								SpotConflictStatus											= s.CONFLICT_STATUSValue
				FROM			#DayDateSubset x
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.UTCSPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimIE ie WITH (NOLOCK)									ON x.DimIEID = ie.DimIEID
																							AND x.UTCIEDayOfYearPartitionKey = ie.UTCIEDayOfYearPartitionKey
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.ZoneName													= ISNULL(@ZoneName,s.ZoneName)
				AND				s.NetworkName												= ISNULL(@NetworkName,s.NetworkName)
				AND				s.MarketID													= ISNULL(@MarketID,s.MarketID)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)
				AND				ie.NSTATUS													= ISNULL( @IEStatusID,ie.NSTATUS )
				AND				ie.CONFLICT_STATUS											= ISNULL( @IEConflictStatusID,ie.CONFLICT_STATUS )
				AND				s.NSTATUS													= ISNULL( @SpotStatusID,s.NSTATUS )
				AND				s.CONFLICT_STATUS											= ISNULL( @SpotConflictStatusID,s.CONFLICT_STATUS )
				--AND				( EXISTS(SELECT TOP 1 1 FROM #IEStatusTBL x1				WHERE x1.Value = ie.NSTATUS) OR ISNULL(LEN(@IEStatus),0) = 0 )
				--AND				( EXISTS(SELECT TOP 1 1 FROM #IEConflictStatusTBL x2		WHERE x2.Value = ie.CONFLICT_STATUS) OR ISNULL(LEN(@IEConflictStatus),0) = 0 )
				--AND				( EXISTS(SELECT TOP 1 1 FROM #SPOTStatusTBL x3				WHERE x3.Value = s.NSTATUS) OR ISNULL(LEN(@SPOTStatus),0) = 0 )
				--AND				( EXISTS(SELECT TOP 1 1 FROM #SPOTConflictStatusTBL x4		WHERE x4.Value = s.CONFLICT_STATUS) OR ISNULL(LEN(@SPOTConflictStatus),0) = 0 )


				DROP TABLE		#DayDateSubset


END


GO

