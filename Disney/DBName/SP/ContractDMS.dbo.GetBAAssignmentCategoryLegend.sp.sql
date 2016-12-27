
IF OBJECT_ID('GetBAAssignmentCategoryLegend', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetBAAssignmentCategoryLegend
GO


CREATE PROC dbo.GetBAAssignmentCategoryLegend
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-06-05 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetBAAssignmentCategoryLegend
	--   Created:		2015-Jul-05
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--
	--   Usage:
	--
	--					EXEC			dbo.GetBAAssignmentCategoryLegend
	--

*/ 
-- =============================================
BEGIN


						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000	

						SELECT			ProjectCategoryId				= x.ProjectCategoryId,
										ProjectCategoryFilterGroup		= x.ProjectCategoryFilterGroup,
										Name							= x.Name,
										Description						= x.Description,
										ColorId							= x.ColorId,
										ColorName						= x.ColorName,
										SortOrder						= x.SortOrder
						FROM			dbo.ProjectCategory x WITH (NOLOCK)
						ORDER BY		x.SortOrder


END
GO
