
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveConflict'), 0) > 0 
	DROP PROCEDURE dbo.SaveConflict
GO

CREATE PROCEDURE [dbo].[SaveConflict]
		@SDBSourceID		INT,
		@SDBUTCOffset		INT,
		@ErrorID			INT = 0 OUTPUT
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
// Module:  dbo.SaveConflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Saves Conflict of the logical SDB.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveConflict.proc.sql 3495 2014-02-12 17:28:01Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveConflict 
//								@SDBSourceID		= 1,
//								@SDBUTCOffset		= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		
		DECLARE				@RegionID		INT
		DECLARE				@NowSDBTime		DATETIME
		
		SELECT				@NowSDBTime		= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
		SET					@ErrorID												= 1

		IF		ISNULL(OBJECT_ID('tempdb..#Conflict'), 0) > 0 
				DROP TABLE		#Conflict

		CREATE TABLE	#Conflict 
						(
							ID INT Identity(1,1),
							SDBSourceID INT,
							IU_ID INT,
							SPOT_ID INT,
							ASSET_ID VARCHAR(32),
							ASSET_DESC VARCHAR(334),
							AWIN_END_DT DATETIME,
							SCHED_DATE_TIME DATETIME,
							SPOT_NSTATUS INT
						)


		SELECT				TOP 1 @RegionID											= RegionID
		FROM				dbo.SDBSource s (NOLOCK)
		JOIN				dbo.MDBSource m (NOLOCK)
		ON					s.MDBSourceID											= m.MDBSourceID
		WHERE				s.SDBSourceID											= @SDBSourceID					


		INSERT				#Conflict 
								(
									SDBSourceID,
									IU_ID,
									SPOT_ID,
									ASSET_ID,
									ASSET_DESC,
									AWIN_END_DT,
									SCHED_DATE_TIME,
									SPOT_NSTATUS
								)
		SELECT				@SDBSourceID											AS SDBSourceID,
							y.IU_ID,
							y.SPOT_ID,
							y.VIDEO_ID												AS ASSET_ID,
							y.ASSET_DESC,
							y.AWIN_END_DT,
							y.SCHED_DATE_TIME,
							y.SPOT_NSTATUS
		FROM				dbo.ChannelStatus w (NOLOCK)
		JOIN				#ImportIE_SPOT y 
		ON					w.SDBSourceID											= y.SDBSourceID
		AND					w.IU_ID													= y.IU_ID
		WHERE				w.SDBSourceID											= @SDBSourceID
		AND					y.SPOT_RUN_DATE_TIME									IS NULL
		AND					y.AWIN_END_DT											>= @NowSDBTime
		AND					(
								y.SPOT_NSTATUS										= 1 
							OR y.SPOT_NSTATUS										>= 6
							)


		--					Delete channels where the channel did NOT come back on the SDB import
		DELETE				a
		FROM				dbo.Conflict a
		LEFT JOIN			#ImportIE_SPOT b
		ON					a.SDBSourceID											= b.SDBSourceID
		AND					a.IU_ID													= b.IU_ID
		AND					a.SPOT_ID												= b.SPOT_ID
		WHERE				a.SDBSourceID											= @SDBSourceID
		AND					b.ImportIE_SPOTID										IS NULL


		DELETE				a
		FROM				dbo.Conflict a
		JOIN				#ImportIE_SPOT b 
		ON					a.SDBSourceID											= b.SDBSourceID
		AND					a.IU_ID													= b.IU_ID
		AND					a.SPOT_ID												= b.SPOT_ID
		WHERE				a.SDBSourceID											= @SDBSourceID
		AND					a.IU_ID													= b.IU_ID
		AND					a.SPOT_ID												= b.SPOT_ID
		AND					(
								b.SPOT_RUN_DATE_TIME								IS NOT NULL
							OR b.AWIN_END_DT										< @NowSDBTime
							OR b.SPOT_NSTATUS										BETWEEN 2 and 5
							OR 														((b.SPOT_NSTATUS = 1) AND (b.IE_NSTATUS	= 4))
							)



		INSERT				dbo.Conflict 
								(
									SDBSourceID,
									IU_ID,
									SPOT_ID,
									Time,
									UTCTime,
									Asset_ID,
									Asset_Desc,
									Conflict_Code,
									Scheduled_Insertions,
									CreateDate,
									UpdateDate
								)
		SELECT					
							@SDBSourceID											AS SDBSourceID,
							a.IU_ID,
							a.SPOT_ID,
							a.SCHED_DATE_TIME										AS Time,
							DATEADD(HOUR,@SDBUTCOffset*(-1),a.SCHED_DATE_TIME)		AS UTCTime,
							a.Asset_ID												AS Asset_ID,
							a.ASSET_DESC											AS Asset_Desc,
							a.SPOT_NSTATUS											AS Conflict_Code,
							b.Scheduled_Insertions									AS Scheduled_Insertions,
							GETUTCDATE()											AS CreateDate,
							GETUTCDATE()											AS UpdateDate
		FROM				#Conflict a
		LEFT JOIN			(
									SELECT		Asset_ID, COUNT(1) AS Scheduled_Insertions
									FROM		#Conflict x
									GROUP BY	Asset_ID
							) b 
		ON					a.Asset_ID												= b.Asset_ID
		LEFT JOIN			dbo.Conflict c 
		ON					a.SDBSourceID											= c.SDBSourceID
		AND					a.IU_ID													= c.IU_ID
		AND					a.SPOT_ID												= c.SPOT_ID
		WHERE				c.ConflictID											IS NULL
		SET					@ErrorID												= 0		--SUCCESS

		DROP TABLE			#Conflict

END



GO

