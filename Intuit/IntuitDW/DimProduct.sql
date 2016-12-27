
/*



Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED

customerid	TransactionDate	creditcardtype	Amount
4266961000066405	1/28/2016	MASTERCARD	97.56


*/

IF (OBJECT_ID('dbo.DimProduct','u') IS NOT NULL) 
	DROP TABLE dbo.DimProduct
GO

IF (OBJECT_ID('dbo.DimProduct','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[DimProduct]
		(
			[DimProductId]		[int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimProduct PRIMARY KEY CLUSTERED,
			[CreateDate]		[datetime] NOT NULL CONSTRAINT DF_DimProduct_CreateDate DEFAULT (GETUTCDATE()),
			[UpdateDate]		[datetime] NULL,
			[Product]			[nvarchar](255) NOT NULL,
		) ON [PRIMARY]

		CREATE UNIQUE INDEX UX_DimProduct_Product ON dbo.DimProduct ( Product )


END
GO




