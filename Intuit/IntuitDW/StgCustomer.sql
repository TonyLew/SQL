
/*



Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


*/

IF (OBJECT_ID('dbo.StgCustomer','u') IS NOT NULL) 
	DROP TABLE dbo.StgCustomer
GO

IF (OBJECT_ID('dbo.StgCustomer','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[StgCustomer]
		(
			[StgCustomerId]				[int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_StgCustomer PRIMARY KEY CLUSTERED,
			[CustomerId]				[nvarchar](255) NOT NULL,
			[AccountOpenDate]			[date] NOT NULL,
			[Product]					[nvarchar](255) NOT NULL,
			[Channel]					[nvarchar](255) NOT NULL,
			[AccountStatus]				[nvarchar](255) NOT NULL
		) ON [PRIMARY]

		CREATE UNIQUE INDEX UX_StgCustomer_CustomerId ON dbo.StgCustomer ( CustomerId )


END
GO



