



/*

Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED

customerid	TransactionDate	creditcardtype	Amount
4266961000066405	1/28/2016	MASTERCARD	97.56


*/

IF (OBJECT_ID('dbo.StgTransaction','u') IS NOT NULL) 
	DROP TABLE dbo.StgTransaction
GO

IF (OBJECT_ID('dbo.StgTransaction','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[StgTransaction]
		(
			[StgTransactionId]			[bigint] IDENTITY(1,1) NOT NULL CONSTRAINT PK_StgTransaction PRIMARY KEY NONCLUSTERED,
			[TransactionDate]			[date] NOT NULL,
			[CustomerId]				[nvarchar](255) NOT NULL,
			[CreditCardType]			[nvarchar](255) NOT NULL,
			[Amount]					[money] NOT NULL
		) ON [Primary]


END
GO


