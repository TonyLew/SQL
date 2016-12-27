



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

IF (OBJECT_ID('dbo.FactTransactionMonthly','u') IS NOT NULL) 
	DROP TABLE dbo.FactTransactionMonthly
GO

IF (OBJECT_ID('dbo.FactTransactionMonthly','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[FactTransactionMonthly]
		(
			[FactTransactionMonthlyId]	[bigint] IDENTITY(1,1) NOT NULL CONSTRAINT PK_FactTransactionMonthly PRIMARY KEY NONCLUSTERED,
			[TransactionDate]			[date] NOT NULL,
			[Amount]					[money] NOT NULL
		) ON [Primary]

		CREATE UNIQUE CLUSTERED INDEX UX_FactTransactionMonthly_TransactionDate ON dbo.FactTransactionMonthly ( TransactionDate ) ON DateRangePS ( TransactionDate )



END
GO


