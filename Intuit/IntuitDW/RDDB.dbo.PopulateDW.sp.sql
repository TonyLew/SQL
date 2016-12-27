

IF ISNULL(OBJECT_ID('dbo.PopulateDW'), 0) > 0 
	DROP PROCEDURE dbo.PopulateDW
GO


CREATE PROCEDURE [dbo].[PopulateDW]
AS
-- =============================================
/*
//
//
// Project: Intuit
// Module:  dbo.PopulateDW
// Created: 2016-Dec-05
// Author:  Tony Lew
// 
// Purpose: 
//    
//
//   Current revision:
//     Release:   1.0
//     Revision:  $Id: RDDB.dbo.PopulateDW.proc.sql 3246 2016-Dec-05 tlew $
//    
//	 Usage:
//
//				EXEC	RDDB.dbo.PopulateDW	
//
//
*/ 
-- =============================================
BEGIN


				--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE			@MaxStgTransactionDate DATE


				INSERT			dbo.DimCustomer
							(
								CustomerId,
								Product,
								Channel,
								AccountOpenDate,
								AccountStatus
							)
				SELECT			x.CustomerId,
								x.Product,
								x.Channel,
								x.AccountOpenDate,
								x.AccountStatus
				FROM		(
								SELECT		CustomerId,
											MAX(Product) AS Product,
											MAX(Channel) AS Channel,
											MAX(AccountOpenDate) AS AccountOpenDate,
											MAX(AccountStatus) AS AccountStatus
								FROM		dbo.StgCustomer
								GROUP BY	CustomerId
							) x
				LEFT JOIN		dbo.DimCustomer y						ON x.CustomerId = y.CustomerId
				WHERE			y.DimCustomerId							IS NULL




				INSERT			dbo.DimCreditCardType
							(
								CreditCardType
							)
				SELECT			x.CreditCardType
				FROM		(
								SELECT		CreditCardType
								FROM		dbo.StgTransaction t
								GROUP BY	CreditCardType

							) x
				LEFT JOIN		dbo.DimCreditCardType y					ON x.CreditCardType = y.CreditCardType
				WHERE			y.DimCreditCardTypeId					IS NULL


				SELECT			TOP 1 @MaxStgTransactionDate = Max(TransactionDate) FROM dbo.StgTransaction 
				

				--				If we have not already loaded the data from previous job, then load the fact table
				IF	NOT EXISTS	( SELECT TOP 1 1 FROM dbo.FactTransaction  WHERE TransactionDate >= @MaxStgTransactionDate  )
				BEGIN

								INSERT			dbo.FactTransaction
											(
												TransactionDate,
												DimCustomerId,
												DimCreditCardTypeId,
												Amount
											)
								SELECT			t.TransactionDate,
												dc.DimCustomerId,
												dcc.DimCreditCardTypeId,
												t.Amount
								FROM			dbo.StgTransaction t
								JOIN			dbo.DimCustomer dc						ON t.CustomerId = dc.CustomerId
								JOIN			dbo.DimCreditCardType dcc				ON t.CreditCardType = dcc.CreditCardType

				END




END

GO

