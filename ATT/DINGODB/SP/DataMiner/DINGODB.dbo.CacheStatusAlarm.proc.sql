
Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.CacheStatusAlarm'), 0) > 0 
	DROP PROCEDURE dbo.CacheStatusAlarm
GO

CREATE PROCEDURE [dbo].[CacheStatusAlarm]
		@MDBName			VARCHAR(32) = 'TestMDBAlarm',
		@SDBName			VARCHAR(32) = 'TestSDBAlarm',
		@Action				VARCHAR(32)
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
// Module:  dbo.CacheStatusAlarm
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Saves Cache Status of the logical SDB for the given cache type.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CacheStatusAlarm.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC		dbo.CacheStatusAlarm 
//								@MDBName			= 'TestMDBAlarm',
//								@SDBName			= 'TestSDBAlarm',
//								@Action				= 'Alarm'  --Possible types: Alarm, NoAlarm, Delete
//
*/ 
-- =============================================
BEGIN


			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SET NOCOUNT ON;

			DECLARE			@CacheStatusTypeID		INT
			DECLARE			@RegionID				INT
			DECLARE			@MDBSourceID			INT
			DECLARE			@SDBSourceID			INT
		

			SELECT			TOP 1 @RegionID										= RegionID
			FROM			dbo.Region (NOLOCK) 
			WHERE			Name												= 'Test Region' 

			SELECT			TOP 1 @MDBSourceID									= MDBSourceID
			FROM			dbo.MDBSource (NOLOCK) 
			WHERE			MDBComputerNamePrefix								= @MDBName

			SELECT			TOP 1 @SDBSourceID									= SDBSourceID			
			FROM			dbo.SDBSource a (NOLOCK)
			WHERE			a.SDBComputerNamePrefix								= @SDBName 

			IF				( @Action = 'Alarm' )
			BEGIN

							IF			EXISTS( SELECT TOP 1 1 FROM dbo.CacheStatus WHERE SDBSourceID = @SDBSourceID )
							BEGIN
										UPDATE		dbo.CacheStatus
										SET			UpdateDate					= DATEADD( DAY, -1, GETUTCDATE() )
										WHERE		SDBSourceID					= @SDBSourceID
							END
							ELSE
							BEGIN
										BEGIN TRAN

										IF			( @RegionID IS NULL )
										BEGIN
													INSERT	dbo.Region ( Name ) 
													SELECT	'Test Region'		AS Name
													SELECT	@RegionID			= SCOPE_IDENTITY()
										END

										IF			( @MDBSourceID IS NULL )
										BEGIN
													INSERT	dbo.MDBSource ( RegionID, MDBComputerNamePrefix, NodeID )
													SELECT	@RegionID			AS RegionID, 
															@MDBName			AS MDBComputerNamePrefix, 
															1					AS NodeID
													SELECT @MDBSourceID			= SCOPE_IDENTITY()
										END

										IF			( @SDBSourceID IS NULL )
										BEGIN
													INSERT		dbo.SDBSource ( MDBSourceID, SDBComputerNamePrefix, NodeID )
													SELECT		@RegionID AS RegionID, @SDBName AS MDBComputerNamePrefix, 1 AS NodeID
													SELECT		@SDBSourceID = SCOPE_IDENTITY()
										END

										INSERT		dbo.SDBSourceSystem ( SDBSourceID, SDBComputerName, Role, Status, Enabled )
										SELECT		x.*
										FROM		(
													SELECT		@SDBSourceID AS SDBSourceID, @SDBName + 'P' AS SDBComputerName, 1 AS Role, 1 AS Status, 1 AS Enabled UNION ALL
													SELECT		@SDBSourceID AS SDBSourceID, @SDBName + 'B' AS SDBComputerName, 2 AS Role, 1 AS Status, 1 AS Enabled 
													) x
										LEFT JOIN	dbo.SDBSourceSystem y (NOLOCK)
										ON			x.SDBSourceID = y.SDBSourceID
										WHERE		y.SDBSourceSystemID			IS NULL


										SELECT		TOP 1 @CacheStatusTypeID	= CacheStatusTypeID
										FROM		dbo.CacheStatusType (NOLOCK)

										INSERT		dbo.CacheStatus ( SDBSourceID, CacheStatusTypeID, UpdateDate )
										SELECT		@SDBSourceID				AS SDBSourceID, 
													@CacheStatusTypeID			AS CacheStatusTypeID, 
													GETUTCDATE()				AS UpdateDate

										COMMIT

							END
				END
				ELSE		IF ( @Action = 'NoAlarm' )
				BEGIN
										UPDATE		dbo.CacheStatus
										SET			UpdateDate					= GETUTCDATE()
										WHERE		SDBSourceID					= @SDBSourceID
				END
				ELSE		IF ( @Action = 'Delete' )
				BEGIN
										BEGIN TRAN

										DELETE		dbo.CacheStatus 
										WHERE		SDBSourceID					= @SDBSourceID

										DELETE		dbo.SDBSourceSystem 
										WHERE		SDBSourceID					= @SDBSourceID
										DELETE		dbo.SDBSource 
										WHERE		SDBSourceID					= @SDBSourceID

										DELETE		dbo.MDBSourceSystem 
										WHERE		MDBSourceID					= @MDBSourceID
										DELETE		dbo.MDBSource 
										WHERE		MDBSourceID					= @MDBSourceID

										DELETE		dbo.Region 
										WHERE		RegionID					= @RegionID

										COMMIT
				END


END


GO

