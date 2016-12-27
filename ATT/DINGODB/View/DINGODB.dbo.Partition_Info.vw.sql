USE DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.Partition_Info'), 0) > 0 
	DROP VIEW dbo.Partition_Info
GO


CREATE VIEW dbo.Partition_Info 
AS
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.Partition_Info
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Provides partition information by table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.Partition_Info.vw.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//
*/ 

		SELECT		OBJECT_NAME(i.object_id) AS OBJECT_NAME,
					p.partition_number,
					fg.NAME AS FILEGROUP_NAME,
					ROWS,
					au.total_pages,
					CASE boundary_value_on_right
					WHEN 1 THEN 'Less than'
					ELSE 'Less than or equal to' END AS 'Compartition',
					VALUE 
		FROM		sys.partitions p
		JOIN		sys.indexes i
		ON			p.object_id = i.object_id
		AND			p.index_id = i.index_id
		JOIN		sys.partition_schemes ps
		ON			ps.data_space_id = i.data_space_id
		JOIN		sys.partition_functions f
		ON			f.function_id = ps.function_id
		LEFT JOIN	sys.partition_range_values rv
		ON			f.function_id = rv.function_id
		AND			p.partition_number = rv.boundary_id
		JOIN		sys.destination_data_spaces dds
		ON			dds.partition_scheme_id = ps.data_space_id
		AND			dds.destination_id = p.partition_number
		JOIN		sys.filegroups fg
		ON			dds.data_space_id = fg.data_space_id
		JOIN		(
						SELECT container_id, SUM(total_pages) AS total_pages
						FROM sys.allocation_units
						GROUP BY container_id
					)	AS au
		ON			au.container_id = p.partition_id
		WHERE		i.index_id < 2

