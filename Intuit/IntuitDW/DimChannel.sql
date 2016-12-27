
/*



Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED

customerid	TransactionDate	creditcardtype	Amount
4266961000066405	1/28/2016	MASTERCARD	97.56


*/

IF (OBJECT_ID('dbo.DimChannel','u') IS NOT NULL) 
	DROP TABLE dbo.DimChannel
GO

IF (OBJECT_ID('dbo.DimChannel','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[DimChannel]
		(
			[DimChannelId]		[int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimChannel PRIMARY KEY CLUSTERED,
			[CreateDate]		[datetime] NOT NULL CONSTRAINT DF_DimChannel_CreateDate DEFAULT (GETUTCDATE()),
			[UpdateDate]		[datetime] NULL,
			[Channel]			[nvarchar](255) NOT NULL,
		) ON [PRIMARY]

		CREATE UNIQUE INDEX UX_DimChannel_Channel ON dbo.DimChannel ( Channel )


END
GO




