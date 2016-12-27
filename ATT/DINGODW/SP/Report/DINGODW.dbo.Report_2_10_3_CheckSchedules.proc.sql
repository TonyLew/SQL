

USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.Report_2_10_3_CheckSchedules'), 0) > 0 
	DROP PROCEDURE dbo.Report_2_10_3_CheckSchedules
GO

CREATE PROCEDURE dbo.Report_2_10_3_CheckSchedules 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@UseUTC						INT				= NULL,
				@ServerAddress				VARCHAR(50)		= NULL,
				@DATE						DATETIME		= NULL,
				@VHO						VARCHAR(50)		= NULL,
				@ServerName					VARCHAR(50)		= NULL,
				@GIVEBACKS					VARCHAR(200)	= '''ECL'',''FSCLHD'',''FSOHCL'',''GALA'',''STO'',''STYLE'',''TV_1'',''None'''
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
// Module:  dbo.Report_2_10_3_CheckSchedules
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate CheckSchedules report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_3_CheckSchedules.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_3_CheckSchedules	
//								@RegionID			= 1,
//								@SDBSourceID		= 1,
//								@SDBName			= '',
//								@UTCOffset			= NULL,
//								@UseUTC				= NULL,
//								@ServerAddress		= '',
//								@DATE				= '2013-09-23',
//								@VHO				= '',
//								@ServerName			= '',
//								@GIVEBACKS			= '''ECL'',''FSCLHD'',''FSOHCL'',''GALA'',''STO'',''STYLE'',''TV_1'',''None'''
//
*/ 
BEGIN

				--SELECT			@Title								= @ServerName + ' - ' + @VHO

				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				SET				@DATE													= ISNULL( @DATE,DATEADD(DAY, 1, GETUTCDATE()) )

				DECLARE			@DYPartition											INT
				SELECT			@DYPartition											= DATEPART( DAYOFYEAR,@DATE )


				INSERT			#tmp_AllSpots
							(
									VHO,
									Ntwrk,
									CH,
									LocalValue,
									ICValue,
									Conflict,
									LocalFlag,
									ICFlag,
									GiveBack
							)
				SELECT			VHO														= x.VHO,
								Ntwrk													= x.Ntwrk,
								CH														= x.CH,
								LocalValue												= x.LocalSUM,
								ICValue													= CASE WHEN x.GiveBack = 1 THEN CAST( x.ICSUM AS VARCHAR(50) ) + ' - GB' ELSE CAST( x.ICSUM AS VARCHAR(50) ) END,
								Conflict												= x.Conflict,
								LocalFlag												= CASE WHEN x.LocalSUM <> 0 THEN 1 ELSE 0 END,
								ICFlag													= CASE WHEN x.ICSUM <> 0 THEN 1 ELSE 0 END,
								GiveBack												= x.GiveBack 
				FROM			(
									SELECT			VHO									= IU.ZoneName,
													Ntwrk								= IU.ChannelName,
													CH									= IU.CHANNEL,
													LocalSUM							= SUM(CASE WHEN IE.SOURCE_ID = 1 THEN 1 ELSE 0 END),
													ICSUM								= SUM(CASE WHEN IE.SOURCE_ID = 2 THEN 1 ELSE 0 END),
													Conflict							= SUM(CASE WHEN IE.CONFLICT_STATUS IN (103, 107) THEN 1 ELSE 0 END),
													GiveBack							= CASE WHEN CHARINDEX('''' + IU.ChannelName + '''',@GIVEBACKS) > 0 THEN 1 ELSE 0 END
									FROM			
												(
													SELECT		IU_ID 
													FROM		dbo.XSEU x WITH (NOLOCK)
													JOIN		dbo.DimIU y WITH (NOLOCK)
													ON			x.DimIUID						= y.DimIUID
													AND			x.DayOfYearPartitionKey			= y.IEDayOfYearPartitionKey
													WHERE		y.IEDayOfYearPartitionKey		= @DYPartition
													AND			x.DimDateDay					= @DATE 
													GROUP BY	y.IU_ID 
												) IE2
									INNER JOIN		dbo.DimIU IU WITH (NOLOCK) 
									ON				IE2.IU_ID							= IU.IU_ID
									LEFT JOIN		dbo.DimIE IE (NOLOCK) 
									ON				IE.IU_ID							= IE2.IU_ID
									--AND				CONVERT(DATE,ISNULL(IE.SCHED_DATE_TIME,@DATE)) = CONVERT(DATE,@DATE) BETWEEN @DATE AND @DATE
									WHERE			IU.ZoneName							= ISNULL(@VHO,IU.ZoneName) 
									AND				IU.ChannelName						NOT LIKE '%ALT%'
									GROUP BY		IU.ZoneName,
													IU.ChannelName, 
													IU.CHANNEL
								) x


END


GO


