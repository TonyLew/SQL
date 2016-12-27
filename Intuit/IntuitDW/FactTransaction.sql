



/*

Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED

customerid	TransactionDate	creditcardtype	Amount
4266961000066405	1/28/2016	MASTERCARD	97.56


-- Creates a partitioned table called PartitionTable that uses myRangePS1 to partition col1  
CREATE TABLE PartitionTable (col1 int PRIMARY KEY, col2 char(10))  
    ON myRangePS1 (col1) ;  
GO  

CREATE CLUSTERED INDEX IX_TABLE1_partitioncol ON dbo.TABLE1 (partitioncol)
  WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
        ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
  ON myPartitionScheme(partitioncol)
GO


*/

IF (OBJECT_ID('dbo.FactTransaction','u') IS NOT NULL) 
	DROP TABLE dbo.FactTransaction
GO

IF (OBJECT_ID('dbo.FactTransaction','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[FactTransaction]
		(
			[FactTransactionId]			[bigint] IDENTITY(1,1) NOT NULL CONSTRAINT PK_FactTransaction PRIMARY KEY NONCLUSTERED,
			[TransactionDate]			[date] NOT NULL,
			[DimCustomerId]				[int] NOT NULL CONSTRAINT [FK_FactTransaction_DimCustomerId-->DimCustomer_DimCustomerId] FOREIGN KEY ( DimCustomerId ) REFERENCES dbo.DimCustomer ( DimCustomerId ),
			--[DimProductId]				[int] NOT NULL CONSTRAINT [FK_FactTransaction_DimProductId-->DimProduct_DimProductId] FOREIGN KEY ( DimProductId ) REFERENCES dbo.DimProduct ( DimProductId ),
			--[DimChannelId]				[int] NOT NULL CONSTRAINT [FK_FactTransaction_DimChannelId-->DimChannel_DimChannelId] FOREIGN KEY ( DimChannelId ) REFERENCES dbo.DimChannel ( DimChannelId ),
			[DimCreditCardTypeId]		[int] NOT NULL CONSTRAINT [FK_FactTransaction_DimCreditCardTypeId-->DimCreditCardType_DimCreditCardTypeId] FOREIGN KEY ( DimCreditCardTypeId ) REFERENCES dbo.DimCreditCardType ( DimCreditCardTypeId ),
			[Amount]					[money] NOT NULL
		) ON [Primary]

		CREATE CLUSTERED INDEX IX_FactTransaction_TransactionDate ON dbo.FactTransaction ( TransactionDate ) ON DateRangePS ( TransactionDate )

		CREATE INDEX IX_FactTransaction_DimCustomerId_iAmount ON dbo.FactTransaction ( DimCustomerId ) INCLUDE ( Amount )

		--CREATE INDEX IX_FactTransaction_DimProductId_iAmount ON dbo.FactTransaction ( DimProductId ) INCLUDE ( Amount )

		--CREATE INDEX IX_FactTransaction_DimChannelId_iAmount ON dbo.FactTransaction ( DimChannelId ) INCLUDE ( Amount )

		CREATE INDEX IX_FactTransaction_DimCreditCardTypeId__iAmount ON dbo.FactTransaction ( DimCreditCardTypeId ) INCLUDE ( Amount )


END
GO


