


IF OBJECT_ID('GetDRRoleUserId', 'p') IS NOT NULL
    DROP PROCEDURE dbo.GetDRRoleUserId
GO

CREATE PROC dbo.GetDRRoleUserId
					@UserId				UNIQUEIDENTIFIER = NULL
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-July-04 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.GetDRRoleUserId
	--   Created:		2015-July-04
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--
	--   Usage:
	--
	--
	--					DECLARE		@UserId											UNIQUEIDENTIFIER	= CAST('5B29512C-811F-E511-BADE-005056A06886' as UNIQUEIDENTIFIER)
	--					EXEC		dbo.GetDRRoleUserId
	--										@UserId									= @UserId
	--

*/ 
-- =============================================
BEGIN


						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000	

						SELECT			TOP 1 
										x											= 1
						FROM			dbo.Users u WITH (NOLOCK)
						LEFT JOIN		dbo.Roles r WITH (NOLOCK)					ON u.RoleId = r.RoleId
						WHERE			u.IsActive									= 1
						AND				u.UserId									= @UserId



						--select			x=1
						--SELECT 
						--	u.UserName,
						--	u.IsActive,
						--	u.PropertyValuesString as UserPrefereces,
						--	u.RoleId,
						--	r.RoleName,
						--	srch.Id AS SearchID,
						--	srch.GroupName,
						--	srch.Title 
						--FROM [dbo].Users u
						--INNER JOIN [dbo].Roles r (NOLOCK) ON r.RoleId = u.RoleId
						--LEFT JOIN UserSearch srch (NOLOCK) ON srch.UserId = u.UserId
						--WHERE u.UserId = @UserID




END
GO



