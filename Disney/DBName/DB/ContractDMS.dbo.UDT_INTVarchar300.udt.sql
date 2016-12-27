
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.types WHERE name = 'UDT_INTVarchar300') 
--		drop type UDT_INTVarchar300
		create type UDT_INTVarchar300 as table 
		(
			Id							INT IDENTITY(1,1) NOT NULL,
			Name						VARCHAR(300) NOT NULL
		)
GO