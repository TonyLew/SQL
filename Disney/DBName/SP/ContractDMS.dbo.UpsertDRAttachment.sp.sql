

IF OBJECT_ID('UpsertDRAttachment', 'p') IS NOT NULL
    DROP PROCEDURE dbo.UpsertDRAttachment
GO


CREATE PROCEDURE dbo.UpsertDRAttachment
						@UserId								UNIQUEIDENTIFIER		= NULL			,
						@AttachmentId						UNIQUEIDENTIFIER		= NULL	OUTPUT	,
						@AttachmentTypeId					UNIQUEIDENTIFIER						,
						@DRId								UNIQUEIDENTIFIER						,
						@DRServiceId						UNIQUEIDENTIFIER		= NULL			,
						@DocumentDate						DATE					= NULL			,
						@FileName							VARCHAR(1000)			= NULL			,
						@FileExtension						VARCHAR(20)				= NULL			,
						@Note								VARCHAR(MAX)			= NULL			,
						@BlobData							VARBINARY(MAX)							,
						@StatusTypeName						VARCHAR(200)			= NULL  OUTPUT	,
						@Status								INT						= NULL  OUTPUT	,
						@StatusMessage						VARCHAR(1000)			= NULL  OUTPUT
AS
-- =============================================


	--   Revision Info
	-------------------------------------------------------------------------------
	--   $HeadURL: 
	--   $Revision:		$RevisionID$
	--   $Date:			2015-Sep-17 $
	--   $Author:		Neal Slomsky $
	-------------------------------------------------------------------------------
	--
	--
	--   Project: 
	--   Module:		dbo.UpsertDRAttachment
	--   Created:		2015-Sep-17
	--   Author:		Neal Slomsky
	-- 
	--   Purpose: 
	--					
	--
	--   Usage:
	--
	--
	--
	--				 	DECLARE			@EmptyGUID									UNIQUEIDENTIFIER	= CAST('00000000-0000-0000-0000-000000000000' as UNIQUEIDENTIFIER)
	--					DECLARE			@DRId										UNIQUEIDENTIFIER	= CAST('3F0E9B9A-16A5-E511-8F22-005056A06886' as UNIQUEIDENTIFIER)
	--					DECLARE			@AttachmentTypeId							UNIQUEIDENTIFIER	= CAST('00000000-0000-0000-0000-000000000000' as UNIQUEIDENTIFIER)
	--					DECLARE			@AttachmentId								UNIQUEIDENTIFIER	--= '3F9ECE82-486B-457E-A19B-AE852BF0FE76'
	--					DECLARE			@DRServiceId								UNIQUEIDENTIFIER	= '5A0E9B9A-16A5-E511-8F22-005056A06886'
	
	--					DECLARE			@UserId										UNIQUEIDENTIFIER
	--					DECLARE			@ModifiedBy									VARCHAR(250)
	--					DECLARE			@BlobData                                   varbinary(max)
	--
	--					SELECT			TOP 1 @UserId								= UserId from dbo.Users order by newid()
	--					SELECT			TOP 1 @ModifiedBy							= UserName from dbo.Users Where UserId = @UserId
	--					SELECT			TOP 1 @BlobData								= BlobData from dbo.Attachment order by CreatedOn DESC
	--					SELECT			TOP 1 @AttachmentTypeId						= AttachmentTypeId from dbo.AttachmentType order by Newid()
	--					
	--
	--					DECLARE			@StatusTypeNameOUT VARCHAR(200)
	--					DECLARE			@StatusOUT INT
	--					DECLARE			@StatusMessageOUT VARCHAR(250)
	--					EXEC			dbo.UpsertDRAttachment
	--											@UserId								= @UserId					,
	--									        @AttachmentId						= @AttachmentId	OUTPUT      ,
	--											@AttachmentTypeId					= @AttachmentTypeId			,
	--											@DRId								= @DRId					    ,
	--											@DRServiceId						= @DRServiceId				,
	--											@DocumentDate                       = NULL                      ,
	--											@FileName                           = 'FileName'                ,
	--											@FileExtension                      = NULL                      ,
	--											@Note                               = NULL                      ,
	--											@BlobData                           = @BlobData			        ,
	--											@StatusTypeName						= @StatusTypeNameOUT OUTPUT	,
	--											@Status								= @StatusOUT OUTPUT			,
	--											@StatusMessage						= @StatusMessageOUT OUTPUT
	--					SELECT			@AttachmentId, @StatusTypeNameOUT, @StatusOUT, @StatusMessageOUT
	--					SELECT			TOP 100 * FROM dbo.Attachment WHERE AttachmentId = @AttachmentId
	--					SELECT			b.* FROM dbo.DRService a join dbo.DRAttachment b ON a.DRId = b.DRId WHERE a.DRId = @DRId
	--					EXEC			dbo.GetEventLog
	--
-- =============================================

BEGIN


						SET				TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
						SET				NOCOUNT ON	
						SET				LOCK_TIMEOUT 5000

						DECLARE			@EmptyGUID												UNIQUEIDENTIFIER = CAST('00000000-0000-0000-0000-000000000000' as UNIQUEIDENTIFIER)
						DECLARE			@EventId												UNIQUEIDENTIFIER
						DECLARE			@EventLogTypeIdError									UNIQUEIDENTIFIER
						DECLARE			@EventLogTypeIdUpdate									UNIQUEIDENTIFIER
						DECLARE			@Rows													INT
						DECLARE			@ModifiedBy												VARCHAR(256) = 'SelecticaCable'


						SELECT			@EventLogTypeIdError									= EventLogTypeId FROM dbo.EventLogType WITH (NOLOCK) WHERE Name = 'Error'
						SELECT			@EventLogTypeIdUpdate									= EventLogTypeId FROM dbo.EventLogType WITH (NOLOCK) WHERE Name = 'DR Update - AttachmentId Creation'
						IF				( @UserId IS NULL )
										SELECT	@UserId  										= UserId
										FROM	dbo.Users WITH (NOLOCK) 
										WHERE	UserName										= @ModifiedBy
						ELSE
										SELECT	@ModifiedBy										= UserName
										FROM	dbo.Users WITH (NOLOCK) 
										WHERE	UserId											= @UserId


						SELECT			TOP 1 @EventId											= EventId
						FROM			dbo.DR e
						WHERE			e.DRId													= @DRId	
						SELECT			@Rows													= @@ROWCOUNT

						IF				( @Rows = 0 )
						BEGIN
										EXEC		dbo.GetEventStatus
															@StatusName							= 'Invalid DRId',
															@StatusTypeName						= @StatusTypeName OUTPUT,
															@StatusId							= @Status OUTPUT,
															@StatusMessage						= @StatusMessage OUTPUT
										SELECT 				@StatusMessage						= 'Invalid DRId' + @StatusMessage
										RETURN
						END

						IF				( @ModifiedBy IS NULL )
						BEGIN
										EXEC		dbo.GetEventStatus
															@StatusName							= 'Invalid DR UserId',
															@StatusTypeName						= @StatusTypeName OUTPUT,
															@StatusId							= @Status OUTPUT,
															@StatusMessage						= @StatusMessage OUTPUT
										SELECT 				@StatusMessage						= 'Invalid DR UserId' + @StatusMessage
										RETURN
						END

						--				default Document Date to today's date
						IF				( @DocumentDate IS NULL )
										SET			@DocumentDate								= GETDATE()

						--				Assign AttachmentID, if not provided
						IF				( ISNULL(@AttachmentId,@EmptyGUID) = @EmptyGUID )
										SET			@AttachmentId								= NEWID()

						BEGIN TRY

										BEGIN TRANSACTION



										--Insert/Update Attachment/DRAttachment
										IF EXISTS (SELECT TOP 1 1 FROM dbo.Attachment WITH (NOLOCK) WHERE AttachmentId = @AttachmentId)
										BEGIN

													EXEC		dbo.SaveAttachment
																	@AttachmentId				= @AttachmentId,
																	@DocumentDate 				= @DocumentDate,
																	@FileName 					= @FileName,
																	@FileExtension 				= @FileExtension,
																	@Note 						= @Note,
																	@ModifiedBy 				= @ModifiedBy,
																	@BlobData 					= @BlobData,
																	@AttachmentType 			= 0,				-- We don't care about the ancillary Attachment tables yet.
																	@TypeID 					= @EmptyGUID,
																	@DocumentVersionId 			= @EmptyGUID,
																	@DocumentSubTypeId 			= @EmptyGUID,
																	@Complete 					= 0,
																	@DocumentType 				= @EmptyGUID

													IF			NOT EXISTS (SELECT TOP 1 1 FROM dbo.DRAttachment WITH (NOLOCK) WHERE AttachmentId = @AttachmentId AND DRId = @DRId)
																INSERT		dbo.DRAttachment ( AttachmentId,AttachmentTypeId,DRId,DRServiceId )
																SELECT		@AttachmentId,@AttachmentTypeId,@DRId,@DRServiceId
													ELSE
																UPDATE		dbo.DRAttachment
																SET			AttachmentTypeId	= @AttachmentTypeId,
																			DRServiceId			= ISNULL(@DRServiceId,DRServiceId),
																			Updated				= GETDATE()
																WHERE		AttachmentId		= @AttachmentId
																AND			DRId				= @DRId

										END
										ELSE
										BEGIN


													EXEC		dbo.SaveAttachment
																	@AttachmentId				= @AttachmentId,
																	@DocumentDate 				= @DocumentDate,
																	@FileName 					= @FileName,
																	@FileExtension 				= @FileExtension,
																	@Note 						= @Note,
																	@ModifiedBy 				= @ModifiedBy,
																	@BlobData 					= @BlobData,
																	@AttachmentType 			= 0,				-- We don't care about the ancillary Attachment tables yet.
																	@TypeID 					= @EmptyGUID,
																	@DocumentVersionId 			= @EmptyGUID,
																	@DocumentSubTypeId 			= @EmptyGUID,
																	@Complete 					= 0,
																	@DocumentType 				= @EmptyGUID

													INSERT		dbo.DRAttachment ( AttachmentId,AttachmentTypeId,DRId,DRServiceId )
													SELECT		@AttachmentId,@AttachmentTypeId,@DRId,@DRServiceId


										END

										EXEC		dbo.InsertEventLog
															@EventLogTypeId						= @EventLogTypeIdUpdate,
															@EventId							= @EventId,
															@UserId								= @UserId

										COMMIT

										EXEC		dbo.GetEventStatus
															@StatusName							= 'Success',
															@StatusTypeName						= @StatusTypeName OUTPUT,
															@StatusId							= @Status OUTPUT,
															@StatusMessage						= @StatusMessage OUTPUT
										SELECT 		@StatusMessage								= NULL

						END TRY
						BEGIN CATCH
										IF @@TRANCOUNT > 0
										BEGIN
													ROLLBACK TRANSACTION
										END
										SELECT		@StatusTypeName								= 'Error',
													@Status										= CASE WHEN ERROR_NUMBER() = 0 THEN -99 ELSE ERROR_NUMBER() END, 
													@StatusMessage								= ERROR_MESSAGE()

										EXEC		dbo.InsertEventLog
														@EventLogTypeId							= @EventLogTypeIdError,
														@EventId								= @EventId,
														@UserId									= @UserId,
														@Comment								= @StatusMessage

						END CATCH
END

GO


