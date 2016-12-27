
/*



Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED

customerid	TransactionDate	creditcardtype	Amount
4266961000066405	1/28/2016	MASTERCARD	97.56


*/


IF (OBJECT_ID('dbo.DimTransactionDate','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[DimTransactionDate]
		(
			[DimTransactionDateId]		[int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimTransactionDate PRIMARY KEY CLUSTERED,
			[CreateDate]				[datetime] NOT NULL CONSTRAINT DF_DimTransactionDate_CreateDate DEFAULT (GETUTCDATE()),
			[UpdateDate]				[datetime] NULL,
			[TransactionDate]			[date] NULL,
		) ON [PRIMARY]


END
GO




