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
// Module:  DINGOCT database creation script.
// Created: 2014-Jun-01
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



USE [MASTER]
GO
/****** OBJECT:  DATABASE [DINGOCT]    SCRIPT DATE: 09/17/2013 11:44:27 ******/
--DROP DATABASE [DINGOCT] 
CREATE DATABASE [DINGOCT] ON  PRIMARY 
( NAME = N'DINGOCT', FILENAME = N'D:\DATA\DINGOCT.MDF' , SIZE = 145408KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ),
FILEGROUP Partition1
( NAME = Partition1,
    FILENAME = 'D:\Data\DingoCTPartition1.ndf',
    SIZE = 100,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 5 )
 LOG ON 
( NAME = N'DINGOCT_LOG', FILENAME = N'D:\LOG\DINGOCT.LDF' , SIZE = 353920KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DINGOCT] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('ISFULLTEXTINSTALLED'))
BEGIN
EXEC [DINGOCT].[DBO].[SP_FULLTEXT_DATABASE] @ACTION = 'ENABLE'
END
GO


USE [MASTER]
GO
/****** OBJECT:  DATABASE [DINGOCT]    SCRIPT DATE: 09/17/2013 11:44:27 ******/
ALTER DATABASE [DINGOCT] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
ALTER DATABASE [DINGOCT] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('ISFULLTEXTINSTALLED'))
BEGIN
EXEC [DINGOCT].[DBO].[SP_FULLTEXT_DATABASE] @ACTION = 'ENABLE'
END
GO
ALTER DATABASE [DINGOCT] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [DINGOCT] SET ANSI_NULLS OFF
GO
ALTER DATABASE [DINGOCT] SET ANSI_PADDING OFF
GO
ALTER DATABASE [DINGOCT] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [DINGOCT] SET ARITHABORT OFF
GO
ALTER DATABASE [DINGOCT] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [DINGOCT] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [DINGOCT] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [DINGOCT] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [DINGOCT] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [DINGOCT] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [DINGOCT] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [DINGOCT] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [DINGOCT] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [DINGOCT] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [DINGOCT] SET  ENABLE_BROKER
GO
ALTER DATABASE [DINGOCT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [DINGOCT] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [DINGOCT] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [DINGOCT] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE [DINGOCT] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [DINGOCT] SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE [DINGOCT] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [DINGOCT] SET  READ_WRITE
GO
ALTER DATABASE [DINGOCT] SET RECOVERY FULL
GO
ALTER DATABASE [DINGOCT] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [DINGOCT] SET DB_CHAINING OFF
GO
ALTER DATABASE [DINGOCT] SET  MULTI_USER
GO


USE DINGOCT
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


--DROP PARTITION SCHEME [DayOfYearPartitionScheme]
CREATE PARTITION SCHEME [DayOfYearPartitionScheme]
AS PARTITION [DayOfYearPartition]
ALL TO ( Partition1 )






USE [DINGOCT]
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

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGOCT DBInfo identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'DBInfoID'
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
Select		'Version' AS Name, '2.0.0.4585' AS Description
GO



/****** Object:  StoredProcedure [dbo].[ReportContentEvent]    Script Date: 5/27/2014 12:24:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReportContentEvent] 
				@ContentID			UDT_Int READONLY,
				@ContentTypeID		UDT_Int READONLY,
				@SortOrder			INT = NULL
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
// Module:  dbo.ReportContentEvent
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Generate Content - Event report.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOCT.dbo.ReportContentEvent.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				DECLARE			@ContentIDIN			UDT_Int,
//								@ContentTypeIDIN		UDT_Int
//				EXEC			dbo.ReportContentEvent	
//										@ContentID		= @ContentIDIN,
//										@ContentTypeID	= @ContentTypeIDIN,
//										@SortOrder		= NULL
//
*/ 
BEGIN


				SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET				NOCOUNT ON

				DECLARE			@LastContentID								INT
				DECLARE			@LastContentTypeID							INT

				SELECT			TOP 1 @LastContentID						= c.ID
				FROM			@ContentID c
				ORDER BY		c.ID DESC

				SELECT			TOP 1 @LastContentTypeID					= ct.ID
				FROM			@ContentTypeID ct
				ORDER BY		ct.ID DESC


				SELECT
								UTCDayOfYearPartitionKey	= ce.UTCDayOfYearPartitionKey,
								ContentTypeID				= ce.ContentTypeID,
								ContentID					= ce.ContentID,
								CSPLogID					= ce.CSPLogID,
								ContentIdentifier			= c.ContentIdentifier,
								OccuranceDateStamp			= e.OccuranceDateStamp,
								OccuranceTimeStamp			= e.OccuranceTimeStamp,
								Severity					= e.Severity,
								HostName					= e.HostName,
								Tag							= e.Tag,
								FileName					= e.FileName,
								FilePath					= e.FilePath,
								Message						= e.Message,
								ContentType					= ctdef.Name
				FROM			dbo.ContentEvent ce (NOLOCK)
				JOIN			dbo.Content c (NOLOCK)
				ON				ce.ContentID				= c.ContentID
				JOIN			dbo.CSPLog e (NOLOCK)
				ON				ce.CSPLogID					= e.CSPLogID
				JOIN			dbo.ContentType ctdef (NOLOCK)
				ON				ce.ContentTypeID			= ctdef.ContentTypeID
				LEFT JOIN		@ContentID cp
				ON				ce.ContentID				= cp.Value
				LEFT JOIN		@ContentTypeID ct
				ON				ce.ContentTypeID			= ct.Value
				WHERE			( cp.ID IS NOT NULL OR @LastContentID IS NULL )
				AND				( ct.ID IS NOT NULL OR @LastContentTypeID IS NULL )
				ORDER BY		CASE WHEN @SortOrder = 1 THEN ce.ContentEventID WHEN  @SortOrder = 2 THEN c.ContentIdentifier END,
								CASE WHEN @SortOrder = 2 THEN ce.ContentEventID WHEN  @SortOrder = 1 THEN c.ContentIdentifier END



END

GO
/****** Object:  StoredProcedure [dbo].[SaveCSPLog]    Script Date: 5/27/2014 12:24:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveCSPLog]
		@ErrorID			INT = 0 OUTPUT
AS
-- =============================================
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
// Module:  dbo.SaveCSPLog
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Initial DINGOCT transform step of CSP Log.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOCT.dbo.SaveCSPLog.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum					INT
//				EXEC		dbo.SaveCSPLog 
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


				SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET			NOCOUNT ON;

				DECLARE		@MaxRows															INT = 5000
				DECLARE		@TOPNCSPLogStagingID												UDT_Int
				DECLARE		@TOPNCSPLogID														UDT_Int
				DECLARE		@ContentTypeToken													CHAR(1) = '.'
				DECLARE		@FirstCSPLogStagingID												INT
				DECLARE		@CurrentYear														INT = DATEPART(YEAR,GETUTCDATE())


				IF			ISNULL(OBJECT_ID('tempdb..#CSPLogStagingInserted'), 0) > 0 
							DROP TABLE		#CSPLogStagingInserted
				CREATE TABLE	#CSPLogStagingInserted 
								(
									ID INT Identity(1,1),
									CSPLogStagingID INT,
									TokenID UNIQUEIDENTIFIER
								)


				IF			ISNULL(OBJECT_ID('tempdb..#ContentDefinitions'), 0) > 0 
							DROP TABLE		#ContentDefinitions
				CREATE TABLE	#ContentDefinitions 
								(
									ID INT Identity(1,1),
									CSPLogStagingID INT,
									ContentType VARCHAR(50),
									ContentIdentifier VARCHAR(50),
									TokenID UNIQUEIDENTIFIER
								)


				IF			ISNULL(OBJECT_ID('tempdb..#CSPLogInserted'), 0) > 0 
							DROP TABLE		#CSPLogInserted
				CREATE TABLE	#CSPLogInserted 
								(
									ID INT Identity(1,1),
									CSPLogID INT,
									TokenID UNIQUEIDENTIFIER
								)


				INSERT		@TOPNCSPLogStagingID ( Value )
				SELECT		TOP (@MaxRows) a.CSPLogStagingID			
				FROM		dbo.CSPLogStaging a (NOLOCK)
				WHERE		a.Status															IS NULL
				ORDER BY	a.CSPLogStagingID

				SELECT		TOP 1 @FirstCSPLogStagingID											= a.Value
				FROM		@TOPNCSPLogStagingID a 
				ORDER BY	a.ID 


				IF			( @FirstCSPLogStagingID IS NOT NULL )
				BEGIN

							UPDATE		TOP (@MaxRows) dbo.CSPLogStaging 
							SET			Status													=	CASE	
																											WHEN ISDATE(CAST(@CurrentYear AS CHAR(4)) + ' ' + LTRIM(RTRIM(OccuranceDateStamp)) + ' ' + OccuranceTimeStamp) = 1 
																											AND CHARINDEX( @ContentTypeToken , FileName , 1 ) > 0 THEN 1 
																											ELSE 10 
																									END
							OUTPUT		inserted.CSPLogStagingID,
										inserted.TokenID
										--deleted.Validity,	--Value before update
										--inserted.Validity,	--Value after update
							INTO		#CSPLogStagingInserted
							FROM		@TOPNCSPLogStagingID a
							WHERE		CSPLogStagingID											= a.Value
							AND			Status													IS NULL


							SELECT		TOP 1 @FirstCSPLogStagingID								= a.ID			
							FROM		#CSPLogStagingInserted a 
							ORDER BY	a.ID DESC


							--			Extract the ContentType and the ContentIdentifier from the raw log file table.
							INSERT		#ContentDefinitions ( CSPLogStagingID, ContentType, ContentIdentifier, TokenID )
							SELECT		CSPLogStagingID											= x.CSPLogStagingID,
										ContentType												= REVERSE ( SUBSTRING( REVERSE ( x.FileName ) , 1 , CHARINDEX( @ContentTypeToken ,REVERSE ( x.FileName ) , 1) - 1 ) ),
										ContentIdentifier										= SUBSTRING( x.FileName, 2, LEN(x.FileName) - CHARINDEX( @ContentTypeToken ,REVERSE ( x.FileName ) , 1) - 1 ),
										TokenID													= y.TokenID
							FROM		dbo.CSPLogStaging x (NOLOCK)
							JOIN		#CSPLogStagingInserted y
							ON			x.CSPLogStagingID										= y.CSPLogStagingID
							WHERE		x.Status												= 1

							
							--			Populate the ContentType definitions if any
							INSERT		dbo.ContentType ( Name )
							SELECT		Name													= cd.ContentType
							FROM		(
											SELECT		DISTINCT ContentType
											FROM		#ContentDefinitions cd
										) cd
							LEFT JOIN	dbo.ContentType a (NOLOCK)
							ON			cd.ContentType											= a.Name
							WHERE		a.ContentTypeID											IS NULL
							

							--			Populate the Content definitions if any
							INSERT		dbo.Content
									(
										ContentIdentifier
									)
							SELECT		ContentIdentifier										= cd.ContentIdentifier
							FROM		(
											SELECT		DISTINCT ContentIdentifier
											FROM		#ContentDefinitions cd
										) cd
							LEFT JOIN	dbo.Content a (NOLOCK)
							ON			cd.ContentIdentifier									= a.ContentIdentifier
							WHERE		a.ContentID												IS NULL
							

							IF			( @FirstCSPLogStagingID > 0 )
							BEGIN

										SET			@ErrorID									=	1		--FAIL

										BEGIN TRAN


										--			Populate the History table
										INSERT		dbo.CSPLog 
												(
													UTCDayOfYearPartitionKey,
													OccuranceDateStamp,
													OccuranceTimeStamp,
													Severity,
													HostName,
													Tag,
													FileName,
													FilePath,
													Message,
													ContentID,
													ContentTypeID,
													TokenID
												)
										OUTPUT		inserted.CSPLogID,
													inserted.TokenID
										INTO		#CSPLogInserted
										SELECT		UTCDayOfYearPartitionKey					=	CASE	
																											--if the date of occurance is Jan BUT the date of insertion is december, then advance the Year 
																											WHEN ( CHARINDEX('Jan', ls.OccuranceDateStamp, 1) > 0 ) AND ( DATEPART(MONTH, ls.CreateDate) = 12 ) 
																											THEN DATEPART( DY, CONVERT(DATE, CAST(@CurrentYear + 1 AS CHAR(4)) + ' ' + ls.OccuranceDateStamp ) )
																											ELSE ls.UTCDayOfYearPartitionKey
																									END,
													OccuranceDateStamp							=	CASE	
																											WHEN ( CHARINDEX('Jan', ls.OccuranceDateStamp, 1) > 0 ) AND ( DATEPART(MONTH, ls.CreateDate) = 12 ) 
																											THEN CONVERT(DATE, CAST(@CurrentYear + 1 AS CHAR(4)) + ' ' + ls.OccuranceDateStamp )
																											ELSE CONVERT(DATE, CAST(@CurrentYear AS CHAR(4)) + ' ' + ls.OccuranceDateStamp )
																									END,
													OccuranceTimeStamp							=	CONVERT(TIME, ls.OccuranceTimeStamp, 100),	--Convert to Military time
													Severity									=	ls.Severity,
													HostName									=	ls.HostName,
													Tag											=	ls.Tag,
													FileName									=	ls.FileName,
													FilePath									=	ls.FilePath,
													Message										=	ls.Message,
													ContentID									=	c.ContentID,
													ContentTypeID								=	ct.ContentTypeID,
													TokenID										=	cd.TokenID
										FROM		#ContentDefinitions cd
										JOIN		dbo.CSPLogStaging ls (NOLOCK)
										ON			cd.CSPLogStagingID							=	ls.CSPLogStagingID
										JOIN		dbo.ContentType ct (NOLOCK)
										ON			cd.ContentType								=	ct.Name
										JOIN		dbo.Content c (NOLOCK)
										ON			cd.ContentIdentifier						=	c.ContentIdentifier
										WHERE		ls.Status									=	1
										AND			ct.Valid									=	1
										ORDER BY	ls.CSPLogStagingID


										--			Populate the Mapping table
										INSERT		dbo.ContentEvent
												(
													UTCDayOfYearPartitionKey,
													CSPLogID,
													ContentTypeID,
													ContentID
												)
										SELECT		UTCDayOfYearPartitionKey					=	b.UTCDayOfYearPartitionKey,
													CSPLogID									=	b.CSPLogID,
													ContentTypeID								=	b.ContentTypeID,
													ContentID									=	b.ContentID
										FROM		#CSPLogInserted a
										JOIN		dbo.CSPLog b (NOLOCK)
										ON			a.CSPLogID									=	b.CSPLogID
										

										--			This last step would denote that the transaction was successful by setting status to 0
										UPDATE		dbo.CSPLogStaging 
										SET			Status										=	0
										--OUTPUT		inserted.CSPLogStagingID
													--deleted.Validity,	--Value before update
													--inserted.Validity,	--Value after update
										FROM		#ContentDefinitions a
										JOIN		#CSPLogInserted c 
										ON			a.TokenID									=	c.TokenID
										WHERE		CSPLogStaging.CSPLogStagingID				=	a.CSPLogStagingID
										AND			Status										=	1

										SET			@ErrorID									=	0		--SUCCESS


										COMMIT

							END

				END

				DROP TABLE	#CSPLogStagingInserted
				DROP TABLE	#ContentDefinitions
				DROP TABLE	#CSPLogInserted

END



GO








/****** Object:  Table [dbo].[Content]    Script Date: 5/27/2014 12:24:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Content](
	[ContentID] [int] IDENTITY(1,1) NOT NULL,
	[ContentIdentifier] [varchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContentEvent]    Script Date: 5/27/2014 12:24:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentEvent](
	[ContentEventID] [int] IDENTITY(1,1) NOT NULL,
	[UTCDayOfYearPartitionKey] [int] NOT NULL,
	[ContentTypeID] [int] NOT NULL,
	[ContentID] [int] NOT NULL,
	[CSPLogID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ContentEvent] PRIMARY KEY CLUSTERED 
(
	[ContentEventID] ASC,
	[UTCDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCDayOfYearPartitionKey])

GO
/****** Object:  Table [dbo].[ContentType]    Script Date: 5/27/2014 12:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContentType](
	[ContentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](200) NULL,
	[Valid] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ContentType] PRIMARY KEY CLUSTERED 
(
	[ContentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CSPLog]    Script Date: 5/27/2014 12:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CSPLog](
	[CSPLogID] [int] IDENTITY(1,1) NOT NULL,
	[UTCDayOfYearPartitionKey] [int] NOT NULL,
	[OccuranceDateStamp] [date] NOT NULL,
	[OccuranceTimeStamp] [time](7) NOT NULL,
	[Severity] [varchar](200) NULL,
	[HostName] [varchar](200) NULL,
	[Tag] [varchar](200) NULL,
	[FileName] [varchar](200) NULL,
	[FilePath] [varchar](200) NULL,
	[Message] [varchar](500) NULL,
	[ContentID] [int] NOT NULL,
	[ContentTypeID] [int] NOT NULL,
	[TokenID] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CSPLog] PRIMARY KEY CLUSTERED 
(
	[CSPLogID] ASC,
	[UTCDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCDayOfYearPartitionKey])

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CSPLogStaging]    Script Date: 5/27/2014 12:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CSPLogStaging](
	[CSPLogStagingID] [int] IDENTITY(1,1) NOT NULL,
	[UTCDayOfYearPartitionKey] [int] NOT NULL,
	[OccuranceDateStamp] [varchar](25) NOT NULL,
	[OccuranceTimeStamp] [varchar](50) NOT NULL,
	[Severity] [varchar](200) NULL,
	[HostName] [varchar](200) NULL,
	[Tag] [varchar](200) NULL,
	[FileName] [varchar](200) NULL,
	[FilePath] [varchar](200) NULL,
	[Message] [varchar](500) NULL,
	[Status] [int] NULL,
	[TokenID] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CSPLogStaging] PRIMARY KEY CLUSTERED 
(
	[CSPLogStagingID] ASC,
	[UTCDayOfYearPartitionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCDayOfYearPartitionKey])
) ON [DayOfYearPartitionScheme]([UTCDayOfYearPartitionKey])

GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[CSPLogImport]    Script Date: 5/27/2014 12:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CSPLogImport](
	[CSPLogImportID] [int] IDENTITY(1,1) NOT NULL,
	[RowText] [varchar](2000) NULL,
	[Mark1] INT, 
	[Mark2] INT, 
	[Mark3] INT, 
	[Mark4] INT, 
	[Mark5] INT, 
	[Mark6] INT, 
	[Mark7] INT,
	[Mark8] INT,
	[Status] [int] NULL
 CONSTRAINT [PK_CSPLogImport] PRIMARY KEY CLUSTERED 
(
	[CSPLogImportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [Primary]
) ON [Primary]
GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogImport', @level2type=N'COLUMN',@level2name=N'CSPLogImportID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The row text.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogImport', @level2type=N'COLUMN',@level2name=N'RowText'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The row status.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogImport', @level2type=N'COLUMN',@level2name=N'Status'
GO


--DROP INDEX dbo.CSPLogImport.FNC_CSPLogImport_Status 
CREATE NONCLUSTERED INDEX FNC_CSPLogImport_Status ON dbo.CSPLogImport ( Status ) WHERE Status IS NULL 
GO


/****** Object:  Index [UNC_Content_Name]    Script Date: 5/27/2014 12:24:13 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_Content_Name] ON [dbo].[Content]
(
	[ContentIdentifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_ContentType_Name]    Script Date: 5/27/2014 12:24:13 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ContentType_Name] ON [dbo].[ContentType]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [FNC_CSPLogStaging_Status]    Script Date: 5/27/2014 12:24:13 PM ******/
CREATE NONCLUSTERED INDEX [FNC_CSPLogStaging_Status] ON [dbo].[CSPLogStaging]
(
	[Status] ASC
)
WHERE ([Status] IS NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DayOfYearPartitionScheme]([UTCDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ContentEvent] ADD  CONSTRAINT [DF_ContentEvent_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ContentEvent] ADD  CONSTRAINT [DF_ContentEvent_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ContentType] ADD  CONSTRAINT [DF_ContentType_Valid]  DEFAULT ((1)) FOR [Valid]
GO
ALTER TABLE [dbo].[ContentType] ADD  CONSTRAINT [DF_ContentType_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ContentType] ADD  CONSTRAINT [DF_ContentType_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[CSPLog] ADD  CONSTRAINT [DF_CSPLog_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CSPLog] ADD  CONSTRAINT [DF_CSPLog_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[CSPLogStaging] ADD  CONSTRAINT [DF_CSPLogStaging_UTCDayOfYearPartitionKey]  DEFAULT (datepart(dayofyear,getutcdate())) FOR [UTCDayOfYearPartitionKey]
GO
ALTER TABLE [dbo].[CSPLogStaging] ADD  CONSTRAINT [DF_CSPLogStaging_TokenID]  DEFAULT (newid()) FOR [TokenID]
GO
ALTER TABLE [dbo].[CSPLogStaging] ADD  CONSTRAINT [DF_CSPLogStaging_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CSPLogStaging] ADD  CONSTRAINT [DF_CSPLogStaging_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ContentEvent]  WITH CHECK ADD  CONSTRAINT [FK_ContentEvent_ContentID_-->_Content_ContentID] FOREIGN KEY([ContentID])
REFERENCES [dbo].[Content] ([ContentID])
GO
ALTER TABLE [dbo].[ContentEvent] CHECK CONSTRAINT [FK_ContentEvent_ContentID_-->_Content_ContentID]
GO
ALTER TABLE [dbo].[ContentEvent]  WITH CHECK ADD  CONSTRAINT [FK_ContentEvent_ContentTypeID_-->_ContentType_ContentTypeID] FOREIGN KEY([ContentTypeID])
REFERENCES [dbo].[ContentType] ([ContentTypeID])
GO
ALTER TABLE [dbo].[ContentEvent] CHECK CONSTRAINT [FK_ContentEvent_ContentTypeID_-->_ContentType_ContentTypeID]
GO
ALTER TABLE [dbo].[ContentEvent]  WITH CHECK ADD  CONSTRAINT [FK_ContentEvent_CSPLogID_UTCDayOfYearPartitionKey_-->_CSPLog_CSPLogID_UTCDayOfYearPartitionKey] FOREIGN KEY([CSPLogID], [UTCDayOfYearPartitionKey])
REFERENCES [dbo].[CSPLog] ([CSPLogID], [UTCDayOfYearPartitionKey])
GO
ALTER TABLE [dbo].[ContentEvent] CHECK CONSTRAINT [FK_ContentEvent_CSPLogID_UTCDayOfYearPartitionKey_-->_CSPLog_CSPLogID_UTCDayOfYearPartitionKey]
GO
ALTER TABLE [dbo].[CSPLog]  WITH CHECK ADD  CONSTRAINT [FK_CSPLog_ContentID_-->_Content_ContentID] FOREIGN KEY([ContentID])
REFERENCES [dbo].[Content] ([ContentID])
GO
ALTER TABLE [dbo].[CSPLog] CHECK CONSTRAINT [FK_CSPLog_ContentID_-->_Content_ContentID]
GO
ALTER TABLE [dbo].[CSPLog]  WITH CHECK ADD  CONSTRAINT [FK_CSPLog_ContentTypeID_-->_ContentType_ContentTypeID] FOREIGN KEY([ContentTypeID])
REFERENCES [dbo].[ContentType] ([ContentTypeID])
GO
ALTER TABLE [dbo].[CSPLog] CHECK CONSTRAINT [FK_CSPLog_ContentTypeID_-->_ContentType_ContentTypeID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Content', @level2type=N'COLUMN',@level2name=N'ContentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to the associated content type.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Content', @level2type=N'COLUMN',@level2name=N'ContentIdentifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Content', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Content', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentEvent', @level2type=N'COLUMN',@level2name=N'ContentEventID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The corresponding UTC day of year of the OccuranceTimeStamp column value.  This is the designated DINGOCT partition key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentEvent', @level2type=N'COLUMN',@level2name=N'UTCDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to the associated Content Type.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentEvent', @level2type=N'COLUMN',@level2name=N'ContentTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to the associated Content.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentEvent', @level2type=N'COLUMN',@level2name=N'ContentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to the associated CSPLog event.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentEvent', @level2type=N'COLUMN',@level2name=N'CSPLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentEvent', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentEvent', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentType', @level2type=N'COLUMN',@level2name=N'ContentTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of content type.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentType', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of content type.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentType', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Validity of content type.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentType', @level2type=N'COLUMN',@level2name=N'Valid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentType', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ContentType', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'CSPLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The corresponding UTC day of year of the OccuranceTimeStamp column value.  This is the designated DINGOCT partition key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'UTCDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The corresponding UTC date and time of the OccuranceTimeStamp column value.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'OccuranceDateStamp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The date and time given by syslog.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'OccuranceTimeStamp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'Severity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'HostName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'Tag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'FilePath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'Message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'ContentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'ContentTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'TokenID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLog', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'CSPLogStagingID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The corresponding UTC day of year of the OccuranceTimeStamp column value.  This is the designated DINGOCT partition key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'UTCDayOfYearPartitionKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The UTC date given by syslog.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'OccuranceDateStamp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The UTC time given by syslog.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'OccuranceTimeStamp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Severity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'HostName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Tag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'FilePath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Status value indicating ETL progress of the row.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'TokenID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSPLogStaging', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


/****** Object:  Job [CT ETL]    Script Date: 5/28/2014 2:49:33 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [ETL]    Script Date: 5/28/2014 2:49:33 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'CT' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'CT'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CT ETL', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'CT', 
		--@owner_login_name=N'domain\username', @job_id = @jobId OUTPUT
		--@owner_login_name=N'MCC2-LAILAB\_AIMONSQLDINGO', 
		@job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Execute ETL SP]    Script Date: 5/28/2014 2:49:33 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Execute ETL SP', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC	DINGOCT.dbo.SaveCSPLog', 
		@database_name=N'DINGOCT', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 30 seconds', 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=2, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140528, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'f9aba853-454a-4756-9fe7-4b2102357771'
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
ALTER DATABASE [DINGOCT] SET  READ_WRITE 
GO
