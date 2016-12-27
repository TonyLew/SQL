
/*



Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED

customerid	TransactionDate	creditcardtype	Amount
4266961000066405	1/28/2016	MASTERCARD	97.56


*/

IF (OBJECT_ID('dbo.DimCreditCardType','u') IS NOT NULL) 
	DROP TABLE dbo.DimCreditCardType
GO

IF (OBJECT_ID('dbo.DimCreditCardType','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[DimCreditCardType]
		(
			[DimCreditCardTypeId]		[int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimCreditCardType PRIMARY KEY CLUSTERED,
			[CreateDate]				[datetime] NOT NULL CONSTRAINT DF_DimCreditCardType_CreateDate DEFAULT (GETUTCDATE()),
			[UpdateDate]				[datetime] NULL,
			[CreditCardType]			[nvarchar](255) NULL,
		) ON [PRIMARY]

		CREATE UNIQUE INDEX UX_DimCreditCardType_CreditCardType ON dbo.DimCreditCardType ( CreditCardType )

END
GO




