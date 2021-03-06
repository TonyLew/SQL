/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand BlvdINSERT dbo.DimSDBSource 
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  DINGODW database table population script.
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Database data population for definition tables.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 


---------------------------------------------------
--Dimension
---------------------------------------------------
USE [DINGODW]
GO

		--delete dbo.Dimension 
		INSERT dbo.Dimension 
				(
					Name,
					Description,
					CreateDate
				)
		SELECT 
					Name					= x.Name,
					Description				= x.Description,
					CreateDate				= GETUTCDATE()
		FROM	(

								Select 
											Name				= 'DimDateDay',
											Description			= 'DimDateDay dimension',
											SortOrder			= 0
								UNION
								Select 
											Name				= 'IE',
											Description			= 'IE dimension',
											SortOrder			= 1
								UNION
								Select 
											Name				= 'IU',
											Description			= 'IU dimension',
											SortOrder			= 2
								UNION
								Select 
											Name				= 'SPOT',
											Description			= 'SPOT dimension',
											SortOrder			= 3
								UNION
								Select 
											Name				= 'TB_REQUEST',
											Description			= 'TB_REQUEST dimension',
											SortOrder			= 4
								UNION
								Select 
											Name				= 'SDBSource',
											Description			= 'SDBSource dimension',
											SortOrder			= 5
								UNION
								Select 
											Name				= 'IEStatus',
											Description			= 'IEStatus dimension',
											SortOrder			= 6
								UNION
								Select 
											Name				= 'IEConflictStatus',
											Description			= 'IEConflictStatus dimension',
											SortOrder			= 7
								UNION
								Select 
											Name				= 'SpotStatus',
											Description			= 'SpotStatus dimension',
											SortOrder			= 8
								UNION
								Select 
											Name				= 'SpotConflictStatus',
											Description			= 'SpotConflictStatus dimension',
											SortOrder			= 9
								UNION
								Select 
											Name				= 'Asset',
											Description			= 'Asset dimension',
											SortOrder			= 10
								UNION
								Select 
											Name				= 'ChannelMap',
											Description			= 'ChannelMap dimension',
											SortOrder			= 11

				) x
		LEFT JOIN	dbo.Dimension y (NOLOCK)
		ON			x.Name				= y.Name
		WHERE		y.DimensionID		IS NULL
		ORDER BY	x.SortOrder



---------------------------------------------------
--Fact
---------------------------------------------------
USE [DINGODW]
GO


		--delete dbo.Fact 
		INSERT dbo.Fact 
				(
					Name,
					Description,
					CreateDate
				)
		SELECT 
					Name					= x.Name,
					Description				= x.Description,
					CreateDate				= GETUTCDATE()
		FROM	(


								Select 
											Name				= 'XSEU',
											Description			= 'Factless fact table/bridge table',
											SortOrder			= 0
								UNION
								Select 
											Name				= 'SPOTSummary',
											Description			= 'SPOTSummary fact',
											SortOrder			= 1
								UNION
								Select 
											Name				= 'IESummary',
											Description			= 'IESummary fact',
											SortOrder			= 2
								UNION
								Select 
											Name				= 'IUSummary',
											Description			= 'IUSummary fact',
											SortOrder			= 3
								UNION
								Select 
											Name				= 'SDBSource',
											Description			= 'SDBSource fact',
											SortOrder			= 5
								UNION
								Select 
											Name				= 'IEStatusSummary',
											Description			= 'IEStatusSummary fact',
											SortOrder			= 6
								UNION
								Select 
											Name				= 'IEConflictStatusSummary',
											Description			= 'IEConflictStatusSummary fact',
											SortOrder			= 7
								UNION
								Select 
											Name				= 'SpotStatusSummary',
											Description			= 'SpotStatusSummary fact',
											SortOrder			= 8
								UNION
								Select 
											Name				= 'SpotConflictStatusSummary',
											Description			= 'SpotConflictStatusSummary fact',
											SortOrder			= 9
								UNION
								Select 
											Name				= 'AssetSummary',
											Description			= 'AssetSummary fact',
											SortOrder			= 10
								UNION
								Select 
											Name				= 'IC',
											Description			= 'IC fact',
											SortOrder			= 11
								UNION
								Select 
											Name				= 'ATT',
											Description			= 'ATT fact',
											SortOrder			= 12
								UNION
								Select 
											Name				= 'Break',
											Description			= 'Break fact',
											SortOrder			= 13
								UNION
								Select 
											Name				= 'Conflict',
											Description			= 'Conflict fact',
											SortOrder			= 14


				) x
		LEFT JOIN	dbo.Fact y (NOLOCK)
		ON			x.Name				= y.Name
		WHERE		y.FactID		IS NULL
		ORDER BY	x.SortOrder



---------------------------------------------------
--DimSDBSource
---------------------------------------------------
USE [DINGODW]
GO

				--delete dbo.DimSDBSource 
				INSERT dbo.DimSDBSource 
							(
								SDBSourceID,
								SDBName,
								MDBSourceID,
								MDBName,
								RegionID,
								RegionName,
								UTCOffset,
								Enabled,
								CreateDate
							)
				SELECT			SDBSourceID									= s.SDBSourceID,
								SDBName										= s.SDBComputerNamePrefix,
								MDBSourceID									= m.MDBSourceID,
								MDBName										= m.MDBComputerNamePrefix,
								RegionID									= m.RegionID,
								RegionName									= r.Name,
								UTCOffset									= s.UTCOffset,
								Enabled										= 1,
								CreateDate									= GETUTCDATE()
				FROM			DINGODB.dbo.MDBSource m WITH (NOLOCK)
				JOIN			DINGODB.dbo.SDBSource s WITH (NOLOCK)
				ON				m.MDBSourceID								= s.MDBSourceID
				JOIN			DINGODB.dbo.Region r WITH (NOLOCK)
				ON				r.RegionID									= m.RegionID




---------------------------------------------------
--DimDateDay
---------------------------------------------------


				DECLARE @begindate date = '2014-01-01'
				DECLARE @enddate date = '2114-12-31'
				DECLARE @DateYear int
				DECLARE	@DateQuarter int
				DECLARE @DateMonth int
				DECLARE @DateDayOfWeek int
				DECLARE @DateDay int
				DECLARE @DateDayOfYear int


				WHILE ( @begindate <= @enddate )
				BEGIN


							SELECT		@DateYear			= DATEPART(YEAR,@begindate),
										@DateQuarter		= DATEPART(QUARTER,@begindate),
										@DateMonth			= DATEPART(MONTH,@begindate),
										@DateDayOfWeek		= DATEPART(WEEKDAY,@begindate),
										@DateDay			= DATEPART(DAY, @begindate),
										@DateDayOfYear		= DATEPART(DAYOFYEAR, @begindate)


							INSERT		dbo.DimDateDay 
									(
										DimDate,
										DateYear,
										DateQuarter,
										DateMonth,
										DateDayOfWeek,
										DateDay,
										DayOfYearPartitionKey
									)
							SELECT		DimDate						= @begindate,
										DateYear					= @DateYear ,
										DateQuarter					= @DateQuarter,
										DateMonth					= @DateMonth ,
										DateDayOfWeek				= @DateDayOfWeek ,
										DateDay						= @DateDay ,
										DayOfYearPartitionKey		= @DateDayOfYear 

							SET			@begindate			= DATEADD(DAY,1,@begindate)

				END



---------------------------------------------------
--DimIEStatus
---------------------------------------------------

/*


select 'SELECT		IEStatusID = ' + CAST(r.NSTATUS AS VARCHAR(50)) + ', ' + 
'IEStatusValue = ''' + r.VALUE + ''' UNION '
from DINGODB.dbo.REGIONALIZED_IE_STATUS r


*/

INSERT		dbo.DimIEStatus (IEStatusID,IEStatusValue,CreateDate)
SELECT
			x.IEStatusID,
			x.IEStatusValue,
			CreateDate = GETUTCDATE()
FROM
	(
				SELECT		IEStatusID = 1, IEStatusValue = 'Idle' UNION 
				SELECT		IEStatusID = 2, IEStatusValue = 'Scheduled' UNION 
				SELECT		IEStatusID = 3, IEStatusValue = 'Dispatched' UNION 
				SELECT		IEStatusID = 4, IEStatusValue = 'Copied' UNION 
				SELECT		IEStatusID = 5, IEStatusValue = 'Loading' UNION 
				SELECT		IEStatusID = 6, IEStatusValue = 'Unloading' UNION 
				SELECT		IEStatusID = 7, IEStatusValue = 'Loaded' UNION 
				SELECT		IEStatusID = 8, IEStatusValue = 'Triggered' UNION 
				SELECT		IEStatusID = 9, IEStatusValue = 'Playing' UNION 
				SELECT		IEStatusID = 10, IEStatusValue = 'Stopped' UNION 
				SELECT		IEStatusID = 11, IEStatusValue = 'Aborted' UNION 
				SELECT		IEStatusID = 12, IEStatusValue = 'Expired' UNION 
				SELECT		IEStatusID = 13, IEStatusValue = 'Played' UNION 
				SELECT		IEStatusID = 14, IEStatusValue = 'Error' UNION 
				SELECT		IEStatusID = 15, IEStatusValue = 'Deleted' UNION 
				SELECT		IEStatusID = 16, IEStatusValue = 'Deleting' UNION 
				SELECT		IEStatusID = 17, IEStatusValue = 'Dispatching' UNION 
				SELECT		IEStatusID = 18, IEStatusValue = 'Undispatching' UNION 
				SELECT		IEStatusID = 19, IEStatusValue = 'Scheduling' UNION 
				SELECT		IEStatusID = 20, IEStatusValue = 'Unchecked' UNION 
				SELECT		IEStatusID = 21, IEStatusValue = 'Conflict' UNION 
				SELECT		IEStatusID = 22, IEStatusValue = 'Expiring' UNION 
				SELECT		IEStatusID = 23, IEStatusValue = 'Ignore' UNION 
				SELECT		IEStatusID = 24, IEStatusValue = 'NoNetworkFeed' 
	) x
		LEFT JOIN	dbo.DimIEStatus y (NOLOCK)
		ON			x.IEStatusID				= y.IEStatusID
		AND			x.IEStatusValue				= y.IEStatusValue
		WHERE		y.DimIEStatusID		IS NULL
		ORDER BY	x.IEStatusID

SELECT * FROM dbo.DimIEStatus




---------------------------------------------------
--DimIEConflictStatus
---------------------------------------------------

/*


select 'SELECT		IEConflictStatusID = ' + CAST(r.NSTATUS AS VARCHAR(50)) + ', ' + 
'IEConflictStatusValue = ''' + r.VALUE + ''' UNION '
from DINGODB.dbo.REGIONALIZED_IE_CONFLICT_STATUS r


*/

INSERT		dbo.DimIEConflictStatus (IEConflictStatusID,IEConflictStatusValue,CreateDate)
SELECT
			x.IEConflictStatusID,
			x.IEConflictStatusValue,
			CreateDate = GETUTCDATE()
FROM
	(
					SELECT		IEConflictStatusID = 100, IEConflictStatusValue = '' UNION 
					SELECT		IEConflictStatusID = 101, IEConflictStatusValue = 'Invalid Zone' UNION 
					SELECT		IEConflictStatusID = 102, IEConflictStatusValue = 'Invalid Channel' UNION 
					SELECT		IEConflictStatusID = 103, IEConflictStatusValue = 'Time Error' UNION 
					SELECT		IEConflictStatusID = 104, IEConflictStatusValue = 'Trigger Error' UNION 
					SELECT		IEConflictStatusID = 105, IEConflictStatusValue = 'Count Error' UNION 
					SELECT		IEConflictStatusID = 106, IEConflictStatusValue = 'Duration Error' UNION 
					SELECT		IEConflictStatusID = 107, IEConflictStatusValue = 'Video Conflict' UNION 
					SELECT		IEConflictStatusID = 108, IEConflictStatusValue = 'TC Reject' UNION 
					SELECT		IEConflictStatusID = 109, IEConflictStatusValue = 'Late' UNION 
					SELECT		IEConflictStatusID = 110, IEConflictStatusValue = 'No Tone' UNION 
					SELECT		IEConflictStatusID = 111, IEConflictStatusValue = 'Down' UNION 
					SELECT		IEConflictStatusID = 112, IEConflictStatusValue = 'Offline' UNION 
					SELECT		IEConflictStatusID = 113, IEConflictStatusValue = 'Daylight ST' UNION 
					SELECT		IEConflictStatusID = 114, IEConflictStatusValue = 'Partial' UNION 
					SELECT		IEConflictStatusID = 115, IEConflictStatusValue = 'System Error' UNION 
					SELECT		IEConflictStatusID = 116, IEConflictStatusValue = 'Decoder Error' UNION 
					SELECT		IEConflictStatusID = 117, IEConflictStatusValue = 'Play Timeout' UNION 
					SELECT		IEConflictStatusID = 118, IEConflictStatusValue = 'Switch Error' UNION 
					SELECT		IEConflictStatusID = 119, IEConflictStatusValue = 'Video Detect Error' UNION 
					SELECT		IEConflictStatusID = 120, IEConflictStatusValue = 'Audio Detect Error' UNION 
					SELECT		IEConflictStatusID = 121, IEConflictStatusValue = 'Interconnect Collision' UNION 
					SELECT		IEConflictStatusID = 122, IEConflictStatusValue = 'Ignored Collision' UNION 
					SELECT		IEConflictStatusID = 123, IEConflictStatusValue = 'Spots Skipped' UNION 
					SELECT		IEConflictStatusID = 124, IEConflictStatusValue = 'Restarted' UNION 
					SELECT		IEConflictStatusID = 125, IEConflictStatusValue = 'Disabled' UNION 
					SELECT		IEConflictStatusID = 126, IEConflictStatusValue = 'No Playable Spots' UNION 
					SELECT		IEConflictStatusID = 127, IEConflictStatusValue = 'Decoder Collision' UNION 
					SELECT		IEConflictStatusID = 128, IEConflictStatusValue = 'Splice Error' UNION 
					SELECT		IEConflictStatusID = 129, IEConflictStatusValue = 'Maximum Bandwidth Exceeded'  
	) x
		LEFT JOIN	dbo.DimIEConflictStatus y (NOLOCK)
		ON			x.IEConflictStatusID				= y.IEConflictStatusID
		AND			x.IEConflictStatusValue				= y.IEConflictStatusValue
		WHERE		y.DimIEConflictStatusID		IS NULL
		ORDER BY	x.IEConflictStatusID

SELECT * FROM dbo.DimIEConflictStatus




---------------------------------------------------
--DimSpotStatus
---------------------------------------------------

/*


select 'SELECT		SpotStatusID = ' + CAST(r.NSTATUS AS VARCHAR(50)) + ', ' + 
'SpotConflictStatusValue = ''' + r.VALUE + ''' UNION '
from DINGODB.dbo.REGIONALIZED_SPOT_STATUS r


*/

INSERT		dbo.DimSpotStatus (SpotStatusID,SpotStatusValue,CreateDate)
SELECT
			x.SpotStatusID,
			x.SpotStatusValue,
			CreateDate = GETUTCDATE()
FROM
	(
					SELECT		SpotStatusID = 1, SpotStatusValue = 'Idle' UNION 
					SELECT		SpotStatusID = 2, SpotStatusValue = 'Copied' UNION 
					SELECT		SpotStatusID = 3, SpotStatusValue = 'Loaded' UNION 
					SELECT		SpotStatusID = 4, SpotStatusValue = 'Playing' UNION 
					SELECT		SpotStatusID = 5, SpotStatusValue = 'Done' UNION 
					SELECT		SpotStatusID = 6, SpotStatusValue = 'Error' UNION 
					SELECT		SpotStatusID = 7, SpotStatusValue = 'Conflict' UNION 
					SELECT		SpotStatusID = 8, SpotStatusValue = 'Unchecked' UNION 
					SELECT		SpotStatusID = 9, SpotStatusValue = 'Skipped' UNION 
					SELECT		SpotStatusID = 10, SpotStatusValue = 'Ignored' 
 	) x
		LEFT JOIN	dbo.DimSpotStatus y (NOLOCK)
		ON			x.SpotStatusID					= y.SpotStatusID
		AND			x.SpotStatusValue				= y.SpotStatusValue
		WHERE		y.DimSpotStatusID		IS NULL
		ORDER BY	x.SpotStatusID

SELECT * FROM dbo.DimSpotStatus



---------------------------------------------------
--DimSpotConflictStatus
---------------------------------------------------

/*


select 'SELECT		SpotConflictStatusID = ' + CAST(r.NSTATUS AS VARCHAR(50)) + ', ' + 
'SpotConflictStatusValue = ''' + r.VALUE + ''' UNION '
from DINGODB.dbo.REGIONALIZED_SPOT_CONFLICT_STATUS r


*/

INSERT		dbo.DimSpotConflictStatus (SpotConflictStatusID,SpotConflictStatusValue,CreateDate)
SELECT
			x.SpotConflictStatusID,
			x.SpotConflictStatusValue,
			CreateDate = GETUTCDATE()
FROM
	(
					SELECT		SpotConflictStatusID = 0, SpotConflictStatusValue = 'None' UNION 
					SELECT		SpotConflictStatusID = 1, SpotConflictStatusValue = 'Video Not Found' UNION 
					SELECT		SpotConflictStatusID = 2, SpotConflictStatusValue = 'Duration Error' UNION 
					SELECT		SpotConflictStatusID = 3, SpotConflictStatusValue = 'System Error' UNION 
					SELECT		SpotConflictStatusID = 4, SpotConflictStatusValue = 'Decoder Error' UNION 
					SELECT		SpotConflictStatusID = 5, SpotConflictStatusValue = 'Play Timeout' UNION 
					SELECT		SpotConflictStatusID = 6, SpotConflictStatusValue = 'Switch Error' UNION 
					SELECT		SpotConflictStatusID = 7, SpotConflictStatusValue = 'Video Detect Error' UNION 
					SELECT		SpotConflictStatusID = 8, SpotConflictStatusValue = 'Audio Detect Error' UNION 
					SELECT		SpotConflictStatusID = 9, SpotConflictStatusValue = 'Interconnect Collision' UNION 
					SELECT		SpotConflictStatusID = 10, SpotConflictStatusValue = 'Ignored Collision' UNION 
					SELECT		SpotConflictStatusID = 11, SpotConflictStatusValue = 'Play Stopped' UNION 
					SELECT		SpotConflictStatusID = 12, SpotConflictStatusValue = 'Play Aborted' UNION 
					SELECT		SpotConflictStatusID = 13, SpotConflictStatusValue = 'Late Copy' UNION 
					SELECT		SpotConflictStatusID = 14, SpotConflictStatusValue = 'No Tone' UNION 
					SELECT		SpotConflictStatusID = 15, SpotConflictStatusValue = 'Down' UNION 
					SELECT		SpotConflictStatusID = 16, SpotConflictStatusValue = 'Deleted' UNION 
					SELECT		SpotConflictStatusID = 17, SpotConflictStatusValue = 'Restarted' UNION 
					SELECT		SpotConflictStatusID = 18, SpotConflictStatusValue = 'Invalid AUX/NUL' UNION 
					SELECT		SpotConflictStatusID = 19, SpotConflictStatusValue = 'Disabled' UNION 
					SELECT		SpotConflictStatusID = 20, SpotConflictStatusValue = 'Decoder Collision' UNION 
					SELECT		SpotConflictStatusID = 21, SpotConflictStatusValue = 'Splice Error' UNION 
					SELECT		SpotConflictStatusID = 22, SpotConflictStatusValue = 'Maximum Bandwidth Exceeded' UNION 
					SELECT		SpotConflictStatusID = 100, SpotConflictStatusValue = 'Successful Response' UNION 
					SELECT		SpotConflictStatusID = 101, SpotConflictStatusValue = 'Unknown Failure' UNION 
					SELECT		SpotConflictStatusID = 102, SpotConflictStatusValue = 'Invalid Version' UNION 
					SELECT		SpotConflictStatusID = 103, SpotConflictStatusValue = 'Access Denied' UNION 
					SELECT		SpotConflictStatusID = 104, SpotConflictStatusValue = 'Invalid/Unknown ChannelName' UNION 
					SELECT		SpotConflictStatusID = 105, SpotConflictStatusValue = 'Invalid Physical Connection' UNION 
					SELECT		SpotConflictStatusID = 106, SpotConflictStatusValue = 'No Configuration Found' UNION 
					SELECT		SpotConflictStatusID = 107, SpotConflictStatusValue = 'Invalid Configuration' UNION 
					SELECT		SpotConflictStatusID = 108, SpotConflictStatusValue = 'Splice Failed - Unknown Failure' UNION 
					SELECT		SpotConflictStatusID = 109, SpotConflictStatusValue = 'Splice Collision' UNION 
					SELECT		SpotConflictStatusID = 110, SpotConflictStatusValue = 'No Insertion Channel Found' UNION 
					SELECT		SpotConflictStatusID = 111, SpotConflictStatusValue = 'No Primary Channel Found' UNION 
					SELECT		SpotConflictStatusID = 112, SpotConflictStatusValue = 'Splice_Request Was Too Late' UNION 
					SELECT		SpotConflictStatusID = 113, SpotConflictStatusValue = 'No Splice Point Was Found' UNION 
					SELECT		SpotConflictStatusID = 114, SpotConflictStatusValue = 'Splice Queue Full' UNION 
					SELECT		SpotConflictStatusID = 115, SpotConflictStatusValue = 'Session Playback Suspect' UNION 
					SELECT		SpotConflictStatusID = 116, SpotConflictStatusValue = 'Insertion Aborted' UNION 
					SELECT		SpotConflictStatusID = 117, SpotConflictStatusValue = 'Invalid Cue Message' UNION 
					SELECT		SpotConflictStatusID = 118, SpotConflictStatusValue = 'Splicing Device Does Not Exist' UNION 
					SELECT		SpotConflictStatusID = 119, SpotConflictStatusValue = 'Init_Request Refused' UNION 
					SELECT		SpotConflictStatusID = 120, SpotConflictStatusValue = 'Unknown MessageID' UNION 
					SELECT		SpotConflictStatusID = 121, SpotConflictStatusValue = 'Invalid SessionID' UNION 
					SELECT		SpotConflictStatusID = 122, SpotConflictStatusValue = 'Session Did Not Complete' UNION 
					SELECT		SpotConflictStatusID = 123, SpotConflictStatusValue = 'Invalid Request Message data( )' UNION 
					SELECT		SpotConflictStatusID = 124, SpotConflictStatusValue = 'Descriptor Not Implemented' UNION 
					SELECT		SpotConflictStatusID = 125, SpotConflictStatusValue = 'Channel Override' UNION 
					SELECT		SpotConflictStatusID = 126, SpotConflictStatusValue = 'Insertion Channel Started Early' UNION 
					SELECT		SpotConflictStatusID = 127, SpotConflictStatusValue = 'Playback Rate Below Threshold' UNION 
					SELECT		SpotConflictStatusID = 128, SpotConflictStatusValue = 'PMT changed' UNION 
					SELECT		SpotConflictStatusID = 129, SpotConflictStatusValue = 'Invalid message size' UNION 
					SELECT		SpotConflictStatusID = 130, SpotConflictStatusValue = 'Invalid message syntax' UNION 
					SELECT		SpotConflictStatusID = 131, SpotConflictStatusValue = 'Port Collision Error' UNION 
					SELECT		SpotConflictStatusID = 132, SpotConflictStatusValue = 'Splice Failed - EAS active' UNION 
					SELECT		SpotConflictStatusID = 133, SpotConflictStatusValue = 'Insertion Component Not Found' UNION 
					SELECT		SpotConflictStatusID = 134, SpotConflictStatusValue = 'Resources Not Available' UNION 
					SELECT		SpotConflictStatusID = 135, SpotConflictStatusValue = 'Component Mismatch' 
  	) x
		LEFT JOIN	dbo.DimSpotConflictStatus y (NOLOCK)
		ON			x.SpotConflictStatusID					= y.SpotConflictStatusID
		AND			x.SpotConflictStatusValue				= y.SpotConflictStatusValue
		WHERE		y.SpotConflictStatusID		IS NULL
		ORDER BY	x.SpotConflictStatusID

SELECT * FROM dbo.DimSpotConflictStatus



