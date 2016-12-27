
Use DINGOCT
GO

IF ISNULL(OBJECT_ID('dbo.SaveCSPLogStaging'), 0) > 0 
	DROP PROCEDURE dbo.SaveCSPLogStaging
GO

CREATE PROCEDURE [dbo].[SaveCSPLogStaging]
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
// Module:  dbo.SaveCSPLogStaging
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Initial DINGOCT transform step of CSP Log.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGOCT.dbo.SaveCSPLogStaging.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum					INT
//				EXEC		dbo.SaveCSPLogStaging 
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


				SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET			NOCOUNT ON;






DECLARE		@Mark1 INT
DECLARE		@Mark2 INT
DECLARE		@Mark3 INT
DECLARE		@Mark4 INT
DECLARE		@Mark5 INT
DECLARE		@Mark6 INT
DECLARE		@Mark7 INT
DECLARE		@Mark8 INT
DECLARE		@FieldSeparator CHAR(1) = ' '

Update dbo.CSPLogImport
Set
@Mark1		= CHARINDEX ( @FieldSeparator, RowText, 1), 
@Mark2		= CHARINDEX ( @FieldSeparator, RowText, @Mark1+1), 
@Mark3		= CHARINDEX ( @FieldSeparator, RowText, @Mark2+1), 
@Mark4		= CHARINDEX ( @FieldSeparator, RowText, @Mark3+1), 
@Mark5		= CHARINDEX ( @FieldSeparator, RowText, @Mark4+1), 
@Mark6		= CHARINDEX ( @FieldSeparator, RowText, @Mark5+1), 
@Mark7		= CHARINDEX ( @FieldSeparator, RowText, @Mark6+1),
@Mark8		= CHARINDEX ( @FieldSeparator, RowText, @Mark7+1),
Mark1		= @Mark1, 
Mark2		= @Mark2, 
Mark3		= @Mark3, 
Mark4		= @Mark4, 
Mark5		= @Mark5, 
Mark6		= @Mark6, 
Mark7		= @Mark7,
Mark8		= @Mark8



--Jul 8 19:54:46 <1.5> MSSNKNDMZNAS-3(id3) VIRUS_SCAN: /ifs/SHO/DMZ/Arrivals/AUS2TX/SCH/T929-1317323395-TUN-BD4.sch Clean file copied to /ifs/SHO/DMZ/Scan/AUS2TX/SCH/T929-1317323395-TUN-BD4.sch


INSERT INTO dbo.CSPLogStaging
        ( UTCDayOfYearPartitionKey ,
          OccuranceDateStamp ,
          OccuranceTimeStamp ,
          Severity ,
          HostName ,
          Tag ,
          FileName ,
          FilePath ,
          Message ,
          Status ,
          TokenID ,
          CreateDate ,
          UpdateDate
        )
      
select 
	UTCDayOfYearPartitionKey = 200,
	DateStamp		= LTRIM(RTRIM(SUBSTRING(i.RowText, 1,  i.Mark1))) + ' ' + LTRIM(RTRIM(SUBSTRING(i.RowText, i.Mark1, i.Mark2-i.Mark1))),
	TimeStamp		= LTRIM(RTRIM(SUBSTRING(i.RowText, i.Mark2, i.Mark3-i.Mark2))),
	Severity		= CASE WHEN (CHARINDEX('6',SUBSTRING(i.RowText, i.Mark3, i.Mark4-i.Mark3)) != 0)
						THEN ('Information')
						ELSE ('Error')
						END,
	HostName		= LTRIM(RTRIM(SUBSTRING(i.RowText, i.Mark4, i.Mark5-i.Mark4))),
	Tag				= LTRIM(RTRIM(SUBSTRING(i.RowText, i.Mark5, i.Mark6-i.Mark5))),
	FileName		= LTRIM(RTRIM(SUBSTRING(i.RowText, i.Mark6, i.Mark7-i.Mark6))),
	Filepath		= LTRIM(RTRIM(SUBSTRING(i.RowText, i.Mark7, i.Mark8-i.Mark7))),
	Message			= LTRIM(RTRIM(SUBSTRING(i.RowText, i.Mark8, LEN(i.RowText)-i.Mark8+1))),
	0,
	NEWID(),
	'2014-07-21',
	'2014-07-21'
from dbo.CSPLogImport i

END
GO
