Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveZone'), 0) > 0 
	DROP PROCEDURE dbo.SaveZone
GO

CREATE PROCEDURE [dbo].[SaveZone]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
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
// Module:  dbo.SaveZone
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 			Upserts a SPOT Zone to DINGODB and regionalizes the zone by assigning a DINGODB zone id.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveZone.proc.sql 3495 2014-02-12 17:28:01Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveZone 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD						NVARCHAR(4000)
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						VARCHAR(200)
		DECLARE		@EventLogStatusID			INT = 1		--Unidentified Step
		DECLARE		@TempTableCount				INT
		DECLARE		@ZONECount					INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#DeletedZone'), 0) > 0 
				DROP TABLE		#DeletedZone

		CREATE TABLE	#DeletedZone
						(
							ID INT Identity(1,1),
							REGIONALIZED_ZONE_ID int,
							Zone_ID int,
							Zone_Name varchar(32)
						)


		IF		ISNULL(OBJECT_ID('tempdb..#Zones'), 0) > 0 
				DROP TABLE		#Zones

		CREATE TABLE	#Zones 
						(
							ID INT Identity(1,1),
							ZONE_ID int,
							ZONE_NAME varchar(32),
							DATABASE_SERVER_NAME varchar(32),
							DB_ID int,
							SCHEDULE_RELOADED int,
							MAX_DAYS int,
							MAX_ROWS int,
							TB_TYPE int,
							LOAD_TTL int,
							LOAD_TOD datetime,
							ASRUN_TTL int,
							ASRUN_TOD datetime,
							IC_ZONE_ID int,
							PRIMARY_BREAK int,
							SECONDARY_BREAK int,
							msrepl_tran_version uniqueidentifier
						)

		SET			@CMD			= 
		'INSERT		#Zones
					(
							ZONE_ID,
							ZONE_NAME,
							DATABASE_SERVER_NAME,
							DB_ID,
							SCHEDULE_RELOADED,
							MAX_DAYS,
							MAX_ROWS,
							TB_TYPE,
							LOAD_TTL,
							LOAD_TOD,
							ASRUN_TTL,
							ASRUN_TOD,
							IC_ZONE_ID,
							PRIMARY_BREAK,
							SECONDARY_BREAK,
							msrepl_tran_version
					)
		SELECT
							ZONE_ID,
							LTRIM(RTRIM(ZONE_NAME)),
							DATABASE_SERVER_NAME,
							DB_ID,
							SCHEDULE_RELOADED,
							MAX_DAYS,
							MAX_ROWS,
							TB_TYPE,
							LOAD_TTL,
							LOAD_TOD,
							ASRUN_TTL,
							ASRUN_TOD,
							IC_ZONE_ID,
							PRIMARY_BREAK,
							SECONDARY_BREAK,
							msrepl_tran_version
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.ZONE z WITH (NOLOCK) '

		--SELECT			@CMD

		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			--			Identify the IDs from the REGIONALIZED_ZONE table to be deleted
			INSERT		#DeletedZone 
					(
						REGIONALIZED_ZONE_ID,
						Zone_ID,
						Zone_Name
					)
			SELECT		a.REGIONALIZED_ZONE_ID,
						a.Zone_ID,
						a.Zone_Name
			FROM		REGIONALIZED_ZONE a WITH (NOLOCK)
			LEFT JOIN	#Zones b
			ON			a.ZONE_NAME								= b.ZONE_NAME
			WHERE		a.Region_ID								= @RegionID
			AND			b.ID									IS NULL
			

			--			Delete from the tables with FK constraints first
			DELETE		dbo.ChannelStatus
			FROM		#DeletedZone d
			WHERE		ChannelStatus.RegionalizedZoneID		= d.REGIONALIZED_ZONE_ID


			DELETE		dbo.REGIONALIZED_ZONE
			FROM		#DeletedZone d
			WHERE		REGIONALIZED_ZONE.REGION_ID				= @RegionID
			AND			REGIONALIZED_ZONE.REGIONALIZED_ZONE_ID	= d.REGIONALIZED_ZONE_ID


			UPDATE		dbo.REGIONALIZED_ZONE
			SET
						ZONE_ID									= z.ZONE_ID,
						DATABASE_SERVER_NAME					= z.DATABASE_SERVER_NAME,
						DB_ID									= z.DB_ID,
						SCHEDULE_RELOADED						= z.SCHEDULE_RELOADED,
						MAX_DAYS								= z.MAX_DAYS,
						MAX_ROWS								= z.MAX_ROWS,
						TB_TYPE									= z.TB_TYPE,
						LOAD_TTL								= z.LOAD_TTL,
						LOAD_TOD								= z.LOAD_TOD,
						ASRUN_TTL								= z.ASRUN_TTL,
						ASRUN_TOD								= z.ASRUN_TOD,
						IC_ZONE_ID								= z.IC_ZONE_ID,
						PRIMARY_BREAK							= z.PRIMARY_BREAK,
						SECONDARY_BREAK							= z.SECONDARY_BREAK,
						msrepl_tran_version						= z.msrepl_tran_version,
						UpdateDate								= GETUTCDATE()
			FROM		#Zones z
			WHERE		REGIONALIZED_ZONE.ZONE_NAME				= z.ZONE_NAME
			AND			REGIONALIZED_ZONE.REGION_ID				= @RegionID
			AND			REGIONALIZED_ZONE.msrepl_tran_version	<> z.msrepl_tran_version

			
			INSERT		dbo.REGIONALIZED_ZONE
						(
								REGION_ID,
								ZONE_MAP_ID,
								ZONE_ID,
								ZONE_NAME,
								DATABASE_SERVER_NAME,
								DB_ID,
								SCHEDULE_RELOADED,
								MAX_DAYS,
								MAX_ROWS,
								TB_TYPE,
								LOAD_TTL,
								LOAD_TOD,
								ASRUN_TTL,
								ASRUN_TOD,
								IC_ZONE_ID,
								PRIMARY_BREAK,
								SECONDARY_BREAK,
								msrepl_tran_version,
								CreateDate
						)
			SELECT
								@RegionID AS RegionID,
								z.ZONE_MAP_ID,
								y.ZONE_ID,
								y.ZONE_NAME,
								y.DATABASE_SERVER_NAME,
								y.DB_ID,
								y.SCHEDULE_RELOADED,
								y.MAX_DAYS,
								y.MAX_ROWS,
								y.TB_TYPE,
								y.LOAD_TTL,
								y.LOAD_TOD,
								y.ASRUN_TTL,
								y.ASRUN_TOD,
								y.IC_ZONE_ID,
								y.PRIMARY_BREAK,
								y.SECONDARY_BREAK,
								y.msrepl_tran_version,
								GETUTCDATE()
			FROM				#Zones y
			--JOIN				dbo.ZONE_MAP x (NOLOCK)
			--ON					y.ZONE_NAME = x.ZONE_NAME
			LEFT JOIN			(
										SELECT		b.ZONE_NAME, b.ZONE_MAP_ID
										FROM		dbo.REGIONALIZED_ZONE b (NOLOCK)
										WHERE		b.REGION_ID		= @RegionID
								) z
			ON					y.ZONE_NAME = z.ZONE_NAME
			WHERE				z.ZONE_NAME IS NULL
			ORDER BY			y.ID
						
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#Zones
		DROP TABLE		#DeletedZone

END



GO


