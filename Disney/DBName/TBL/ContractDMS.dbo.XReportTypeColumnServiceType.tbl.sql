

-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-Dec-01 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.XReportTypeColumnServiceType
	--   Created:		2015-Dec-01
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--					
	--
	--   Usage:
	--
	--
	--					SELECT		*
	--					FROM		dbo.XReportTypeColumnServiceType WITH (NOLOCK)
	--					ORDER BY	XReportTypeColumnServiceTypeId
	--

*/ 
-- =============================================


--------------------------------------------------------------------------------------------
----CREATION of XReportTypeColumnServiceType TABLE
--------------------------------------------------------------------------------------------


IF ( OBJECT_ID('XReportTypeColumnServiceType', 'u') IS NULL )					
BEGIN

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		--DROP TABLE dbo.XReportTypeColumnServiceType
		CREATE TABLE dbo.XReportTypeColumnServiceType
		(
			[XReportTypeColumnServiceTypeId] [uniqueidentifier] NOT NULL CONSTRAINT PK_XReportTypeColumnServiceType PRIMARY KEY,
			[Created] [DATETIME] NOT NULL CONSTRAINT [DF_XReportTypeColumnServiceType_Created]  DEFAULT (GETDATE()),
			[Updated] [DATETIME] NULL,
			[IsActive] [BIT] NOT NULL CONSTRAINT [DF_XReportTypeColumnServiceType_Enabled]  DEFAULT (1),
			[ReportTypeColumnId] [uniqueidentifier] NOT NULL,
			[ServiceTypeId] [uniqueidentifier] NOT NULL,
			[SortOrder] [int] NOT NULL
		) ON [PRIMARY] 

		SET ANSI_PADDING OFF

		ALTER TABLE  dbo.XReportTypeColumnServiceType ADD CONSTRAINT DF_XReportTypeColumnServiceType_TemplateId  DEFAULT NEWSEQUENTIALID() FOR XReportTypeColumnServiceTypeId

		ALTER TABLE dbo.XReportTypeColumnServiceType  WITH CHECK ADD  CONSTRAINT [FK_XReportTypeColumnServiceType_ReportTypeColumnId-->ReportTypeColumn_ReportTypeColumnId] FOREIGN KEY ( ReportTypeColumnId )
		REFERENCES dbo.ReportTypeColumn ( ReportTypeColumnId )

		ALTER TABLE dbo.XReportTypeColumnServiceType  WITH CHECK ADD  CONSTRAINT [FK_XReportTypeColumnServiceType_ServiceTypeId-->ServiceType_ServiceTypeId] FOREIGN KEY ( ServiceTypeId )
		REFERENCES dbo.ServiceType ( ServiceTypeId )

		CREATE UNIQUE NONCLUSTERED INDEX UX_XReportTypeColumnServiceType_ReportTypeColumnId_ServiceTypeId_iIsActive ON dbo.XReportTypeColumnServiceType ( ReportTypeColumnId, ServiceTypeId ) INCLUDE ( IsActive )

END

GO


------------------------------------------------------------------------------------------
--POPULATION of TABLE
------------------------------------------------------------------------------------------

IF ( OBJECT_ID('XReportTypeColumnServiceType', 'u') IS NOT NULL ) 
BEGIN

		SET				NOCOUNT ON
		Insert			dbo.XReportTypeColumnServiceType ( ReportTypeColumnId, ServiceTypeId, SortOrder )
		Select			ReportTypeColumnId = c.ReportTypeColumnId, ServiceTypeId = d.ServiceTypeId, a.SortOrder
		From		(
						Select		SortOrder =   1, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotScript',		ServiceTypeId = '5AE3336E-A30F-43BA-A5B6-277B0B442AC1',	ServiceTypeName = 'Pilot Script' UNION
						Select		SortOrder =   2, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotScript',		ServiceTypeId = '97214953-FBDE-4A1C-ADB2-ECCD192F812C',	ServiceTypeName = 'Pilot Script 2' UNION
						Select		SortOrder =   3, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotScript',		ServiceTypeId = '60089FE6-60E2-40BC-A06F-88FDA28CC83A',	ServiceTypeName = 'Pilot Script Bonus' UNION
						Select		SortOrder =   4, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotScript',		ServiceTypeId = '2A981120-30BE-429B-AF0D-E46AF9A84593',	ServiceTypeName = 'Rewrite' UNION
						Select		SortOrder =   5, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotScript',		ServiceTypeId = '45E738B1-A648-4572-8ED1-4CB16D2BBDCD',	ServiceTypeName = 'Backup Script' UNION
						Select		SortOrder =   6, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotScript',		ServiceTypeId = 'C743E8B0-9746-499F-84AA-976E713AEABF',	ServiceTypeName = 'Polish' UNION
						Select		SortOrder =   7, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotServices',		ServiceTypeId = 'E412BA6C-99E7-4FEF-9DED-62D2D7FAFA53',	ServiceTypeName = 'Pilot' UNION
						Select		SortOrder =   8, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotServices',		ServiceTypeId = '741AB710-3995-457E-95AD-B0A4FFE6DF6B',	ServiceTypeName = 'Pilot Co-EP' UNION
						Select		SortOrder =   9, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'PilotServices',		ServiceTypeId = '878C74F6-05BD-4B23-A58C-7C1529373C03',	ServiceTypeName = 'Pilot EP' UNION
						Select		SortOrder =  10, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'Term',				ServiceTypeId = '5AFCDB25-255C-47C0-BC61-93142742C6F0',	ServiceTypeName = 'Series' UNION
						Select		SortOrder =  11, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'Consulting',		ServiceTypeId = '0F7AAB40-8185-471B-AEB6-2A1980DB2065',	ServiceTypeName = 'Consulting' UNION
						Select		SortOrder =  12, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'Consulting',		ServiceTypeId = 'F6988102-328B-41CB-BD99-1D97E40E2FE9',	ServiceTypeName = 'Consulting (if not EP in subsqt Yr)' UNION
						Select		SortOrder =  13, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'Consulting',		ServiceTypeId = '270F2B54-B4C9-4BC9-BAF8-72B0F38D991F',	ServiceTypeName = 'Pilot Script Consulting' UNION
						Select		SortOrder =  14, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'Consulting',		ServiceTypeId = 'FF356219-0A7C-4370-B201-CE9B3D2F2403',	ServiceTypeName = 'Revision' UNION
						Select		SortOrder =  15, ReportTypeName = 'Writer-Creator-PtS',			ReportTypeColumnName = 'Consulting',		ServiceTypeId = '2C7A52F4-B7C1-4441-926C-903E3D0FA9C6',	ServiceTypeName = 'Sizzle Reel' 


					) a
		Join			dbo.ReportType b ON a.ReportTypeName = b.ReportTypeName
		Join			dbo.ReportTypeColumn c ON a.ReportTypeColumnName = c.Name
		Join			dbo.ServiceType d ON a.ServiceTypeId = d.ServiceTypeId
										 AND a.ServiceTypeName = d.ServiceTypeName

		Left Join		dbo.XReportTypeColumnServiceType y ON c.ReportTypeColumnId = y.ReportTypeColumnId
															AND d.ServiceTypeId = y.ServiceTypeId
		Where			y.XReportTypeColumnServiceTypeId IS NULL




--Report - Column					ServiceTypeId							ServiceTypeName

--WriterCreatorPts - PilotScript	5AE3336E-A30F-43BA-A5B6-277B0B442AC1	Pilot Script
--WriterCreatorPts - PilotScript	97214953-FBDE-4A1C-ADB2-ECCD192F812C	Pilot Script 2
--WriterCreatorPts - PilotScript	C743E8B0-9746-499F-84AA-976E713AEABF	Polish
--WriterCreatorPts - PilotScript	2A981120-30BE-429B-AF0D-E46AF9A84593	Rewrite
--WriterCreatorPts - PilotScript	45E738B1-A648-4572-8ED1-4CB16D2BBDCD	Backup Script
--WriterCreatorPts - PilotScript	60089FE6-60E2-40BC-A06F-88FDA28CC83A	Pilot Script Bonus
		
--WriterCreatorPts - PilotServices	E412BA6C-99E7-4FEF-9DED-62D2D7FAFA53	Pilot
--WriterCreatorPts - PilotServices	741AB710-3995-457E-95AD-B0A4FFE6DF6B	Pilot Co-EP
--WriterCreatorPts - PilotServices	878C74F6-05BD-4B23-A58C-7C1529373C03	Pilot EP


--WriterCreatorPts - Term			5AFCDB25-255C-47C0-BC61-93142742C6F0	Series

--WriterCreatorPts - Consulting		0F7AAB40-8185-471B-AEB6-2A1980DB2065	Consulting
--WriterCreatorPts - Consulting		F6988102-328B-41CB-BD99-1D97E40E2FE9	Consulting (if not EP in subsqt Yr)
--WriterCreatorPts - Consulting		270F2B54-B4C9-4BC9-BAF8-72B0F38D991F	Pilot Script Consulting
--WriterCreatorPts - Consulting		FF356219-0A7C-4370-B201-CE9B3D2F2403	Revision
--WriterCreatorPts - Consulting		2C7A52F4-B7C1-4441-926C-903E3D0FA9C6	Sizzle Reel


		--Select			* From dbo.ReportType c order by ReportTypeName
		--Select			* From dbo.ReportTypeColumn c order by Name
		--Select			* From dbo.ServiceType c where c.Pilot = 1 order by ServiceTypeName
		--SELECT			* FROM	dbo.XReportTypeColumnServiceType


		--SELECT			z.ServiceTypeName, x.SortOrder
		--FROM				dbo.XReportTypeColumnServiceType x	
		--JOIN				dbo.ReportTypeColumn y				ON x.ReportTypeColumnId = y.ReportTypeColumnId
		--JOIN				dbo.ServiceType z					ON x.ServiceTypeId = z.ServiceTypeId 
		--WHERE				y.Name = 'PilotScript' 



END

GO












