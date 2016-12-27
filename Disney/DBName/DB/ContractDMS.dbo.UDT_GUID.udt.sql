
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.types WHERE Name = 'UDT_GUID') 
--		drop type UDT_GUID
		CREATE TYPE UDT_GUID AS TABLE 
		(
			Id		INT IDENTITY(1,1),
			Gid		UNIQUEIDENTIFIER
		)
GO
