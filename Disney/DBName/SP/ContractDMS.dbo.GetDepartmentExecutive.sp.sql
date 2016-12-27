

IF OBJECT_ID('GetDepartmentExecutive', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetDepartmentExecutive
GO


CREATE proc dbo.GetDepartmentExecutive
			@DeptName						VARCHAR(250) = NULL
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-07-05 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetDepartmentExecutive
	--   Created:		2015-May-05
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--
	--   Usage:
	--
	--
	--					EXEC		dbo.GetDepartmentExecutive
	--										@DeptName					= 'Department Name'
	--

*/ 
-- =============================================
BEGIN


			SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
			SET			NOCOUNT ON	
			SET			LOCK_TIMEOUT 5000	

			SELECT		de.Id,
						d.DepartmentId,
						d.DepartmentName,
						e.ExecutiveId,
						e.ExecutiveName
			FROM		dbo.DepartmentExecutive de
			JOIN		dbo.Department d WITH (NOLOCK)			ON d.DepartmentId=de.DepartmentId
			JOIN		dbo.Executive e WITH (NOLOCK)			ON e.ExecutiveId=de.ExecutiveId
			WHERE		d.IsActive								= 1
			AND			e.IsActive								= 1
			AND			d.DepartmentName						= ISNULL(@DeptName, d.DepartmentName)

END
GO
