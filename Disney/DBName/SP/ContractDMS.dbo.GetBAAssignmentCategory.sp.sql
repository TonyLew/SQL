
IF OBJECT_ID('GetBAAssignmentCategory', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetBAAssignmentCategory
GO

CREATE PROC dbo.GetBAAssignmentCategory
					@BAExecutiveId		UNIQUEIDENTIFIER = NULL
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-Nov-01 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetBAAssignmentCategory
	--   Created:		2015-Nov-01
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					CCADMS - 705
	--					
	--
	--   Usage:
	--
	--
	--					DECLARE		@BAExecutiveId								UNIQUEIDENTIFIER	= CAST('42666195-024E-442E-9078-9FD78A2AB59D' as UNIQUEIDENTIFIER)
	--					EXEC		dbo.GetBAAssignmentCategory
	--										@BAExecutiveId						= @BAExecutiveId
	--

*/ 
-- =============================================
BEGIN



						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000	


						DECLARE			@SQLstr									VARCHAR(MAX)
						DECLARE			@cols									VARCHAR(4000)

						CREATE TABLE	#NetworkFilter 
									( 
										NetworkId								UNIQUEIDENTIFIER, 
										NetworkShortName						VARCHAR(10), 
										SortOrder								INT
									)

						CREATE TABLE	#BANetworkProjecttbl 
									(	
										BAName									VARCHAR(300), 
										NetworkName								VARCHAR(300), 
										NetworkShortName						VARCHAR(10), 
										HubName									VARCHAR(100), 
										ProjectName								VARCHAR(300), 
										ProjectStatusName						VARCHAR(300), 
										ProjectStatusColor						VARCHAR(50), 
										ColorId									VARCHAR(20),
										SortOrder								INT
									)
						CREATE TABLE	#BAUsers 
									( 
										BAExecutiveId							UNIQUEIDENTIFIER, 
										BAName									VARCHAR(300), 
										SortOrder								INT
									)

						CREATE TABLE	#FilterProjectStatus
									( 
										ProjectStatusId							UNIQUEIDENTIFIER, 
										ProjectStatusName						VARCHAR(100), 
										ProjectStatusColor						VARCHAR(50), 
										ColorId									VARCHAR(20),
										SortOrder								INT
									)
						DECLARE			@FilterProjectStatus					UDT_GUIDVarchar300


						INSERT			#FilterProjectStatus ( ProjectStatusId,ProjectStatusName,ProjectStatusColor,SortOrder )
						SELECT			ps.ProjectStatusId,ps.ProjectStatusName, x.ProjectStatusColor, x.SortOrder
						FROM			dbo.ProjectStatus ps WITH (NOLOCK)	
						JOIN		(
										select	SortOrder =    1, ProjectStatusColor = 'Light Green',		ProjectStatusName =	'Current-Development'		UNION 
										select	SortOrder =    2, ProjectStatusColor = 'Green',				ProjectStatusName =	'Current-Post Production'	UNION
										select	SortOrder =    3, ProjectStatusColor = 'Light Blue',		ProjectStatusName =	'Current-Production'		
									) x											
						ON				ps.ProjectStatusName					= x.ProjectStatusName
						ORDER BY		x.SortOrder


						INSERT			#BAUsers ( BAExecutiveId, BAName , SortOrder )
						SELECT			x.ExecutiveId, w.ExecutiveName, w.SortOrder
						FROM
									(
										select	SortOrder =    1, ExecutiveName =	'Adina Savin'		UNION 
										select	SortOrder =    2, ExecutiveName =	'Yvonne Shay'		UNION
										select	SortOrder =    3, ExecutiveName =	'Mila Livitz'		UNION
										select	SortOrder =    4, ExecutiveName =	'Jen Konare'		UNION
										select	SortOrder =    5, ExecutiveName =	'Scott Lowry'		UNION
										select	SortOrder =    6, ExecutiveName =	'Ron Tzadik'		UNION
										select	SortOrder =    7, ExecutiveName =	'Dan Mendelsohn'	UNION
										select	SortOrder =    8, ExecutiveName =	'Tony Brackett'		UNION
										select	SortOrder =    9, ExecutiveName =	'Emily Jarvis'

									) w	
						JOIN			dbo.Executive x							ON w.ExecutiveName = x.ExecutiveName
						JOIN			dbo.DepartmentExecutive y				ON x.ExecutiveId = y.ExecutiveId
						JOIN			dbo.Department z						ON y.DepartmentId = z.DepartmentId 
						WHERE			z.DepartmentName						= 'Business Affairs'
						AND				x.ExecutiveId							= ISNULL(@BAExecutiveId,x.ExecutiveId)




/*



SELECT			DISTINCT e.ExecutiveName
FROM			dbo.ProjectExecutive pe WITH (NOLOCK)	
JOIN			dbo.Project p WITH (NOLOCK)				ON pe.ProjectId = p.ProjectId
JOIN			dbo.ProjectStatus ps WITH (NOLOCK)		ON p.ProjectStatusId = ps.ProjectStatusId
JOIN			dbo.Executive e WITH (NOLOCK)			ON pe.ExecutiveId = e.ExecutiveId
JOIN			dbo.DepartmentExecutive de WITH (NOLOCK)	ON e.ExecutiveId = de.ExecutiveId
JOIN			dbo.Department d WITH (NOLOCK)			ON de.DepartmentId = d.DepartmentId
JOIN			dbo.Network n WITH (NOLOCK)				ON p.NetworkId = n.NetworkId
JOIN			dbo.HubExecutive he WITH (NOLOCK)		ON pe.ExecutiveId = he.ExecutiveId
JOIN			dbo.Hub h WITH (NOLOCK)					ON he.HubId = h.HubId
WHERE			1=1
AND				n.ShortName								IN ('DC','JR','XD')
AND				ps.ProjectStatusName					IN ('Current-Development','Current-Post Production','Current-Production')
AND				d.DepartmentName						= 'Business Affairs'
AND				h.Name									= 'DCWW'
AND				e.IsActive								= 1
AND				p.ProjectName							NOT LIKE '%TALENT DEAL%'




Jarred Katz
Jeff Lowy (Music)
Johanna MacCabe (UK)
Josh Shapiro (TVA)
Lisa Liberatore (TVA)
Teresa Rogers (UK)



*/


						INSERT			#BANetworkProjecttbl ( BAName, NetworkName, NetworkShortName, HubName, ProjectName, ProjectStatusName, ProjectStatusColor, ColorId, SortOrder )
						SELECT			x.BAName, n.NetworkName, n.ShortName, h.Name, p.ProjectName, f.ProjectStatusName as ProjectStatusName, f.ProjectStatusColor, f.ColorId, x.SortOrder
						FROM			#BAUsers x
						LEFT JOIN		dbo.ProjectExecutive pe WITH (NOLOCK)	ON x.BAExecutiveId = pe.ExecutiveId
						LEFT JOIN		dbo.Project p WITH (NOLOCK)				ON pe.ProjectId = p.ProjectId
						LEFT JOIN		dbo.Network n WITH (NOLOCK)				ON p.NetworkId = n.NetworkId
						LEFT JOIN		dbo.HubExecutive he WITH (NOLOCK)		ON pe.ExecutiveId = he.ExecutiveId
						LEFT JOIN		dbo.Hub h WITH (NOLOCK)					ON he.HubId = h.HubId
						LEFT JOIN		#FilterProjectStatus f					ON p.ProjectStatusId = f.ProjectStatusId
						WHERE			f.ProjectStatusId						IS NOT NULL
						--ORDER BY		x.SortOrder, f.SortOrder


						--				Get the BA names in SortOrder to use as the column names.
						SELECT			@cols									= COALESCE(@cols + ',[' + BAName + ']','[' + BAName + ']')
						FROM    
									(
										SELECT DISTINCT BAName, SortOrder FROM #BANetworkProjecttbl
									) x
						ORDER BY		x.sortorder


						SELECT			@SQLstr		=	'SELECT ' + @cols + ' FROM	( ' +
															'SELECT BAName, ProjectName + '' - '' + NetworkShortName + '' - '' + ProjectStatusName AS RptBox, ' +
																	'RNumber			= ROW_NUMBER() OVER( PARTITION BY BAName ORDER BY SortOrder ) ' +
															'FROM #BANetworkProjecttbl ' +
															'GROUP BY BAName, SortOrder, ProjectName + '' - '' + NetworkShortName + '' - '' + ProjectStatusName ' +
															') src ' +
														'PIVOT	( ' +
																' MIN(RptBox) FOR BAName IN ( ' + @cols + ' )  ' +
																') AS pvt '

						EXEC			( @SQLstr )



/*

						SELECT			NetworkId														= n.NetworkId,
										NetworkName														= n.NetworkName,
										ProjectId														= p.ProjectId, 
										ProjectName														= p.ProjectName,
										ProjectStatusId													= ps.Gid,
										ProjectStatusName												= ps.Name,
										ProgramTypeId													= pt.ProgramTypeId,
										ProgramTypeName													= pt.ProgramTypeName,
										LengthId														= l.LengthId,
										LengthName														= l.LengthName,

										ExecutiveId														= x.ExecutiveId						,
										ExecutiveName													= x.ExecutiveName					,
										AgreementId														= x.AgreementId						,
										DocumentId														= x.DocumentId						,
										DocumentDate													= x.DocumentDate					,
										DocumentStatusTypeId											= x.DocumentStatusTypeId			,
										DocumentStatusTypeName											= x.DocumentStatusTypeName			

						FROM		(
										SELECT			ExecutiveId										= e.ExecutiveId, 
														ExecutiveName									= e.ExecutiveName,
														AgreementId										= d.AgreementId,
														DocumentId										= pd.DocumentId,
														DocumentDate									= d.DocumentDate,
														DocumentStatusTypeId							= dst.DocumentStatusTypeId,
														DocumentStatusTypeName							= dst.DocumentStatusTypeName
										FROM			dbo.Executive e WITH (NOLOCK)	
										JOIN			dbo.DepartmentExecutive dex WITH (NOLOCK)		ON e.ExecutiveId = dex.ExecutiveId 
										JOIN			dbo.Department dept WITH (NOLOCK)				ON dex.DepartmentId = dept.DepartmentId 
										JOIN			dbo.DocumentExecutive de WITH (NOLOCK)			ON e.ExecutiveId = de.ExecutiveId 
										JOIN			dbo.ProdDocument pd WITH (NOLOCK)				ON de.DocumentId = pd.DocumentId 
										JOIN			dbo.Document d WITH (NOLOCK)					ON de.DocumentId = d.DocumentId 
										JOIN			dbo.DocumentStatusType dst WITH (NOLOCK)		ON d.DocumentStatusTypeId = dst.DocumentStatusTypeId 
										WHERE			dept.DepartmentName								= 'Business Affairs'
										AND				e.ExecutiveId									= ISNULL(@BAExecutiveId,e.ExecutiveId)
									)	x
						JOIN			dbo.ProdAgreement pa WITH (NOLOCK)								ON x.AgreementId = pa.AgreementId	
						JOIN			dbo.Project p WITH (NOLOCK)										ON pa.ProjectId = p.ProjectId
						JOIN			dbo.Network n WITH (NOLOCK)										ON p.NetworkId = n.NetworkId
						JOIN			#FilterProjectStatus ps											ON p.ProjectStatusId = ps.Gid
						LEFT JOIN		dbo.ProgramType pt WITH (NOLOCK)								ON p.ProgramTypeId = pt.ProgramTypeId
						LEFT JOIN		dbo.[Length] l WITH (NOLOCK)									ON p.LengthId = l.LengthId
						ORDER BY		x.ExecutiveId			,
										x.ExecutiveName			,
										p.ProjectId				,
										p.ProjectName
										--x.DocumentDate

*/

						DROP TABLE		#FilterProjectStatus
						DROP TABLE		#BANetworkProjecttbl 
						DROP TABLE		#BAUsers 
						

END
GO

/*


Adina Savin	Yvonne Shay	Mila Livitz	Jen Konare	Scott Lowry	Ron Tzadik	Dan Mendelsohn	Tony Brackett	Emily Jarvis

select * from titleclearancetype

Series Development	Series Production	Movie Development	Movie Production	Talent Deal	
Alt/Reality Dev	Alt/Reality Prod	License	Co-Productions	Disney JR Dev	Disney JR Production

Report_LegalAssignmentTracking

--SP
select distinct o.name
from sysobjects o
join syscomments c on o.id = c.id
where o.xtype in ('p','v','fn')
and c.text like '%Reality%'
order by o.name


select * from dbo.Network Where IsActive = 1 order by NetworkName
select * from dbo.Hub Where IsActive = 1 
select * from dbo.Department Where IsActive = 1 order by NetworkName


select distinct e.ExecutiveName 
from dbo.Hub h
join dbo.HubExecutive he on h.HubId = he.HubId
join dbo.Executive e on he.ExecutiveId = e.ExecutiveId
Where h.IsActive = 1 
and h.Name = 'ABCF'




select e.ExecutiveName, *
from DepartmentExecutive de
join Executive e on de.ExecutiveId = e.ExecutiveId
join Department d on de.DepartmentId = d.DepartmentId
where d.DepartmentName = 'Business Affairs'
and e.IsActive = 1
order by e.ExecutiveName



select * from dbo.AgreementClass
select * from dbo.Format Where IsActive = 1 order by FormatName
select * from dbo.ProgramType 
--Where IsActive = 1 
order by ProgramTypeName
select * from dbo.Length Where IsActive = 1 order by LengthName

select * from dbo.Genre Where IsActive = 1 order by GenreName






declare @BANetworkProjecttbl table (BAName varchar(300), NetworkName varchar(300), NetworkShortName varchar(10), HubName varchar(100), ProjectName varchar(300), ProjectStatusName varchar(300), SortOrder int)
declare @pivottbl table ( BAExecutiveId uniqueidentifier, BAName varchar(300), SortOrder int)
						DECLARE			#FilterProjectStatus											UDT_GUIDVarchar300


drop table #BANetworkProjecttbl 
drop table #BAUsers 

create table #BANetworkProjecttbl (BAName varchar(300), NetworkName varchar(300), NetworkShortName varchar(10), HubName varchar(100), ProjectName varchar(300), ProjectStatusName varchar(300), SortOrder int)
create table #BAUsers ( BAExecutiveId uniqueidentifier, BAName varchar(300), SortOrder int)
--create table #FilterProjectStatus											UDT_GUIDVarchar300



						INSERT			#FilterProjectStatus ( Gid,Name )
						SELECT			ProjectStatusId,ProjectStatusName
						FROM			dbo.ProjectStatus ps WITH (NOLOCK)	
						WHERE			ps.ProjectStatusName											IN (
																											'Current-Development',
																											'Current-Post Production',
																											'Current-Production'
																											)


insert #BAUsers ( BAExecutiveId, BAName , SortOrder )
select x.ExecutiveId, w.ExecutiveName, w.SortOrder --row_number() over ( order by (select 1) ), row_number() over ( order by (select 1) )
FROM
(
		select			SortOrder =    1, ExecutiveName =	'Adina Savin'		UNION 
		select			SortOrder =    2, ExecutiveName =	'Yvonne Shay'		UNION
		select			SortOrder =    3, ExecutiveName =	'Mila Livitz'		UNION
		select			SortOrder =    4, ExecutiveName =	'Jen Konare'		UNION
		select			SortOrder =    5, ExecutiveName =	'Scott Lowry'		UNION
		select			SortOrder =    6, ExecutiveName =	'Ron Tzadik'		UNION
		select			SortOrder =    7, ExecutiveName =	'Dan Mendelsohn'	UNION
		select			SortOrder =    8, ExecutiveName =	'Tony Brackett'		UNION
		select			SortOrder =    9, ExecutiveName =	'Emily Jarvis'

) w	
join dbo.Executive x on w.ExecutiveName = x.ExecutiveName
join dbo.DepartmentExecutive y on x.ExecutiveId = y.ExecutiveId
join dbo.Department z on y.DepartmentId = z.DepartmentId 
where z.DepartmentName = 'Business Affairs'
--and  ExecutiveName IN (

--						'Adina Savin',
--						'Yvonne Shay',
--						'Mila Livitz',
--						'Jen Konare',
--						'Scott Lowry',
--						'Ron Tzadik',
--						'Dan Mendelsohn',
--						'Tony Brackett',
--						'Emily Jarvis'
--)
order by w.SortOrder


--select *
--from @pivottbl
--order by sortorder


insert #BANetworkProjecttbl ( BAName, NetworkName, NetworkShortName, HubName, ProjectName, ProjectStatusName, SortOrder )
select x.BAName, n.NetworkName, n.ShortName, h.Name, p.ProjectName, y.Name as ProjectStatusName, x.SortOrder
from		#BAUsers x
left join	dbo.ProjectExecutive pe on x.BAExecutiveId = pe.ExecutiveId
left join	dbo.Project p  on pe.ProjectId = p.ProjectId
left join	dbo.Network n  on p.NetworkId = n.NetworkId
left join	dbo.HubExecutive he  on pe.ExecutiveId = he.ExecutiveId
left join	dbo.Hub h on he.HubId = h.HubId
left join	#FilterProjectStatus y on p.ProjectStatusId = y.Gid
where		y.Name IS NOT NULL

--select * from #BANetworkProjecttbl x


DECLARE	@SQLstr VARCHAR(MAX)
DECLARE @cols VARCHAR(4000)
SELECT  @cols = COALESCE(@cols + ',[' + BAName + ']',
                         '[' + BAName + ']')
FROM    
	(
	select distinct BAName, sortorder from #BANetworkProjecttbl
	) x
ORDER BY x.sortorder
select @cols


SELECT		@SQLstr		= 'SELECT ' + @cols + ' FROM	( ' +

									'SELECT BAName, ProjectName + '' - '' + NetworkShortName + '' - '' + ProjectStatusName AS RptBox, ' +
											'RNumber			= row_number() over( partition by BAName order by SortOrder ) ' +
									'FROM #BANetworkProjecttbl ' +
									'GROUP BY BAName, SortOrder, ProjectName + '' - '' + NetworkShortName + '' - '' + ProjectStatusName ' +
									') src ' +
						'PIVOT	( ' +
								' MIN(RptBox) FOR BAName IN ( ' + @cols + ' )  ' +
								') AS pvt '

EXEC (@SQLstr)




SELECT [Adina Savin],[Mila Livitz],[Ron Tzadik],[Tony Brackett],[Yvonne Shay],[Emily Jarvis],[Jen Konare],[Dan Mendelsohn],[Scott Lowry]
FROM	(
			SELECT BAName, ProjectName + ' - ' + NetworkShortName + ' - ' + ProjectStatusName AS RptBox,
					RNumber			= row_number() over( partition by BAName order by SortOrder )
			FROM @BANetworkProjecttbl 
			GROUP BY BAName, SortOrder, ProjectName + ' - ' + NetworkShortName + ' - ' + ProjectStatusName 
		) src
PIVOT	( 
			MIN(RptBox) FOR BAName IN ([Adina Savin],[Mila Livitz],[Ron Tzadik],[Tony Brackett],[Yvonne Shay],[Emily Jarvis],[Jen Konare],[Dan Mendelsohn],[Scott Lowry]) 
		) AS pvt
--ORDER BY [Adina Savin]
GO



select * from 

Series Development	Series Production	Movie Development	Movie Production	Talent Deal	
Alt/Reality Dev	Alt/Reality Prod	License	Co-Productions	Disney JR Dev	Disney JR Production





*/

