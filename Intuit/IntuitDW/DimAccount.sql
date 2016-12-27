
/*



Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


Customerid	AccountOpenDate	product	Channel	accountstatus
4266961000065936	1/24/2003	Non-Quickbooks	IMS	CANCELLED


*/


IF (OBJECT_ID('dbo.DimAccount','u') IS NOT NULL) 
BEGIN


		CREATE TABLE [dbo].[DimAccount]
		(
			[DimAccountId]				[int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimAccount PRIMARY KEY CLUSTERED,
			[CreateDate]				[datetime] NOT NULL CONSTRAINT DF_DimAccount_CreateDate DEFAULT (GETUTCDATE()),
			[UpdateDate]				[datetime] NULL,
			[AccountOpenDate]			[date] NULL,
			[ProductChannel]			[varchar](100) NULL,
			[AccountStatus]				[varchar](100) NULL
		) ON [PRIMARY]


END
GO




