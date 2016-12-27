

IF OBJECT_ID('UpsertDRCreativeExecutive', 'p') IS NOT NULL
    DROP PROCEDURE dbo.UpsertDRCreativeExecutive
GO

CREATE PROC dbo.UpsertDRCreativeExecutive
						@DRId													UNIQUEIDENTIFIER,
						@UserId													UNIQUEIDENTIFIER	,
						--@UDT_DRCreativeExecutive								UDT_GUID			READONLY,
						@StatusTypeName											VARCHAR(200)		= NULL OUTPUT,
						@Status													INT 				= NULL OUTPUT,
						@StatusMessage											VARCHAR(1000)		= NULL OUTPUT
AS
-- =============================================
/*

	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-Jul-04 $
	--   $Author:		Tony Lew $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.UpsertDRCreativeExecutive
	--   Created:		2015-Jul-04
	--   Author:		Tony Lew
	-- 
	--   Purpose: 
	--					
	--
	--   Usage:
	--
	--
	--					DECLARE		@EmptyGUID									UNIQUEIDENTIFIER	= CAST('00000000-0000-0000-0000-000000000000' as UNIQUEIDENTIFIER)
	--					DECLARE		@DRId										UNIQUEIDENTIFIER	= CAST('3F0E9B9A-16A5-E511-8F22-005056A06886' as UNIQUEIDENTIFIER)
	--					DECLARE		@UDT_DRCreativeExecutive					UDT_GUID
	--					INSERT		@UDT_DRCreativeExecutive ( Gid )
	--					SELECT		TOP 2 u.UserId
	--					FROM		dbo.Users u 
	--					JOIN		dbo.Roles r ON u.RoleId = r.RoleId 
	--					WHERE		r.RoleName = 'Creative Executive'
	--					ORDER BY	NewId()
	--
	--					SELECT		Id											= e.Gid					
	--					FROM		@UDT_DRCreativeExecutive e
	--
	--					DECLARE		@UserId										UNIQUEIDENTIFIER
	--					SELECT		TOP 1 @UserId								= UserId from dbo.Users order by NewID()
	--
	--					DECLARE		@StatusTypeNameOUT VARCHAR(200)
	--					DECLARE		@StatusOUT INT
	--					DECLARE		@StatusMessageOUT VARCHAR(250)
	--					EXEC		dbo.UpsertDRCreativeExecutive
	--										@DRId								= @DRId					,
	--										@UserId								= @UserId				,
	--										--@UDT_DRCreativeExecutive			= @UDT_DRCreativeExecutive	,
	--										@StatusTypeName						= @StatusTypeNameOUT OUTPUT	,
	--										@Status								= @StatusOUT OUTPUT			,
	--										@StatusMessage						= @StatusMessageOUT OUTPUT
	--					SELECT		@StatusTypeNameOUT, @StatusOUT, @StatusMessageOUT
	--					SELECT		* FROM dbo.DR WHERE DRId = @DRId
	--					SELECT		* FROM dbo.DRCreativeExecutive WHERE DRId = @DRId
	--					EXEC		dbo.GetEventLog
	--

*/ 
-- =============================================
BEGIN


						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000	

						DECLARE			@EmptyGUID															UNIQUEIDENTIFIER = CAST('00000000-0000-0000-0000-000000000000' as UNIQUEIDENTIFIER)
						DECLARE			@EventLogTypeIdError												UNIQUEIDENTIFIER
						DECLARE			@EventLogTypeIdUpdate												UNIQUEIDENTIFIER
						DECLARE			@EventTypeId														UNIQUEIDENTIFIER
						DECLARE			@EventId															UNIQUEIDENTIFIER
						DECLARE			@Rows																INT
						DECLARE			@UDT_DRCreativeExecutiveIdTBD										UDT_GUID
						DECLARE			@UDT_DRCreativeExecutive											UDT_GUID
						DECLARE			@JSONCreativeExecutive												VARCHAR(MAX)
						DECLARE			@JSONCE																Hierarchy
						DECLARE			@CreativeExecutiveIdTBL												UDT_GUID

						SELECT			@EventTypeId														= EventTypeId FROM dbo.EventType WITH (NOLOCK) WHERE Name = 'DR'
						SELECT			@EventLogTypeIdError												= EventLogTypeId FROM dbo.EventLogType WITH (NOLOCK) WHERE Name = 'Error'
						SELECT			@EventLogTypeIdUpdate												= EventLogTypeId FROM dbo.EventLogType WITH (NOLOCK) WHERE Name = 'DR Update - DR Creative Executive'
						IF				( @UserId = @EmptyGUID )											SET @UserId = NULL

						SELECT			TOP 1 @EventId														= d.EventId,
										@JSONCreativeExecutive												= d.JSONCreativeExecutive
						FROM			dbo.DR d WITH (NOLOCK)
						WHERE			d.DRId																= @DRId	
						SELECT			@Rows																= @@ROWCOUNT


						IF				( @Rows = 0 )
						BEGIN
										EXEC		dbo.GetEventStatus
															@StatusName										= 'Invalid DRId',
															@StatusTypeName									= @StatusTypeName OUTPUT,
															@StatusId										= @Status OUTPUT,
															@StatusMessage									= @StatusMessage OUTPUT
										SELECT 		@StatusMessage											= 'Invalid DRId' + @StatusMessage
										RETURN
						END



						--TSQL JSON Parser
						BEGIN TRY
										IF			( @JSONCreativeExecutive IS NOT NULL )
										BEGIN
													INSERT		@JSONCE 
															(
																element_id	,	
																sequenceNo	,	
																parent_ID	,	
																[Object_ID]	,	
																NAME		,	
																StringValue	,	
																ValueType		
															)
													SELECT		element_id	,
																sequenceNo	,
																parent_ID	,
																[Object_ID]	,
																NAME		,
																StringValue	,
																ValueType	
													FROM		dbo.ParseJSON( @JSONCreativeExecutive) x
													WHERE		x.ValueType									= 'string'

										END
						END TRY
						BEGIN CATCH
										EXEC		dbo.GetEventStatus
															@StatusName										= 'Invalid CreativeExecutive JSON',
															@StatusTypeName									= @StatusTypeName OUTPUT,
															@StatusId										= @Status OUTPUT,
															@StatusMessage									= @StatusMessage OUTPUT
										SELECT 		@StatusMessage											= 'Invalid CreativeExecutive JSON' + @StatusMessage

										EXEC		dbo.InsertEventLog
														@EventLogTypeId										= @EventLogTypeIdError,
														@EventId											= @EventId,
														@UserId												= @UserId,
														@Comment											= @StatusMessage

										RETURN
						END CATCH


						--				If any member of this creative executive JSON string does NOT 
						--				belong to the creative executive role, then we have a problem.
						IF				EXISTS	(
													SELECT		TOP 1 1
													FROM		@JSONCE x
													LEFT JOIN	(
																	SELECT	CAST(de.ExecutiveId AS VARCHAR(100))	AS ExecutiveId
																	FROM	dbo.DepartmentExecutive de WITH (NOLOCK)
																	JOIN	dbo.Department d WITH (NOLOCK)	ON de.DepartmentId = d.DepartmentId 
																	JOIN	dbo.Executive e WITH (NOLOCK)	ON de.ExecutiveId = e.ExecutiveId 
																	WHERE	d.DepartmentName				= 'Creative'
																	AND		e.IsActive						= 1
																) y											ON x.StringValue = y.ExecutiveId
													WHERE		y.ExecutiveId								IS NULL
										)
						BEGIN
										EXEC		dbo.GetEventStatus
															@StatusName										= 'Invalid DR CreativeExecutive',
															@StatusTypeName									= @StatusTypeName OUTPUT,
															@StatusId										= @Status OUTPUT,
															@StatusMessage									= @StatusMessage OUTPUT
										SELECT 		@StatusMessage											= 'Invalid DR CreativeExecutive' + @StatusMessage

										EXEC		dbo.InsertEventLog
														@EventLogTypeId										= @EventLogTypeIdError,
														@EventId											= @EventId,
														@UserId												= @UserId,
														@Comment											= @StatusMessage

										RETURN
						END

						INSERT			@UDT_DRCreativeExecutive ( Gid )
						SELECT			CONVERT(UNIQUEIDENTIFIER,x.StringValue) 
						FROM			@JSONCE x
						WHERE			x.ValueType = 'string'
						GROUP BY		x.StringValue

						BEGIN TRY

										BEGIN TRANSACTION

										--				Add creative executives that don't already exist in the list.
										INSERT			dbo.DRCreativeExecutive ( DRId,CreativeExecutiveUserId )
										SELECT			x.DRId,x.CreativeExecutiveUserId 
										FROM		(
														SELECT		DRId									= @DRId,
																	CreativeExecutiveUserId					= a.Gid
														FROM		@UDT_DRCreativeExecutive a
													) x
										LEFT JOIN		dbo.DRCreativeExecutive y WITH (NOLOCK)				ON x.DRId = y.DRId
																											AND x.CreativeExecutiveUserId = y.CreativeExecutiveUserId
										WHERE			y.DRCreativeExecutiveId								IS NULL

										--				Identify the creative executives that don't exist in the new mapping table
										INSERT			@UDT_DRCreativeExecutiveIdTBD ( Gid )
										SELECT			Gid													= x.DRCreativeExecutiveId
										FROM		(
														SELECT		DRCreativeExecutiveId					= DRCreativeExecutiveId,
																	CreativeExecutiveUserId					= CreativeExecutiveUserId
														FROM		dbo.DRCreativeExecutive WITH (NOLOCK)	
														WHERE		DRId									= @DRId					
													) x														
										LEFT JOIN		@UDT_DRCreativeExecutive y							ON x.CreativeExecutiveUserId = y.Gid
										WHERE			y.Id												IS NULL

										--				Delete records those records that we just identified.
										DELETE			x
										FROM			dbo.DRCreativeExecutive x
										JOIN			@UDT_DRCreativeExecutiveIdTBD d						ON x.DRCreativeExecutiveId = d.Gid 
										WHERE			x.DRId												= @DRId	

										SELECT			@Rows												= COUNT(1)
										FROM			dbo.DRCreativeExecutive x
										WHERE			x.DRId												= @DRId	

										IF				( ISNULL(@Rows,0) = 0 )
										BEGIN	
														ROLLBACK TRANSACTION
														EXEC		dbo.GetEventStatus
																			@StatusName						= 'Invalid DR CreativeExecutive State',
																			@StatusTypeName					= @StatusTypeName OUTPUT,
																			@StatusId						= @Status OUTPUT,
																			@StatusMessage					= @StatusMessage OUTPUT
														SELECT 		@StatusMessage							= 'Invalid DR CreativeExecutive State' + @StatusMessage

														EXEC	dbo.InsertEventLog
																	@EventLogTypeId							= @EventLogTypeIdError,
																	@EventId								= @EventId,
																	@UserId									= @UserId,
																	@Comment								= @StatusMessage

														RETURN
										END


										EXEC			dbo.InsertEventLog
																@EventLogTypeId								= @EventLogTypeIdUpdate,
																@EventId									= @EventId,
																@UserId										= @UserId

										COMMIT

										EXEC		dbo.GetEventStatus
															@StatusName										= 'Success',
															@StatusTypeName									= @StatusTypeName OUTPUT,
															@StatusId										= @Status OUTPUT,
															@StatusMessage									= @StatusMessage OUTPUT
										SELECT 		@StatusMessage											= 'Success'


						END TRY
						BEGIN CATCH

										IF @@TRANCOUNT > 0
										BEGIN
													ROLLBACK TRANSACTION
										END
										SELECT		@StatusTypeName											= 'Error',
													@Status													= CASE WHEN ERROR_NUMBER() = 0 THEN -99 ELSE ERROR_NUMBER() END, 
													@StatusMessage											= ERROR_MESSAGE()

										EXEC	dbo.InsertEventLog
													@EventLogTypeId											= @EventLogTypeIdError,
													@EventId												= @EventId,
													@UserId													= @UserId,
													@Comment												= @StatusMessage

						END CATCH


END

GO



