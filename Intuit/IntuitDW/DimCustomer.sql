
/*



Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


*/

IF (OBJECT_ID('dbo.DimCustomer','u') IS NOT NULL) 
	DROP TABLE dbo.DimCustomer
GO

IF (OBJECT_ID('dbo.DimCustomer','u') IS NULL) 
BEGIN


		CREATE TABLE [dbo].[DimCustomer]
		(
			[DimCustomerId]				[int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimCustomer PRIMARY KEY CLUSTERED,
			[CreateDate]				[datetime] NOT NULL CONSTRAINT DF_DimCustomer_CreateDate DEFAULT (GETUTCDATE()),
			[UpdateDate]				[datetime] NULL,
			[CustomerId]				[nvarchar](255) NOT NULL,
			[Product]					[nvarchar](255) NOT NULL,
			[Channel]					[nvarchar](255) NOT NULL,
			[AccountOpenDate]			[date] NULL,
			[AccountStatus]				[nvarchar](255) NULL
		) ON [PRIMARY]

		CREATE UNIQUE INDEX UX_DimCustomer_CustomerId ON dbo.DimCustomer ( CustomerId )


END
GO



