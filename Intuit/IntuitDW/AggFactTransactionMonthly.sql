

IF ISNULL(OBJECT_ID('dbo.AggFactTransactionMonthly'), 0) > 0 
	DROP PROCEDURE dbo.AggFactTransactionMonthly
GO


CREATE PROCEDURE [dbo].[AggFactTransactionMonthly]
AS
-- =============================================
/*
//
//
// Project: Intuit
// Module:  dbo.AggFactTransactionMonthly
// Created: 2016-Dec-05
// Author:  Tony Lew
// 
// Purpose: 
//    
//
//   Current revision:
//     Release:   1.0
//     Revision:  $Id: RDDB.dbo.AggFactTransactionMonthly.proc.sql 3246 2016-Dec-05 tlew $
//    
//	 Usage:
//
//				EXEC	RDDB.dbo.AggFactTransactionMonthly	
//
//
*/ 
-- =============================================
BEGIN


				--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;


				INSERT			dbo.FactTransactionMonthly
							(
								TransactionDate,
								Amount
							)
				SELECT			x.TransactionDate,
								x.Amount
				FROM
							(
								SELECT			CAST( CAST(DatePart(YEAR, TransactionDate) AS VARCHAR(50)) + '-' + CAST(DatePart(MONTH, TransactionDate) AS VARCHAR(50)) + '-01' AS DATE ) AS TransactionDate,
												SUM(Amount) AS Amount
								FROM			dbo.FactTransaction 
								GROUP BY		CAST(DatePart(YEAR, TransactionDate) AS VARCHAR(50)) + '-' + CAST(DatePart(MONTH, TransactionDate) AS VARCHAR(50))
							) x
				LEFT JOIN		dbo.FactTransactionMonthly y		ON x.TransactionDate = y.TransactionDate
				WHERE			y.TransactionDate					IS NULL


END

GO

