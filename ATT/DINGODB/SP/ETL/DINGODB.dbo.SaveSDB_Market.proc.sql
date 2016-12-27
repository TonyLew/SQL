Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.SaveSDB_Market'), 0) > 0 
	DROP PROCEDURE dbo.SaveSDB_Market
GO

CREATE PROCEDURE [dbo].[SaveSDB_Market]
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
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
// Module:  dbo.SaveSDB_Market
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Inserts an SDB to Market relationship to DINGODB and assigns the mapping with a DINGODB SDB_Market ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveSDB_Market.proc.sql 4178 2014-05-13 22:00:51Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveSDB_Market 
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'MSSNKNLSDB001P',
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


				DECLARE		@LogIDReturn			INT
				DECLARE		@ErrNum					INT
				DECLARE		@ErrMsg					VARCHAR(200)
				DECLARE		@EventLogStatusID		INT = 1		--Unidentified Step
				DECLARE		@TempTableCount			INT
				DECLARE		@ZONECount				INT
				DECLARE		@UnMappedMarketID		INT
				DECLARE		@RegionID				INT
				DECLARE		@TotalMissingIU			INT
				DECLARE		@TotalMissingSDBMarket	INT


				SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market First Step'
				SET			@ErrorID = 1
				SELECT		TOP 1 @UnMappedMarketID = MarketID FROM dbo.Market (NOLOCK) WHERE Name = 'n/a'

				EXEC		dbo.LogEvent 
									@LogID				= NULL,
									@EventLogStatusID	= @EventLogStatusID,
									@JobID				= @JobID,
									@JobName			= @JobName,
									@DBID				= @SDBSourceID,
									@DBComputerName		= @SDBName,
									@LogIDOUT			= @LogIDReturn OUTPUT


				SELECT		@RegionID					= r.RegionID 
				FROM		dbo.SDBSource s WITH (NOLOCK)
				JOIN		dbo.MDBSource m WITH (NOLOCK)
				ON			s.MDBSourceID				= m.MDBSourceID
				JOIN		dbo.Region r WITH (NOLOCK)
				ON			m.RegionID					= r.RegionID
				WHERE		s.SDBSourceID				= @SDBSourceID


				IF		ISNULL(OBJECT_ID('tempdb..#Missing_IU'), 0) > 0 
						DROP TABLE #Missing_IU

				CREATE TABLE #Missing_IU
					(
						[Missing_IUID] [int] IDENTITY(1,1) NOT NULL,
						[SDBSourceID] [int] NOT NULL,
						[ChannelStatusID] [int] NULL,
						[IU_ID] [int] NULL
					)


				IF		ISNULL(OBJECT_ID('tempdb..#Missing_SDBMarket'), 0) > 0 
						DROP TABLE #Missing_SDBMarket

				CREATE TABLE #Missing_SDBMarket
					(
						[Missing_SDBMarketID] [int] IDENTITY(1,1) NOT NULL,
						[SDBSourceID] [int] NOT NULL,
						[SDB_MarketID] [int] NULL,
						[MarketID] [int] NULL,
						[ZONE_NAME] [varchar](32) NULL
					)




				INSERT					#Missing_IU
									(
										SDBSourceID,
										ChannelStatusID,
										IU_ID
									)
				SELECT					SDBSourceID									= @SDBSourceID, 
										ChannelStatusID								= CS.ChannelStatusID, 
										IU_ID										= CS.IU_ID
				FROM					#ImportIE_SPOT IE
				RIGHT JOIN				dbo.ChannelStatus CS
				ON						IE.IU_ID									= CS.IU_ID
				AND						IE.SDBSourceID								= CS.SDBSourceID
				WHERE					IE.ImportIE_SPOTID							IS NULL
				AND						CS.SDBSourceID								= @SDBSourceID
				SELECT					@TotalMissingIU								= @@ROWCOUNT

				INSERT					#Missing_SDBMarket
									(
										SDBSourceID,
										SDB_MarketID,
										MarketID,
										ZONE_NAME
									)
				SELECT					SDBSourceID									= @SDBSourceID, 
										SDB_MarketID								= sm.SDB_MarketID, 
										MarketID									= sm.MarketID,
										ZONE_NAME									= x.ZONE_NAME
				FROM
									(
										SELECT			@SDBSourceID AS SDBSourceID, IU.ZONE_NAME, IU.REGIONID, z.MarketID
										FROM			#ImportIE_SPOT IE
										RIGHT JOIN		dbo.REGIONALIZED_IU  IU (NOLOCK)
										ON				IE.IU_ID					= IU.IU_ID
										JOIN			dbo.ZONE_MAP  z (NOLOCK)
										ON				IU.ZONE_NAME				= z.ZONE_NAME
										WHERE			IE.ImportIE_SPOTID			IS NULL
										AND				IU.REGIONID					= @RegionID
										GROUP BY		IU.ZONE_NAME, IU.REGIONID, z.MarketID
									) x
				JOIN					dbo.SDB_Market  sm (NOLOCK)
				ON						x.SDBSourceID								= sm.SDBSourceID
				AND						x.MarketID									= sm.MarketID
				SELECT					@TotalMissingSDBMarket						= @@ROWCOUNT


				IF			( @TotalMissingSDBMarket > 0 OR @TotalMissingIU > 0 )
				BEGIN


				BEGIN TRAN

							DELETE			dbo.ChannelStatus
							FROM			#Missing_IU x
							WHERE			ChannelStatus.ChannelStatusID			= x.ChannelStatusID
							AND				ChannelStatus.IU_ID						= x.IU_ID
							AND				ChannelStatus.SDBSourceID				= @SDBSourceID

							DELETE			dbo.SDB_Market
							FROM			#Missing_SDBMarket x
							WHERE			SDB_Market.SDB_MarketID					= x.SDB_MarketID
							AND				SDB_Market.MarketID						= x.MarketID
							AND				SDB_Market.SDBSourceID					= @SDBSourceID

				COMMIT


				END


				BEGIN TRY
							INSERT				dbo.SDB_Market ( SDBSourceID, MarketID, Enabled )
							SELECT				@SDBSourceID AS SDBSourceID, c.MarketID, 1 AS Enabled
 							FROM				(
													SELECT			@SDBSourceID AS SDBSourceID, IU.ZONE_NAME, IU.REGIONID
													FROM			#ImportIE_SPOT ie
													JOIN			dbo.REGIONALIZED_IU  IU (NOLOCK)
													ON				ie.IU_ID = IU.IU_ID
													GROUP BY		IU.ZONE_NAME, IU.REGIONID
												) a
							LEFT JOIN			dbo.ZONE_MAP c (NOLOCK)									--It is possible that the REGIONALIZED_ZONE.ZONE_NAME has not been mapped
							ON					a.ZONE_NAME												= c.ZONE_NAME
							LEFT JOIN			dbo.SDB_Market d (NOLOCK)
							ON					a.SDBSourceID											= d.SDBSourceID
							AND					c.MarketID												= d.MarketID
							WHERE				d.SDB_MarketID											IS NULL
							AND					c.MarketID												IS NOT NULL
							GROUP BY			c.MarketID

							SET			@ErrorID = 0
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market Success Step'
				END TRY
				BEGIN CATCH
							SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
							SET			@ErrorID = @ErrNum
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market Fail Step'
				END CATCH

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

				DROP TABLE #Missing_IU
				DROP TABLE #Missing_SDBMarket


END



GO


