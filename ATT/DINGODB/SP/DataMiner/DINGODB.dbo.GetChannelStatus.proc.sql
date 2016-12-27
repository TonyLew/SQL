Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.GetChannelStatus'), 0) > 0 
	DROP PROCEDURE dbo.GetChannelStatus
GO


CREATE PROCEDURE [dbo].[GetChannelStatus]
		@RegionID			UDT_Int READONLY,
		@MarketID			UDT_Int READONLY,
		@Channel_IUID		UDT_Int READONLY,
		@ROCID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
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
// Module:  dbo.GetChannelStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Channel Status and all accompanying information based on the applied filters.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetChannelStatus.proc.sql 4284 2014-05-27 17:06:21Z tlew $
//    
//	 Usage:
//
//				DECLARE @Region_TBL			UDT_Int
//				DECLARE @Market_TBL			UDT_Int
//				DECLARE @Channel_IU_TBL		UDT_Int
//				DECLARE @ROC_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//
//				INSERT	@Market_TBL (Value) VALUES (0)
//				INSERT	@Market_TBL (Value) VALUES (1)
//				INSERT	@Market_TBL (Value) VALUES (47)
//				
//				EXEC	dbo.GetChannelStatus 
//						--@RegionID = @Region_TBL, 
//						@MarketID = @Market_TBL,
//						--@Channel_IUID = @Channel_IU_TBL,
//						--@ROCID = @ROC_TBL, 
//						@Return = @ReturnValue OUTPUT
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE				@RegionID_COUNT INT
		DECLARE				@MarketID_COUNT INT
		DECLARE				@Channel_IUID_COUNT INT
		DECLARE				@ROCID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @MarketID_COUNT = ID FROM @MarketID
		SELECT				TOP 1 @Channel_IUID_COUNT = ID FROM @Channel_IUID
		SELECT				TOP 1 @ROCID_COUNT = ID FROM @ROCID


		SELECT
							Regionalized_IU											= IU.REGIONALIZED_IU_ID,
							Region													= r.Name,
							SDB														= sdb.SDBComputerNamePrefix,
							Channel_Name											= CAST(IU.CHANNEL_NAME AS VARCHAR(40)),
							Market													= mkt.Name,											--It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
							Zone													= zm.ZONE_NAME,
							Network													= net.NAME,
							TSI 													= IU.COMPUTER_NAME,
							ICProvider  											= IC.Name,
							ROC 													= ROC.Name,
							Consecutive_NoTone_Count								= a.Consecutive_NoTone_Count,
							Consecutive_Error_Count									= a.Consecutive_Error_Count,
							Average_BreakCount										= a.Average_BreakCount,
							Total_Insertions_Today									= a.TotalInsertionsToday,							--Int	The total number of scheduled insertions
							Total_Insertions_NextDay								= a.TotalInsertionsNextDay,							--Int	The total number of scheduled insertions for tomorrow
							DTM_Total_Insertions									= a.DTM_Total,										--Int	Day-to-moment attempted insertions
							DTM_Successful_Insertions								= a.DTM_Played,										--Int	Day-to-moment successful insertions
							DTM_Failed_Insertions									= a.DTM_Failed,										--Int	Day-to-moment failed insertions including NoTones
							DTM_NoTone_Insertions									= a.DTM_NoTone,										--Int	Day-to-moment insertions with NoTone
							MTE_Insertions_In_Dispatch								= 0,												--Int	
							MTE_Insertion_Conflicts									= a.MTE_Conflicts,									--Int	Moment-to-end insertion conflicts
							First_Insertion_Conflicts								= a.MTE_Conflicts_Window1,							--Int	Moment-to-end insertion conflicts in time window1
							Second_Insertion_Conflicts								= a.MTE_Conflicts_Window2,							--Int	Moment-to-end insertion conflicts in time window2
							Third_Insertion_Conflicts								= a.MTE_Conflicts_Window3,							--Int	Moment-to-end insertion conflicts in time window3
							First_Conflicts_NextDay									= 0,												--Int	
							Insertion_Conflicts_NextDay								= a.ConflictsNextDay,								--Int	The number of insertion conflicts for tomorrow
							Break_Conflicts											= 0,												--Int	
							Break_Conflicts_NextDay									= 0,												--Int	

							ATT_Total_Insertions_Today								= a.ATTTotal,										--Int	AT&T total number of scheduled insertions
							ATT_Total_Insertions_NextDay							= a.ATTTotalNextDay,								--Int	AT&T total number of scheduled insertions for tomorrow
							ATT_DTM_Total_Insertions								= a.DTM_ATTTotal,									--Int	AT&T Day-to-moment attempted insertions
							ATT_DTM_Successful_Insertions							= a.DTM_ATTPlayed,									--Int	AT&T Day-to-moment successful insertions
							ATT_DTM_Failed_Insertions								= a.DTM_ATTFailed,									--Int	AT&T Day-to-moment failed insertions including NoTones
							ATT_DTM_NoTone_Insertions								= a.DTM_ATTNoTone,									--Int	AT&T Day-to-moment insertions with NoTone
							ATT_MTE_Insertion_Conflicts								= a.MTE_ATTConflicts,								--Int	AT&T Moment-to-end insertion conflicts
							ATT_First_Insertion_Conflicts							= a.MTE_ATTConflicts_Window1,						--Int	AT&T Moment-to-end insertion conflicts in time window1
							ATT_Second_Insertion_Conflicts							= a.MTE_ATTConflicts_Window2,						--Int	AT&T Moment-to-end insertion conflicts in time window2
							ATT_Third_Insertion_Conflicts							= a.MTE_ATTConflicts_Window3,						--Int	AT&T Moment-to-end insertion conflicts in time window3
							ATT_First_Conflicts_NextDay								= 0,												--Int	
							ATT_Insertion_Conflicts_NextDay							= a.ATTConflictsNextDay,							--Int	The number of AT&T insertion conflicts for tomorrow
							ATT_BreakCount											= a.ATT_BreakCount,
							ATT_LastSchedule_Load									= a.ATT_LastSchedule_Load,
							ATT_LastSchedule_Received								= GETDATE(),										--DateTime	
							ATT_WrongPrefix											= 0,												--Int	
							ATT_WrongDuration										= 0,												--Int	
							ATT_WrongFormat											= 0,												--Int	
							ATT_NextDay_BreakCount									= a.ATT_NextDay_BreakCount,
							ATT_NextDay_LastSchedule_Load							= a.ATT_NextDay_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Received						= GETDATE(),										--DateTime	
							ATT_NextDay_WrongPrefix									= 0,												--Int	
							ATT_NextDay_WrongDuration								= 0,												--Int	
							ATT_NextDay_WrongFormat									= 0,												--Int	
							ATT_LastVERReport_Generated								= GETDATE(),										--DateTime	
							ATT_LastVERReport_RecordCount							= 0,												--Int	
							ATT_Yesterdays_BreakCount								= 0,												--Int	

							IC_Total_Insertions_Today								= a.ICTotal,										--Int	IC total number of scheduled insertions
							IC_Total_Insertions_NextDay								= a.ICTotalNextDay,									--Int	IC total number of scheduled insertions for tomorrow
							IC_DTM_Total_Insertions									= a.DTM_ICTotal,									--Int	IC Day-to-moment attempted insertions
							IC_DTM_Successful_Insertions							= a.DTM_ICPlayed,									--Int	IC Day-to-moment successful insertions
							IC_DTM_Failed_Insertions								= a.DTM_ICFailed,									--Int	IC Day-to-moment failed insertions including NoTones
							IC_DTM_NoTone_Insertions								= a.DTM_ICNoTone,									--Int	IC Day-to-moment insertions with NoTone
							IC_MTE_Insertion_Conflicts								= a.MTE_ICConflicts,								--Int	IC Moment-to-end insertion conflicts
							IC_First_Insertion_Conflicts							= a.MTE_ICConflicts_Window1,						--Int	IC Moment-to-end insertion conflicts in time window1
							IC_Second_Insertion_Conflicts							= a.MTE_ICConflicts_Window2,						--Int	IC Moment-to-end insertion conflicts in time window2
							IC_Third_Insertion_Conflicts							= a.MTE_ICConflicts_Window3,						--Int	IC Moment-to-end insertion conflicts in time window3
							IC_First_Conflicts_NextDay								= 0,												--Int	
							IC_Insertion_Conflicts_NextDay							= a.ICConflictsNextDay,								--Int	The number of IC insertion conflicts for tomorrow
							IC_BreakCount											= a.IC_BreakCount,
							IC_LastSchedule_Load									= a.IC_LastSchedule_Load,
							IC_LastSchedule_Received								= GETDATE(),										--DateTime	
							IC_WrongPrefix											= 0,												--Int	
							IC_WrongDuration										= 0,												--Int	
							IC_WrongFormat											= 0,												--Int	
							IC_NextDay_BreakCount									= a.IC_NextDay_BreakCount,
							IC_NextDay_LastSchedule_Load							= a.IC_NextDay_LastSchedule_Load,
							IC_NextDay_LastSchedule_Received						= GETDATE(),										--DateTime	
							IC_NextDay_WrongPrefix									= 0,												--Int	
							IC_NextDay_WrongDuration								= 0,												--Int	
							IC_NextDay_WrongFormat									= 0,												--Int	
							IC_LastVERReport_Generated								= GETDATE(),										--DateTime	
							IC_LastVERReport_RecordCount							= 0,												--Int	
							IC_Yesterdays_BreakCount								= 0													--Int	





							--Old Columns
							--IC_DTM_Run_Rate											= a.IC_DTM_Run_Rate,
							--IC_Forecast_Best_Run_Rate								= a.IC_Forecast_Best_Run_Rate,
							--IC_Forecast_Worst_Run_Rate								= a.IC_Forecast_Worst_Run_Rate,
							--IC_NextDay_Forecast_Run_Rate							= a.IC_NextDay_Forecast_Run_Rate,
							--IC_DTM_NoTone_Rate										= a.IC_DTM_NoTone_Rate,
							--IC_DTM_Failed_Rate										= a.IC_DTM_Failed_Rate,
							--DTM_Run_Rate											= a.DTM_Run_Rate,
							--Forecast_Best_Run_Rate									= a.Forecast_Best_Run_Rate,
							--Forecast_Worst_Run_Rate									= a.Forecast_Worst_Run_Rate,
							--NextDay_Forecast_Run_Rate								= a.NextDay_Forecast_Run_Rate,
							--DTM_NoTone_Rate											= a.DTM_NoTone_Rate,
							--DTM_Failed_Rate											= a.DTM_Failed_Rate,
							--ATT_DTM_Run_Rate										= a.ATT_DTM_Run_Rate,
							--ATT_Forecast_Best_Run_Rate								= a.ATT_Forecast_Best_Run_Rate,
							--ATT_Forecast_Worst_Run_Rate								= a.ATT_Forecast_Worst_Run_Rate,
							--ATT_NextDay_Forecast_Run_Rate							= a.ATT_NextDay_Forecast_Run_Rate,
							--ATT_DTM_NoTone_Rate										= a.ATT_DTM_NoTone_Rate,
							--ATT_DTM_Failed_Rate										= a.ATT_DTM_Failed_Rate,

		FROM				dbo.ChannelStatus a (NOLOCK)
		JOIN				(
									SELECT		x.SDBSourceID
									FROM		dbo.SDB_Market x (NOLOCK)
									LEFT JOIN	@MarketID y
									ON			x.MarketID							= y.Value
									WHERE		x.Enabled							= 1
									AND			(		y.Value						IS NOT NULL
													OR	@MarketID_COUNT				IS NULL
												)
									GROUP BY	x.SDBSourceID
							) f
		ON					a.SDBSourceID											= f.SDBSourceID
		JOIN				dbo.SDBSource sdb (NOLOCK)
		ON					a.SDBSourceID											= sdb.SDBSourceID
		JOIN				dbo.MDBSource mdb (NOLOCK)
		ON					sdb.MDBSourceID											= mdb.MDBSourceID
		JOIN				dbo.Region r (NOLOCK)
		ON					mdb.RegionID											= r.RegionID
		JOIN				dbo.REGIONALIZED_IU IU (NOLOCK)
		ON					a.IU_ID													= IU.IU_ID
		AND					r.RegionID												= IU.REGIONID
		JOIN				dbo.REGIONALIZED_NETWORK_IU_MAP netmap (NOLOCK)
		ON					IU.REGIONALIZED_IU_ID									= netmap.REGIONALIZED_IU_ID
		JOIN				dbo.REGIONALIZED_NETWORK net (NOLOCK)
		ON					netmap.REGIONALIZED_NETWORK_ID							= net.REGIONALIZED_NETWORK_ID
		JOIN				dbo.REGIONALIZED_ZONE z (NOLOCK)
		ON					a.RegionalizedZoneID									= z.REGIONALIZED_ZONE_ID
		JOIN				dbo.ZONE_MAP zm (NOLOCK)								--It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
		ON					z.ZONE_NAME												= zm.ZONE_NAME
		LEFT JOIN			dbo.ROC ROC (NOLOCK)
		ON					zm.ROCID												= ROC.ROCID
		LEFT JOIN			dbo.Market mkt (NOLOCK)
		ON					zm.MarketID												= mkt.MarketID
		LEFT JOIN			dbo.ICProvider IC (NOLOCK) 
		ON					zm.ICProviderID											= IC.ICProviderID
		WHERE				a.Enabled												= 1
		AND					( EXISTS(SELECT TOP 1 1 FROM @RegionID					WHERE Value = r.RegionID)					OR @RegionID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @MarketID					WHERE Value = mkt.MarketID)					OR @MarketID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @Channel_IUID				WHERE Value = IU.REGIONALIZED_IU_ID)		OR @Channel_IUID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @ROCID						WHERE Value = zm.ROCID)						OR @ROCID_COUNT IS NULL )
		ORDER BY			mkt.Name,												--AS Market
							net.NAME,												--AS Network
							zm.ZONE_NAME											--AS Zone


		SET					@Return = @@ERROR


END


GO


