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
// Module:  DINGODW database creation script.
// Created: 2014-Jul-01
// Author:  Tony Lew
// 
// Purpose: Database creation and objects.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 

USE [master]
GO
/****** Object:  Database [DINGODW]    Script Date: 11/1/2013 9:34:11 PM ******/
ALTER DATABASE [DINGODW] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
ALTER DATABASE [DINGODW] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DINGODW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DINGODW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DINGODW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DINGODW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DINGODW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DINGODW] SET ARITHABORT OFF 
GO
ALTER DATABASE [DINGODW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DINGODW] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DINGODW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DINGODW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DINGODW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DINGODW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DINGODW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DINGODW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DINGODW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DINGODW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DINGODW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DINGODW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DINGODW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DINGODW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DINGODW] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [DINGODW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DINGODW] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [DINGODW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DINGODW] SET RECOVERY FULL 
GO
ALTER DATABASE [DINGODW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DINGODW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DINGODW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DINGODW] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DINGODW', N'ON'
GO
ALTER DATABASE [DINGODW] SET  MULTI_USER 
GO

-----------------------------------------------------------------------------------------------------------------
--PARTITION CREATION 
-----------------------------------------------------------------------------------------------------------------


USE DINGODW
GO

--DROP PARTITION FUNCTION [DayOfYearPartition]
CREATE PARTITION FUNCTION [DayOfYearPartition] (INT)
AS RANGE RIGHT FOR VALUES 
(

1,2,3,4,5,6,7,8,9,
10,11,12,13,14,15,16,17,18,19,
20,21,22,23,24,25,26,27,28,29,
30,31,32,33,34,35,36,37,38,39,
40,41,42,43,44,45,46,47,48,49,
50,51,52,53,54,55,56,57,58,59,
60,61,62,63,64,65,66,67,68,69,
70,71,72,73,74,75,76,77,78,79,
80,81,82,83,84,85,86,87,88,89,
90,91,92,93,94,95,96,97,98,99,

100,101,102,103,104,105,106,107,108,109,
110,111,112,113,114,115,116,117,118,119,
120,121,122,123,124,125,126,127,128,129,
130,131,132,133,134,135,136,137,138,139,
140,141,142,143,144,145,146,147,148,149,
150,151,152,153,154,155,156,157,158,159,
160,161,162,163,164,165,166,167,168,169,
170,171,172,173,174,175,176,177,178,179,
180,181,182,183,184,185,186,187,188,189,
190,191,192,193,194,195,196,197,198,199,

200,201,202,203,204,205,206,207,208,209,
210,211,212,213,214,215,216,217,218,219,
220,221,222,223,224,225,226,227,228,229,
230,231,232,233,234,235,236,237,238,239,
240,241,242,243,244,245,246,247,248,249,
250,251,252,253,254,255,256,257,258,259,
260,261,262,263,264,265,266,267,268,269,
270,271,272,273,274,275,276,277,278,279,
280,281,282,283,284,285,286,287,288,289,
290,291,292,293,294,295,296,297,298,299,

300,301,302,303,304,305,306,307,308,309,
310,311,312,313,314,315,316,317,318,319,
320,321,322,323,324,325,326,327,328,329,
330,331,332,333,334,335,336,337,338,339,
340,341,342,343,344,345,346,347,348,349,
350,351,352,353,354,355,356,357,358,359,
360,361,362,363,364,365,366

);






--2. Create Partition Scheme,
--DROP PARTITION SCHEME [DATEPartitionKeyScheme]
--CREATE PARTITION SCHEME [DATEPartitionKeyScheme]
--AS PARTITION [DATEPartitionKey]
--ALL TO ( Partition1 )


--DROP PARTITION SCHEME [DayOfYearPartitionScheme]
CREATE PARTITION SCHEME [DayOfYearPartitionScheme]
AS PARTITION [DayOfYearPartition]
ALL TO ( Partition1 )


USE [DINGODW]
GO

/****** Object:  UserDefinedTableType [dbo].[UDT_Int]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[UDT_Int] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UDT_VarChar50]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[UDT_VarChar50] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UDT_VarChar50]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[UDT_VarChar500] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](500) NULL
)
GO



/****** Object:  Table [dbo].[DBInfo]    Script Date: 11/8/2013 12:19:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DBInfo](
	[DBInfoID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DBInfo] PRIMARY KEY CLUSTERED 
(
	[DBInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[DBInfo] ADD  CONSTRAINT [DF_DBInfo_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[DBInfo] ADD  CONSTRAINT [DF_DBInfo_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW DBInfo identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'DBInfoID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual DBInfo Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual DBInfo Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


--Change	DBInfo
Insert		dbo.DBInfo ( Name, Description )
Select		'Version' AS Name, '2.0.0.4646' AS Description
GO

/****** Object:  StoredProcedure [dbo].[SaveDimRecordCount]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SaveDimRecordCount] 
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
// Module:  dbo.SaveDimRecordCount
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.CountDimensionDate table to save record counts for each date and each SDBSourceID for each dimension.  
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.SaveDimRecordCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.SaveDimRecordCount	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON



				UPDATE				dbo.CountDimensionDate
				SET					DimensionCount												= r.TotalRecords,
									UpdateDate													= GETUTCDATE()
				FROM				#TotalCountByDay r
				WHERE				CountDimensionDate.SDBSourceID								= r.SDBSourceID
				AND					CountDimensionDate.UTCDateStored							= r.UTCDATE
				AND					CountDimensionDate.DimensionID								= r.DimID
				AND					CountDimensionDate.DimensionCount							<> r.TotalRecords


				INSERT				dbo.CountDimensionDate
								(
									SDBSourceID,
									UTCDateStored,
									DimensionID,
									DimensionCount,
									CreateDate
								)
				SELECT
									SDBSourceID													= r.SDBSourceID,
									UTCDateStored												= r.UTCDATE,
									DimensionID													= r.DimID,
									DimensionCount												= r.TotalRecords,
									CreateDate													= GETUTCDATE()
				FROM				#TotalCountByDay r
				LEFT JOIN			dbo.CountDimensionDate s WITH (NOLOCK)
				ON					r.SDBSourceID												= s.SDBSourceID
				AND					r.UTCDATE 													= s.UTCDateStored
				AND					r.DimID														= s.DimensionID
				WHERE				s.CountDimensionDateID 										IS NULL
				ORDER BY			r.UTCDATE,r.DimID



END

GO
/****** Object:  StoredProcedure [dbo].[SaveFactRecordCount]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveFactRecordCount] 
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
// Module:  dbo.SaveFactRecordCount
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.CountFactDate table to save record counts for each date for each Fact.  
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.SaveFactRecordCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.SaveFactRecordCount	
//
*/ 
BEGIN


				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON


				UPDATE				dbo.CountFactDate
				SET					FactCount													= r.TotalRecords,
									UpdateDate													= GETUTCDATE()
				FROM				#TotalCountByDay r
				WHERE				CountFactDate.UTCDateStored									= r.UTCDATE
				AND					CountFactDate.FactID										= r.FactID
				AND					CountFactDate.FactCount										<> r.TotalRecords


				INSERT				dbo.CountFactDate
								(
									UTCDateStored,
									FactID,
									FactCount,
									CreateDate
								)
				SELECT
									UTCDateStored												= r.UTCDATE,
									FactID														= r.FactID,
									FactCount													= r.TotalRecords,
									CreateDate													= GETUTCDATE()
				FROM				#TotalCountByDay r
				LEFT JOIN			dbo.CountFactDate f WITH (NOLOCK)
				ON					r.UTCDATE 													= f.UTCDateStored
				AND					r.FactID													= f.FactID
				WHERE				f.CountFactDateID 											IS NULL
				ORDER BY			r.UTCDATE,r.FactID


END

GO

/****** Object:  StoredProcedure [dbo].[CheckDimensionCount]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckDimensionCount] 
							@StartingDate		DATE = NULL,
							@EndingDate			DATE = NULL,
							@Complete			BIT OUTPUT,
							@EventLogTypeID		INT OUTPUT
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
// Module:  dbo.CheckDimensionCount
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Check dimension counts for the given date range.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.CheckDimensionCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							DECLARE			@CompleteOUT BIT
//							DECLARE			@EventLogTypeIDOUT INT
//							EXEC			dbo.CheckDimensionCount	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03',
//												@Complete				= @CompleteOUT OUTPUT,
//												@EventLogTypeID			= @EventLogTypeIDOUT OUTPUT
//							SELECT			@CompleteOUT, @EventLogTypeIDOUT
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@TotalDayRangeCount											INT
							DECLARE				@TotalSDBSources											INT
							DECLARE				@TotalRequiredRows											INT
							DECLARE				@TotalActiveRows											INT
							DECLARE				@TotalInComplete											INT
							DECLARE				@TotalDimensions											INT = 4
							DECLARE				@DimensionName_SPOT											VARCHAR(50) = 'SPOT'
							DECLARE				@DimensionName_IE											VARCHAR(50) = 'IE'
							DECLARE				@DimensionName_IU											VARCHAR(50) = 'IU'
							DECLARE				@DimensionName_TB_REQUEST									VARCHAR(50) = 'TB_REQUEST'
							DECLARE				@EndingDateWhereValue										DATE

							SELECT				@Complete													= 0,
												@EventLogTypeID												= 0

							IF					( ISNULL(OBJECT_ID('tempdb..#ActiveDimensionAndDay'), 0) > 0 ) DROP TABLE #ActiveDimensionAndDay
							CREATE TABLE		#ActiveDimensionAndDay ( ID INT IDENTITY(1,1), DateDay DATE, SDBSourceID INT, DimensionID INT, DimensionName VARCHAR(50) )

							IF					( ISNULL(OBJECT_ID('tempdb..#InCompleteDay'), 0) > 0 )		DROP TABLE #InCompleteDay
							CREATE TABLE		#InCompleteDay ( ID INT IDENTITY(1,1), DateDay DATE, SDBSourceID INT, DimensionID INT, DimensionName VARCHAR(50), DimensionCount INT )

							SELECT				@StartingDate												= ISNULL( @StartingDate,GETUTCDATE() )
							SELECT				@EndingDate													= ISNULL( @EndingDate, DATEADD(DAY,1,@StartingDate) )
							SELECT				@EndingDateWhereValue										= DATEADD(DAY,-1,@EndingDate)
							SELECT				@TotalDayRangeCount											= DATEDIFF(DAY,@StartingDate,@EndingDate)

							SELECT				@TotalSDBSources											= COUNT(1)
							FROM				dbo.DimSDBSource d WITH (NOLOCK)
							WHERE				d.Enabled													= 1

							SELECT				@TotalRequiredRows											= @TotalDayRangeCount * @TotalDimensions * @TotalSDBSources

							INSERT				#ActiveDimensionAndDay ( DateDay,SDBSourceID,DimensionID,DimensionName )
							SELECT				dy.DimDate, 
												s.SDBSourceID, 
												d.DimensionID, 
												d.Name
							FROM				dbo.DimDateDay dy WITH (NOLOCK)
							CROSS JOIN			dbo.Dimension d WITH (NOLOCK)
							CROSS JOIN			dbo.DimSDBSource s WITH (NOLOCK)
							WHERE				dy.DimDate													BETWEEN @StartingDate AND @EndingDateWhereValue
							AND					d.Name														IN (@DimensionName_SPOT,@DimensionName_IE,@DimensionName_IU,@DimensionName_TB_REQUEST)
							AND					s.Enabled													= 1
							SELECT				@TotalActiveRows											= @@ROWCOUNT

							IF					( @TotalActiveRows <> @TotalRequiredRows )
							BEGIN
												SELECT		@Complete										= 0
												SELECT		@EventLogTypeID									= -1
												--Log the error that the we are NOT checking the complete number of dimensions.  
												--Possibly due to misspelling of dimension names.  This should be a VERY rare error.
												--Then exit.
												RETURN
							END

							--					Calculate the number of incomplete SDBSourceID per DimensionID per day
							INSERT				#InCompleteDay ( DateDay,SDBSourceID,DimensionID,DimensionName,DimensionCount )
							SELECT				d1.DateDay,
												d1.SDBSourceID,
												d1.DimensionID,
												d1.DimensionName, 
												d2.DimensionCount
							FROM				#ActiveDimensionAndDay d1 WITH (NOLOCK) 
							LEFT JOIN			dbo.CountDimensionDate d2 WITH (NOLOCK) 
							ON					d1.DateDay													= d2.UTCDateStored
							AND					d1.DimensionID												= d2.DimensionID
							WHERE				d2.CountDimensionDateID										IS NULL
							OR					( d2.Enabled = 1 AND d2.DimensionCount = 0 )
							SELECT				@TotalInComplete											= @@ROWCOUNT

							--If there are NO incomplete days in the date range, then return @Complete = 1 else 0.
							SELECT				@Complete													= CASE WHEN (ISNULL(@TotalInComplete,0)  = 0) THEN 1 ELSE 0 END
							SELECT				@EventLogTypeID												= CASE WHEN (@Complete = 1) THEN 1 ELSE 0 END

							DROP TABLE			#ActiveDimensionAndDay
							DROP TABLE			#InCompleteDay


END

GO
/****** Object:  StoredProcedure [dbo].[CheckFactCount]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckFactCount] 
							@StartingDate		DATE = NULL,
							@EndingDate			DATE = NULL,
							@Exists				BIT OUTPUT,
							@EventLogTypeID		INT OUTPUT
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
// Module:  dbo.CheckFactCount
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Check fact counts for the given date range.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.CheckFactCount.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							DECLARE			@ExistsOUT BIT
//							DECLARE			@EventLogTypeIDOUT INT
//							EXEC			dbo.CheckFactCount	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03',
//												@Exists					= @ExistsOUT OUTPUT,
//												@EventLogTypeID			= @EventLogTypeIDOUT OUTPUT
//							SELECT			@ExistsOUT, @EventLogTypeIDOUT
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@TotalDayRangeCount											INT
							DECLARE				@TotalRequiredFactAndDay									INT
							DECLARE				@TotalActiveFactAndDay										INT
							DECLARE				@TotalComplete												INT
							DECLARE				@TotalFacts													INT = 1
							DECLARE				@FactName_XSEU												VARCHAR(50) = 'XSEU'
							--DECLARE				@FactName_IE												VARCHAR(50) = 'IE'
							--DECLARE				@FactName_IU												VARCHAR(50) = 'IU'
							--DECLARE				@FactName_TB_REQUEST										VARCHAR(50) = 'TB_REQUEST'
							DECLARE				@EndingDateWhereValue										DATE

							SELECT				@Exists														= 1,
												@EventLogTypeID												= 0

							IF					( ISNULL(OBJECT_ID('tempdb..#ActiveFactAndDay'), 0) > 0 )	DROP TABLE #ActiveFactAndDay
							CREATE TABLE		#ActiveFactAndDay ( ID INT IDENTITY(1,1), DateDay DATE, FactID INT, FactName VARCHAR(50) )

							IF					( ISNULL(OBJECT_ID('tempdb..#CompleteDay'), 0) > 0 )		DROP TABLE #CompleteDay
							CREATE TABLE		#CompleteDay ( ID INT IDENTITY(1,1), DateDay DATE, FactID INT, FactName VARCHAR(50), FactCount INT )

							SELECT				@StartingDate												= ISNULL( @StartingDate,GETUTCDATE() )
							SELECT				@EndingDate													= ISNULL( @EndingDate, DATEADD(DAY,1,@StartingDate) )
							SELECT				@EndingDateWhereValue										= DATEADD(DAY,-1,@EndingDate)
							SELECT				@TotalDayRangeCount											= DATEDIFF(DAY,@StartingDate,@EndingDate)

							SELECT				@TotalRequiredFactAndDay									= @TotalDayRangeCount * @TotalFacts

							INSERT				#ActiveFactAndDay ( DateDay,FactID,FactName )
							SELECT				dy.DimDate, d.FactID, d.Name
							FROM				dbo.DimDateDay dy WITH (NOLOCK)
							CROSS JOIN			dbo.Fact d WITH (NOLOCK)
							WHERE				dy.DimDate													BETWEEN @StartingDate AND @EndingDateWhereValue
							AND					d.Name														IN (@FactName_XSEU)
							SELECT				@TotalActiveFactAndDay										= @@ROWCOUNT

							IF					( @TotalActiveFactAndDay <> @TotalRequiredFactAndDay )
							BEGIN
												SELECT		@Exists											= 1
												SELECT		@EventLogTypeID									= 1
												--Log the error that the we are NOT checking the complete number of Facts.  
												--Possibly due to misspelling of Fact names.  This should be a VERY rare error.
												--Then exit.
												--Insert into DINGODB.dbo.EventLog table.
												RETURN
							END

							--					Calculate the number of complete days
							INSERT				#CompleteDay ( DateDay,FactID,FactName,FactCount )
							SELECT				d.DateDay,
												d.FactID,
												d.FactName, 
												f.FactCount
							FROM				#ActiveFactAndDay d WITH (NOLOCK) 
							JOIN				dbo.CountFactDate f WITH (NOLOCK) 
							ON					d.DateDay													= f.UTCDateStored
							AND					d.FactID													= f.FactID
							WHERE				f.Enabled													= 1 
							AND					f.FactCount													> 0
							SELECT				@TotalComplete												= @@ROWCOUNT

							--If any of the days to be archived have Facts that are incomplete or missing, then return @Exists = 0 and log the error.
							SELECT				@Exists														= CASE WHEN (ISNULL(@TotalComplete,0) > 0) THEN 1 ELSE 0 END
							SELECT				@EventLogTypeID												= CASE WHEN (@Exists = 1) THEN 1 ELSE 0 END


							DROP TABLE			#ActiveFactAndDay
							DROP TABLE			#CompleteDay


END


GO
/****** Object:  StoredProcedure [dbo].[ComputeHistoricalBoundaries]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ComputeHistoricalBoundaries] 
				@StartDateTime					DATETIME,
				@EndDateTime					DATETIME,
				@UseUTC							INT,
				@UTCHistoricalMarkerDateTime	DATETIME OUTPUT,
				@UTCHistoricalStartDateTime		DATETIME OUTPUT,
				@UTCHistoricalEndDateTime		DATETIME OUTPUT,
				@UTCCurrentStartDateTime		DATETIME OUTPUT,
				@UTCCurrentEndDateTime			DATETIME OUTPUT
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
// Module:  dbo.ComputeHistoricalBoundaries
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Determine the historical and current datetime ranges based on the input parameters.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.ComputeHistoricalBoundaries.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//
//				DECLARE				@UTCHistoricalMarkerDateTimeO			DATETIME
//				DECLARE				@UTCHistoricalStartDateTimeO			DATETIME
//				DECLARE				@UTCHistoricalEndDateTimeO				DATETIME
//				DECLARE				@UTCCurrentStartDateTimeO				DATETIME
//				DECLARE				@UTCCurrentEndDateTimeO					DATETIME
//
//				EXEC				dbo.ComputeHistoricalBoundaries	
//											@StartDateTime					= '2014-06-19 08:00:00',
//											@EndDateTime					= '2014-06-23 20:00:00',
//											@UseUTC							= 1,
//											@UTCHistoricalMarkerDateTime	= @UTCHistoricalMarkerDateTimeO OUTPUT,
//											@UTCHistoricalStartDateTime		= @UTCHistoricalStartDateTimeO OUTPUT,
//											@UTCHistoricalEndDateTime		= @UTCHistoricalEndDateTimeO OUTPUT,
//											@UTCCurrentStartDateTime		= @UTCCurrentStartDateTimeO OUTPUT,
//											@UTCCurrentEndDateTime			= @UTCCurrentEndDateTimeO OUTPUT
//
//				SELECT				@UTCHistoricalMarkerDateTimeO,
//									@UTCHistoricalStartDateTimeO,
//									@UTCHistoricalEndDateTimeO,
//									@UTCCurrentStartDateTimeO,
//									@UTCCurrentEndDateTimeO
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON


				DECLARE			@UTCHourOffset									INT = DATEDIFF(HOUR,GETUTCDATE(),GETDATE())
				DECLARE			@UTCHistoricalMarkerNextDayDateTime				DATETIME
				DECLARE			@UTCStartDateTime								DATETIME
				DECLARE			@UTCEndDateTime									DATETIME
				DECLARE			@UTCHistoricalMarkerDate						DATE

				--				The dataware house marker may NOT always be @UTCToday because the job may not have run.
				--				So we have the last recorded datetime stored here: @UTCHistoricalMarkerDateTime .
				SELECT TOP 1	@UTCHistoricalMarkerDateTime					= UTCDateStored,
								@UTCHistoricalMarkerNextDayDateTime				= DATEADD( DAY,1,@UTCHistoricalMarkerDateTime ),
								@UTCHistoricalMarkerDateTime					= DATEADD( SECOND,86399,@UTCHistoricalMarkerDateTime ) --86399 = seconds per day -1
				FROM			dbo.CountFactDate (NOLOCK)
				ORDER BY		UTCDateStored DESC

				IF				( @StartDateTime IS NULL OR @EndDateTime IS NULL )
								SELECT TOP 1	@StartDateTime					= UTCDateStored,
												@EndDateTime					= @UTCHistoricalMarkerDateTime
								FROM			dbo.CountFactDate (NOLOCK)
								ORDER BY		UTCDateStored 


				SELECT			@UTCStartDateTime								= CASE WHEN @UseUTC = 1 THEN @StartDateTime ELSE DATEADD( HOUR,@UTCHourOffset,@StartDateTime ) END,
								@UTCEndDateTime									= CASE WHEN @UseUTC = 1 THEN @EndDateTime ELSE DATEADD( HOUR,@UTCHourOffset,@EndDateTime ) END


				SELECT			@UTCHistoricalStartDateTime						= CASE WHEN @UTCStartDateTime		< @UTCHistoricalMarkerNextDayDateTime		THEN @UTCStartDateTime						ELSE @UTCHistoricalMarkerDateTime END, 
								@UTCHistoricalEndDateTime						= CASE WHEN @UTCEndDateTime			< @UTCHistoricalMarkerNextDayDateTime		THEN @UTCEndDateTime						ELSE @UTCHistoricalMarkerDateTime END,
								@UTCCurrentStartDateTime						= CASE WHEN @UTCStartDateTime		< @UTCHistoricalMarkerNextDayDateTime		THEN @UTCHistoricalMarkerNextDayDateTime	ELSE @UTCStartDateTime END,
								@UTCCurrentEndDateTime							= CASE WHEN @UTCEndDateTime			< @UTCHistoricalMarkerNextDayDateTime		THEN @UTCHistoricalMarkerNextDayDateTime	ELSE @UTCEndDateTime END



END



GO


/****** Object:  StoredProcedure [dbo].[ETLAllSpotExecute]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLAllSpotExecute] 
				@ParentProcID		INT,
				@SPParamValues		UDT_VarChar500 READONLY,
				@SDBID				UDT_Int READONLY
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
// Module:  dbo.ETLAllSpotExecute
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Traverse all SDBs and execute the command given.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLAllSpotExecute.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				DECLARE		@SDBIDIN UDT_Int 
//				INSERT		@SDBIDIN (value ) values ( 1 )
//				DECLARE		@parametervaluesIN UDT_VarChar50 
//				INSERT		@parametervaluesIN (value ) values ( '5000' )
//				EXEC			dbo.ETLAllSpotExecute	
//									@ParentProcID		= 123,
//									@SPParamValues		= @parametervaluesIN,
//									@SDBID				= @SDBIDIN
//
//
//				SELECT CMD = '', CMDParam = '', CMDType = 'INSERT-EXEC', Name = 'ReportAllSpotReport'

*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				IF				OBJECT_ID('tempdb..#CMDTable') IS NOT NULL DROP TABLE #CMDTable
				CREATE TABLE	#CMDTable		(
													id int identity(1,1),
													RegionID int,  
													SDBSourceID int,  
													SDBSourceSystemID int, 
													SDBSourceSystemName varchar(200), 
													MPEGDBName varchar(200), 
													CurrentCMD nvarchar(MAX)
												)

				IF				OBJECT_ID('tempdb..#ParameterIN') IS NOT NULL DROP TABLE #ParameterIN
				CREATE TABLE	#ParameterIN	(
													id int identity(1,1), 
													Name varchar(256), 
													Type varchar(256), 
													ParameterID int 
												)


				DECLARE			@parentSPName							VARCHAR(100)
				DECLARE			@CMD									NVARCHAR(4000)
				DECLARE			@CMDParam								NVARCHAR(4000)
				DECLARE			@FinalCMD								NVARCHAR(4000)
				DECLARE			@CurrentCMD								NVARCHAR(4000)
				DECLARE			@TotalSDB								INT
				DECLARE			@CurrentSDBID							INT = 1
				DECLARE			@TotalParams							INT
				DECLARE			@i										INT = 1
				DECLARE			@CMDparamsIN							NVARCHAR(MAX)
				DECLARE			@currentparameter						VARCHAR(256)
				DECLARE			@currenttype							VARCHAR(256)
				DECLARE			@currentvalue							VARCHAR(500)
				DECLARE			@currenttypetest						INT
				DECLARE			@TotalSDBID								INT

				DECLARE			@ParmDefinition							NVARCHAR(2000) = N' @CMD NVARCHAR(2000) OUTPUT, @CMDParam NVARCHAR(2000) OUTPUT '
				DECLARE			@ReplicationClusterName					VARCHAR(50)

				SELECT			TOP 1 @TotalSDBID						= r.ID
				FROM			@SDBID r
				ORDER BY		r.ID DESC
				SELECT			@TotalSDBID								= ISNULL(@TotalSDBID, 0)

				SELECT			@parentSPName							= OBJECT_NAME(@ParentProcID)
				IF				(@parentSPName IS NULL) return
				--select			@parentSPName


				INSERT			#ParameterIN ( Name , Type , ParameterID )
				SELECT			b.name, c.name, b.parameter_id 
				FROM			sys.procedures a (NOLOCK)
				JOIN			sys.parameters b (NOLOCK)				ON a.object_id = b.object_id
				--JOIN			sys.systypes c (NOLOCK)					ON b.system_type_id = c.xusertype
				JOIN			sys.types c (NOLOCK)					ON b.user_type_id = c.user_type_id
				WHERE			a.name									= @parentSPName
				AND				b.parameter_id							> 4
				ORDER BY		b.parameter_id
				SELECT			@TotalParams							= SCOPE_IDENTITY()


				--SELECT			@CMD									= CMD, 
				--				@CMDParam								= CMDParam 
				--FROM			[DINGOSDB_HOST].DINGOSDB.dbo.MPEGArticle with (NOLOCK)
				--WHERE			CMDType									= 'INSERT-EXEC' 
				--AND				Name									= @parentSPName

				SELECT			TOP 1 @ReplicationClusterName			= Name 
				FROM			DINGODB.dbo.ReplicationCluster WITH (NOLOCK)
				WHERE			Enabled = 1
				AND				ReplicationClusterID					> 0

				SELECT			@CurrentCMD								=	N'SELECT	@CMD		= CMD,		' +
																			N'			@CMDParam	= CMDParam	' + 
																			N'FROM		['+@ReplicationClusterName+'].DINGOSDB.dbo.MPEGArticle with (NOLOCK) ' +
																			N'WHERE		CMDType		= ''INSERT-EXEC''  ' +
																			N'AND		Name		= ''' + @parentSPName + ''' '
				EXECUTE			sys.sp_executesql						@CurrentCMD, @ParmDefinition, @CMD=@CMD OUTPUT, @CMDParam=@CMDParam OUTPUT


				WHILE			(@i <= @TotalParams AND @i > 0)
				BEGIN


								SELECT		@currentparameter			= a.name,
											@currenttype				= a.type 
								FROM		#ParameterIN a
								WHERE		a.id						= @i

								SELECT		@currentvalue				= ISNULL(a.value , 'Null')
								FROM		@SPParamValues a
								WHERE		a.id						= @i

								SELECT		@currenttypetest			=	CASE 
																				WHEN @currentvalue = 'Null' THEN 3
																				WHEN @currenttype IN ('char','date','datetime','datetime2','datetimeoffset','nchar','ntext','nvarchar','smalldatetime','sysname','time','timestamp','uniqueidentifier','varbinary','varchar') THEN 2
																				WHEN @currenttype IN ('bigint') AND  TRY_PARSE( @currentvalue as bigint ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('bit') THEN 1
																				WHEN @currenttype IN ('date') AND  TRY_PARSE( @currentvalue as date ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('datetime') AND  TRY_PARSE( @currentvalue as datetime ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('datetime2') AND  TRY_PARSE( @currentvalue as datetime2 ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('datetimeoffset') AND  TRY_PARSE( @currentvalue as datetimeoffset ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('decimal') AND  TRY_PARSE( @currentvalue as decimal ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('float') AND  TRY_PARSE( @currentvalue as float ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('int') AND  TRY_PARSE( @currentvalue as int ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('money') AND  TRY_PARSE( @currentvalue as money ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('numeric') AND  TRY_PARSE( @currentvalue as numeric ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('real') AND  TRY_PARSE( @currentvalue as real ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('smalldatetime') AND  TRY_PARSE( @currentvalue as smalldatetime ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('smallint') AND  TRY_PARSE( @currentvalue as smallint ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('smallmoney') AND  TRY_PARSE( @currentvalue as smallmoney ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('time') AND  TRY_PARSE( @currentvalue as time ) IS NOT NULL THEN 1
																				WHEN @currenttype IN ('tinyint') AND  TRY_PARSE( @currentvalue as tinyint ) IS NOT NULL THEN 1
																				ELSE 0
																			END

								IF			(@currenttypetest > 0)
								BEGIN		
											SELECT @CMDparamsIN			=	CASE	
																				WHEN @currenttypetest = 3 AND (@i < @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=' + @currentvalue + ', '
																				WHEN @currenttypetest = 3 AND (@i = @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=' + @currentvalue + ' '
																				WHEN @currenttypetest = 2 AND (@i < @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=''' + @currentvalue + ''', '
																				WHEN @currenttypetest = 1 AND (@i < @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=' + @currentvalue + ', '
																				WHEN @currenttypetest = 2 AND (@i = @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=''' + @currentvalue + ''' '
																				WHEN @currenttypetest = 1 AND (@i = @totalparams)
																				THEN ISNULL(@CMDparamsIN,'') + @currentparameter + '=' + @currentvalue + ' '
																			END
											SET @i = @i + 1
								END
								ELSE		SET @i = 0


				END


				IF				( @i > @totalparams OR @totalparams = 0 )
				BEGIN

								SET				@FinalCMD				=	N'declare @cmd nvarchar(2000) '
								SET				@FinalCMD				=	@FinalCMD + N'declare @paramsIN NVARCHAR(2000) = N''' + @CMDParam + ''' '
								SET				@FinalCMD				=	@FinalCMD + N'set @cmd = N'''+@CMD+''' '

								INSERT			#CMDTable ( RegionID, SDBSourceID,  SDBSourceSystemID, SDBSourceSystemName, MPEGDBName, CurrentCMD )
								SELECT			RegionID				= m.RegionID, 
												SDBSourceID				= a.SDBSourceID,  
												SDBSourceSystemID		= a.SDBSourceSystemID, 
												SDBSourceSystemName		= a.SDBComputerName, 
												MPEGDBName				= 'MPEG' + CAST(SDBSourceSystemID AS VARCHAR(50)), 
												CurrentCMD				=	REPLACE( REPLACE(@FinalCMD, 'MPEGN', 'MPEG' + CAST(SDBSourceSystemID AS VARCHAR(50))), '@ReplicationCluster', d.Name ) + 
																			N'exec sp_executesql @stmt = @cmd, @params = @paramsIN, ' + 
																			'@RegionID		= ' + CAST(m.RegionID AS VARCHAR(50)) + ', ' +
																			'@SDBSourceID	= ' + CAST(a.SDBSourceID AS VARCHAR(50)) + ', ' +
																			'@SDBName		= ''' + CAST(a.SDBComputerName AS VARCHAR(100)) + ''', ' +
																			'@UTCOffset		= ' + CAST(ISNULL(b.UTCOffset, 0) AS VARCHAR(50)) + ' ' +
																			ISNULL(', ' + @CMDparamsIN, '')
								FROM			DINGODB.dbo.SDBSourceSystem a WITH (NOLOCK)
								JOIN			DINGODB.dbo.SDBSource b WITH (NOLOCK)
								ON				a.SDBSourceID			= b.SDBSourceID
								JOIN			DINGODB.dbo.MDBSource m WITH (NOLOCK)
								ON				b.MDBSourceID			= m.MDBSourceID
								JOIN			DINGODB.dbo.ReplicationCluster d WITH (NOLOCK)
								ON				b.ReplicationClusterID	= d.ReplicationClusterID
								LEFT JOIN		@SDBID r
								ON				a.SDBSourceID			= r.Value
								WHERE			a.Role					= CASE WHEN b.SDBStatus = 1 THEN 1 WHEN b.SDBStatus = 5 THEN 2 END
								AND				a.Enabled				= 1
								AND				d.Enabled				= 1
								AND				( r.value IS NOT NULL OR @TotalSDBID = 0)
								SELECT			@TotalSDB				= SCOPE_IDENTITY()
								SELECT			@TotalSDB				= ISNULL(@TotalSDB,0)

				END
				ELSE			SELECT			@TotalSDB				= 0


				WHILE			( @CurrentSDBID <= @TotalSDB )
				BEGIN
								
								SELECT		@CurrentCMD					= a.CurrentCMD
								FROM		#CMDTable a
								WHERE		a.id						= @CurrentSDBID 

								EXECUTE		sys.sp_executesql			@CurrentCMD
								SET			@CurrentSDBID				= @CurrentSDBID + 1

				END

				DROP TABLE		#CMDTable
				DROP TABLE		#ParameterIN

END

GO
/****** Object:  StoredProcedure [dbo].[ETLDimAsset]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLDimAsset] 
							@RegionID			INT = NULL,
							@SDBSourceID		INT = NULL,
							@SDBName			VARCHAR(64) = NULL,
							@UTCOffset			INT = NULL,
							@Override			BIT = 0
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
// Module:  dbo.ETLDimAsset
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimAsset table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimAsset.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimAsset	
//												@RegionID				= 1,
//												@SDBSourceID			= 1,
//												@SDBName				= '',
//												@UTCOffset				= 1,
//												@LastVideoID			= NULL
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@DimID														INT
							DECLARE				@DimName													VARCHAR(50) = 'Asset'
							DECLARE				@InsertedRows												TABLE ( ID int identity(1,1), DimAssetID int, RegionID int )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )	DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID int IDENTITY(1,1), DimID int, DimName varchar(50), DayOfYearPartitionKey int, UTCDate date, SDBSourceID int, TotalRecords int )

							SELECT				@DimID														= d.DimensionID
							FROM				dbo.Dimension d WITH (NOLOCK)
							WHERE				d.Name														= @DimName

							DECLARE				@SPParamValuesIN											UDT_VarChar500 
							DECLARE				@SDBIDIN													UDT_Int
							DECLARE				@ProcID														INT = @@PROCID --OBJECT_ID('ETLDimIE')
							DECLARE				@Now														DATETIME = GETUTCDATE()

							--Create a tmp table to store the data from each SDB. We're grabbing/storing the statuses as codes and joining to status tables locally.
							IF					OBJECT_ID('tempdb..#tmp_AllSpots') IS NOT NULL				DROP TABLE #tmp_AllSpots
							CREATE TABLE		#tmp_AllSpots 
											(
												ID															INT IDENTITY(1,1),
												RegionID													INT NOT NULL,
												SDBSourceID													INT NOT NULL,
												SDBName														VARCHAR(64) NOT NULL,
												UTCOffset													INT NOT NULL,
												AssetID 													VARCHAR(32) NOT NULL,
												VIDEO_ID 													VARCHAR(32) NOT NULL,
												FRAMES	 													INT NULL,
												CODE 														VARCHAR(65) NULL,
												DESCRIPTION													VARCHAR(65) NULL,
												VALUE 														INT NULL,
												FPS 														INT NULL,
												Length	 													INT NULL
											)


							IF					NOT EXISTS(SELECT TOP 1 1 FROM dbo.DimAsset WITH (NOLOCK) ORDER BY DimAssetID DESC)
												SELECT		@Override			= 1

							INSERT				@SPParamValuesIN (Value ) VALUES ( CAST( @Override AS VARCHAR(500)) )

							EXEC				dbo.ETLAllSpotExecute			
														@ParentProcID			= @ProcID, 
														@SPParamValues			= @SPParamValuesIN, 
														@SDBID					= @SDBIDIN
							

							BEGIN TRAN


												INSERT				dbo.DimAsset 
																( 
																	RegionID,
																	AssetID,
																	VIDEO_ID,
																	SDBSourceID,
																	FRAMES,
																	CODE,
																	DESCRIPTION,
																	VALUE,
																	FPS,
																	Length,
																	CreateDate
																) 
												OUTPUT				INSERTED.DimAssetID,  INSERTED.RegionID 
												INTO				@InsertedRows
												SELECT				RegionID													= t.RegionID,
																	AssetID														= t.AssetID,
																	VIDEO_ID													= t.VIDEO_ID,
																	SDBSourceID													= 0,
																	FRAMES														= MAX(t.FRAMES),
																	CODE														= MAX(t.CODE),
																	DESCRIPTION													= MAX(t.DESCRIPTION),
																	VALUE														= MAX(t.VALUE),
																	FPS															= MAX(t.FPS),
																	Length														= MAX(t.Length),
																	CreateDate													= @Now
												FROM				#tmp_AllSpots t 
												LEFT JOIN			dbo.DimAsset d
												ON					t.RegionID													= d.RegionID
												AND					t.AssetID													= d.AssetID
												WHERE				d.DimAssetID												IS NULL
												GROUP BY			t.RegionID, t.AssetID, t.VIDEO_ID
												ORDER BY			t.RegionID, t.AssetID, t.VIDEO_ID


												--					This is a dimension that is distinct by RegionID as opposed to SDBSourceID.  
												--					So it is recorded by RegionID in the dbo.CountDimensionDate table.
												INSERT				#TotalCountByDay ( DimID, DimName, DayOfYearPartitionKey, UTCDate, SDBSourceID, TotalRecords )
												SELECT				DimID														= @DimID,
																	DimName														= @DimName,
																	DayOfYearPartitionKey										= DATEPART( DAYOFYEAR,@Now ), 
																	UTCDate														= CONVERT( DATE,@Now,121 ), 
																	SDBSourceID													= s.SDBSourceID, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												JOIN				dbo.DimSDBSource s WITH (NOLOCK)
												ON					x.RegionID 													= s.RegionID 
												WHERE				s.Enabled													= 1
												GROUP BY			s.SDBSourceID


												--					Uses temp table #TotalCountByDay
												EXEC				dbo.SaveDimRecordCount	


							COMMIT

							DROP TABLE			#tmp_AllSpots
							DROP TABLE			#TotalCountByDay


END

GO
/****** Object:  StoredProcedure [dbo].[ETLDimIE]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[ETLDimIEConflictStatus]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLDimIEConflictStatus] 
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
// Module:  dbo.ETLDimIEConflictStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimIEConflictStatus table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimIEConflictStatus.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimIEConflictStatus	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON

				DECLARE				@Total														INT
				
				INSERT				dbo.DimIEConflictStatus ( IEConflictStatusID,IEConflictStatusValue )
				SELECT				t.IEConflictStatusID, 
									t.IEConflictStatusValue
				FROM			(
									SELECT				DISTINCT 
														IEConflictStatusID						= CONFLICT_STATUS, 
														IEConflictStatusValue					= CONFLICT_STATUSValue
									FROM				#tmp_AllSpots x
									WHERE				x.NSTATUS								IS NOT NULL
								) t
				LEFT JOIN			dbo.DimIEConflictStatus d
				ON					t.IEConflictStatusID										= d.IEConflictStatusID
				AND					t.IEConflictStatusValue										= d.IEConflictStatusValue
				WHERE				d.IEConflictStatusID										IS NULL
				SELECT				@Total														= @@ROWCOUNT

				--IF					( @Total > 0 )
				--BEGIN
					--Insert into DINGODB.dbo.EventLog table.
				--END


END

GO
/****** Object:  StoredProcedure [dbo].[ETLDimIEStatus]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLDimIEStatus] 
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
// Module:  dbo.ETLDimIEStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimIEStatus table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimIEStatus.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimIEStatus	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON

				DECLARE				@Total														INT
				
				INSERT				dbo.DimIEStatus ( IEStatusID,IEStatusValue )
				SELECT				t.IEStatusID, 
									t.IEStatusValue
				FROM			(
									SELECT				DISTINCT 
														IEStatusID								= NSTATUS, 
														IEStatusValue							= NSTATUSValue
									FROM				#tmp_AllSpots x
									WHERE				x.NSTATUS								IS NOT NULL
								) t
				LEFT JOIN			dbo.DimIEStatus d
				ON					t.IEStatusID												= d.IEStatusID
				AND					t.IEStatusValue												= d.IEStatusValue
				WHERE				d.IEStatusID												IS NULL
				SELECT				@Total														= @@ROWCOUNT

				--IF					( @Total > 0 )
				--BEGIN
					--Insert into DINGODB.dbo.EventLog table.
				--END


END

GO
/****** Object:  StoredProcedure [dbo].[ETLDimIU]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
							--WHERE				xs.UTCIEDayOfYearPartitionKey								IS NULL


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
												JOIN				dbo.DimChannelMap cm WITH (NOLOCK)							ON		x.RegionID						= cm.RegionID
																																AND		x.IU_ID							= cm.IU_ID
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
/****** Object:  StoredProcedure [dbo].[ETLDimSDBSource]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLDimSDBSource] 
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
// Module:  dbo.ETLDimSDBSource
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimSDBSource table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimSDBSource.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimSDBSource	
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON


							INSERT				dbo.DimSDBSource 
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
							SELECT				SDBSourceID													= s1.SDBSourceID,
												SDBName														= s1.SDBComputerNamePrefix,
												MDBSourceID													= m.MDBSourceID,
												MDBName														= m.MDBComputerNamePrefix,
												RegionID													= r.RegionID,
												RegionName													= r.Name,
												UTCOffset													= s1.UTCOffset,
												Enabled														= 1,
												CreateDate													= GETUTCDATE()
							FROM				DINGODB.dbo.SDBSource s1 WITH (NOLOCK)
							JOIN			(
												SELECT		SDBSourceID
												FROM		DINGODB.dbo.SDBSourceSystem WITH (NOLOCK)
												WHERE		Enabled											= 1
												GROUP BY	SDBSourceID
											) ss															ON		s1.SDBSourceID					= ss.SDBSourceID
							JOIN				DINGODB.dbo.MDBSource m WITH (NOLOCK)						ON		s1.MDBSourceID					= m.MDBSourceID
							JOIN				DINGODB.dbo.Region r WITH (NOLOCK)							ON		m.RegionID						= r.RegionID
							LEFT JOIN			dbo.DimSDBSource s2 WITH (NOLOCK)							ON		s1.SDBSourceID					= s2.SDBSourceID
							WHERE				s2.DimSDBSourceID											IS NULL



END

GO
/****** Object:  StoredProcedure [dbo].[ETLDimSPOT]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[ETLDimSpotConflictStatus]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLDimSpotConflictStatus] 
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
// Module:  dbo.ETLDimSpotConflictStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimSpotConflictStatus table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimSpotConflictStatus.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimSpotConflictStatus	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON

				DECLARE				@Total														INT
				
				INSERT				dbo.DimSpotConflictStatus ( SpotConflictStatusID,SpotConflictStatusValue )
				SELECT				t.SpotConflictStatusID, 
									t.SpotConflictStatusValue
				FROM			(
									SELECT				DISTINCT 
														SpotConflictStatusID					= CONFLICT_STATUS, 
														SpotConflictStatusValue					= CONFLICT_STATUSValue
									FROM				#tmp_AllSpots x
									WHERE				x.NSTATUS								IS NOT NULL
								) t
				LEFT JOIN			dbo.DimSpotConflictStatus d
				ON					t.SpotConflictStatusID										= d.SpotConflictStatusID
				AND					t.SpotConflictStatusValue									= d.SpotConflictStatusValue
				WHERE				d.SpotConflictStatusID										IS NULL
				SELECT				@Total														= @@ROWCOUNT

				--IF					( @Total > 0 )
				--BEGIN
					--Insert into DINGODB.dbo.EventLog table.
				--END


END

GO
/****** Object:  StoredProcedure [dbo].[ETLDimSpotStatus]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLDimSpotStatus] 
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
// Module:  dbo.ETLDimSpotStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimSpotStatus table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimSpotStatus.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimSpotStatus	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON

				DECLARE				@Total														INT
				
				INSERT				dbo.DimSpotStatus ( SpotStatusID,SpotStatusValue )
				SELECT				t.SpotStatusID, 
									t.SpotStatusValue
				FROM			(
									SELECT				DISTINCT 
														SpotStatusID							= NSTATUS, 
														SpotStatusValue							= NSTATUSValue
									FROM				#tmp_AllSpots x
									WHERE				x.NSTATUS								IS NOT NULL
								) t
				LEFT JOIN			dbo.DimSpotStatus d
				ON					t.SpotStatusID												= d.SpotStatusID
				AND					t.SpotStatusValue											= d.SpotStatusValue
				WHERE				d.SpotStatusID												IS NULL
				SELECT				@Total														= @@ROWCOUNT

				--IF					( @Total > 0 )
				--BEGIN
					--Insert into DINGODB.dbo.EventLog table.
				--END


END

GO
/****** Object:  StoredProcedure [dbo].[ETLDimTB_REQUEST]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLDimTB_REQUEST] 
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
// Module:  dbo.ETLDimTB_REQUEST
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			ETL MPEG.dbo.IE to DINGODW.dbo.DimIE.
//					This is all done in UTC time.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimTB_REQUEST.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimTB_REQUEST	
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


							DECLARE				@DimID														INT
							DECLARE				@DimName													VARCHAR(50) = 'TB_REQUEST'
							DECLARE				@InsertedRows												TABLE ( ID int identity(1,1), DimTB_REQUESTID int, UTCIEDayOfYearPartitionKey int, UTCIEDate date, SDBSourceID int )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )	DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID int IDENTITY(1,1), DimID int, DimName varchar(50), DayOfYearPartitionKey int, UTCDate date, SDBSourceID int, TotalRecords int )

							SELECT				@DimID														= d.DimensionID
							FROM				dbo.Dimension d WITH (NOLOCK)
							WHERE				d.Name														= @DimName

							DECLARE				@SPParamValuesIN											UDT_VarChar500 
							DECLARE				@SDBIDIN													UDT_Int
							DECLARE				@ProcID														INT = @@PROCID --OBJECT_ID('ETLDimTB_REQUEST')
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
												TB_ID														INT NOT NULL,
												ZONE_ID														INT NOT NULL,
												IU_ID														INT NOT NULL,
												TB_REQUEST													INT NOT NULL,
												TB_MODE														INT NOT NULL,
												TB_TYPE														INT NULL,
												TB_DAYPART													DATETIME NOT NULL,
												TB_FILE														VARCHAR(128) NOT NULL,
												TB_FILE_DATE												DATETIME NOT NULL,
												STATUS														INT NOT NULL,
												EXPLANATION													VARCHAR(128) NULL,
												TB_MACHINE													VARCHAR(32) NULL,
												TB_MACHINE_TS												DATETIME NULL,
												TB_MACHINE_THREAD											INT NULL,
												REQUESTING_MACHINE											VARCHAR(32) NULL,
												REQUESTING_PORT												INT NULL,
												SOURCE_ID													INT NOT NULL,
												MSGNR														INT NULL,
												TS															BINARY(8) NOT NULL,

												--Derived Columns
												ZoneName													VARCHAR(32) NOT NULL,
												TB_MODE_NAME												VARCHAR(32) NOT NULL,
												REQUEST_NAME												VARCHAR(32) NOT NULL,
												SOURCE_ID_NAME												VARCHAR(32) NOT NULL,
												STATUS_NAME													VARCHAR(32) NOT NULL,
												TYPE_NAME													VARCHAR(32) NOT NULL,
												DAYPART_DATE												DATE NOT NULL,
												DAYPART_DATE_TIME											DATETIME NOT NULL,
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
												FROM			dbo.DimTB_REQUEST  WITH (NOLOCK)
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

												INSERT				dbo.DimTB_REQUEST 
																(
																	RegionID,
																	SDBSourceID,
																	SDBName,
																	UTCOffset,
																	TB_ID,
																	ZONE_ID,
																	IU_ID,
																	TB_REQUEST,
																	TB_MODE,
																	TB_TYPE,
																	TB_DAYPART,
																	TB_FILE,
																	TB_FILE_DATE,
																	STATUS,
																	EXPLANATION,
																	TB_MACHINE,
																	TB_MACHINE_TS,
																	TB_MACHINE_THREAD,
																	REQUESTING_MACHINE,
																	REQUESTING_PORT,
																	SOURCE_ID,
																	MSGNR,
																	TS,

																	ZoneName,
																	TB_MODE_NAME,
																	REQUEST_NAME,
																	SOURCE_ID_NAME,
																	STATUS_NAME,
																	TYPE_NAME,

																	--Derived columns for reporting purposes
																	UTCTB_FILE_DATE,
																	UTCTB_FILE_DATE_TIME,
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
												OUTPUT				INSERTED.DimTB_REQUESTID, INSERTED.UTCIEDayOfYearPartitionKey, INSERTED.UTCIEDate, INSERTED.SDBSourceID
												INTO				@InsertedRows
												SELECT				
																	RegionID													= x.RegionID,
																	SDBSourceID													= x.SDBSourceID,
																	SDBName														= x.SDBName,
																	UTCOffset													= x.UTCOffset,
																	TB_ID														= x.TB_ID,
																	ZONE_ID														= x.ZONE_ID,
																	IU_ID														= x.IU_ID,
																	TB_REQUEST													= x.TB_REQUEST,
																	TB_MODE														= x.TB_MODE,
																	TB_TYPE														= x.TB_TYPE,
																	TB_DAYPART													= x.TB_DAYPART,
																	TB_FILE														= x.TB_FILE,
																	TB_FILE_DATE												= x.TB_FILE_DATE,
																	STATUS														= x.STATUS,
																	EXPLANATION													= x.EXPLANATION,
																	TB_MACHINE													= x.TB_MACHINE,
																	TB_MACHINE_TS												= x.TB_MACHINE_TS,
																	TB_MACHINE_THREAD											= x.TB_MACHINE_THREAD,
																	REQUESTING_MACHINE											= x.REQUESTING_MACHINE,
																	REQUESTING_PORT												= x.REQUESTING_PORT,
																	SOURCE_ID													= x.SOURCE_ID,
																	MSGNR														= x.MSGNR,
																	TS															= x.TS,

																	ZoneName													= x.ZoneName,
																	TB_MODE_NAME												= x.TB_MODE_NAME,
																	REQUEST_NAME												= x.REQUEST_NAME,
																	SOURCE_ID_NAME												= x.SOURCE_ID_NAME,
																	STATUS_NAME													= x.STATUS_NAME,
																	TYPE_NAME													= x.TYPE_NAME,

																	--Derived columns for reporting purposes
																	UTCTB_FILE_DATE												= CONVERT ( DATE,	(DATEADD( HOUR, -x.UTCOffset, x.DAYPART_DATE_TIME )), 121 ),
																	UTCTB_FILE_DATE_TIME										= DATEADD ( HOUR,	x.UTCOffset, x.TB_FILE_DATE ),
																	UTCIEDatetime												= x.UTCIEDatetime,
																	UTCIEDate													= x.UTCIEDate,
																	UTCIEDateYear												= x.UTCIEDateYear,
																	UTCIEDateMonth												= x.UTCIEDateMonth,
																	UTCIEDateDay												= x.UTCIEDateDay,
																	UTCIEDayOfYearPartitionKey									= x.UTCIEDayOfYearPartitionKey,
																	IEDate														= CONVERT ( DATE,	x.DAYPART_DATE, 121 ),
																	IEDateYear													= DATEPART( YEAR,	x.DAYPART_DATE ),
																	IEDateMonth													= DATEPART( MONTH,	x.DAYPART_DATE ),
																	IEDateDay													= DATEPART( DAY,	x.DAYPART_DATE ),
																	IEDayOfYearPartitionKey										= DATEPART( DY,		x.DAYPART_DATE ),
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
												ORDER BY			x.DAYPART_DATE, x.TB_DAYPART


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
/****** Object:  StoredProcedure [dbo].[ETLDimZoneMap]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ETLDimZoneMap] 
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
// Module:  dbo.ETLDimZoneMap
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimSDBSource table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimZoneMap.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.ETLDimZoneMap	
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON


							INSERT				dbo.DimZoneMap 
											( 
												ZoneMapID,
												ZoneName,
												MarketID,
												MarketName,
												ICProviderID,
												ICProviderName,
												ROCID,
												ROCName,
												Enabled,
												CreateDate
											) 
							SELECT				ZoneMapID													= zm1.ZONE_MAP_ID,
												ZoneName													= zm1.ZONE_NAME,
												MarketID													= zm1.MarketID,
												MarketName													= mkt.Name,
												ICProviderID												= zm1.ICProviderID,
												ICProviderName												= IC.Name,
												ROCID														= zm1.ROCID,
												ROCName														= r.Name,
												Enabled														= 1,
												CreateDate													= GETUTCDATE()
							FROM				DINGODB.dbo.ZONE_MAP zm1 WITH (NOLOCK)
							JOIN				DINGODB.dbo.Market mkt WITH (NOLOCK)						ON		zm1.MarketID					= mkt.MarketID
							JOIN				DINGODB.dbo.ICProvider IC WITH (NOLOCK)						ON		zm1.ICProviderID				= IC.ICProviderID
							JOIN				DINGODB.dbo.ROC r WITH (NOLOCK)								ON		zm1.ROCID						= r.ROCID
							LEFT JOIN			dbo.DimZoneMap zm2 WITH (NOLOCK)							ON		zm1.ZONE_NAME					= zm2.ZoneName
							WHERE				zm2.DimZoneMapID												IS NULL



END

GO
/****** Object:  StoredProcedure [dbo].[GetSDBList]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSDBList] 
				--@TotalCount		INT OUTPUT
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
// Module:  dbo.GetSDBList
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.XSEU table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.GetSDBList.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.GetSDBList	
//
*/ 
BEGIN


				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON


				SELECT				d.SDBSourceID
				FROM				dbo.DimSDBSource d WITH (NOLOCK)
				--JOIN				DINGODB.dbo.SDBSource a WITH (NOLOCK)
				--ON					d.SDBSourceID											= a.SDBSourceID
				--JOIN				DINGODB.dbo.SDBSourceSystem b WITH (NOLOCK)
				--ON					a.SDBSourceID											= b.SDBSourceID
				WHERE				d.Enabled												= 1
				--AND					b.Role													= CASE WHEN a.SDBStatus = 1 THEN 1 WHEN a.SDBStatus = 5 THEN 2 END
				--SELECT				@TotalCount												= @@ROWCOUNT

END

GO


/****** Object:  StoredProcedure [dbo].[PopulateFactAssetSummary]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PopulateFactAssetSummary] 
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
// Module:  dbo.PopulateFactAssetSummary
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.FactAssetSummary table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFactAssetSummary.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFactAssetSummary	
//
*/ 
BEGIN


							--					This is deliberately commented because we need to make sure the physical temp table is NOT currently being manipulated.
							--SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'AssetSummary'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), FactAssetSummaryID int, UTCSPOTDayOfYearPartitionKey int, UTCSPOTDayDate date )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )		DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID INT IDENTITY(1,1), FactID INT, FactName VARCHAR(50), DayOfYearPartitionKey INT, UTCDate DATE, TotalRecords int )

							SELECT				@FactID															= f.FactID
							FROM				dbo.Fact f WITH (NOLOCK)
							WHERE				f.Name															= @FactName

							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), TempTableFactSummary1ID INT, DayOfYearPartitionKey INT, DayDate DATE )

							--					Make sure metrics for a particular day DOES NOT exist.
							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
												FROM			dbo.FactAssetSummary  WITH (NOLOCK)
												GROUP BY		UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
											) xs																ON		d.DayDate				= xs.UTCSPOTDayDate
																												AND		d.DayOfYearPartitionKey	= xs.UTCSPOTDayOfYearPartitionKey
							WHERE				xs.UTCSPOTDayOfYearPartitionKey									IS NULL



							BEGIN TRAN

												INSERT				dbo.FactAssetSummary
																(
																	UTCSPOTDayOfYearPartitionKey,
																	UTCSPOTDayDate,
																	SPOTDayOfYearPartitionKey,
																	SPOTDayDate,
																	UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate,
																	DimAssetID,
																	DimSDBSourceID,
																	DimSPOTID,
																	DimIEID,
																	DimIUID,
																	DimTB_REQUESTID,
																	DimSpotStatusID,
																	DimSpotConflictStatusID,
																	DimIEStatusID,
																	DimIEConflictStatusID,
																	SecondsLength,
																	CreateDate
																)
												OUTPUT				INSERTED.FactAssetSummaryID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDayDate
												INTO				@InsertedRows
												SELECT
																	UTCSPOTDayOfYearPartitionKey								= t.UTCSPOTDayOfYearPartitionKey,
																	UTCSPOTDayDate												= t.UTCSPOTDayDate,
																	SPOTDayOfYearPartitionKey									= t.SPOTDayOfYearPartitionKey,
																	SPOTDayDate													= t.SPOTDayDate,
																	UTCIEDayOfYearPartitionKey									= t.UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate												= t.UTCIEDayDate,
																	DimAssetID													= a.DimAssetID,
																	DimSDBSourceID												= t.DimSDBSourceID,
																	DimSPOTID													= t.DimSPOTID,
																	DimIEID														= t.DimIEID,
																	DimIUID														= t.DimIUID,
																	DimTB_REQUESTID												= t.DimTB_REQUESTID,
																	DimSpotStatusID												= t.DimSpotStatusID,
																	DimSpotConflictStatusID										= t.DimSpotConflictStatusID,
																	DimIEStatusID												= t.DimIEStatusID,
																	DimIEConflictStatusID										= t.DimIEConflictStatusID,
																	SecondsLength												= a.Length,
																	CreateDate													= GETUTCDATE()
												FROM				#DayOfYearPartitionSubset d
												JOIN				dbo.TempTableFactSummary1 t WITH (NOLOCK)
												ON					d.DayOfYearPartitionKey										= t.UTCSPOTDayOfYearPartitionKey	
												AND					d.DayDate													= t.UTCSPOTDayDate	
												JOIN				dbo.DimAsset a WITH (NOLOCK)
												ON					t.AssetID													= a.AssetID	
												AND					t.RegionID													= a.RegionID


												INSERT				#TotalCountByDay ( FactID, FactName, DayOfYearPartitionKey, UTCDate, TotalRecords )
												SELECT				FactID														= @FactID,
																	FactName													= @FactName,
																	DayOfYearPartitionKey										= x.UTCSPOTDayOfYearPartitionKey, 
																	UTCDate														= x.UTCSPOTDayDate, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCSPOTDayOfYearPartitionKey, x.UTCSPOTDayDate

												--					Uses Temp Table #TotalCountByDay
												EXEC				dbo.SaveFactRecordCount	


							COMMIT

							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#TotalCountByDay


END

GO
/****** Object:  StoredProcedure [dbo].[PopulateFactBreakMovingAverage]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PopulateFactBreakMovingAverage] 
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
// Module:  dbo.PopulateFactBreakMovingAverage
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.FactBreakMovingAverage table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFactBreakMovingAverage.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFactBreakMovingAverage	
//
*/ 
BEGIN


							--					This is deliberately commented because we need to make sure the physical temp table is NOT currently being manipulated.
							--SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@NumPreviousDays												INT = -7
							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'Break'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), FactBreakMovingAverageID int, UTCIEDayOfYearPartitionKey int, UTCIEDayDate date )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )		DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID INT IDENTITY(1,1), FactID INT, FactName VARCHAR(50), DayOfYearPartitionKey INT, UTCDate DATE, TotalRecords int )

							IF					( ISNULL(OBJECT_ID('tempdb..#UTCDayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #UTCDayOfYearPartitionSubset
							CREATE TABLE		#UTCDayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )

							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )



							SELECT				@FactID															= f.FactID
							FROM				dbo.Fact f WITH (NOLOCK)
							WHERE				f.Name															= @FactName


							--					Make sure metrics for a particular day DOES NOT exist (Done for UTC and NonUTC timezones).
							INSERT				#UTCDayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			IEDayOfYearPartitionKey,IEDayDate
												FROM			dbo.FactBreakMovingAverage  WITH (NOLOCK)
												WHERE			UTC												= 1
												GROUP BY		IEDayOfYearPartitionKey,IEDayDate
											) xs																ON		d.DayDate				= xs.IEDayDate
																												AND		d.DayOfYearPartitionKey	= xs.IEDayOfYearPartitionKey
							WHERE				xs.IEDayOfYearPartitionKey										IS NULL

							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			IEDayOfYearPartitionKey,IEDayDate
												FROM			dbo.FactBreakMovingAverage  WITH (NOLOCK)
												WHERE			UTC												= 0
												GROUP BY		IEDayOfYearPartitionKey,IEDayDate
											) xs																ON		d.DayDate				= xs.IEDayDate
																												AND		d.DayOfYearPartitionKey	= xs.IEDayOfYearPartitionKey
							WHERE				xs.IEDayOfYearPartitionKey										IS NULL


							BEGIN TRAN

												INSERT				dbo.FactBreakMovingAverage
																(
																	IEDayOfYearPartitionKey,
																	IEDayDate,
																	RegionID,
																	RegionName,
																	MarketID,
																	MarketName,
																	ZoneName,
																	NetworkID,
																	NetworkName,
																	ICProviderID,
																	ICProviderName,
																	ROCID,
																	ROCName,
																	ChannelName,
																	ICDailyCount,
																	ATTDailyCount,
																	UTC,
																	CreateDate
																)
												OUTPUT				INSERTED.FactBreakMovingAverageID, INSERTED.IEDayOfYearPartitionKey, INSERTED.IEDayDate
												INTO				@InsertedRows
												SELECT
																	IEDayOfYearPartitionKey										= x.IEDayOfYearPartitionKey,
																	IEDayDate													= x.IEDayDate,
																	RegionID													= x.RegionID,
																	RegionName													= x.RegionName,
																	MarketID													= x.MarketID,
																	MarketName													= x.MarketName,
																	ZoneName													= x.ZoneName,
																	NetworkID													= x.NetworkID,
																	NetworkName													= x.NetworkName,
																	ICProviderID												= x.ICProviderID,
																	ICProviderName												= x.ICProviderName,
																	ROCID														= x.ROCID,
																	ROCName														= x.ROCName,
																	ChannelName													= x.ChannelName,
																	ICDailyCount												= x.ICDailyCount,
																	ATTDailyCount												= x.ATTDailyCount,
																	UTC															= x.UTC,
																	CreateDate													= GETUTCDATE()
												FROM				
																(
																	SELECT		IEDayOfYearPartitionKey							= t.UTCIEDayOfYearPartitionKey,
																				IEDayDate										= t.UTCIEDayDate,
																				RegionID										= t.RegionID,
																				RegionName										= t.RegionName,
																				MarketID										= t.MarketID,
																				MarketName										= t.MarketName,
																				ZoneName										= t.ZoneName,
																				NetworkID										= t.NetworkID,
																				NetworkName										= t.NetworkName,
																				ICProviderID									= t.ICProviderID,
																				ICProviderName									= t.ICProviderName,
																				ROCID											= t.ROCID,
																				ROCName											= t.ROCName,
																				ChannelName										= t.ChannelName,
																				UTC												= 1,
																				ICDailyCount									=	SUM(	CASE	
																																				WHEN t.SourceID = 2 THEN 1
																																				ELSE 0
																																			END
																																		),
																				ATTDailyCount									=	SUM(	CASE	
																																				WHEN t.SourceID = 1 THEN 1
																																				ELSE 0
																																			END
																																		)

																	FROM		#UTCDayOfYearPartitionSubset d
																	JOIN		dbo.TempTableFactSummary1 t WITH (NOLOCK)
																	ON			d.DayOfYearPartitionKey							= t.UTCIEDayOfYearPartitionKey	
																	AND			d.DayDate										= t.UTCIEDayDate	
																	GROUP BY	t.UTCIEDayOfYearPartitionKey,
																				t.UTCIEDayDate,
																				t.RegionID,
																				t.RegionName,
																				t.MarketID,
																				t.MarketName,
																				t.ZoneName,
																				t.NetworkID,
																				t.NetworkName,
																				t.ICProviderID,
																				t.ICProviderName,
																				t.ROCID,
																				t.ROCName,
																				t.ChannelName
																	UNION ALL
																	SELECT		IEDayOfYearPartitionKey							= t.IEDayOfYearPartitionKey,
																				IEDayDate										= t.IEDayDate,
																				RegionID										= t.RegionID,
																				RegionName										= t.RegionName,
																				MarketID										= t.MarketID,
																				MarketName										= t.MarketName,
																				ZoneName										= t.ZoneName,
																				NetworkID										= t.NetworkID,
																				NetworkName										= t.NetworkName,
																				ICProviderID									= t.ICProviderID,
																				ICProviderName									= t.ICProviderName,
																				ROCID											= t.ROCID,
																				ROCName											= t.ROCName,
																				ChannelName										= t.ChannelName,
																				UTC												= 0,
																				ICDailyCount									=	SUM(	CASE	
																																				WHEN t.SourceID = 2 THEN 1
																																				ELSE 0
																																			END
																																		),
																				ATTDailyCount									=	SUM(	CASE	
																																				WHEN t.SourceID = 1 THEN 1
																																				ELSE 0
																																			END
																																		)

																	FROM		#DayOfYearPartitionSubset d
																	JOIN		dbo.TempTableFactSummary1 t WITH (NOLOCK)
																	ON			d.DayOfYearPartitionKey							= t.IEDayOfYearPartitionKey	
																	AND			d.DayDate										= t.IEDayDate	
																	GROUP BY	t.IEDayOfYearPartitionKey,
																				t.IEDayDate,
																				t.RegionID,
																				t.RegionName,
																				t.MarketID,
																				t.MarketName,
																				t.ZoneName,
																				t.NetworkID,
																				t.NetworkName,
																				t.ICProviderID,
																				t.ICProviderName,
																				t.ROCID,
																				t.ROCName,
																				t.ChannelName

																) x


												UPDATE				dbo.FactBreakMovingAverage
												SET					ICMovingAvg7Day												= x.ICAvg7Day,
																	ATTMovingAvg7Day											= x.ATTAvg7Day
												FROM			(
																	SELECT	
																				d1.IEDayDate,
																				d1.UTC,
																				d1.ChannelName,
																				TotalDays 										= COUNT(1),
																				ICAvg7Day 										= SUM(d2.ICDailyCount)/COUNT(1),
																				ATTAvg7Day 										= SUM(d2.ATTDailyCount)/COUNT(1)
																	FROM		dbo.FactBreakMovingAverage d1 WITH (NOLOCK)
																	JOIN 		dbo.FactBreakMovingAverage d2 WITH (NOLOCK)
																	ON			d1.UTC 											= d2.UTC
																	AND			d1.ChannelName 									= d2.ChannelName
																	WHERE		d2.IEDayDate 									BETWEEN DATEADD(DAY,-7,d1.IEDayDate) AND d1.IEDayDate
																	GROUP BY	d1.IEDayDate,
																				d1.UTC,
																				d1.ChannelName
																) x
												WHERE				FactBreakMovingAverage.IEDayDate							= x.IEDayDate
												AND					FactBreakMovingAverage.UTC									= x.UTC
												AND					FactBreakMovingAverage.ChannelName							= x.ChannelName
	

												INSERT				#TotalCountByDay ( FactID, FactName, DayOfYearPartitionKey, UTCDate, TotalRecords )
												SELECT				FactID														= @FactID,
																	FactName													= @FactName,
																	DayOfYearPartitionKey										= x.UTCIEDayOfYearPartitionKey, 
																	UTCDate														= x.UTCIEDayDate, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCIEDayOfYearPartitionKey, x.UTCIEDayDate

												--					Uses Temp Table #TotalCountByDay
												EXEC				dbo.SaveFactRecordCount	


							COMMIT


							DROP TABLE			#UTCDayOfYearPartitionSubset
							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#TotalCountByDay


END

GO
/****** Object:  StoredProcedure [dbo].[PopulateFactIESummary]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PopulateFactIESummary] 
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
// Module:  dbo.PopulateFactIESummary
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.FactIESummary table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFactIESummary.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFactIESummary	
//
*/ 
BEGIN


							--					This is deliberately commented because we need to make sure the physical temp table is NOT currently being manipulated.
							--SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'IESummary'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), FactIESummaryID int, UTCIEDayOfYearPartitionKey int, UTCIEDayDate date )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )		DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID INT IDENTITY(1,1), FactID INT, FactName VARCHAR(50), DayOfYearPartitionKey INT, UTCDate DATE, TotalRecords int )

							SELECT				@FactID															= f.FactID
							FROM				dbo.Fact f WITH (NOLOCK)
							WHERE				f.Name															= @FactName

							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )

							--					Make sure metrics for a particular day DOES NOT exist.
							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			UTCIEDayDate,UTCIEDayOfYearPartitionKey
												FROM			dbo.FactIESummary  WITH (NOLOCK)
												GROUP BY		UTCIEDayDate,UTCIEDayOfYearPartitionKey
											) xs																ON		d.DayDate				= xs.UTCIEDayDate
																												AND		d.DayOfYearPartitionKey	= xs.UTCIEDayOfYearPartitionKey
							WHERE				xs.UTCIEDayOfYearPartitionKey									IS NULL



							BEGIN TRAN

												INSERT				dbo.FactIESummary
																(
																	UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate,
																	IEDayOfYearPartitionKey,
																	IEDayDate,
																	DimIEID,
																	DimIUID,
																	DimTB_REQUESTID,
																	--DimSpotStatusID,
																	--DimSpotConflictStatusID,
																	--DimIEStatusID,
																	--DimIEConflictStatusID,
																	ICScheduleLoaded, 
																	ICScheduleBreakCount,
																	ICMissingMedia,
																	ICMediaPrefixErrors,
																	ICMediaDurationErrors,
																	ICMediaFormatErrors,
																	ATTScheduleLoaded,
																	ATTScheduleBreakCount,
																	ATTMissingMedia,
																	ATTMediaPrefixErrors,
																	ATTMediaDurationErrors,
																	ATTMediaFormatErrors,
																	CreateDate
																)
												OUTPUT				INSERTED.FactIESummaryID, INSERTED.UTCIEDayOfYearPartitionKey, INSERTED.UTCIEDayDate
												INTO				@InsertedRows
												SELECT
																	UTCIEDayOfYearPartitionKey									= t.UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate												= t.UTCIEDayDate,
																	IEDayOfYearPartitionKey										= t.IEDayOfYearPartitionKey,
																	IEDayDate													= t.IEDayDate,
																	DimIEID														= t.DimIEID,
																	DimIUID														= t.DimIUID,
																	DimTB_REQUESTID												= t.DimTB_REQUESTID,
																	--DimSpotStatusID												= t.DimSpotStatusID,
																	--DimSpotConflictStatusID										= t.DimSpotConflictStatusID,
																	--DimIEStatusID												= t.DimIEStatusID,
																	--DimIEConflictStatusID										= t.DimIEConflictStatusID,
																	ICScheduleLoaded											= t.ICScheduleLoaded, 
																	ICScheduleBreakCount										= t.ICScheduleBreakCount, 
																	ICMissingMedia												= t.ICMissingMedia, 
																	ICMediaPrefixErrors											= t.ICMediaPrefixErrors, 
																	ICMediaDurationErrors										= t.ICMediaDurationErrors, 
																	ICMediaFormatErrors											= t.ICMediaFormatErrors, 
																	ATTScheduleLoaded											= t.ATTScheduleLoaded, 
																	ATTScheduleBreakCount										= t.ATTScheduleBreakCount, 
																	ATTMissingMedia												= t.ATTMissingMedia, 
																	ATTMediaPrefixErrors										= t.ATTMediaPrefixErrors, 
																	ATTMediaDurationErrors										= t.ATTMediaDurationErrors, 
																	ATTMediaFormatErrors										= t.ATTMediaFormatErrors, 

																	CreateDate													= GETUTCDATE()
												FROM				#DayOfYearPartitionSubset d
												JOIN				dbo.TempTableFactSummary1 t
												ON					d.DayOfYearPartitionKey										= t.UTCIEDayOfYearPartitionKey	
												AND					d.DayDate													= t.UTCIEDayDate	


												INSERT				#TotalCountByDay ( FactID, FactName, DayOfYearPartitionKey, UTCDate, TotalRecords )
												SELECT				FactID														= @FactID,
																	FactName													= @FactName,
																	DayOfYearPartitionKey										= x.UTCIEDayOfYearPartitionKey, 
																	UTCDate														= x.UTCIEDayDate, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCIEDayOfYearPartitionKey, x.UTCIEDayDate

												--					Uses Temp Table #TotalCountByDay
												EXEC				dbo.SaveFactRecordCount	


							COMMIT

							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#TotalCountByDay


END

GO

/****** Object:  StoredProcedure [dbo].[PopulateFactSpotSummary]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PopulateFactSpotSummary] 
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
// Module:  dbo.PopulateFactSpotSummary
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.FactSpotSummary table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFactSpotSummary.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFactSpotSummary	
//
*/ 
BEGIN


							--					This is deliberately commented because we need to make sure the physical temp table is NOT currently being manipulated.
							--SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'SpotSummary'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), FactSpotSummaryID int, UTCSPOTDayOfYearPartitionKey int, UTCSPOTDayDate date )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )		DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID INT IDENTITY(1,1), FactID INT, FactName VARCHAR(50), DayOfYearPartitionKey INT, UTCDate DATE, TotalRecords int )

							SELECT				@FactID															= f.FactID
							FROM				dbo.Fact f WITH (NOLOCK)
							WHERE				f.Name															= @FactName

							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )

							--					Make sure metrics for a particular day DOES NOT exist.
							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
												FROM			dbo.FactSpotSummary  WITH (NOLOCK)
												GROUP BY		UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
											) xs																ON		d.DayDate				= xs.UTCSPOTDayDate
																												AND		d.DayOfYearPartitionKey	= xs.UTCSPOTDayOfYearPartitionKey
							WHERE				xs.UTCSPOTDayOfYearPartitionKey									IS NULL



							BEGIN TRAN

												INSERT				dbo.FactSpotSummary
																(
																	UTCSPOTDayOfYearPartitionKey,
																	UTCSPOTDayDate,
																	SPOTDayOfYearPartitionKey,
																	SPOTDayDate,
																	UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate,
																	IEDayOfYearPartitionKey,
																	IEDayDate,
																	DimSDBSourceID,
																	DimSPOTID,
																	DimIEID,
																	DimIUID,
																	DimTB_REQUESTID,
																	DimSpotStatusID,
																	DimSpotConflictStatusID,
																	DimIEStatusID,
																	DimIEConflictStatusID,

																	OTHERTotal,
																	DTM_OTHERTotal,
																	DTM_OTHERPlayed,
																	DTM_OTHERFailed,
																	DTM_OTHERNoTone,
																	DTM_OTHERMpegError,
																	DTM_OTHERMissingCopy,
																	OTHERScheduleLoaded,
																	OTHERScheduleBreakCount,
																	OTHERMissingMedia,
																	OTHERMediaPrefixErrors,
																	OTHERMediaDurationErrors,
																	OTHERMediaFormatErrors,

																	ICTotal,
																	DTM_ICTotal,
																	DTM_ICPlayed,
																	DTM_ICFailed,
																	DTM_ICNoTone,
																	DTM_ICMpegError,
																	DTM_ICMissingCopy,
																	ICScheduleLoaded, 
																	ICScheduleBreakCount,
																	ICMissingMedia,
																	ICMediaPrefixErrors,
																	ICMediaDurationErrors,
																	ICMediaFormatErrors,

																	ATTTotal,
																	DTM_ATTTotal,
																	DTM_ATTPlayed,
																	DTM_ATTFailed,
																	DTM_ATTNoTone,
																	DTM_ATTMpegError,
																	DTM_ATTMissingCopy,
																	ATTScheduleLoaded,
																	ATTScheduleBreakCount,
																	ATTMissingMedia,
																	ATTMediaPrefixErrors,
																	ATTMediaDurationErrors,
																	ATTMediaFormatErrors,
																	CreateDate
																)
												OUTPUT				INSERTED.FactSpotSummaryID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDayDate
												INTO				@InsertedRows
												SELECT
																	UTCSPOTDayOfYearPartitionKey								= t.UTCSPOTDayOfYearPartitionKey,
																	UTCSPOTDayDate												= t.UTCSPOTDayDate,
																	SPOTDayOfYearPartitionKey									= t.SPOTDayOfYearPartitionKey,
																	SPOTDayDate													= t.SPOTDayDate,
																	UTCIEDayOfYearPartitionKey									= t.UTCIEDayOfYearPartitionKey,
																	UTCIEDayDate												= t.UTCIEDayDate,
																	IEDayOfYearPartitionKey										= t.IEDayOfYearPartitionKey,
																	IEDayDate													= t.IEDayDate,
																	DimSDBSourceID												= t.DimSDBSourceID,
																	DimSPOTID													= t.DimSPOTID,
																	DimIEID														= t.DimIEID,
																	DimIUID														= t.DimIUID,
																	DimTB_REQUESTID												= t.DimTB_REQUESTID,
																	DimSpotStatusID												= t.DimSpotStatusID,
																	DimSpotConflictStatusID										= t.DimSpotConflictStatusID,
																	DimIEStatusID												= t.DimIEStatusID,
																	DimIEConflictStatusID										= t.DimIEConflictStatusID,

																	OTHERTotal													= t.OTHERTotal,
																	DTM_OTHERTotal												= t.DTM_OTHERTotal,
																	DTM_OTHERPlayed												= t.DTM_OTHERPlayed,
																	DTM_OTHERFailed												= t.DTM_OTHERFailed,
																	DTM_OTHERNoTone												= t.DTM_OTHERNoTone,
																	DTM_OTHERMpegError											= t.DTM_OTHERMpegError,
																	DTM_OTHERMissingCopy										= t.DTM_OTHERMissingCopy,
																	OTHERScheduleLoaded											= t.OTHERScheduleLoaded,
																	OTHERScheduleBreakCount										= t.OTHERScheduleBreakCount,
																	OTHERMissingMedia											= t.OTHERMissingMedia,
																	OTHERMediaPrefixErrors										= t.OTHERMediaPrefixErrors,
																	OTHERMediaDurationErrors									= t.OTHERMediaDurationErrors,
																	OTHERMediaFormatErrors										= t.OTHERMediaFormatErrors,

																	ICTotal														= t.ICTotal,
																	DTM_ICTotal													= t.DTM_ICTotal,
																	DTM_ICPlayed												= t.DTM_ICPlayed,
																	DTM_ICFailed												= t.DTM_ICFailed,
																	DTM_ICNoTone												= t.DTM_ICNoTone,
																	DTM_ICMpegError												= t.DTM_ICMpegError,
																	DTM_ICMissingCopy											= t.DTM_ICMissingCopy,
																	ICScheduleLoaded											= t.ICScheduleLoaded, 
																	ICScheduleBreakCount										= t.ICScheduleBreakCount, 
																	ICMissingMedia												= t.ICMissingMedia, 
																	ICMediaPrefixErrors											= t.ICMediaPrefixErrors, 
																	ICMediaDurationErrors										= t.ICMediaDurationErrors, 
																	ICMediaFormatErrors											= t.ICMediaFormatErrors, 

																	ATTTotal													= t.ATTTotal,
																	DTM_ATTTotal												= t.DTM_ATTTotal,
																	DTM_ATTPlayed												= t.DTM_ATTPlayed,
																	DTM_ATTFailed												= t.DTM_ATTFailed,
																	DTM_ATTNoTone												= t.DTM_ATTNoTone,
																	DTM_ATTMpegError											= t.DTM_ATTMpegError,
																	DTM_ATTMissingCopy											= t.DTM_ATTMissingCopy,
																	ATTScheduleLoaded											= t.ATTScheduleLoaded, 
																	ATTScheduleBreakCount										= t.ATTScheduleBreakCount, 
																	ATTMissingMedia												= t.ATTMissingMedia, 
																	ATTMediaPrefixErrors										= t.ATTMediaPrefixErrors, 
																	ATTMediaDurationErrors										= t.ATTMediaDurationErrors, 
																	ATTMediaFormatErrors										= t.ATTMediaFormatErrors, 
																	CreateDate													= GETUTCDATE()
												FROM				#DayOfYearPartitionSubset d
												JOIN				dbo.TempTableFactSummary1 t
												ON					d.DayOfYearPartitionKey										= t.UTCSPOTDayOfYearPartitionKey	
												AND					d.DayDate													= t.UTCSPOTDayDate	


												INSERT				#TotalCountByDay ( FactID, FactName, DayOfYearPartitionKey, UTCDate, TotalRecords )
												SELECT				FactID														= @FactID,
																	FactName													= @FactName,
																	DayOfYearPartitionKey										= x.UTCSPOTDayOfYearPartitionKey, 
																	UTCDate														= x.UTCSPOTDayDate, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCSPOTDayOfYearPartitionKey, x.UTCSPOTDayDate

												--					Uses Temp Table #TotalCountByDay
												EXEC				dbo.SaveFactRecordCount	


							COMMIT

							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#TotalCountByDay


END

GO
/****** Object:  StoredProcedure [dbo].[PopulateTempTableFactSummary1]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PopulateTempTableFactSummary1] 
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
// Module:  dbo.PopulateTempTableFactSummary1
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.TempTableFactSummary1 table which is a physical temp table.
//					It is denoted with 1 in order to accomodate a future parallel fact table population.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateTempTableFactSummary1.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateTempTableFactSummary1	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03'
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), TempTableFactSummary1ID int, DayOfYearPartitionKey int, DayDate date )

							TRUNCATE TABLE		dbo.TempTableFactSummary1
							INSERT				dbo.TempTableFactSummary1
											(
												UTCSPOTDayOfYearPartitionKey,
												UTCSPOTDayDate,
												SPOTDayOfYearPartitionKey,
												SPOTDayDate,
												UTCIEDayOfYearPartitionKey,
												UTCIEDayDate,
												IEDayOfYearPartitionKey,
												IEDayDate,
												DimSDBSourceID,
												UTCOffset,
												DimSpotID,
												DimSpotStatusID,
												DimSpotConflictStatusID,
												DimIEID,
												DimIEStatusID,
												DimIEConflictStatusID,
												DimIUID,
												DimTB_REQUESTID,
												AssetID,
												RegionID,
												RegionName,
												ChannelName,
												MarketID,
												MarketName,
												ZoneName,
												NetworkID,
												NetworkName,
												ICProviderID,
												ICProviderName,
												ROCID,
												ROCName,
												SourceID,
												ScheduleDate,
												OTHERTotal,
												DTM_OTHERTotal,
												DTM_OTHERPlayed,
												DTM_OTHERFailed,
												DTM_OTHERNoTone,
												DTM_OTHERMpegError,
												DTM_OTHERMissingCopy,
												OTHERScheduleLoaded,
												OTHERScheduleBreakCount,
												OTHERMissingMedia,
												OTHERMediaPrefixErrors,
												OTHERMediaDurationErrors,
												OTHERMediaFormatErrors,
												ICTotal,
												DTM_ICTotal,
												DTM_ICPlayed,
												DTM_ICFailed,
												DTM_ICNoTone,
												DTM_ICMpegError,
												DTM_ICMissingCopy,
												ICScheduleLoaded,
												ICScheduleBreakCount,
												ICMissingMedia,
												ICMediaPrefixErrors,
												ICMediaDurationErrors,
												ICMediaFormatErrors,
												ATTTotal,
												DTM_ATTTotal,
												DTM_ATTPlayed,
												DTM_ATTFailed,
												DTM_ATTNoTone,
												DTM_ATTMpegError,
												DTM_ATTMissingCopy,
												ATTScheduleLoaded,
												ATTScheduleBreakCount,
												ATTMissingMedia,
												ATTMediaPrefixErrors,
												ATTMediaDurationErrors,
												ATTMediaFormatErrors,
												CreateDate
											)
							OUTPUT				INSERTED.TempTableFactSummary1ID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDayDate
							INTO				@InsertedRows
							SELECT				
												UTCSPOTDayOfYearPartitionKey									= spot.UTCSPOTDayOfYearPartitionKey				, 
												UTCSPOTDate														= spot.UTCSPOTDate								, 
												SPOTDayOfYearPartitionKey										= spot.SPOTDayOfYearPartitionKey				, 
												SPOTDayDate														= spot.SPOTDate									, 
												UTCIEDayOfYearPartitionKey										= spot.UTCIEDayOfYearPartitionKey				, 
												UTCIEDate														= spot.UTCIEDate								, 
												IEDayOfYearPartitionKey											= spot.IEDayOfYearPartitionKey					, 
												IEDayDate														= spot.IEDate									, 
												DimSDBSourceID													= x.DimSDBSourceID								,
												UTCOffset														= spot.UTCOffset								,
												DimSpotID														= spot.DimSpotID								,
												DimSpotStatusID													= spot.DimSpotStatusID							,
												DimSpotConflictStatusID											= spot.DimSpotConflictStatusID					,
												DimIEID															= ie.DimIEID									,
												DimIEStatusID													= ie.DimIEStatusID								,
												DimIEConflictStatusID											= ie.DimIEConflictStatusID						,
												DimIUID															= iu.DimIUID									,
												DimTB_REQUESTID													= tb.DimTB_REQUESTID							,
												AssetID															= spot.VIDEO_ID									,
												RegionID														= spot.RegionID									,
												RegionName														= spot.RegionName								,
												ChannelName														= spot.ChannelName								,
												MarketID														= spot.MarketID									,
												MarketName														= spot.MarketName								,
												ZoneName														= spot.ZoneName									,
												NetworkID														= spot.NetworkID								,
												NetworkName														= spot.NetworkName								,
												ICProviderID													= spot.ICProviderID								,
												ICProviderName													= spot.ICProviderName							,
												ROCID															= spot.ROCID									,
												ROCName															= spot.ROCName									,
												SourceID														= ie.SOURCE_ID									,
												ScheduleDate													= spot.UTCSPOTDate								,

												/* OTHER Provider Breakdown */
												OTHERTotal														= CASE WHEN ie.SOURCE_ID NOT IN (1,2) THEN 1 ELSE 0 END,
												DTM_OTHERTotal													= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) THEN 1 ELSE 0 END,
												DTM_OTHERPlayed													= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 5 THEN 1 ELSE 0 END,
												DTM_OTHERFailed													= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) THEN 1 ELSE 0 END,
												DTM_OTHERNoTone													= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS = 14 THEN 1 ELSE 0 END,
												DTM_OTHERMpegError												= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS IN (2, 4, 115, 128) THEN 1 ELSE 0 END,
												DTM_OTHERMissingCopy											= CASE WHEN ie.SOURCE_ID NOT IN (1,2) AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 ELSE 0 END,
												OTHERScheduleLoaded												= tb.UTCTB_FILE_DATE_TIME,
												OTHERScheduleBreakCount											= 0,
												OTHERMissingMedia												= CASE WHEN ie.SOURCE_ID NOT IN (1,2) 
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												OTHERMediaPrefixErrors											= CASE WHEN ie.SOURCE_ID NOT IN (1,2) 
																															AND ie.NSTATUS IN (10,11,12,13,14,24)
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												OTHERMediaDurationErrors										= CASE WHEN ie.SOURCE_ID NOT IN (1,2)  
																															AND ie.NSTATUS IN (10,11,12,13,14,24)
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												OTHERMediaFormatErrors											= CASE WHEN ie.SOURCE_ID NOT IN (1,2) 
																															AND ie.NSTATUS IN (10,11,12,13,14,24)
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,



												/* IC Provider Breakdown */
												ICTotal															= CASE WHEN ie.SOURCE_ID = 2 THEN 1 ELSE 0 END,
												DTM_ICTotal														= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) THEN 1 ELSE 0 END,
												DTM_ICPlayed													= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 5 THEN 1 ELSE 0 END,
												DTM_ICFailed													= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) THEN 1 ELSE 0 END,
												DTM_ICNoTone													= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS = 14 THEN 1 ELSE 0 END,
												DTM_ICMpegError													= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS IN (2, 4, 115, 128) THEN 1 ELSE 0 END,
												DTM_ICMissingCopy												= CASE WHEN ie.SOURCE_ID = 2 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 ELSE 0 END,

												ICScheduleLoaded												= CASE WHEN ie.SOURCE_ID = 2 THEN tb.UTCTB_FILE_DATE_TIME ELSE '1970-01-01' END,
												ICScheduleBreakCount											= CASE WHEN ie.SOURCE_ID = 2 THEN 1 ELSE 0 END,
												ICMissingMedia													= CASE WHEN ie.SOURCE_ID = 2 
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ICMediaPrefixErrors												= CASE WHEN ie.SOURCE_ID = 2
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ICMediaDurationErrors											= CASE WHEN ie.SOURCE_ID = 2
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ICMediaFormatErrors												= CASE WHEN ie.SOURCE_ID = 2
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,


												/* AT&T Breakdown */
												ATTTotal														= CASE WHEN ie.SOURCE_ID = 1 THEN 1 ELSE 0 END,
												DTM_ATTTotal													= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) THEN 1 ELSE 0 END,
												DTM_ATTPlayed													= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 5 THEN 1 ELSE 0 END,
												DTM_ATTFailed													= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) THEN 1 ELSE 0 END,
												DTM_ATTNoTone													= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS = 14 THEN 1 ELSE 0 END,
												DTM_ATTMpegError												= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS = 6 AND spot.CONFLICT_STATUS IN (2, 4, 115, 128) THEN 1 ELSE 0 END,
												DTM_ATTMissingCopy												= CASE WHEN ie.SOURCE_ID = 1 AND ie.NSTATUS IN (10,11,12,13,14,24) AND spot.NSTATUS IN (6, 7) AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 ELSE 0 END,

												ATTScheduleLoaded												= CASE WHEN ie.SOURCE_ID = 1 THEN tb.UTCTB_FILE_DATE_TIME ELSE '1970-01-01' END,
												ATTScheduleBreakCount											= CASE WHEN ie.SOURCE_ID = 1 THEN 1 ELSE 0 END,
												ATTMissingMedia													= CASE WHEN ie.SOURCE_ID = 1
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ATTMediaPrefixErrors											= CASE WHEN ie.SOURCE_ID = 1
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ATTMediaDurationErrors											= CASE WHEN ie.SOURCE_ID = 1
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,
												ATTMediaFormatErrors											= CASE WHEN ie.SOURCE_ID = 1
																															AND ie.NSTATUS IN (10,11,12,13,14,24) 
																															AND spot.NSTATUS IN (6, 7) 
																															AND spot.CONFLICT_STATUS IN (1, 13) THEN 1 
																															ELSE 0 
																														END,

												CreateDate														= GETUTCDATE()

							FROM				#DayOfYearPartition d 
							INNER JOIN			dbo.XSEU x WITH (NOLOCK)
							ON					d.DayOfYearPartitionKey											= x.UTCSPOTDayOfYearPartitionKey	
							AND					d.DayDate														= x.UTCSPOTDayDate	
							JOIN 				dbo.DimSpot spot  WITH (NOLOCK)									ON x.DimSpotID = spot.DimSpotID
							JOIN 				dbo.DimIE ie  WITH (NOLOCK)										ON x.DimIEID = ie.DimIEID
							JOIN				dbo.DimIU iu (NOLOCK)											ON IE.IU_ID = IU.IU_ID
							JOIN				dbo.DimTB_REQUEST tb WITH (NOLOCK)								ON x.DimTB_REQUESTID = tb.DimTB_REQUESTID
							JOIN				dbo.DimSDBSource sdb WITH (NOLOCK)								ON x.DimSDBSourceID = sdb.DimSDBSourceID
							JOIN				dbo.DimAsset a WITH (NOLOCK)									ON spot.VIDEO_ID = a.AssetID
																												AND spot.RegionID = a.RegionID



END

GO
/****** Object:  StoredProcedure [dbo].[PopulateXSEU]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PopulateXSEU] 
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
// Module:  dbo.PopulateXSEU
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.XSEU table which is a bridge table between DimSpot -> DimIE -> DimIU for each date and each SDBSourceID.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateXSEU.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateXSEU	
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@FactID															INT
							DECLARE				@FactName														VARCHAR(50) = 'XSEU'
							DECLARE				@InsertedRows													TABLE ( ID int identity(1,1), XSEUID int, UTCSPOTDayOfYearPartitionKey int, UTCSPOTDayDate date )

							IF					( ISNULL(OBJECT_ID('tempdb..#TotalCountByDay'), 0) > 0 )		DROP TABLE #TotalCountByDay
							CREATE TABLE		#TotalCountByDay ( ID INT IDENTITY(1,1), FactID INT, FactName VARCHAR(50), DayOfYearPartitionKey INT, UTCDate DATE, TotalRecords int )

							SELECT				@FactID															= f.FactID
							FROM				dbo.Fact f WITH (NOLOCK)
							WHERE				f.Name															= @FactName


							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartitionSubset'), 0) > 0 ) DROP TABLE #DayOfYearPartitionSubset
							CREATE TABLE		#DayOfYearPartitionSubset ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )

							--					Make sure metrics for a particular day DOES NOT exist.
							INSERT				#DayOfYearPartitionSubset ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DayDate
							FROM				#DayOfYearPartition d WITH (NOLOCK)
							LEFT JOIN			
											(
												SELECT			UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
												FROM			dbo.XSEU  WITH (NOLOCK)
												GROUP BY		UTCSPOTDayDate,UTCSPOTDayOfYearPartitionKey
											) xs																ON		d.DayDate				= xs.UTCSPOTDayDate
																												AND		d.DayOfYearPartitionKey	= xs.UTCSPOTDayOfYearPartitionKey
							WHERE				xs.UTCSPOTDayOfYearPartitionKey									IS NULL



							BEGIN TRAN

												INSERT				dbo.XSEU
																(
																	DimSpotID,
																	DimIEID,
																	DimIUID,
																	DimTB_REQUESTID,
																	DimSpotStatusID,
																	DimSpotConflictStatusID,
																	DimIEStatusID,
																	DimIEConflictStatusID,
																	DimSDBSourceID,
																	UTCSPOTDayDate,
																	UTCSPOTDayOfYearPartitionKey,
																	UTCIEDayDate,
																	UTCIEDayOfYearPartitionKey,
																	SPOTDayDate,
																	SPOTDayOfYearPartitionKey,
																	IEDayDate,
																	IEDayOfYearPartitionKey,
																	CreateDate
																)
												OUTPUT				INSERTED.XSEUID, INSERTED.UTCSPOTDayOfYearPartitionKey, INSERTED.UTCSPOTDayDate
												INTO				@InsertedRows
												SELECT
																	DimSpotID													= s.DimSpotID,
																	DimIEID														= e.DimIEID,
																	DimIUID														= u.DimIUID,
																	DimTB_REQUESTID												= tb.DimTB_REQUESTID,
																	DimSpotStatusID												= s.DimSpotStatusID,
																	DimSpotConflictStatusID										= s.DimSpotConflictStatusID,
																	DimIEStatusID												= e.DimIEStatusID,
																	DimIEConflictStatusID										= e.DimIEConflictStatusID,
																	DimSDBSourceID												= sdb.DimSDBSourceID,
																	UTCSPOTDayDate												= s.UTCSPOTDATE,
																	UTCSPOTDayOfYearPartitionKey								= s.UTCSPOTDayOfYearPartitionKey,
																	UTCIEDayDate												= s.UTCIEDATE,
																	UTCIEDayOfYearPartitionKey									= s.UTCIEDayOfYearPartitionKey,
																	SPOTDayDate													= s.SPOTDATE,
																	SPOTDayOfYearPartitionKey									= s.SPOTDayOfYearPartitionKey,
																	IEDayDate													= s.IEDATE,
																	IEDayOfYearPartitionKey										= s.IEDayOfYearPartitionKey,
																	CreateDate													= GETUTCDATE()
												FROM				#DayOfYearPartitionSubset d 
												INNER JOIN			dbo.DimSpot s WITH (NOLOCK)
												ON					d.DayOfYearPartitionKey										= s.UTCSPOTDayOfYearPartitionKey	
												AND					d.DayDate													= s.UTCSPOTDate	
												INNER JOIN			dbo.DimSDBSource sdb WITH (NOLOCK)
												ON					s.SDBSourceID												= sdb.SDBSourceID
												LEFT JOIN			dbo.DimIE e WITH (NOLOCK)
												ON					s.IE_ID														= e.IE_ID
												AND					s.UTCIEDATE													= e.UTCIEDATE
												AND					s.UTCIEDayOfYearPartitionKey								= e.UTCIEDayOfYearPartitionKey
												LEFT JOIN			dbo.DimIU u WITH (NOLOCK)
												ON					e.IU_ID														= u.IU_ID
												AND					s.UTCIEDATE													= u.UTCIEDATE
												AND					s.UTCIEDayOfYearPartitionKey								= u.UTCIEDayOfYearPartitionKey
												LEFT JOIN			dbo.DimTB_REQUEST tb WITH (NOLOCK)	
												ON					u.IU_ID														= tb.IU_ID
												AND					s.UTCIEDATE													= tb.UTCIEDATE
												AND					s.UTCIEDayOfYearPartitionKey								= tb.UTCIEDayOfYearPartitionKey

												INSERT				#TotalCountByDay ( FactID, FactName, DayOfYearPartitionKey, UTCDate, TotalRecords )
												SELECT				FactID														= @FactID,
																	FactName													= @FactName,
																	DayOfYearPartitionKey										= x.UTCSPOTDayOfYearPartitionKey, 
																	UTCDate														= x.UTCSPOTDayDate, 
																	TotalRecords												= COUNT(1)
												FROM				@InsertedRows x
												GROUP BY			x.UTCSPOTDayOfYearPartitionKey, x.UTCSPOTDayDate

												--					Uses Temp Table #TotalCountByDay
												EXEC				dbo.SaveFactRecordCount	


							COMMIT

							DROP TABLE			#DayOfYearPartitionSubset
							DROP TABLE			#TotalCountByDay


END

GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_1_SpotReport]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_1_SpotReport] 
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
/****** Object:  StoredProcedure [dbo].[Report_2_10_10_MissingMedia]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_10_MissingMedia] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ChannelName				VARCHAR(50)		= NULL,
				@MarketID					INT				= NULL,
				@ZoneName					VARCHAR(50)		= NULL,
				@NetworkName				VARCHAR(50)		= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@SpotStatusID				INT				= NULL,
				@SpotConflictStatusID		INT				= NULL,
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
// Module:  dbo.Report_2_10_10_MissingMedia
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetSummaryDetails report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_10_MissingMedia.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_10_MissingMedia	
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
//									@ICProviderID				= NULL,
//									@ROCID						= NULL,
//									@SpotStatusID				= NULL,
//									@SpotConflictStatusID		= NULL,
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
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimSPOTID BIGINT, DayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimSPOTID, DayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
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
								WHERE			s.UTCSPOTDatetime							BETWEEN @StartDateTime AND @EndDateTime
				ELSE
								INSERT			#DayDateSubset ( DimSPOTID, DayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate											BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= x.UTCSPOTDayOfYearPartitionKey
								WHERE			s.RUN_DATE_TIME								BETWEEN @StartDateTime AND @EndDateTime





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
								Position,
								AssetID,
								SpotStatus,
								SpotConflictStatus,
								ScheduledDateTime
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName,
								ChannelName													= s.ChannelName,
								MarketName													= s.MarketName,
								ZoneName													= s.ZoneName,
								NetworkName													= s.NetworkName,
								ICProviderName												= s.ICProviderName,
								ROCName														= s.ROCName,
								Position													= s.Spot_ORDER,
								AssetID 													= s.VIDEO_ID,
								SpotStatus													= s.NSTATUSValue,
								SpotConflictStatus											= s.CONFLICT_STATUSValue,
								ScheduledDateTime											= CASE	WHEN @UseUTC = 1 THEN s.UTCIEDatetime ELSE s.IEDatetime END

				FROM			#DayDateSubset x
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.DayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.MarketID													= ISNULL(@MarketID,s.MarketID)
				AND				s.ZoneName													= ISNULL(@ZoneName,s.ZoneName)
				AND				s.NetworkName												= ISNULL(@NetworkName,s.NetworkName)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)
				AND				s.NSTATUS													= ISNULL(@SpotStatusID,s.NSTATUS)
				AND				s.CONFLICT_STATUS											= ISNULL(@SpotConflictStatusID,s.CONFLICT_STATUS)


				DROP TABLE		#DayDateSubset



END



GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_3_FutureReadiness]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_3_FutureReadiness] 
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
/****** Object:  StoredProcedure [dbo].[Report_2_10_4_AssetInfoDuration]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_4_AssetInfoDuration] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@MinDuration				INT				= NULL,
				@MaxDuration				INT				= NULL,
				@StartDate					DATETIME		= NULL,
				@EndDate					DATETIME		= NULL

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
// Module:  dbo.Report_2_10_4_AssetInfoDuration
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetInfoDuration report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_4_AssetInfoDuration.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_4_AssetInfoDuration	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@MinDuration				= NULL,
//									@MaxDuration				= NULL,
//									@StartDate					= NULL,
//									@EndDate					= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				
				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				DECLARE			@DYPartition												UDT_Int
				DECLARE			@StartDay													DATE
				DECLARE			@EndDay														DATE
				DECLARE			@EndDayMinus1Day											DATE
				DECLARE			@7DaysAgoDate												DATE
				DECLARE			@7DaysAgoDateTime											DATETIME

				IF				( ISNULL(OBJECT_ID('tempdb..#XSEUSubset'), 0) > 0 )			DROP TABLE #XSEUSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), MAXFactAssetSummaryID INT, DayDate DATE, DayOfYearPartitionKey INT, UTCSPOTDayDate DATE, UTCSPOTDayOfYearPartitionKey INT )

				SELECT			@UseUTC														=	ISNULL(@UseUTC,1)
				SELECT			@StartDay													=	@StartDate,
								@EndDay														=	@EndDate,
								@EndDayMinus1Day											=	DATEADD( DAY,-1,@EndDay ),
								@7DaysAgoDate												=	DATEADD( DAY,-7,@StartDay),
								@7DaysAgoDateTime											=	DATEADD( DAY,-7,@StartDate)


				INSERT			#DayDateSubset ( MAXFactAssetSummaryID, DayDate, DayOfYearPartitionKey, UTCSPOTDayDate, UTCSPOTDayOfYearPartitionKey )
				--SELECT			f1.FactAssetSummaryID, f1.DimSPOTID, f1.DimIEID, d.DimDate, d.DayOfYearPartitionKey, f1.UTCSPOTDayOfYearPartitionKey, f1.UTCIEDayOfYearPartitionKey
				SELECT			MAX(f1.FactAssetSummaryID) MAXFactAssetSummaryID, d.DimDate, d.DayOfYearPartitionKey, f1.UTCSPOTDayDate, f1.UTCSPOTDayOfYearPartitionKey
				FROM			
							(	
								SELECT		DimDate, DayOfYearPartitionKey
								FROM		dbo.DimDateDay WITH (NOLOCK)
								WHERE		DimDate											BETWEEN @7DaysAgoDate AND @EndDayMinus1Day
							) d
				JOIN			dbo.FactAssetSummary f1 WITH (NOLOCK)
																							ON d.DimDate =	
																								CASE	WHEN 1 = 1 THEN f1.UTCSPOTDayDate
																										ELSE f1.SPOTDayDate
																								END
																							AND	d.DayOfYearPartitionKey	=	
																								CASE	WHEN 1 = 1 THEN f1.UTCSPOTDayOfYearPartitionKey
																										ELSE f1.SPOTDayOfYearPartitionKey
																								END
				GROUP BY		d.DimDate, d.DayOfYearPartitionKey, f1.UTCSPOTDayDate, f1.UTCSPOTDayOfYearPartitionKey, f1.DimAssetID 


				INSERT INTO		#tmp_AllSpots 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								SpotID,
								AssetID,
								Duration,
								Ingested
							)
				SELECT			RegionID													= SPOT.RegionID,
								SDBSourceID													= SPOT.SDBSourceID,
								SDB															= SPOT.SDBName,
								DBSource													= 'DINGODW',
								SpotID														= SPOT.Spot_ID,
								AssetID 													= SPOT.VIDEO_ID ,
								Duration													= f1.SecondsLength,
								Ingested													= CASE	WHEN @UseUTC = 1 THEN SPOT.UTCSPOTDatetime
																									ELSE SPOT.RUN_DATE_TIME
																								END

				FROM			#DayDateSubset x
				JOIN			dbo.FactAssetSummary f1 WITH (NOLOCK)						ON x.MAXFactAssetSummaryID = f1.FactAssetSummaryID
																							AND x.UTCSPOTDayOfYearPartitionKey = f1.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimSpot SPOT WITH (NOLOCK)								ON f1.DimSpotID = SPOT.DimSpotID
																							AND f1.UTCSPOTDayOfYearPartitionKey = SPOT.UTCSPOTDayOfYearPartitionKey
				WHERE			SPOT.RUN_DATE_TIME											BETWEEN @7DaysAgoDateTime AND @EndDate
				AND				f1.SecondsLength											BETWEEN ISNULL( @MinDuration,f1.SecondsLength ) AND ISNULL( @MaxDuration,f1.SecondsLength )



				DROP TABLE		#DayDateSubset



END



GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_4_AssetInfoICROC]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_4_AssetInfoICROC] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@StartDate					DATETIME		= NULL,
				@EndDate					DATETIME		= NULL

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
// Module:  dbo.Report_2_10_4_AssetInfoICROC
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetInfoICROC report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_4_AssetInfoICROC.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_4_AssetInfoICROC	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@ICProviderID				= NULL,
//									@ROCID						= NULL,
//									@StartDate					= NULL,
//									@EndDate					= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				
				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				DECLARE			@DYPartition												UDT_Int
				DECLARE			@StartDay													DATE
				DECLARE			@EndDay														DATE
				DECLARE			@EndDayMinus1Day											DATE

				SELECT			@UseUTC														=	ISNULL(@UseUTC,1)
				SELECT			@StartDay													=	@StartDate,
								@EndDay														=	@EndDate,
								@EndDayMinus1Day											=	DATEADD( DAY,-1,@EndDay )


				IF				( ISNULL(OBJECT_ID('tempdb..#XSEUSubset'), 0) > 0 )			DROP TABLE #XSEUSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), MAXFactAssetSummaryID INT, DayDate DATE, DayOfYearPartitionKey INT, UTCSPOTDayDate DATE, UTCSPOTDayOfYearPartitionKey INT )


				INSERT			#DayDateSubset ( MAXFactAssetSummaryID, DayDate, DayOfYearPartitionKey, UTCSPOTDayDate, UTCSPOTDayOfYearPartitionKey )
				SELECT			MAX(f1.FactAssetSummaryID) MAXFactAssetSummaryID, d.DimDate, d.DayOfYearPartitionKey, f1.UTCSPOTDayDate, f1.UTCSPOTDayOfYearPartitionKey
				FROM			
							(	
								SELECT		DimDate, DayOfYearPartitionKey
								FROM		dbo.DimDateDay WITH (NOLOCK)
								WHERE		DimDate											BETWEEN @StartDay AND @EndDayMinus1Day
							) d
				JOIN			dbo.FactAssetSummary f1 WITH (NOLOCK)
																							ON d.DimDate =	
																								CASE	WHEN 1 = 1 THEN f1.UTCSPOTDayDate
																										ELSE f1.SPOTDayDate
																								END
																							AND	d.DayOfYearPartitionKey	=	
																								CASE	WHEN 1 = 1 THEN f1.UTCSPOTDayOfYearPartitionKey
																										ELSE f1.SPOTDayOfYearPartitionKey
																								END
				GROUP BY		d.DimDate, d.DayOfYearPartitionKey, f1.UTCSPOTDayDate, f1.UTCSPOTDayOfYearPartitionKey, f1.DimAssetID 


				INSERT INTO		#tmp_AllSpots 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								SpotID,
								AssetID
							)
				SELECT			RegionID													= SPOT.RegionID,
								SDBSourceID													= SPOT.SDBSourceID,
								SDB															= SPOT.SDBName,
								DBSource													= 'DINGODW',
								SpotID														= SPOT.Spot_ID,
								AssetID 													= SPOT.VIDEO_ID

				FROM			#DayDateSubset x
				JOIN			dbo.FactAssetSummary f1 WITH (NOLOCK)						ON x.MAXFactAssetSummaryID = f1.FactAssetSummaryID
																							AND x.UTCSPOTDayOfYearPartitionKey = f1.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimSpot SPOT WITH (NOLOCK)								ON f1.DimSpotID = SPOT.DimSpotID
																							AND f1.UTCSPOTDayOfYearPartitionKey = SPOT.UTCSPOTDayOfYearPartitionKey
				WHERE			SPOT.RUN_DATE_TIME											BETWEEN @StartDate AND @EndDate

				DROP TABLE		#DayDateSubset



END



GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_4_AssetSummaryDetails]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_4_AssetSummaryDetails] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ICProviderID				INT				= NULL,
				@ROCID						INT				= NULL,
				@AssetID					VARCHAR(50)		= NULL,
				@MinDuration				INT				= NULL,
				@MaxDuration				INT				= NULL,
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
// Module:  dbo.Report_2_10_4_AssetSummaryDetails
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetSummaryDetails report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_4_AssetSummaryDetails.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_4_AssetSummaryDetails	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@ICProviderID				= NULL,
//									@ROCID						= NULL,
//									@AssetID					= NULL,
//									@MinDuration				= NULL,
//									@MaxDuration				= NULL,
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
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), FactAssetSummaryID BIGINT, DimSPOTID BIGINT, UTCDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			f.FactAssetSummaryID, f.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.FactAssetSummary f WITH (NOLOCK)		ON d.DimDate = f.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON f.DimSpotID = s.DimSpotID
																							AND	f.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCSPOTDatetime							BETWEEN @StartDateTime AND @EndDateTime
				ELSE
								INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			f.FactAssetSummaryID, f.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.FactAssetSummary f WITH (NOLOCK)
																							ON d.DimDate = f.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON f.DimSpotID = s.DimSpotID
																							AND	f.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.SPOTDate									BETWEEN @StartDateTime AND @EndDateTime


				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								ICProviderName,
								ROCName,
								AssetID,
								Duration,
								Ingested
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName,
								ICProviderName												= s.ICProviderName,
								ROCName														= s.ROCName,
								AssetID 													= s.VIDEO_ID,
								Duration													= f.SecondsLength,
								Ingested													= CASE	WHEN @UseUTC = 1 THEN s.UTCSPOTDatetime
																									ELSE s.RUN_DATE_TIME
																								END

				FROM			#DayDateSubset x
				JOIN			dbo.FactAssetSummary f WITH (NOLOCK)						ON x.FactAssetSummaryID = f.FactAssetSummaryID
																							AND x.UTCDayOfYearPartitionKey = f.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON f.DimSpotID = s.DimSpotID
																							AND f.UTCSPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				WHERE			s.RUN_DATE_TIME												BETWEEN @StartDateTime AND @EndDateTime
				AND				f.SecondsLength												BETWEEN ISNULL( @MinDuration,f.SecondsLength ) AND ISNULL( @MaxDuration,f.SecondsLength )
				AND				s.VIDEO_ID													BETWEEN ISNULL( @AssetID,s.VIDEO_ID ) AND ISNULL( @AssetID,s.VIDEO_ID )
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)


				DROP TABLE		#DayDateSubset



END



GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_4_AssetSummaryDuration]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_4_AssetSummaryDuration] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@MinDuration				INT				= NULL,
				@MaxDuration				INT				= NULL,
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
// Module:  dbo.Report_2_10_4_AssetSummaryDuration
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetSummaryDuration report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_4_AssetSummaryDuration.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_4_AssetSummaryDuration	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@MinDuration				= NULL,
//									@MaxDuration				= NULL,
//									@StartDateTime					= NULL,
//									@EndDateTime					= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				
				DECLARE			@StartDay													DATE = @StartDateTime
				DECLARE			@EndDay														DATE = @EndDateTime

				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), FactAssetSummaryID INT, DimSPOTID INT, UTCDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			f.FactAssetSummaryID, f.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.FactAssetSummary f WITH (NOLOCK)		ON d.DimDate = f.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON f.DimSpotID = s.DimSpotID
																							AND	f.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCSPOTDatetime							BETWEEN @StartDateTime AND @EndDateTime
				ELSE
								INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			f.FactAssetSummaryID, f.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.FactAssetSummary f WITH (NOLOCK)
																							ON d.DimDate = f.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON f.DimSpotID = s.DimSpotID
																							AND	f.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.SPOTDate									BETWEEN @StartDateTime AND @EndDateTime


				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								AssetID,
								Duration
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName,
								AssetID 													= s.VIDEO_ID ,
								Duration													= f.SecondsLength
				FROM			#DayDateSubset x
				JOIN			dbo.FactAssetSummary f WITH (NOLOCK)						ON x.FactAssetSummaryID = f.FactAssetSummaryID
																							AND x.UTCDayOfYearPartitionKey = f.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON f.DimSpotID = s.DimSpotID
																							AND f.UTCSPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				WHERE			f.SecondsLength												BETWEEN ISNULL( @MinDuration,f.SecondsLength ) AND ISNULL( @MaxDuration,f.SecondsLength )
				AND				s.RegionID													= ISNULL(@RegionID,s.RegionID)



				DROP TABLE		#DayDateSubset



END



GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_4_AssetSummaryICROC]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_4_AssetSummaryICROC] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@ICProviderID				INT				= NULL,
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
// Module:  dbo.Report_2_10_4_AssetSummaryICROC
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate AssetSummaryICROC report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_4_AssetSummaryICROC.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_4_AssetSummaryICROC	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= NULL,
//									@SortOrder					= NULL,
//									@ICProviderID				= NULL,
//									@ROCID						= NULL,
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
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), FactAssetSummaryID INT, DimSPOTID INT, UTCDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			f.FactAssetSummaryID, f.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.FactAssetSummary f WITH (NOLOCK)		ON d.DimDate = f.UTCSPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f.UTCSPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON f.DimSpotID = s.DimSpotID
																							AND	f.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.UTCSPOTDatetime							BETWEEN @StartDateTime AND @EndDateTime
				ELSE
								INSERT			#DayDateSubset ( FactAssetSummaryID, DimSPOTID, UTCDayOfYearPartitionKey )
								SELECT			f.FactAssetSummaryID, f.DimSPOTID, s.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.FactAssetSummary f WITH (NOLOCK)
																							ON d.DimDate = f.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= f.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON f.DimSpotID = s.DimSpotID
																							AND	f.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.SPOTDate									BETWEEN @StartDateTime AND @EndDateTime


				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								ICProviderName,
								ROCName,
								AssetID
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName,
								ICProviderName												= s.ICProviderName,
								ROCName														= s.ROCName,
								AssetID 													= s.VIDEO_ID
				FROM			#DayDateSubset x
				JOIN			dbo.FactAssetSummary f WITH (NOLOCK)						ON x.FactAssetSummaryID = f.FactAssetSummaryID
																							AND x.UTCDayOfYearPartitionKey = f.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON f.DimSpotID = s.DimSpotID
																							AND f.UTCSPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)

				DROP TABLE		#DayDateSubset



END



GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_4_VideoInfoReport]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_4_VideoInfoReport] 
				@RegionID					INT				= NULL,
				@SDBSourceID				INT				= NULL,
				@SDBName					VARCHAR(64)		= NULL,
				@UTCOffset					INT				= NULL,
				@UseUTC						INT				= NULL,
				@SortOrder					INT				= NULL,
				@MinLength					INT				= NULL,
				@MaxLength					INT				= NULL,
				@StartDate					DATETIME		= NULL,
				@EndDate					DATETIME		= NULL
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
// Module:  dbo.Report_2_10_4_VideoInfoReport
// Created: 2014-May-05
// Author:  Tony Lew
// 
// Purpose:			Generate SDBDashboard report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_4_VideoInfoReport.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_4_VideoInfoReport	
//									@RegionID							= NULL,
//									@SDBSourceID						= NULL,
//									@SDBName							= NULL,
//									@UTCOffset							= NULL,
//									@UseUTC								= NULL,
//									@SortOrder							= NULL,
//									@MinLength							= NULL,
//									@MaxLength							= NULL,
//									@StartDate							= NULL,
//									@EndDate							= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				
				DECLARE			@DATETIME													DATETIME
				SET				@DATETIME													= DATEADD( HOUR,@UTCOffset,GETUTCDATE() )
				DECLARE			@DYPartition												UDT_Int
				DECLARE			@StartDay													DATE
				DECLARE			@EndDay														DATE
				DECLARE			@MAXIEStatusID												INT
				DECLARE			@MAXIEConflictStatusID										INT
				DECLARE			@MAXSPOTStatusID											INT
				DECLARE			@MAXSPOTConflictStatusID									INT

				IF				( ISNULL(OBJECT_ID('tempdb..#XSEUSubset'), 0) > 0 ) DROP TABLE #XSEUSubset
				CREATE TABLE	#XSEUSubset ( ID INT IDENTITY(1,1), XSEUID INT, DimIEID INT, DimSpotID INT, DayOfYearPartitionKey INT )

				SELECT			@UseUTC														=	ISNULL(@UseUTC,1)
				SELECT			@StartDay													=	@StartDate,
								@EndDay														=	@EndDate 

				INSERT			#XSEUSubset ( XSEUID, DimIEID, DimSpotID, DayOfYearPartitionKey )
				SELECT			x.XSEUID, x.DimIEID, x.DimSpotID, d.DayOfYearPartitionKey
				FROM			dbo.DimDateDay d WITH (NOLOCK)
				JOIN			dbo.XSEU x WITH (NOLOCK)
				ON				d.DimDateDay												=	CASE	WHEN @UseUTC = 1 THEN x.UTCDimDateDay
																										ELSE x.DimDateDay
																								END
				WHERE			d.DimDateDay												>= @StartDay 
				AND				d.DimDateDay												< @EndDay


				--INSERT			@DYPartition ( Value )
				--SELECT			DISTINCT DayOfYearPartitionKey FROM #XSEUSubset


				INSERT INTO		#tmp_AllSpots ( RegionID, SDBSourceID, SDB, SPOT_ID, IE_ID, VIDEO_ID, SOURCE_ID, INTERCONNECT_NAME, RUN_DATE_TIME, RUN_LENGTH ) 
				SELECT			RegionID													= IE.RegionID,
								SDBSourceID													= IE.SDBSourceID,
								SDB															= IE.SDBName,
								SPOT_ID														= SPOT.SPOT_ID,
								IE_ID														= SPOT.IE_ID,
								VIDEO_ID													= SPOT.VIDEO_ID,
								SOURCE_ID 													= SPOT.SOURCE_ID,
								INTERCONNECT_NAME											= SPOT.SOURCE_ID_INTERCONNECT_NAME,
								RUN_DATE_TIME												= CASE	WHEN @UseUTC = 1 THEN DATEADD(HOUR,SPOT.UTCOffset,SPOT.RUN_DATE_TIME)
																									ELSE SPOT.RUN_DATE_TIME
																								END,
								RUN_LENGTH  												= SPOT.RUN_LENGTH
				FROM			#XSEUSubset x
				JOIN			dbo.DimIE IE WITH (NOLOCK)
				ON				x.DimIEID													=	IE.DimIEID
				JOIN			dbo.DimSpot SPOT WITH (NOLOCK)
				ON				x.DimSpotID													=	SPOT.DimSpotID
				WHERE			IE.SCHED_DATE_TIME											>= ISNULL(@StartDate, IE.SCHED_DATE_TIME)
				AND				IE.SCHED_DATE_TIME											< ISNULL(@EndDate, IE.SCHED_DATE_TIME)
				AND				SPOT.IE_ID													IS NOT NULL
				AND				SPOT.RUN_LENGTH												BETWEEN ISNULL(@MinLength,SPOT.RUN_LENGTH) AND	ISNULL(@MaxLength,SPOT.RUN_LENGTH)


				DROP TABLE		#XSEUSubset


END



GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_5_RunRate]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_5_RunRate] 
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
/****** Object:  StoredProcedure [dbo].[Report_2_10_7_VideoDurationMismatch]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_7_VideoDurationMismatch] 
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
				@ScheduleDate				DATE			= NULL,
				@AssetID					VARCHAR(50)		= NULL

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
// Module:  dbo.Report_2_10_7_VideoDurationMismatch
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate FutureReadiness report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_7_VideoDurationMismatch.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_7_VideoDurationMismatch	
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
//									@ScheduleDate				= NULL,
//									@AssetID					= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON
				

				IF				( OBJECT_ID('tempdb..#DayDateSubset') IS NOT NULL )			DROP TABLE #DayDateSubset
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimSPOTID BIGINT, DimIEID BIGINT, DimIUID BIGINT, SPOTDayOfYearPartitionKey INT, IEDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimSPOTID, SPOTDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
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
								GROUP BY		x.DimSPOTID, x.DimIEID, x.DimIUID, x.UTCSPOTDayOfYearPartitionKey, x.UTCIEDayOfYearPartitionKey
				ELSE
								INSERT			#DayDateSubset ( DimSPOTID, SPOTDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
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
								GROUP BY		x.DimSPOTID, x.DimIEID, x.DimIUID, x.UTCSPOTDayOfYearPartitionKey, x.UTCIEDayOfYearPartitionKey




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
								Duration
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
								Duration													= a.Length

				FROM			#DayDateSubset x
				JOIN			dbo.DimSpot s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.SPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				JOIN			dbo.DimAsset a WITH (NOLOCK)								ON s.RegionID = a.RegionID
																							AND s.VIDEO_ID = a.AssetID
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				AND				s.ZoneName													= ISNULL(@ZoneName,s.ZoneName)
				AND				s.NetworkName												= ISNULL(@NetworkName,s.NetworkName)
				AND				s.MarketID													= ISNULL(@MarketID,s.MarketID)
				AND				s.ICProviderID												= ISNULL(@ICProviderID,s.ICProviderID)
				AND				s.ROCID														= ISNULL(@ROCID,s.ROCID)


				DROP TABLE		#DayDateSubset



END



GO
/****** Object:  StoredProcedure [dbo].[Report_2_10_7_VideoFormatMismatch]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_7_VideoFormatMismatch] 
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
/****** Object:  StoredProcedure [dbo].[Report_2_10_8_ScheduleLoadEvents]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_8_ScheduleLoadEvents] 
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
/****** Object:  StoredProcedure [dbo].[Report_2_10_9_FailedVideoIngests]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_2_10_9_FailedVideoIngests] 
				@RegionID					INT,
				@SDBSourceID				INT,
				@SDBName					VARCHAR(64),
				@UTCOffset					INT				= 0,
				@UseUTC						INT				= 1,
				@SortOrder					INT				= NULL,
				@FileName					VARCHAR(100)	= NULL,
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
// Module:  dbo.Report_2_10_9_FailedVideoIngests
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate FutureReadiness report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.Report_2_10_9_FailedVideoIngests.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.Report_2_10_9_FailedVideoIngests	
//									@RegionID					= 1,
//									@SDBSourceID				= 1,
//									@SDBName					= '',
//									@UTCOffset					= NULL,
//									@UseUTC						= 1,
//									@SortOrder					= NULL,
//									@FileName					= NULL,
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
				CREATE TABLE	#DayDateSubset ( ID INT IDENTITY(1,1), DimSPOTID BIGINT, UTCSPOTDayOfYearPartitionKey INT )


				IF				( @UseUTC = 1 )
								INSERT			#DayDateSubset ( DimSPOTID, UTCSPOTDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
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
								GROUP BY		x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
				ELSE
								INSERT			#DayDateSubset ( DimSPOTID, UTCSPOTDayOfYearPartitionKey )
								SELECT			x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey
								FROM			
											(	
												SELECT		DimDate, DayOfYearPartitionKey
												FROM		dbo.DimDateDay WITH (NOLOCK)
												WHERE		DimDate							BETWEEN @StartDay AND @EndDay
											) d
								JOIN			dbo.XSEU x WITH (NOLOCK)					ON d.DimDate = x.SPOTDayDate
																							AND	d.DayOfYearPartitionKey	= x.SPOTDayOfYearPartitionKey
								JOIN			dbo.DimSpot s WITH (NOLOCK)					ON x.DimSpotID = s.DimSpotID
																							AND	x.UTCSPOTDayOfYearPartitionKey	= s.UTCSPOTDayOfYearPartitionKey
								WHERE			s.IEDateTime								BETWEEN @StartDateTime AND @EndDateTime
								GROUP BY		x.DimSPOTID, x.UTCSPOTDayOfYearPartitionKey


				INSERT INTO		#FinalResults 
							( 
								RegionID, 
								SDBSourceID, 
								SDB, 
								DBSource, 
								RegionName,
								Reason,
								FileName,
								ScheduledDateTime
							)
				SELECT			RegionID													= s.RegionID,
								SDBSourceID													= s.SDBSourceID,
								SDB															= s.SDBName,
								DBSource													= 'DINGODW',
								RegionName													= s.RegionName, 
								Reason	 													= 'Reason'+ISNULL(s.VIDEO_ID,''),
								FileName													= 'FileName'+ISNULL(s.VIDEO_ID,''),
								ScheduledDateTime											= CASE	WHEN @UseUTC = 1 THEN s.UTCIEDatetime
																									ELSE s.IEDatetime
																								END
				FROM			#DayDateSubset x
				JOIN			dbo.DimSPOT s WITH (NOLOCK)									ON x.DimSpotID = s.DimSpotID
																							AND x.UTCSPOTDayOfYearPartitionKey = s.UTCSPOTDayOfYearPartitionKey
				--JOIN			dbo.DimIE ie WITH (NOLOCK)									ON x.DimIEID = ie.DimIEID
				--																			AND x.IEDayOfYearPartitionKey = ie.UTCIEDayOfYearPartitionKey
				--JOIN			dbo.DimSpotStatus ss WITH (NOLOCK)							ON x.DimSpotStatusID = ss.DimSpotStatusID
				--JOIN			dbo.DimSpotConflictStatus scs WITH (NOLOCK)					ON x.DimSpotConflictStatusID = scs.DimSpotConflictStatusID
				WHERE			s.RegionID													= ISNULL(@RegionID,s.RegionID)
				--AND				s.NSTATUS													= 14
				--AND				s.CONFLICT_STATUS											IN (107)
				AND				s.VIDEO_ID													= ISNULL(@FileName, s.VIDEO_ID)


				DROP TABLE		#DayDateSubset



END



GO


/****** Object:  StoredProcedure [dbo].[PopulateDimensions]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.PopulateDimensions 
							@StartingDate				DATE = NULL,
							@EndingDate					DATE = NULL,
							@EventLogStatusIDFail		INT = NULL,
							@LogIDReturn				INT = NULL,
							@OverRideCounts				INT = 0
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
// Module:  dbo.PopulateDimensions
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW Dimension tables for the given day.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateDimensions.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateDimensions	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03',
//												@EventLogStatusIDFail	= NULL,
//												@LogIDReturn			= NULL,
//												@OverRideCounts			= 0
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@TotalDY													INT
							DECLARE				@TotalDayCount												INT
							DECLARE				@TotalSDBSources											INT
							DECLARE				@TotalDimensions											INT = 3
							DECLARE				@InComplete													INT
							DECLARE				@CurrentTimeZoneOffset										INT
							DECLARE				@DayRecorded												INT
							DECLARE				@CurrentUTCDay												DATE
							DECLARE				@EndingDateMinus1Day										DATE
							DECLARE				@Validity													BIT
							DECLARE				@EventLogTypeIDOUT											INT
							DECLARE				@EventLogStatusID_ETLDimSDBSource							INT
							DECLARE				@EventLogStatusID_ETLDimZoneMap								INT
							DECLARE				@EventLogStatusID_ETLDimAsset								INT
							DECLARE				@EventLogStatusID_ETLDimSpotStatus							INT
							DECLARE				@EventLogStatusID_ETLDimSpotConflictStatus					INT
							DECLARE				@EventLogStatusID_ETLDimIEStatus							INT
							DECLARE				@EventLogStatusID_ETLDimIEConflictStatus					INT
							DECLARE				@EventLogStatusID_ETLDimSpot								INT
							DECLARE				@EventLogStatusID_ETLDimIE									INT
							DECLARE				@EventLogStatusID_ETLDimIU									INT
							DECLARE				@EventLogStatusID_ETLDimTB_REQUEST							INT
							DECLARE				@EventLogStatusID_SaveDimRecordCount						INT
							DECLARE				@Description												VARCHAR(200)


							SELECT				@CurrentUTCDay												= GETUTCDATE()


							SELECT				@StartingDate												= ISNULL( @StartingDate,@CurrentUTCDay )
							SELECT				@EndingDate													= ISNULL( @EndingDate, DATEADD(DAY,1,@StartingDate) )
							SELECT				@EndingDateMinus1Day										= DATEADD(DAY,-1,@EndingDate)

							IF					( @EndingDateMinus1Day < @StartingDate ) RETURN


							--					If the date range is >= the current day AND the current UTC day has NOT finished for an hour or over
							--					Then log error and change the ending date range to be the last completed day.
							IF					( (@EndingDateMinus1Day >= DATEADD(DAY,-1,@CurrentUTCDay)) AND ( DATEDIFF ( HOUR,@CurrentUTCDay,GETUTCDATE() ) < 1 ) )
							BEGIN

												--Log the event that the date range for all SDB systems has already been completed
												--OR log the error that the endingday date parameter is not over.  Then exit.
												--@EventLogTypeIDOUT
												--Insert into DINGODB.dbo.EventLog table.
												--SELECT @Validity, @EndingDateMinus1Day , DATEADD(DAY,-1,@CurrentUTCDay) , DATEDIFF ( HOUR,@CurrentUTCDay,GETUTCDATE() ) 

												SELECT			@Description								= 'Current Day ' + CAST(@CurrentUTCDay AS VARCHAR(30)) + ' is NOT over.' --@ERROR_MESSAGE

												EXEC			DINGODB.dbo.LogEvent 
																		@LogID								= @LogIDReturn, 
																		@EventLogStatusID					= @EventLogStatusIDFail, 
																		@Description						= @Description
												RETURN


												SELECT			@EndingDate									= @CurrentUTCDay,
																@EndingDateMinus1Day						= DATEADD(DAY,-1,@CurrentUTCDay)

							END


							SELECT				TOP 1 @EventLogStatusID_ETLDimSDBSource						= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimSDBSource Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimZoneMap						= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimZoneMap Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimAsset							= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimAsset Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimSpotStatus					= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimSpotStatus Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimSpotConflictStatus			= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimSpotConflictStatus Step'
							SELECT				TOP 1 @EventLogStatusID_ETLDimIEStatus						= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimIEStatus Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimIEConflictStatus				= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimIEConflictStatus Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimSpot							= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimSpot Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimIE							= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimIE Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimIU							= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimIU Step'	
							SELECT				TOP 1 @EventLogStatusID_ETLDimTB_REQUEST					= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - ETLDimTB_REQUEST Step'	
							SELECT				TOP 1 @EventLogStatusID_SaveDimRecordCount					= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - SaveDimRecordCount Step'	



							--					Populate the slow changing dimensions first.  
							EXEC				dbo.ETLDimSpotStatus	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimSpotStatus

							EXEC				dbo.ETLDimSpotConflictStatus
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimSpotConflictStatus

							EXEC				dbo.ETLDimIEStatus	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimIEStatus

							EXEC				dbo.ETLDimIEConflictStatus
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimIEConflictStatus

							EXEC				dbo.ETLDimSDBSource	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimSDBSource

							EXEC				dbo.ETLDimZoneMap	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimZoneMap

							EXEC				dbo.ETLDimAsset	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimAsset


							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartition'), 0) > 0 ) DROP TABLE #DayOfYearPartition
							CREATE TABLE		#DayOfYearPartition ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DateDay DATE, SDBSourceID INT )

							INSERT				#DayOfYearPartition ( DayOfYearPartitionKey,DateDay,SDBSourceID )
							SELECT				d.DayOfYearPartitionKey, d.DimDate, s.SDBSourceID
							FROM				dbo.DimDateDay d WITH (NOLOCK)
							CROSS JOIN			dbo.DimSDBSource s WITH (NOLOCK)
							WHERE				d.DimDate													BETWEEN @StartingDate AND @EndingDateMinus1Day
							AND					s.Enabled													= 1


							--					Populate the IU dimension before the other dimensions.  
							--					This will query DINGODB OLTP and get the values defined in DINGODB.
							--					Namely, ChannelName, SDBSourceID, Network, ZoneMap information (Market, ICProvider, ROC)
							--					This information will then be propogated to the other more molecular units (IE and SPOT)
							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.ETLDimIU	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimIU

							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.ETLDimIE	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimIE

							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.ETLDimSPOT
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimSpot

							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.ETLDimTB_REQUEST	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID						= @EventLogStatusID_ETLDimTB_REQUEST

							
							DROP TABLE			#DayOfYearPartition



END
GO

/****** Object:  StoredProcedure [dbo].[PopulateFacts]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.PopulateFacts 
							@StartingDate				DATE = NULL,
							@EndingDate					DATE = NULL,
							@EventLogStatusIDFail		INT = NULL,
							@LogIDReturn				INT = NULL,
							@OverRideCounts				INT = 0
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
// Module:  dbo.PopulateFacts
// Created: 2014-Jun-05
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW fact tables for the given day.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.PopulateFacts.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//							EXEC			dbo.PopulateFacts	
//												@StartingDate			= '2014-01-01',
//												@EndingDate				= '2014-01-03',
//												@EventLogStatusIDFail	= NULL,
//												@LogIDReturn			= NULL,
//												@OverRideCounts			= 0
//
*/ 
BEGIN



							SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
							SET					NOCOUNT ON

							DECLARE				@TotalDY													INT
							DECLARE				@TotalDayCount												INT
							DECLARE				@TotalSDBSources											INT
							DECLARE				@TotalDimensions											INT = 3
							DECLARE				@InComplete													INT
							DECLARE				@EventLogStatusID_SaveFactRecordCount						INT
							DECLARE				@EventLogStatusID_PopulateXSEU								INT
							DECLARE				@EventLogStatusID_PopulateTempTableFactSummary1				INT
							DECLARE				@EventLogStatusID_PopulateFactBreakMovingAverage			INT
							DECLARE				@EventLogStatusID_PopulateFactAssetSummary					INT
							DECLARE				@EventLogStatusID_PopulateFactSpotSummary					INT
							DECLARE				@EventLogStatusID_PopulateFactIESummary						INT
							DECLARE				@EventLogStatusID_PopulateFactIUSummary						INT
							DECLARE				@CurrentTimeZoneOffset										INT
							DECLARE				@DayRecorded												INT
							DECLARE				@CurrentUTCDay												DATE
							DECLARE				@EndingDateMinus1Day										DATE
							DECLARE				@Validity													BIT
							DECLARE				@Existence													BIT
							DECLARE				@EventLogTypeIDOUT											INT
							DECLARE				@Description												VARCHAR(200)


							SELECT				@CurrentUTCDay												= GETUTCDATE()


							SELECT				@StartingDate												= ISNULL( @StartingDate,@CurrentUTCDay )
							SELECT				@EndingDate													= ISNULL( @EndingDate, DATEADD(DAY,1,@StartingDate) )
							SELECT				@EndingDateMinus1Day										= DATEADD(DAY,-1,@EndingDate)

							IF					( @EndingDateMinus1Day < @StartingDate ) RETURN


							--					If the date range is >= the current day AND the current UTC day has NOT finished for an hour or over
							--					Then log error and change the ending date range to be the last completed day.
							IF					( (@EndingDateMinus1Day >= DATEADD(DAY,-1,@CurrentUTCDay)) AND ( DATEDIFF ( HOUR,@CurrentUTCDay,GETUTCDATE() ) < 1 ) )
							BEGIN

												--Log the error that the endingday date parameter is not over OR the day has already been logged.  Then exit.
												SELECT			@Description								= 'Current Day ' + CAST(@CurrentUTCDay AS VARCHAR(30)) + ' is NOT over.' --@ERROR_MESSAGE

												EXEC			DINGODB.dbo.LogEvent 
																		@LogID								= @LogIDReturn, 
																		@EventLogStatusID					= @EventLogStatusIDFail, 
																		@Description						= @Description
												RETURN

												SELECT			@EndingDate									= @CurrentUTCDay,
																@EndingDateMinus1Day						= DATEADD(DAY,-1,@CurrentUTCDay)
												
							END


							--					When override is NOT enabled, then determine if data from all SDBs for all dimensions is complete before calculating sums.
							IF					( @OverRideCounts = 0 )
							BEGIN

												EXEC			dbo.CheckDimensionCount	
																	@StartingDate							= @StartingDate,
																	@EndingDate								= @EndingDate,
																	@Complete								= @Validity OUTPUT,
																	@EventLogTypeID							= @EventLogTypeIDOUT OUTPUT
												
												--				If any of the days in the date range are incomplete or missing, then log the error and exit.
												IF				( @Validity=0 )	
												BEGIN
																--@EventLogTypeIDOUT
																--Insert into DINGODB.dbo.EventLog table.
																RETURN
												END

							END

							SELECT				TOP 1 @EventLogStatusID_PopulateXSEU						= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateXSEU Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateTempTableFactSummary1		= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateTempTableFactSummary1 Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateFactBreakMovingAverage		= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactBreakMovingAverage Step'
							SELECT				TOP 1 @EventLogStatusID_PopulateFactAssetSummary			= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactAssetSummary Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateFactSpotSummary				= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactSpotSummary Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateFactIESummary				= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactIESummary Step'	
							SELECT				TOP 1 @EventLogStatusID_PopulateFactIUSummary				= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - PopulateFactIUSummary Step'	
							SELECT				TOP 1 @EventLogStatusID_SaveFactRecordCount					= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent - SaveFactRecordCount Step'	


							IF					( ISNULL(OBJECT_ID('tempdb..#DayOfYearPartition'), 0) > 0 ) DROP TABLE #DayOfYearPartition
							CREATE TABLE		#DayOfYearPartition ( ID INT IDENTITY(1,1), DayOfYearPartitionKey INT, DayDate DATE )

							INSERT				#DayOfYearPartition ( DayOfYearPartitionKey,DayDate )
							SELECT				d.DayOfYearPartitionKey, d.DimDate
							FROM				dbo.DimDateDay d WITH (NOLOCK)
							WHERE				d.DimDate													BETWEEN @StartingDate AND @EndingDateMinus1Day


							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateXSEU	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateXSEU

							--					Make sure the subject date range IS recorded in the preliminary fact tables before populating subsequent fact tables.
							EXEC				dbo.CheckFactCount	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate,
														@Exists												= @Existence OUTPUT,
														@EventLogTypeID										= @EventLogTypeIDOUT OUTPUT

							--					If the any date in the entire date range is NON-existent.
							--					Then log error and exit.
							IF					( (@Existence <> 1 ) )
							BEGIN

												--Log the error that the endingday date parameter is not over OR the day has already been logged.  Then exit.
												--@EventLogTypeIDOUT
												--Insert into DINGODB.dbo.EventLog table.
												RETURN

							END


							--					Uses temp table #DayOfYearPartition
							--					This SP will populate a physical temporary table with initial summaries and aggregates
							--					and will be used to populate subsequent fact tables.
							EXEC				dbo.PopulateTempTableFactSummary1	
														@StartingDate										= @StartingDate,
														@EndingDate											= @EndingDate
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateTempTableFactSummary1


							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateFactBreakMovingAverage 
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateFactBreakMovingAverage

							
							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateFactAssetSummary	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateFactAssetSummary


							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateFactSpotSummary	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateFactSpotSummary


							--					Uses temp table #DayOfYearPartition
							EXEC				dbo.PopulateFactIESummary	
							EXEC				DINGODB.dbo.LogEvent @EventLogStatusID	= @EventLogStatusID_PopulateFactIESummary


							DROP TABLE			#DayOfYearPartition


END
GO


/****** Object:  StoredProcedure [dbo].[DWETLParent]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.DWETLParent 
				@RegionID			INT				= NULL,
				@SDBSourceID		INT				= NULL,
				@SDBName			VARCHAR(64)		= NULL,
				@UTCOffset			INT				= NULL,
				@StartingDate		DATE			= NULL,
				@EndingDate			DATE			= NULL,
				@OverRideCounts		INT				= 0
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
// Module:  dbo.DWETLParent
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose:			This parent SP will call all ETL SPs.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.DWETLParent.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.DWETLParent	
//									@RegionID				= NULL,
//									@SDBSourceID			= NULL,
//									@SDBName				= NULL,
//									@UTCOffset				= NULL,
//									@StartingDate			= '2014-01-01',
//									@EndingDate				= NULL,
//									@OverRideCounts			= 0
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON


				DECLARE				@LogIDReturn												INT
				DECLARE				@EventLogStatusIDStart										INT
				DECLARE				@EventLogStatusIDSuccess									INT
				DECLARE				@EventLogStatusIDFail										INT
				DECLARE				@JobName													NVARCHAR(200)
				DECLARE				@DatabaseID													INT
				DECLARE				@StartingDayOfYear											INT
				DECLARE				@CurrentDay													INT
				DECLARE				@CurrentUTCDay												INT
				DECLARE				@ERROR_MESSAGE												NVARCHAR(500)

				SELECT				@CurrentDay													= DATEPART( DAY,GETDATE() ),
									@CurrentUTCDay												= DATEPART( DAY,GETUTCDATE() ),
									@DatabaseID													= DB_ID()

				--					Make sure the UTC day is over before continuing.
				IF					( @CurrentDay = @CurrentUTCDay )	RETURN

				IF					ISNULL(OBJECT_ID('tempdb..#EventLogIDs'), 0) > 0 
									DROP TABLE #EventLogIDs

				CREATE TABLE		#EventLogIDs
								(
									ID int identity(1,1),
									EventLogStatusID int,
									SP varchar(100)

								)

				INSERT				#EventLogIDs ( EventLogStatusID,SP )
				SELECT				EventLogStatusID, SP 
				FROM				DINGODB.dbo.EventLogStatus WITH (NOLOCK) 
				WHERE				SP LIKE 'DWETLParent%'

				SELECT				TOP 1 @EventLogStatusIDStart								= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent First Step'
				SELECT				TOP 1 @EventLogStatusIDSuccess								= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent Success Step'
				SELECT				TOP 1 @EventLogStatusIDFail									= e.EventLogStatusID FROM #EventLogIDs e WHERE e.SP = 'DWETLParent Fail Step'

				EXEC				DINGODB.dbo.LogEvent 
										@LogID													= NULL,
										@EventLogStatusID										= @EventLogStatusIDStart,			----Started Step
										@JobID													= NULL,
										@JobName												= @JobName,
										@DBID													= @DatabaseID,
										@DBComputerName											= @@SERVERNAME,
										@LogIDOUT												= @LogIDReturn OUTPUT

				--					If no starting date parameter is given then use 0:00 UTC minus 1 day
				SELECT				@StartingDate												= ISNULL( @StartingDate,DATEADD( DAY,-1,GETUTCDATE() ) )
				SELECT				@StartingDayOfYear											= DATEPART( DY,@StartingDate )
				SELECT				@EndingDate													= ISNULL( @EndingDate,DATEADD(DAY,1,@StartingDate) )

				EXEC				dbo.PopulateDimensions	
															@EventLogStatusIDFail				= @EventLogStatusIDFail,
															@LogIDReturn						= @LogIDReturn

				EXEC				dbo.PopulateFacts	
															@EventLogStatusIDFail				= @EventLogStatusIDFail,
															@LogIDReturn						= @LogIDReturn

				IF					( 1 = 1 )
									EXEC				DINGODB.dbo.LogEvent 
															@LogID								= @LogIDReturn, 
															@EventLogStatusID					= @EventLogStatusIDSuccess, 
															@Description						= NULL
				ELSE
									EXEC				DINGODB.dbo.LogEvent 
															@LogID								= @LogIDReturn, 
															@EventLogStatusID					= @EventLogStatusIDFail, 
															@Description						= NULL --@ERROR_MESSAGE


				
				DROP TABLE			#EventLogIDs

END

GO

/****** Object:  UserDefinedFunction [dbo].[DeriveChannelName]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[DeriveChannelName] ( @MarketName AS Varchar(100), @NetworkName AS Varchar(100), @Channel AS Int, @ZoneName AS Varchar(100) )
RETURNS
      VARCHAR(40)
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
// Module:  dbo.DeriveChannelName
// Created: 2014-Jul-01
// Author:  Tony Lew
// 
// Purpose:			Derive channel name from inputs given.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: MPEG.dbo.DeriveChannelName.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				SELECT			* FROM dbo.DeriveChannelName( 'MarketName','NetworkName',1,'ZoneName' )
//
*/ 
BEGIN

				DECLARE			@ChannelName  VARCHAR(40)

				SELECT			@ChannelName			=	@MarketName + '-' + @NetworkName + '/' + 
															SUBSTRING('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', ((CAST(@Channel AS INT) / 10) + 1), 1) +  
															CAST((CAST(@Channel AS INT) % 10) AS VARCHAR) + '-' + 
															RIGHT('00000'+CAST((CASE WHEN ISNUMERIC(RIGHT(@ZoneName, 5)) = 1 THEN RIGHT(@ZoneName, 5)ELSE 0 END) AS VARCHAR(5)),5)
				RETURN			( @ChannelName )


END




GO
/****** Object:  Table [dbo].[CountDimensionDate]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountDimensionDate](
	[CountDimensionDateID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[UTCDateStored] [date] NOT NULL,
	[DimensionID] [int] NOT NULL,
	[DimensionCount] [int] NOT NULL,
	[Enabled] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CountDimensionDate] PRIMARY KEY CLUSTERED 
(
	[CountDimensionDateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CountFactDate]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountFactDate](
	[CountFactDateID] [int] IDENTITY(1,1) NOT NULL,
	[UTCDateStored] [date] NOT NULL,
	[FactID] [int] NOT NULL,
	[FactCount] [int] NOT NULL,
	[Enabled] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CountFactDate] PRIMARY KEY CLUSTERED 
(
	[CountFactDateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DimAsset]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimAsset](
	[DimAssetID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[AssetID] [varchar](32) NOT NULL,
	[VIDEO_ID] [varchar](32) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[FRAMES] [int] NULL,
	[CODE] [varchar](65) NULL,
	[DESCRIPTION] [varchar](65) NULL,
	[VALUE] [int] NULL,
	[FPS] [int] NULL,
	[Length] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimAsset] PRIMARY KEY CLUSTERED 
(
	[DimAssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimChannelMap]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimChannelMap](
	[DimChannelMapID] [bigint] IDENTITY(1,1) NOT NULL,
	[IU_ID] [int] NOT NULL,
	[ChannelName] [varchar](40) NULL,
	[Channel] [varchar](12) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[NetworkID] [int] NULL,
	[NetworkName] [varchar](32) NULL,
	[ZoneName] [varchar](32) NULL,
	[MarketID] [int] NULL,
	[MarketName] [varchar](50) NULL,
	[ICProviderID] [int] NULL,
	[ICProviderName] [varchar](50) NULL,
	[ROCID] [int] NULL,
	[ROCName] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimChannelMap] PRIMARY KEY CLUSTERED 
(
	[DimChannelMapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimDateDay]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDateDay](
	[DimDate] [date] NOT NULL,
	[DateYear] [int] NOT NULL,
	[DateQuarter] [int] NOT NULL,
	[DateMonth] [int] NOT NULL,
	[DateDay] [int] NOT NULL,
	[DateDayOfWeek] [int] NOT NULL,
	[DayOfYearPartitionKey] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimDateDay] PRIMARY KEY CLUSTERED 
(
	[DimDate] ASC,
	[DayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([DayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([DayOfYearPartitionKey])

GO
/****** Object:  Table [dbo].[Dimension]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Dimension](
	[DimensionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Dimension] PRIMARY KEY CLUSTERED 
(
	[DimensionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimIE]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimIE](
	[DimIEID] [bigint] IDENTITY(1,1) NOT NULL,
	[IE_ID] [int] NOT NULL,
	[IU_ID] [int] NULL,
	[SCHED_DATE_TIME] [datetime] NOT NULL,
	[START_TRIGGER] [char](5) NULL,
	[END_TRIGGER] [char](5) NULL,
	[NSTATUS] [int] NULL,
	[CONFLICT_STATUS] [int] NULL,
	[SPOTS] [int] NULL,
	[DURATION] [int] NULL,
	[RUN_DATE_TIME] [datetime] NULL,
	[AWIN_START] [int] NULL,
	[AWIN_END] [int] NULL,
	[VALUE] [int] NULL,
	[BREAK_INWIN] [int] NULL,
	[AWIN_START_DT] [datetime] NULL,
	[AWIN_END_DT] [datetime] NULL,
	[SOURCE_ID] [int] NOT NULL,
	[TB_TYPE] [int] NOT NULL,
	[EVENT_ID] [int] NULL,
	[TS] [binary](8) NOT NULL,
	[UTCIEDatetime] [datetime] NOT NULL,
	[UTCIEDate] [date] NOT NULL,
	[UTCIEDateYear] [int] NOT NULL,
	[UTCIEDateMonth] [int] NOT NULL,
	[UTCIEDateDay] [int] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDate] [date] NOT NULL,
	[IEDateYear] [int] NOT NULL,
	[IEDateMonth] [int] NOT NULL,
	[IEDateDay] [int] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[DimIEStatusID] [int] NULL,
	[DimIEConflictStatusID] [int] NULL,
	[NSTATUSValue] [varchar](50) NULL,
	[CONFLICT_STATUSValue] [varchar](50) NULL,
	[SOURCE_IDName] [varchar](32) NOT NULL,
	[TB_TYPEName] [varchar](32) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBName] [varchar](32) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBName] [varchar](50) NOT NULL,
	[UTCOffset] [int] NULL,
	[ChannelName] [varchar](40) NULL,
	[MarketID] [int] NULL,
	[MarketName] [varchar](50) NULL,
	[ZoneName] [varchar](32) NULL,
	[NetworkID] [int] NULL,
	[NetworkName] [varchar](32) NULL,
	[TSI] [varchar](32) NULL,
	[ICProviderID] [int] NULL,
	[ICProviderName] [varchar](50) NULL,
	[ROCID] [int] NULL,
	[ROCName] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimIE] PRIMARY KEY CLUSTERED 
(
	[DimIEID] ASC,
	[UTCIEDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimIEConflictStatus]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimIEConflictStatus](
	[DimIEConflictStatusID] [int] IDENTITY(1,1) NOT NULL,
	[IEConflictStatusID] [int] NOT NULL,
	[IEConflictStatusValue] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimIEConflictStatus] PRIMARY KEY CLUSTERED 
(
	[DimIEConflictStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimIEStatus]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimIEStatus](
	[DimIEStatusID] [int] IDENTITY(1,1) NOT NULL,
	[IEStatusID] [int] NOT NULL,
	[IEStatusValue] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimIEStatus] PRIMARY KEY CLUSTERED 
(
	[DimIEStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimIU]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimIU](
	[DimIUID] [bigint] IDENTITY(1,1) NOT NULL,
	[IU_ID] [int] NOT NULL,
	[CHANNEL] [varchar](12) NOT NULL,
	[CHAN_NAME] [varchar](32) NOT NULL,
	[DELAY] [int] NOT NULL,
	[START_TRIGGER] [char](5) NOT NULL,
	[END_TRIGGER] [char](5) NOT NULL,
	[AWIN_START] [int] NULL,
	[AWIN_END] [int] NULL,
	[VALUE] [int] NULL,
	[MASTER_NAME] [varchar](32) NULL,
	[COMPUTER_NAME] [varchar](32) NULL,
	[PARENT_ID] [int] NULL,
	[SYSTEM_TYPE] [int] NULL,
	[COMPUTER_PORT] [int] NOT NULL,
	[MIN_DURATION] [int] NOT NULL,
	[MAX_DURATION] [int] NOT NULL,
	[START_OF_DAY] [char](8) NOT NULL,
	[RESCHEDULE_WINDOW] [int] NOT NULL,
	[IC_CHANNEL] [varchar](12) NULL,
	[VSM_SLOT] [int] NULL,
	[DECODER_PORT] [int] NULL,
	[TC_ID] [int] NULL,
	[IGNORE_VIDEO_ERRORS] [int] NULL,
	[IGNORE_AUDIO_ERRORS] [int] NULL,
	[COLLISION_DETECT_ENABLED] [int] NULL,
	[TALLY_NORMALLY_HIGH] [int] NULL,
	[PLAY_OVER_COLLISIONS] [int] NULL,
	[PLAY_COLLISION_FUDGE] [int] NULL,
	[TALLY_COLLISION_FUDGE] [int] NULL,
	[TALLY_ERROR_FUDGE] [int] NULL,
	[LOG_TALLY_ERRORS] [int] NULL,
	[TBI_START] [datetime] NULL,
	[TBI_END] [datetime] NULL,
	[CONTINUOUS_PLAY_FUDGE] [int] NULL,
	[TONE_GROUP] [varchar](64) NULL,
	[IGNORE_END_TONES] [int] NULL,
	[END_TONE_FUDGE] [int] NULL,
	[MAX_AVAILS] [int] NULL,
	[RESTART_TRIES] [int] NULL,
	[RESTART_BYTE_SKIP] [int] NULL,
	[RESTART_TIME_REMAINING] [int] NULL,
	[GENLOCK_FLAG] [int] NULL,
	[SKIP_HEADER] [int] NULL,
	[GPO_IGNORE] [int] NULL,
	[GPO_NORMAL] [int] NULL,
	[GPO_TIME] [int] NULL,
	[DECODER_SHARING] [int] NULL,
	[HIGH_PRIORITY] [int] NULL,
	[SPLICER_ID] [int] NULL,
	[PORT_ID] [int] NULL,
	[VIDEO_PID] [int] NULL,
	[SERVICE_PID] [int] NULL,
	[DVB_CARD] [int] NULL,
	[SPLICE_ADJUST] [int] NOT NULL,
	[POST_BLACK] [int] NOT NULL,
	[SWITCH_CNT] [int] NULL,
	[DECODER_CNT] [int] NULL,
	[DVB_CARD_CNT] [int] NULL,
	[DVB_PORTS_PER_CARD] [int] NULL,
	[DVB_CHAN_PER_PORT] [int] NULL,
	[USE_ISD] [int] NULL,
	[NO_NETWORK_VIDEO_DETECT] [int] NULL,
	[NO_NETWORK_PLAY] [int] NULL,
	[IP_TONE_THRESHOLD] [int] NULL,
	[USE_GIGE] [int] NULL,
	[GIGE_IP] [varchar](24) NULL,
	[IS_ACTIVE_IND] [bit] NOT NULL,
	[UTCIEDatetime] [datetime] NOT NULL,
	[UTCIEDate] [date] NOT NULL,
	[UTCIEDateYear] [int] NOT NULL,
	[UTCIEDateMonth] [int] NOT NULL,
	[UTCIEDateDay] [int] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDate] [date] NOT NULL,
	[IEDateYear] [int] NOT NULL,
	[IEDateMonth] [int] NOT NULL,
	[IEDateDay] [int] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[SystemTypeName] [varchar](64) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBName] [varchar](32) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBName] [varchar](50) NOT NULL,
	[UTCOffset] [int] NULL,
	[ChannelName] [varchar](40) NULL,
	[MarketID] [int] NULL,
	[MarketName] [varchar](50) NULL,
	[ZoneName] [varchar](32) NULL,
	[NetworkID] [int] NULL,
	[NetworkName] [varchar](32) NULL,
	[TSI] [varchar](32) NULL,
	[ICProviderID] [int] NULL,
	[ICProviderName] [varchar](50) NULL,
	[ROCID] [int] NULL,
	[ROCName] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimIU] PRIMARY KEY CLUSTERED 
(
	[DimIUID] ASC,
	[UTCIEDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimSDBSource]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimSDBSource](
	[DimSDBSourceID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBName] [varchar](50) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBName] [varchar](50) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[UTCOffset] [int] NULL,
	[Enabled] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimSDBSource] PRIMARY KEY CLUSTERED 
(
	[DimSDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimSpot]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimSpot](
	[DimSpotID] [bigint] IDENTITY(1,1) NOT NULL,
	[Spot_ID] [int] NOT NULL,
	[VIDEO_ID] [varchar](32) NULL,
	[DURATION] [int] NULL,
	[CUSTOMER] [varchar](80) NULL,
	[TITLE] [varchar](254) NULL,
	[NSTATUS] [int] NULL,
	[CONFLICT_STATUS] [int] NULL,
	[RATE] [float] NULL,
	[CODE] [varchar](12) NULL,
	[NOTES] [varchar](254) NULL,
	[SERIAL] [varchar](32) NULL,
	[ID] [varchar](32) NULL,
	[IE_ID] [int] NULL,
	[Spot_ORDER] [int] NULL,
	[RUN_DATE_TIME] [datetime] NULL,
	[RUN_LENGTH] [int] NULL,
	[VALUE] [int] NULL,
	[ORDER_ID] [int] NULL,
	[BONUS_FLAG] [int] NULL,
	[SOURCE_ID] [int] NULL,
	[TS] [binary](8) NULL,
	[UTCSPOTDatetime] [datetime] NOT NULL,
	[UTCSPOTDate] [date] NOT NULL,
	[UTCSPOTDateYear] [int] NOT NULL,
	[UTCSPOTDateMonth] [int] NOT NULL,
	[UTCSPOTDateDay] [int] NOT NULL,
	[UTCSPOTDayOfYearPartitionKey] [int] NOT NULL,
	[SPOTDate] [date] NOT NULL,
	[SPOTDateYear] [int] NOT NULL,
	[SPOTDateMonth] [int] NOT NULL,
	[SPOTDateDay] [int] NOT NULL,
	[SPOTDayOfYearPartitionKey] [int] NOT NULL,
	[UTCIEDatetime] [datetime] NOT NULL,
	[UTCIEDate] [date] NOT NULL,
	[UTCIEDateYear] [int] NOT NULL,
	[UTCIEDateMonth] [int] NOT NULL,
	[UTCIEDateDay] [int] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDatetime] [datetime] NOT NULL,
	[IEDate] [date] NOT NULL,
	[IEDateYear] [int] NOT NULL,
	[IEDateMonth] [int] NOT NULL,
	[IEDateDay] [int] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[DimSpotStatusID] [int] NULL,
	[DimSpotConflictStatusID] [int] NULL,
	[IU_ID] [int] NULL,
	[NSTATUSValue] [varchar](50) NULL,
	[CONFLICT_STATUSValue] [varchar](50) NULL,
	[SOURCE_ID_INTERCONNECT_NAME] [varchar](32) NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBName] [varchar](32) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBName] [varchar](50) NOT NULL,
	[UTCOffset] [int] NULL,
	[ChannelName] [varchar](40) NULL,
	[MarketID] [int] NULL,
	[MarketName] [varchar](50) NULL,
	[ZoneName] [varchar](32) NULL,
	[NetworkID] [int] NULL,
	[NetworkName] [varchar](32) NULL,
	[TSI] [varchar](32) NULL,
	[ICProviderID] [int] NULL,
	[ICProviderName] [varchar](50) NULL,
	[ROCID] [int] NULL,
	[ROCName] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DIMSpot] PRIMARY KEY CLUSTERED 
(
	[DimSpotID] ASC,
	[UTCSPOTDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimSpotConflictStatus]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimSpotConflictStatus](
	[DimSpotConflictStatusID] [int] IDENTITY(1,1) NOT NULL,
	[SpotConflictStatusID] [int] NOT NULL,
	[SpotConflictStatusValue] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimSpotConflictStatus] PRIMARY KEY CLUSTERED 
(
	[DimSpotConflictStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimSpotStatus]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimSpotStatus](
	[DimSpotStatusID] [int] IDENTITY(1,1) NOT NULL,
	[SpotStatusID] [int] NOT NULL,
	[SpotStatusValue] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimSpotStatus] PRIMARY KEY CLUSTERED 
(
	[DimSpotStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimTB_REQUEST]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimTB_REQUEST](
	[DimTB_REQUESTID] [bigint] IDENTITY(1,1) NOT NULL,
	[TB_ID] [int] NOT NULL,
	[ZONE_ID] [int] NOT NULL,
	[IU_ID] [int] NOT NULL,
	[TB_REQUEST] [int] NOT NULL,
	[TB_MODE] [int] NOT NULL,
	[TB_TYPE] [int] NULL,
	[TB_DAYPART] [datetime] NOT NULL,
	[TB_FILE] [varchar](128) NOT NULL,
	[TB_FILE_DATE] [datetime] NOT NULL,
	[STATUS] [int] NOT NULL,
	[EXPLANATION] [varchar](128) NULL,
	[TB_MACHINE] [varchar](32) NULL,
	[TB_MACHINE_TS] [datetime] NULL,
	[TB_MACHINE_THREAD] [int] NULL,
	[REQUESTING_MACHINE] [varchar](32) NULL,
	[REQUESTING_PORT] [int] NULL,
	[SOURCE_ID] [int] NOT NULL,
	[MSGNR] [int] NULL,
	[TS] [binary](8) NOT NULL,
	[UTCTB_FILE_DATE] [date] NOT NULL,
	[UTCTB_FILE_DATE_TIME] [datetime] NOT NULL,
	[UTCIEDatetime] [datetime] NOT NULL,
	[UTCIEDate] [date] NOT NULL,
	[UTCIEDateYear] [int] NOT NULL,
	[UTCIEDateMonth] [int] NOT NULL,
	[UTCIEDateDay] [int] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDate] [date] NOT NULL,
	[IEDateYear] [int] NOT NULL,
	[IEDateMonth] [int] NOT NULL,
	[IEDateDay] [int] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[TB_MODE_NAME] [varchar](32) NOT NULL,
	[REQUEST_NAME] [varchar](32) NOT NULL,
	[SOURCE_ID_NAME] [varchar](32) NOT NULL,
	[STATUS_NAME] [varchar](32) NOT NULL,
	[TYPE_NAME] [varchar](32) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBName] [varchar](32) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBName] [varchar](50) NOT NULL,
	[UTCOffset] [int] NULL,
	[ChannelName] [varchar](40) NULL,
	[MarketID] [int] NULL,
	[MarketName] [varchar](50) NULL,
	[ZoneName] [varchar](32) NULL,
	[NetworkID] [int] NULL,
	[NetworkName] [varchar](32) NULL,
	[TSI] [varchar](32) NULL,
	[ICProviderID] [int] NULL,
	[ICProviderName] [varchar](50) NULL,
	[ROCID] [int] NULL,
	[ROCName] [varchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimTB_REQUEST] PRIMARY KEY CLUSTERED 
(
	[DimTB_REQUESTID] ASC,
	[UTCIEDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimZoneMap]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DimZoneMap](
	[DimZoneMapID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneMapID] [int] NOT NULL,
	[ZoneName] [varchar](50) NOT NULL,
	[MarketID] [int] NOT NULL,
	[MarketName] [varchar](50) NOT NULL,
	[ICProviderID] [int] NOT NULL,
	[ICProviderName] [varchar](50) NOT NULL,
	[ROCID] [int] NOT NULL,
	[ROCName] [varchar](50) NOT NULL,
	[Enabled] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimZoneMap] PRIMARY KEY CLUSTERED 
(
	[DimZoneMapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Fact]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Fact](
	[FactID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Fact] PRIMARY KEY CLUSTERED 
(
	[FactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactAssetSummary]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactAssetSummary](
	[FactAssetSummaryID] [bigint] IDENTITY(1,1) NOT NULL,
	[UTCSPOTDayOfYearPartitionKey] [int] NOT NULL,
	[UTCSPOTDayDate] [date] NOT NULL,
	[SPOTDayOfYearPartitionKey] [int] NOT NULL,
	[SPOTDayDate] [date] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[UTCIEDayDate] [date] NOT NULL,
	[DimAssetID] [int] NOT NULL,
	[DimSDBSourceID] [int] NOT NULL,
	[DimSPOTID] [bigint] NULL,
	[DimIEID] [bigint] NULL,
	[DimIUID] [bigint] NULL,
	[DimTB_REQUESTID] [bigint] NULL,
	[DimSpotStatusID] [int] NULL,
	[DimSpotConflictStatusID] [int] NULL,
	[DimIEStatusID] [int] NULL,
	[DimIEConflictStatusID] [int] NULL,
	[SecondsLength] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_FactAssetSummary] PRIMARY KEY CLUSTERED 
(
	[FactAssetSummaryID] ASC,
	[UTCSPOTDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])

GO
/****** Object:  Table [dbo].[FactBreakMovingAverage]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[FactBreakMovingAverage](
	[FactBreakMovingAverageID] [bigint] IDENTITY(1,1) NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDayDate] [date] NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[MarketID] [int] NOT NULL,
	[MarketName] [varchar](50) NOT NULL,
	[ZoneName] [varchar](50) NOT NULL,
	[NetworkID] [int] NOT NULL,
	[NetworkName] [varchar](50) NOT NULL,
	[ICProviderID] [int] NOT NULL,
	[ICProviderName] [varchar](50) NOT NULL,
	[ROCID] [int] NOT NULL,
	[ROCName] [varchar](50) NOT NULL,
	[ChannelName] [varchar](50) NOT NULL,
	[ICDailyCount] [int] NOT NULL,
	[ATTDailyCount] [int] NOT NULL,
	[ICMovingAvg7Day] [float] NULL,
	[ATTMovingAvg7Day] [float] NULL,
	[UTC] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_FactBreakMovingAverage] PRIMARY KEY CLUSTERED 
(
	[FactBreakMovingAverageID] ASC,
	[IEDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([IEDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([IEDayOfYearPartitionKey])

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactIESummary]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactIESummary](
	[FactIESummaryID] [bigint] IDENTITY(1,1) NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[UTCIEDayDate] [date] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDayDate] [date] NOT NULL,
	[DimIEID] [bigint] NULL,
	[DimIUID] [bigint] NULL,
	[DimTB_REQUESTID] [bigint] NULL,
	[ICScheduleLoaded] [datetime] NOT NULL,
	[ICScheduleBreakCount] [int] NOT NULL,
	[ICMissingMedia] [int] NOT NULL,
	[ICMediaPrefixErrors] [int] NOT NULL,
	[ICMediaDurationErrors] [int] NOT NULL,
	[ICMediaFormatErrors] [int] NOT NULL,
	[ATTScheduleLoaded] [datetime] NOT NULL,
	[ATTScheduleBreakCount] [int] NOT NULL,
	[ATTMissingMedia] [int] NOT NULL,
	[ATTMediaPrefixErrors] [int] NOT NULL,
	[ATTMediaDurationErrors] [int] NOT NULL,
	[ATTMediaFormatErrors] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_FactIESummary] PRIMARY KEY CLUSTERED 
(
	[FactIESummaryID] ASC,
	[UTCIEDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])

GO
/****** Object:  Table [dbo].[FactSpotSummary]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactSpotSummary](
	[FactSpotSummaryID] [bigint] IDENTITY(1,1) NOT NULL,
	[UTCSPOTDayOfYearPartitionKey] [int] NOT NULL,
	[UTCSPOTDayDate] [date] NOT NULL,
	[SPOTDayOfYearPartitionKey] [int] NOT NULL,
	[SPOTDayDate] [date] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[UTCIEDayDate] [date] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDayDate] [date] NOT NULL,
	[DimSDBSourceID] [int] NOT NULL,
	[DimSPOTID] [bigint] NULL,
	[DimIEID] [bigint] NULL,
	[DimIUID] [bigint] NULL,
	[DimTB_REQUESTID] [bigint] NULL,
	[DimSpotStatusID] [int] NULL,
	[DimSpotConflictStatusID] [int] NULL,
	[DimIEStatusID] [int] NULL,
	[DimIEConflictStatusID] [int] NULL,
	[OTHERTotal] [int] NOT NULL,
	[DTM_OTHERTotal] [int] NOT NULL,
	[DTM_OTHERPlayed] [int] NOT NULL,
	[DTM_OTHERFailed] [int] NOT NULL,
	[DTM_OTHERNoTone] [int] NOT NULL,
	[DTM_OTHERMpegError] [int] NOT NULL,
	[DTM_OTHERMissingCopy] [int] NOT NULL,
	[OTHERScheduleLoaded] [datetime] NOT NULL,
	[OTHERScheduleBreakCount] [int] NOT NULL,
	[OTHERMissingMedia] [int] NOT NULL,
	[OTHERMediaPrefixErrors] [int] NOT NULL,
	[OTHERMediaDurationErrors] [int] NOT NULL,
	[OTHERMediaFormatErrors] [int] NOT NULL,
	[ICTotal] [int] NOT NULL,
	[DTM_ICTotal] [int] NOT NULL,
	[DTM_ICPlayed] [int] NOT NULL,
	[DTM_ICFailed] [int] NOT NULL,
	[DTM_ICNoTone] [int] NOT NULL,
	[DTM_ICMpegError] [int] NOT NULL,
	[DTM_ICMissingCopy] [int] NOT NULL,
	[ICScheduleLoaded] [datetime] NOT NULL,
	[ICScheduleBreakCount] [int] NOT NULL,
	[ICMissingMedia] [int] NOT NULL,
	[ICMediaPrefixErrors] [int] NOT NULL,
	[ICMediaDurationErrors] [int] NOT NULL,
	[ICMediaFormatErrors] [int] NOT NULL,
	[ATTTotal] [int] NOT NULL,
	[DTM_ATTTotal] [int] NOT NULL,
	[DTM_ATTPlayed] [int] NOT NULL,
	[DTM_ATTFailed] [int] NOT NULL,
	[DTM_ATTNoTone] [int] NOT NULL,
	[DTM_ATTMpegError] [int] NOT NULL,
	[DTM_ATTMissingCopy] [int] NOT NULL,
	[ATTScheduleLoaded] [datetime] NOT NULL,
	[ATTScheduleBreakCount] [int] NOT NULL,
	[ATTMissingMedia] [int] NOT NULL,
	[ATTMediaPrefixErrors] [int] NOT NULL,
	[ATTMediaDurationErrors] [int] NOT NULL,
	[ATTMediaFormatErrors] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_FactSpotSummary] PRIMARY KEY CLUSTERED 
(
	[FactSpotSummaryID] ASC,
	[UTCSPOTDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])

GO
/****** Object:  Table [dbo].[TempTableFactSummary1]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TempTableFactSummary1](
	[TempTableFactSummary1ID] [int] IDENTITY(1,1) NOT NULL,
	[UTCSPOTDayOfYearPartitionKey] [int] NOT NULL,
	[UTCSPOTDayDate] [date] NOT NULL,
	[SPOTDayOfYearPartitionKey] [int] NOT NULL,
	[SPOTDayDate] [date] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[UTCIEDayDate] [date] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[IEDayDate] [date] NOT NULL,
	[DimSDBSourceID] [int] NOT NULL,
	[UTCOffset] [int] NOT NULL,
	[DimSpotID] [int] NOT NULL,
	[DimSpotStatusID] [int] NOT NULL,
	[DimSpotConflictStatusID] [int] NOT NULL,
	[DimIEID] [int] NOT NULL,
	[DimIEStatusID] [int] NOT NULL,
	[DimIEConflictStatusID] [int] NOT NULL,
	[DimIUID] [int] NOT NULL,
	[DimTB_REQUESTID] [int] NOT NULL,
	[AssetID] [varchar](50) NOT NULL,
	[RegionID] [int] NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[ChannelName] [varchar](50) NOT NULL,
	[MarketID] [int] NOT NULL,
	[MarketName] [varchar](50) NOT NULL,
	[ZoneName] [varchar](50) NOT NULL,
	[NetworkID] [int] NOT NULL,
	[NetworkName] [varchar](50) NOT NULL,
	[ICProviderID] [int] NOT NULL,
	[ICProviderName] [varchar](50) NOT NULL,
	[ROCID] [int] NOT NULL,
	[ROCName] [varchar](50) NOT NULL,
	[SourceID] [int] NOT NULL,
	[ScheduleDate] [date] NOT NULL,
	[OTHERTotal] [int] NOT NULL,
	[DTM_OTHERTotal] [int] NOT NULL,
	[DTM_OTHERPlayed] [int] NOT NULL,
	[DTM_OTHERFailed] [int] NOT NULL,
	[DTM_OTHERNoTone] [int] NOT NULL,
	[DTM_OTHERMpegError] [int] NOT NULL,
	[DTM_OTHERMissingCopy] [int] NOT NULL,
	[OTHERScheduleLoaded] [datetime] NOT NULL,
	[OTHERScheduleBreakCount] [int] NOT NULL,
	[OTHERMissingMedia] [int] NOT NULL,
	[OTHERMediaPrefixErrors] [int] NOT NULL,
	[OTHERMediaDurationErrors] [int] NOT NULL,
	[OTHERMediaFormatErrors] [int] NOT NULL,
	[ICTotal] [int] NOT NULL,
	[DTM_ICTotal] [int] NOT NULL,
	[DTM_ICPlayed] [int] NOT NULL,
	[DTM_ICFailed] [int] NOT NULL,
	[DTM_ICNoTone] [int] NOT NULL,
	[DTM_ICMpegError] [int] NOT NULL,
	[DTM_ICMissingCopy] [int] NOT NULL,
	[ICScheduleLoaded] [datetime] NOT NULL,
	[ICScheduleBreakCount] [int] NOT NULL,
	[ICMissingMedia] [int] NOT NULL,
	[ICMediaPrefixErrors] [int] NOT NULL,
	[ICMediaDurationErrors] [int] NOT NULL,
	[ICMediaFormatErrors] [int] NOT NULL,
	[ATTTotal] [int] NOT NULL,
	[DTM_ATTTotal] [int] NOT NULL,
	[DTM_ATTPlayed] [int] NOT NULL,
	[DTM_ATTFailed] [int] NOT NULL,
	[DTM_ATTNoTone] [int] NOT NULL,
	[DTM_ATTMpegError] [int] NOT NULL,
	[DTM_ATTMissingCopy] [int] NOT NULL,
	[ATTScheduleLoaded] [datetime] NOT NULL,
	[ATTScheduleBreakCount] [int] NOT NULL,
	[ATTMissingMedia] [int] NOT NULL,
	[ATTMediaPrefixErrors] [int] NOT NULL,
	[ATTMediaDurationErrors] [int] NOT NULL,
	[ATTMediaFormatErrors] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TempTableFactSummary1] PRIMARY KEY CLUSTERED 
(
	[TempTableFactSummary1ID] ASC,
	[UTCSPOTDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[XSEU]    Script Date: 7/1/2014 11:33:23 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XSEU](
	[XSEUID] [bigint] IDENTITY(1,1) NOT NULL,
	[DimSpotID] [bigint] NOT NULL,
	[DimIEID] [bigint] NULL,
	[DimIUID] [bigint] NULL,
	[DimTB_REQUESTID] [bigint] NULL,
	[DimSpotStatusID] [int] NULL,
	[DimSpotConflictStatusID] [int] NULL,
	[DimIEStatusID] [int] NULL,
	[DimIEConflictStatusID] [int] NULL,
	[DimSDBSourceID] [int] NOT NULL,
	[UTCSPOTDayDate] [date] NOT NULL,
	[UTCSPOTDayOfYearPartitionKey] [int] NOT NULL,
	[UTCIEDayDate] [date] NOT NULL,
	[UTCIEDayOfYearPartitionKey] [int] NOT NULL,
	[SPOTDayDate] [date] NOT NULL,
	[SPOTDayOfYearPartitionKey] [int] NOT NULL,
	[IEDayDate] [date] NOT NULL,
	[IEDayOfYearPartitionKey] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_XSEU] PRIMARY KEY CLUSTERED 
(
	[XSEUID] ASC,
	[UTCSPOTDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])

GO
/****** Object:  Index [UNC_CountDimensionDate_UTCDateStored_SDBSourceID_DimensionID_iDimensionCount]    Script Date: 7/1/2014 11:33:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_CountDimensionDate_UTCDateStored_SDBSourceID_DimensionID_iDimensionCount] ON [dbo].[CountDimensionDate]
(
	[UTCDateStored] ASC,
	[SDBSourceID] ASC,
	[DimensionID] ASC
)
INCLUDE ( 	[DimensionCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_CountFactDate_UTCDateStored_FactID_iFactCount]    Script Date: 7/1/2014 11:33:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_CountFactDate_UTCDateStored_FactID_iFactCount] ON [dbo].[CountFactDate]
(
	[UTCDateStored] ASC,
	[FactID] ASC
)
INCLUDE ( 	[FactCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_DimAsset_AssetID_RegionID_iLength]    Script Date: 7/1/2014 11:33:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_DimAsset_AssetID_RegionID_iLength] ON [dbo].[DimAsset]
(
	[AssetID] ASC,
	[RegionID] ASC
)
INCLUDE ( 	[Length]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [NC_DimSpot_UTCSPOTDayOfYearPartitionKey_VIDEO_ID_RegionID]    Script Date: 7/1/2014 11:33:23 PM ******/
CREATE NONCLUSTERED INDEX [NC_DimSpot_UTCSPOTDayOfYearPartitionKey_VIDEO_ID_RegionID] ON [dbo].[DimSpot]
(
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[VIDEO_ID] ASC,
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactAssetSummary_DayOfYearPartitionKey_DimDateDay]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactAssetSummary_DayOfYearPartitionKey_DimDateDay] ON [dbo].[FactAssetSummary]
(
	[SPOTDayOfYearPartitionKey] ASC,
	[SPOTDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactAssetSummary_DayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactAssetSummary_DayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactAssetSummary]
(
	[SPOTDayOfYearPartitionKey] ASC,
	[DimSPOTID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactAssetSummary_SPOTDimDateDay_iDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactAssetSummary_SPOTDimDateDay_iDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactAssetSummary]
(
	[SPOTDayDate] ASC
)
INCLUDE ( 	[SPOTDayOfYearPartitionKey],
	[DimSPOTID],
	[DimIEID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactAssetSummary_SPOTDimDateDay_SPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactAssetSummary_SPOTDimDateDay_SPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactAssetSummary]
(
	[SPOTDayDate] ASC,
	[SPOTDayOfYearPartitionKey] ASC,
	[DimSPOTID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactAssetSummary_UTCDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactAssetSummary_UTCDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactAssetSummary]
(
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[DimSPOTID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactAssetSummary_UTCSPOTDayOfYearPartitionKey_UTCSPOTDimDateDay]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactAssetSummary_UTCSPOTDayOfYearPartitionKey_UTCSPOTDimDateDay] ON [dbo].[FactAssetSummary]
(
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[UTCSPOTDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactAssetSummary_UTCSPOTDimDateDay_iUTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactAssetSummary_UTCSPOTDimDateDay_iUTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactAssetSummary]
(
	[UTCSPOTDayDate] ASC
)
INCLUDE ( 	[UTCSPOTDayOfYearPartitionKey],
	[DimSPOTID],
	[DimIEID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactAssetSummary_UTCSPOTDimDateDay_UTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactAssetSummary_UTCSPOTDimDateDay_UTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactAssetSummary]
(
	[UTCSPOTDayDate] ASC,
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[DimSPOTID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactBreakMovingAverage_IEDayOfYearPartitionKey_IEDayDate_UTC_iCounts]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactBreakMovingAverage_IEDayOfYearPartitionKey_IEDayDate_UTC_iCounts] ON [dbo].[FactBreakMovingAverage]
(
	[IEDayOfYearPartitionKey] ASC,
	[IEDayDate] ASC,
	[UTC] ASC
)
INCLUDE ( 	[ICDailyCount],
	[ATTDailyCount],
	[ICMovingAvg7Day],
	[ATTMovingAvg7Day]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([IEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactIESummary_IEDayOfYearPartitionKey_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactIESummary_IEDayOfYearPartitionKey_DimIEID] ON [dbo].[FactIESummary]
(
	[IEDayOfYearPartitionKey] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactIESummary_IEDayOfYearPartitionKey_IEDayDate]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactIESummary_IEDayOfYearPartitionKey_IEDayDate] ON [dbo].[FactIESummary]
(
	[IEDayOfYearPartitionKey] ASC,
	[IEDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([IEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactIESummary_IEDimDateDay_IEDayOfYearPartitionKey_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactIESummary_IEDimDateDay_IEDayOfYearPartitionKey_DimIEID] ON [dbo].[FactIESummary]
(
	[IEDayDate] ASC,
	[IEDayOfYearPartitionKey] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([IEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactIESummary_UTCDayOfYearPartitionKey_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactIESummary_UTCDayOfYearPartitionKey_DimIEID] ON [dbo].[FactIESummary]
(
	[UTCIEDayOfYearPartitionKey] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactIESummary_UTCIEDayDate_UTCIEDayOfYearPartitionKey_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactIESummary_UTCIEDayDate_UTCIEDayOfYearPartitionKey_DimIEID] ON [dbo].[FactIESummary]
(
	[UTCIEDayDate] ASC,
	[UTCIEDayOfYearPartitionKey] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactIESummary_UTCIEDayOfYearPartitionKey_UTCIEDimDateDay]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactIESummary_UTCIEDayOfYearPartitionKey_UTCIEDimDateDay] ON [dbo].[FactIESummary]
(
	[UTCIEDayOfYearPartitionKey] ASC,
	[UTCIEDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactSpotSummary_DayOfYearPartitionKey_DimDateDay]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactSpotSummary_DayOfYearPartitionKey_DimDateDay] ON [dbo].[FactSpotSummary]
(
	[SPOTDayOfYearPartitionKey] ASC,
	[SPOTDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactSpotSummary_DayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactSpotSummary_DayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactSpotSummary]
(
	[SPOTDayOfYearPartitionKey] ASC,
	[DimSPOTID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactSpotSummary_SPOTDimDateDay_iDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactSpotSummary_SPOTDimDateDay_iDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactSpotSummary]
(
	[SPOTDayDate] ASC
)
INCLUDE ( 	[SPOTDayOfYearPartitionKey],
	[DimSPOTID],
	[DimIEID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactSpotSummary_SPOTDimDateDay_SPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactSpotSummary_SPOTDimDateDay_SPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactSpotSummary]
(
	[SPOTDayDate] ASC,
	[SPOTDayOfYearPartitionKey] ASC,
	[DimSPOTID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactSpotSummary_UTCDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactSpotSummary_UTCDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactSpotSummary]
(
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[DimSPOTID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactSpotSummary_UTCSPOTDayOfYearPartitionKey_UTCSPOTDimDateDay]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactSpotSummary_UTCSPOTDayOfYearPartitionKey_UTCSPOTDimDateDay] ON [dbo].[FactSpotSummary]
(
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[UTCSPOTDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactSpotSummary_UTCSPOTDimDateDay_iUTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactSpotSummary_UTCSPOTDimDateDay_iUTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactSpotSummary]
(
	[UTCSPOTDayDate] ASC
)
INCLUDE ( 	[UTCSPOTDayOfYearPartitionKey],
	[DimSPOTID],
	[DimIEID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_FactSpotSummary_UTCSPOTDimDateDay_UTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_FactSpotSummary_UTCSPOTDimDateDay_UTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[FactSpotSummary]
(
	[UTCSPOTDayDate] ASC,
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[DimSPOTID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_TempTableFactSummary1_IEDayOfYearPartitionKey_IEDayDate]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_TempTableFactSummary1_IEDayOfYearPartitionKey_IEDayDate] ON [dbo].[TempTableFactSummary1]
(
	[IEDayOfYearPartitionKey] ASC,
	[IEDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([IEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_TempTableFactSummary1_SPOTDayOfYearPartitionKey_SPOTDayDate]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_TempTableFactSummary1_SPOTDayOfYearPartitionKey_SPOTDayDate] ON [dbo].[TempTableFactSummary1]
(
	[SPOTDayOfYearPartitionKey] ASC,
	[SPOTDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_TempTableFactSummary1_UTCIEDayOfYearPartitionKey_UTCIEDayDate]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_TempTableFactSummary1_UTCIEDayOfYearPartitionKey_UTCIEDayDate] ON [dbo].[TempTableFactSummary1]
(
	[UTCIEDayOfYearPartitionKey] ASC,
	[UTCIEDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCIEDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_TempTableFactSummary1_UTCSPOTDayOfYearPartitionKey_UTCSPOTDayDate]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_TempTableFactSummary1_UTCSPOTDayOfYearPartitionKey_UTCSPOTDayDate] ON [dbo].[TempTableFactSummary1]
(
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[UTCSPOTDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_XSEU_DayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_XSEU_DayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[XSEU]
(
	[SPOTDayOfYearPartitionKey] ASC,
	[DimSpotID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_XSEU_DayOfYearPartitionKey_SPOTDayDate]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_XSEU_DayOfYearPartitionKey_SPOTDayDate] ON [dbo].[XSEU]
(
	[SPOTDayOfYearPartitionKey] ASC,
	[SPOTDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_XSEU_SPOTDayDate_iDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_XSEU_SPOTDayDate_iDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[XSEU]
(
	[SPOTDayDate] ASC
)
INCLUDE ( 	[SPOTDayOfYearPartitionKey],
	[DimSpotID],
	[DimIEID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_XSEU_SPOTDayDate_SPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_XSEU_SPOTDayDate_SPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[XSEU]
(
	[SPOTDayDate] ASC,
	[SPOTDayOfYearPartitionKey] ASC,
	[DimSpotID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([SPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_XSEU_UTCDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_XSEU_UTCDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[XSEU]
(
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[DimSpotID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_XSEU_UTCSPOTDayDate_iUTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_XSEU_UTCSPOTDayDate_iUTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[XSEU]
(
	[UTCSPOTDayDate] ASC
)
INCLUDE ( 	[UTCSPOTDayOfYearPartitionKey],
	[DimSpotID],
	[DimIEID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_XSEU_UTCSPOTDayDate_UTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_XSEU_UTCSPOTDayDate_UTCSPOTDayOfYearPartitionKey_DimSpotID_DimIEID] ON [dbo].[XSEU]
(
	[UTCSPOTDayDate] ASC,
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[DimSpotID] ASC,
	[DimIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
/****** Object:  Index [NC_XSEU_UTCSPOTDayOfYearPartitionKey_UTCSPOTDayDate]    Script Date: 7/1/2014 11:33:24 PM ******/
CREATE NONCLUSTERED INDEX [NC_XSEU_UTCSPOTDayOfYearPartitionKey_UTCSPOTDayDate] ON [dbo].[XSEU]
(
	[UTCSPOTDayOfYearPartitionKey] ASC,
	[UTCSPOTDayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCSPOTDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[CountDimensionDate] ADD  CONSTRAINT [DF_CountDimensionDate_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[CountDimensionDate] ADD  CONSTRAINT [DF_CountDimensionDate_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CountDimensionDate] ADD  CONSTRAINT [DF_CountDimensionDate_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[CountFactDate] ADD  CONSTRAINT [DF_CountFactDate_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[CountFactDate] ADD  CONSTRAINT [DF_CountFactDate_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CountFactDate] ADD  CONSTRAINT [DF_CountFactDate_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimAsset] ADD  CONSTRAINT [DF_DimAsset_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimAsset] ADD  CONSTRAINT [DF_DimAsset_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimChannelMap] ADD  CONSTRAINT [DF_DimChannelMap_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimChannelMap] ADD  CONSTRAINT [DF_DimChannelMap_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimDateDay] ADD  CONSTRAINT [DF_DimDateDay_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimDateDay] ADD  CONSTRAINT [DF_DimDateDay_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Dimension] ADD  CONSTRAINT [DF_Dimension_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Dimension] ADD  CONSTRAINT [DF_Dimension_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimIE] ADD  CONSTRAINT [DF_DimIE_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimIE] ADD  CONSTRAINT [DF_DimIE_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimIEConflictStatus] ADD  CONSTRAINT [DF_DimIEConflictStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimIEConflictStatus] ADD  CONSTRAINT [DF_DimIEConflictStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimIEStatus] ADD  CONSTRAINT [DF_DimIEStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimIEStatus] ADD  CONSTRAINT [DF_DimIEStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimIU] ADD  CONSTRAINT [DF_DimIU_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimIU] ADD  CONSTRAINT [DF_DimIU_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimSDBSource] ADD  CONSTRAINT [DF_DimSDBSource_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[DimSDBSource] ADD  CONSTRAINT [DF_DimSDBSource_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimSDBSource] ADD  CONSTRAINT [DF_DimSDBSource_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimSpot] ADD  CONSTRAINT [DF_DimSpot_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimSpot] ADD  CONSTRAINT [DF_DimSpot_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimSpotConflictStatus] ADD  CONSTRAINT [DF_DimSpotConflictStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimSpotConflictStatus] ADD  CONSTRAINT [DF_DimSpotConflictStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimSpotStatus] ADD  CONSTRAINT [DF_DimSpotStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimSpotStatus] ADD  CONSTRAINT [DF_DimSpotStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimTB_REQUEST] ADD  CONSTRAINT [DF_DimTB_REQUEST_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimTB_REQUEST] ADD  CONSTRAINT [DF_DimTB_REQUEST_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[DimZoneMap] ADD  CONSTRAINT [DF_DimZoneMap_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[DimZoneMap] ADD  CONSTRAINT [DF_DimZoneMap_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DimZoneMap] ADD  CONSTRAINT [DF_DimZoneMap_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Fact] ADD  CONSTRAINT [DF_Fact_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Fact] ADD  CONSTRAINT [DF_Fact_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[FactAssetSummary] ADD  CONSTRAINT [DF_FactAssetSummary_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[FactAssetSummary] ADD  CONSTRAINT [DF_FactAssetSummary_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[FactBreakMovingAverage] ADD  CONSTRAINT [DF_FactBreakMovingAverage_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[FactBreakMovingAverage] ADD  CONSTRAINT [DF_FactBreakMovingAverage_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[FactIESummary] ADD  CONSTRAINT [DF_FactIESummary_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[FactIESummary] ADD  CONSTRAINT [DF_FactIESummary_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[FactSpotSummary] ADD  CONSTRAINT [DF_FactSpotSummary_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[FactSpotSummary] ADD  CONSTRAINT [DF_FactSpotSummary_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[TempTableFactSummary1] ADD  CONSTRAINT [DF_TempTableFactSummary1_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[TempTableFactSummary1] ADD  CONSTRAINT [DF_TempTableFactSummary1_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[XSEU] ADD  CONSTRAINT [DF_XSEU_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[XSEU] ADD  CONSTRAINT [DF_XSEU_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[CountDimensionDate]  WITH CHECK ADD  CONSTRAINT [FK_CountDimensionDate_DimensionID_-->_Dimension_DimensionID] FOREIGN KEY([DimensionID])
REFERENCES [dbo].[Dimension] ([DimensionID])
GO
ALTER TABLE [dbo].[CountDimensionDate] CHECK CONSTRAINT [FK_CountDimensionDate_DimensionID_-->_Dimension_DimensionID]
GO
ALTER TABLE [dbo].[CountFactDate]  WITH CHECK ADD  CONSTRAINT [FK_CountFactDate_FactID_-->_Fact_FactID] FOREIGN KEY([FactID])
REFERENCES [dbo].[Fact] ([FactID])
GO
ALTER TABLE [dbo].[CountFactDate] CHECK CONSTRAINT [FK_CountFactDate_FactID_-->_Fact_FactID]
GO
ALTER TABLE [dbo].[DimIE]  WITH CHECK ADD  CONSTRAINT [FK_DimIE_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID] FOREIGN KEY([DimIEConflictStatusID])
REFERENCES [dbo].[DimIEConflictStatus] ([DimIEConflictStatusID])
GO
ALTER TABLE [dbo].[DimIE] CHECK CONSTRAINT [FK_DimIE_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID]
GO
ALTER TABLE [dbo].[DimIE]  WITH CHECK ADD  CONSTRAINT [FK_DimIE_DimIEStatusID_-->_DimIEStatus_DimIEStatusID] FOREIGN KEY([DimIEStatusID])
REFERENCES [dbo].[DimIEStatus] ([DimIEStatusID])
GO
ALTER TABLE [dbo].[DimIE] CHECK CONSTRAINT [FK_DimIE_DimIEStatusID_-->_DimIEStatus_DimIEStatusID]
GO
ALTER TABLE [dbo].[DimSpot]  WITH CHECK ADD  CONSTRAINT [FK_DIMSpot_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID] FOREIGN KEY([DimSpotConflictStatusID])
REFERENCES [dbo].[DimSpotConflictStatus] ([DimSpotConflictStatusID])
GO
ALTER TABLE [dbo].[DimSpot] CHECK CONSTRAINT [FK_DIMSpot_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID]
GO
ALTER TABLE [dbo].[DimSpot]  WITH CHECK ADD  CONSTRAINT [FK_DIMSpot_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID] FOREIGN KEY([DimSpotStatusID])
REFERENCES [dbo].[DimSpotStatus] ([DimSpotStatusID])
GO
ALTER TABLE [dbo].[DimSpot] CHECK CONSTRAINT [FK_DIMSpot_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID]
GO
ALTER TABLE [dbo].[FactAssetSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactAssetSummary_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY] FOREIGN KEY([DimSPOTID], [UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimSpot] ([DimSpotID], [UTCSPOTDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactAssetSummary] CHECK CONSTRAINT [FK_FactAssetSummary_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY]
GO
ALTER TABLE [dbo].[FactAssetSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactAssetSummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY] FOREIGN KEY([UTCSPOTDayDate], [UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate], [DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactAssetSummary] CHECK CONSTRAINT [FK_FactAssetSummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY]
GO
ALTER TABLE [dbo].[FactIESummary]  WITH CHECK ADD  CONSTRAINT [FK_FactIESummary_DimIEID_UTCDY-->_DimIE_DimIEID_UTCDY] FOREIGN KEY([DimIEID], [UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimIE] ([DimIEID], [UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactIESummary] CHECK CONSTRAINT [FK_FactIESummary_DimIEID_UTCDY-->_DimIE_DimIEID_UTCDY]
GO
ALTER TABLE [dbo].[FactIESummary]  WITH CHECK ADD  CONSTRAINT [FK_FactIESummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY] FOREIGN KEY([UTCIEDayDate], [UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate], [DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactIESummary] CHECK CONSTRAINT [FK_FactIESummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY]
GO
ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY] FOREIGN KEY([DimSPOTID], [UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimSpot] ([DimSpotID], [UTCSPOTDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY]
GO
ALTER TABLE [dbo].[FactSpotSummary]  WITH CHECK ADD  CONSTRAINT [FK_FactSpotSummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY] FOREIGN KEY([UTCSPOTDayDate], [UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate], [DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[FactSpotSummary] CHECK CONSTRAINT [FK_FactSpotSummary_UTCDayDate_UTCDY-->_DimDate_DimDateDay_DY]
GO
ALTER TABLE [dbo].[TempTableFactSummary1]  WITH CHECK ADD  CONSTRAINT [FK_TempTableFactSummary1_UTCSPOTDayDate_DY-->_DimDateDay_DimDate_DY] FOREIGN KEY([UTCSPOTDayDate], [UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate], [DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[TempTableFactSummary1] CHECK CONSTRAINT [FK_TempTableFactSummary1_UTCSPOTDayDate_DY-->_DimDateDay_DimDate_DY]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID] FOREIGN KEY([DimIEConflictStatusID])
REFERENCES [dbo].[DimIEConflictStatus] ([DimIEConflictStatusID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimIEConflictStatusID_-->_DimIEConflictStatus_DimIEConflictStatusID]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimIEID_UTCDY_-->_DimIE_DimIEID_UTCDY] FOREIGN KEY([DimIEID], [UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimIE] ([DimIEID], [UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimIEID_UTCDY_-->_DimIE_DimIEID_UTCDY]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimIEStatusID_-->_DimIEStatus_DimIEStatusID] FOREIGN KEY([DimIEStatusID])
REFERENCES [dbo].[DimIEStatus] ([DimIEStatusID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimIEStatusID_-->_DimIEStatus_DimIEStatusID]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimIUID_UTCDY_-->_DimIU_DimIUID_UTCDY] FOREIGN KEY([DimIUID], [UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimIU] ([DimIUID], [UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimIUID_UTCDY_-->_DimIU_DimIUID_UTCDY]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimSDBSourceID_-->_DimSDBSource_DimSDBSourceID] FOREIGN KEY([DimSDBSourceID])
REFERENCES [dbo].[DimSDBSource] ([DimSDBSourceID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimSDBSourceID_-->_DimSDBSource_DimSDBSourceID]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID] FOREIGN KEY([DimSpotConflictStatusID])
REFERENCES [dbo].[DimSpotConflictStatus] ([DimSpotConflictStatusID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimSpotConflictStatusID_-->_DimSpotConflictStatus_DimSpotConflictStatusID]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY] FOREIGN KEY([DimSpotID], [UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimSpot] ([DimSpotID], [UTCSPOTDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimSpotID_UTCDY-->_DimSpot_DimSpotID_UTCDY]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_DimTB_REQUESTID_UTCDY_-->_DimTB_REQUEST_DimTB_REQUESTID_UTCDY] FOREIGN KEY([DimTB_REQUESTID], [UTCIEDayOfYearPartitionKey])
REFERENCES [dbo].[DimTB_REQUEST] ([DimTB_REQUESTID], [UTCIEDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_DimTB_REQUESTID_UTCDY_-->_DimTB_REQUEST_DimTB_REQUESTID_UTCDY]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID] FOREIGN KEY([DimSpotStatusID])
REFERENCES [dbo].[DimSpotStatus] ([DimSpotStatusID])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_SpotStatusID_-->_DimSpotStatus_DimSpotStatusID]
GO
ALTER TABLE [dbo].[XSEU]  WITH CHECK ADD  CONSTRAINT [FK_XSEU_UTCDayDate_UTCDY-->_DimDateDay_DimDate_DY] FOREIGN KEY([UTCSPOTDayDate], [UTCSPOTDayOfYearPartitionKey])
REFERENCES [dbo].[DimDateDay] ([DimDate], [DayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[XSEU] CHECK CONSTRAINT [FK_XSEU_UTCDayDate_UTCDY-->_DimDateDay_DimDate_DY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a SDB to dimension to day record.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'CountDimensionDateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a logical ID of the SDB system.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC Date Stored in dimension table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'UTCDateStored'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'DimensionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Count of the records for this dimension for an SDB for a particular day.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'DimensionCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to determine if count for a particular dimension, for a particular SDB and particular Date should be used to determine validity.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'Enabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountDimensionDate', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Fact to day record.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'CountFactDateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC Date Stored in Fact table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'UTCDateStored'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Fact.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'FactID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Count of the records for this Fact for a particular day.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'FactCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to determine if count for a particular Fact and particular Date should be used to determine validity.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'Enabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CountFactDate', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW unique identifier for an IE.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'DimAssetID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Region where asset originated.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'AssetID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'VIDEO_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB Database ID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'FRAMES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'DESCRIPTION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'FPS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Length of video in seconds.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'Length'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimAsset', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW unique identifier for an IU.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'DimChannelMapID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'IU_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'ChannelName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'RegionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'NetworkID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'NetworkName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'ZoneName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'MarketName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'ROCID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'ROCName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimChannelMap', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date unique identifier.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DimDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateQuarter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Month of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day of month of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day of week of DimDateDay.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DateDayOfWeek'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day of year of DimDateDay.  Used for partitioning.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'DayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimDateDay', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Dimension' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Dimension', @level2type=N'COLUMN',@level2name=N'DimensionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Dimension', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Dimension', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Dimension', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Dimension', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW unique identifier for an IE.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'DimIEID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'IE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'IU_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'SCHED_DATE_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'START_TRIGGER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'END_TRIGGER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'NSTATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'CONFLICT_STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'SPOTS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'DURATION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'RUN_DATE_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'AWIN_START'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'AWIN_END'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'BREAK_INWIN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'AWIN_START_DT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'AWIN_END_DT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'SOURCE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'TB_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'EVENT_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'TS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'UTCIEDatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'UTCIEDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'UTCIEDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'UTCIEDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'UTCIEDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'IEDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'IEDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'IEDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'IEDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'DimIEStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'DimIEConflictStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE Status.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'NSTATUSValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE Conflict Status.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'CONFLICT_STATUSValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'SOURCE_IDName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'TB_TYPEName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'RegionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'SDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'MDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'ChannelName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'MarketName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'ZoneName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'NetworkID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'NetworkName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'TSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'ROCID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'ROCName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIE', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW unique identifier for an IU.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DimIUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IU_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'CHANNEL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DELAY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'START_TRIGGER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'END_TRIGGER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'AWIN_START'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'AWIN_END'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'MASTER_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'COMPUTER_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'PARENT_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SYSTEM_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'COMPUTER_PORT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'MIN_DURATION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'MAX_DURATION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'START_OF_DAY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'RESCHEDULE_WINDOW'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IC_CHANNEL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'VSM_SLOT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DECODER_PORT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'TC_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IGNORE_VIDEO_ERRORS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IGNORE_AUDIO_ERRORS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'COLLISION_DETECT_ENABLED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'TALLY_NORMALLY_HIGH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'PLAY_OVER_COLLISIONS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'PLAY_COLLISION_FUDGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'TALLY_COLLISION_FUDGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'TALLY_ERROR_FUDGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'LOG_TALLY_ERRORS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'TBI_START'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'TBI_END'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'CONTINUOUS_PLAY_FUDGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'TONE_GROUP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IGNORE_END_TONES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'END_TONE_FUDGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'MAX_AVAILS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'RESTART_TRIES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'RESTART_BYTE_SKIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'RESTART_TIME_REMAINING'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'GENLOCK_FLAG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SKIP_HEADER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'GPO_IGNORE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'GPO_NORMAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'GPO_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DECODER_SHARING'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'HIGH_PRIORITY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SPLICER_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'PORT_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'VIDEO_PID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SERVICE_PID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DVB_CARD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SPLICE_ADJUST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'POST_BLACK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SWITCH_CNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DECODER_CNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DVB_CARD_CNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DVB_PORTS_PER_CARD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'DVB_CHAN_PER_PORT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'USE_ISD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'NO_NETWORK_VIDEO_DETECT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'NO_NETWORK_PLAY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IP_TONE_THRESHOLD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'USE_GIGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'GIGE_IP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IS_ACTIVE_IND'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'UTCIEDatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'UTCIEDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'UTCIEDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'UTCIEDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'UTCIEDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IEDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IEDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IEDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IEDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SystemTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'RegionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'SDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'MDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'ChannelName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'MarketName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'ZoneName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'NetworkID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'NetworkName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'TSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'ROCID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'ROCName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimIU', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW unique identifier for a Spot.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'DimSpotID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'Spot_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'VIDEO_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'DURATION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'CUSTOMER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'TITLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'NSTATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'CONFLICT_STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'RATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'NOTES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SERIAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'IE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'Spot_ORDER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'RUN_DATE_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'RUN_LENGTH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'ORDER_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'BONUS_FLAG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SOURCE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'TS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCSPOTDatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCSPOTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCSPOTDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCSPOTDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCSPOTDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SPOTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SPOTDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SPOTDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SPOTDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCIEDatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCIEDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCIEDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCIEDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCIEDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'IEDatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'IEDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'IEDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'IEDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'IEDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'DimSpotStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'DimSpotConflictStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot Status.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'NSTATUSValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot Conflict Status.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'CONFLICT_STATUSValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SOURCE_ID_INTERCONNECT_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'RegionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'SDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'MDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'ChannelName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'MarketName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'ZoneName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'NetworkID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'NetworkName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'TSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'ROCID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'ROCName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimSpot', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW unique identifier for a TB request.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'DimTB_REQUESTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'ZONE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'IU_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_REQUEST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_MODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_DAYPART'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_FILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_FILE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'EXPLANATION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_MACHINE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_MACHINE_TS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_MACHINE_THREAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'REQUESTING_MACHINE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'REQUESTING_PORT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'SOURCE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'MSGNR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MPEG database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'UTCIEDatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'UTCIEDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'UTCIEDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'UTCIEDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'UTCIEDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'IEDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'IEDateYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'IEDateMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'IEDateDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TB_MODE_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'REQUEST_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'SOURCE_ID_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'STATUS_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TYPE_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'RegionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'SDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'MDBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'ChannelName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'MarketName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'ZoneName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'NetworkID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'NetworkName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'TSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'ROCID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denormalized data.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'ROCName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTB_REQUEST', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW unique identifier for an SDB system.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'DimZoneMapID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for a ZoneMap.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'ZoneMapID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name for a zone.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'ZoneName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for an MDB system' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name for a market.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'MarketName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for a region.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name for a ICProvider.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'ICProviderName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for a region.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'ROCID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name for a ROC.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'ROCName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to determine if row is active.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'Enabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimZoneMap', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Fact' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Fact', @level2type=N'COLUMN',@level2name=N'FactID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of Fact.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Fact', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of Fact.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Fact', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Fact', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Fact', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot for a specific instance in time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'FactAssetSummaryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for SpotID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for SpotID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'SPOTDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for SpotID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'UTCIEDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an asset dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimAssetID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an SDB system dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimSDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimSPOTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimIEID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IU dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimIUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an TB_REQUEST dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimTB_REQUESTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimSpotStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot conflict status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimSpotConflictStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimIEStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE conflict status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'DimIEConflictStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Length of duration of video in seconds.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'SecondsLength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactAssetSummary', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot for a specific instance in time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactBreakMovingAverage', @level2type=N'COLUMN',@level2name=N'FactBreakMovingAverageID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE day dimensions day of year value.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactBreakMovingAverage', @level2type=N'COLUMN',@level2name=N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE Day dimension in UTC time zone value.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactBreakMovingAverage', @level2type=N'COLUMN',@level2name=N'IEDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC Determines whether the columns IEDayOfYearPartitionKey and IEDayDate are UTC time zone values.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactBreakMovingAverage', @level2type=N'COLUMN',@level2name=N'UTC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactBreakMovingAverage', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactBreakMovingAverage', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot for a specific instance in time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactIESummary', @level2type=N'COLUMN',@level2name=N'FactIESummaryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for insertion event.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactIESummary', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for insertion event.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactIESummary', @level2type=N'COLUMN',@level2name=N'UTCIEDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactIESummary', @level2type=N'COLUMN',@level2name=N'DimIEID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IU dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactIESummary', @level2type=N'COLUMN',@level2name=N'DimIUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an TB_REQUEST dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactIESummary', @level2type=N'COLUMN',@level2name=N'DimTB_REQUESTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactIESummary', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactIESummary', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot for a specific instance in time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'FactSpotSummaryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for SpotID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for SpotID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'SPOTDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for SpotID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'UTCIEDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an SDB system dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimSDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimSPOTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimIEID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IU dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimIUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an TB_REQUEST dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimTB_REQUESTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimSpotStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot conflict status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimSpotConflictStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimIEStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE conflict status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'DimIEConflictStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactSpotSummary', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot for a specific instance in time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'TempTableFactSummary1ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC SPOT day dimensions day of year value.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC SPOT Day dimension in UTC time zone value.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT day dimensions day of year value.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT Day dimension in UTC time zone value.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'SPOTDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC IE day dimensions day of year value.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC IE Day dimension in UTC time zone value.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'UTCIEDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE day dimensions day of year value.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE Day dimension in UTC time zone value.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'IEDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempTableFactSummary1', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot for a specific instance in time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'XSEUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimSpotID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimIEID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IU dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimIUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an TB_REQUEST dimension instance.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimTB_REQUESTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimSpotStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for a Spot conflict status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimSpotConflictStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimIEStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an IE conflict status dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimIEConflictStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODW Unique Identifier for an SDB system dimension.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'DimSDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for SpotID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'UTCSPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in UTC time zone value for IEID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'UTCIEDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC day dimensions day of year value for IEID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'UTCIEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in the SDB time zone specific value for SpotID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'SPOTDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB time zone specific day dimensions day of year value for SpotID.  This is used for SQL Server partitioning purposes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'SPOTDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day dimension in nonUTC time zone value for IEID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'IEDayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NonUTC day dimensions day of year value for IEID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'IEDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'XSEU', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO



USE [msdb]
GO

/****** Object:  Job [DW ETL]    Script Date: 5/28/2014 12:53:11 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[SDB]]]    Script Date: 5/28/2014 12:53:12 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Datawarehouse]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Datawarehouse]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Datawarehouse ETL', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Datawarehouse]', 
		--@owner_login_name=N'domain\username', @job_id = @jobId OUTPUT
		--@owner_login_name=N'PC-17252\TLew', 
		@job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Execute Parent ETL SP]    Script Date: 5/28/2014 12:53:12 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Execute Parent ETL SP', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC	DINGODW.dbo.DWETLParent	', 
		@database_name=N'DINGODW', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Hour 5 minutes past', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140528, 
		@active_end_date=99991231, 
		@active_start_time=500, 
		@active_end_time=235959, 
		@schedule_uid=N'e47015c3-e53f-49ee-8778-d07dfa23f3ea'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO





USE [master]
GO
ALTER DATABASE [DINGODW] SET  READ_WRITE 
GO
