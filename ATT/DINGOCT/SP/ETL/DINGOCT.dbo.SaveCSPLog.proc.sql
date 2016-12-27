
Use DINGOCT
GO

IF ISNULL(OBJECT_ID('dbo.SaveCSPLog'), 0) > 0 
	DROP PROCEDURE dbo.SaveCSPLog
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
// Purpose: 		Second DINGOCT transform step of CSP Log.
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

