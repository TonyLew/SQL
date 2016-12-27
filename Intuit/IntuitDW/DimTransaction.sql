
/*



Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED

customerid	TransactionDate	creditcardtype	Amount
4266961000066405	1/28/2016	MASTERCARD	97.56


*/


IF (OBJECT_ID('dbo.DimTransaction','u') IS NOT NULL) 
BEGIN


		CREATE TABLE [dbo].[DimTransaction]
		(
			[DimTransactionId]			[int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimTransaction PRIMARY KEY CLUSTERED,
			[CreateDate]				[datetime] NOT NULL CONSTRAINT DF_DimTransaction_CreateDate DEFAULT (GETUTCDATE()),
			[UpdateDate]				[datetime] NULL,
			[CustomerId]				[varchar](25) NOT NULL,
			[TransactionDate]			[date] NULL,
			[CreditCardType]			[varchar](100) NULL,
			[ProductChannel]			[varchar](100) NULL,
		) ON [PRIMARY]


END
GO




