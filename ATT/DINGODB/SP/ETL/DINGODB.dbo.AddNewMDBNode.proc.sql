

Use DINGODB
GO

IF ISNULL(OBJECT_ID('dbo.AddNewMDBNode'), 0) > 0 
	DROP PROCEDURE dbo.AddNewMDBNode
GO

CREATE PROCEDURE dbo.AddNewMDBNode
		@MDBPrimaryName		NVARCHAR(50),
		@MDBSecondaryName	NVARCHAR(50),
		@RegionID			INT,
		@JobOwnerLoginName	NVARCHAR(100),
		@JobOwnerLoginPWD	NVARCHAR(100)
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
// Module:  dbo.AddNewMDBNode
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Adds a new MDB node (Primary and Backup) for a specified Region.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.AddNewMDBNode.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	dbo.AddNewMDBNode	
//								@MDBPrimaryName			= 'MSSNKNLMDB001P',
//								@MDBSecondaryName		= 'MSSNKNLMDB001B',
//								@RegionID				= 3,
//								@JobOwnerLoginName		= N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD		= N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SET NOCOUNT ON;

			DECLARE		@CMD NVARCHAR(1000)
			DECLARE		@i INT
			DECLARE		@NodeID INT
			DECLARE		@RegionIDPK INT
			DECLARE		@MDBNodeID INT
			DECLARE		@MDBSourceID INT
			DECLARE		@NewMDBSourceID INT
			DECLARE		@MDBComputerNamePrefix VARCHAR(50)
			DECLARE		@MDBTotalRowsResult INT
			DECLARE		@RegionName VARCHAR(50) = 'Region ' + CAST( @RegionID AS VARCHAR(50))

			IF			( ISNULL(@MDBPrimaryName, '') = '' OR ISNULL(@MDBSecondaryName, '') = '' )	RETURN

			SELECT		@MDBComputerNamePrefix		= dbo.DeriveDBPrefix	( @MDBPrimaryName, 'P' )

			IF			NOT EXISTS	(
									SELECT			TOP 1 1
									FROM			dbo.Region r (NOLOCK)
									WHERE 			r.Name				= @RegionName
								)
			BEGIN
						INSERT		dbo.Region ( Name )
						SELECT		y.Name
						FROM		dbo.Region x (NOLOCK)
						RIGHT JOIN	(
										SELECT	Name = 'Region ' + CAST( @RegionID AS VARCHAR(50))
									) y
						ON			x.Name								= y.Name
						WHERE		x.RegionID IS NULL
						SELECT		@RegionIDPK							= SCOPE_IDENTITY()
			END
			ELSE
						SELECT		TOP 1 @RegionIDPK					= r.RegionID
						FROM		dbo.Region r (NOLOCK)
						WHERE 		r.Name								= @RegionName


			--If the MDBLogical node already exists, then it must remain with its original region
			IF			NOT EXISTS	(	
										SELECT			TOP 1 1
										FROM			dbo.MDBSource m (NOLOCK)
										WHERE 			m.MDBComputerNamePrefix	= @MDBComputerNamePrefix
									)
			BEGIN			

						BEGIN TRY
									INSERT		dbo.MDBSource ( RegionID, MDBComputerNamePrefix, NodeID, JobName )
									SELECT		RegionID							= @RegionIDPK,
												MDBComputerNamePrefix				= @MDBComputerNamePrefix,
												NodeID								= SUBSTRING( @MDBComputerNamePrefix, LEN(@MDBComputerNamePrefix)-2, LEN(@MDBComputerNamePrefix)),
												JobName								= @RegionName + ' Job Executor' 
									SELECT		@MDBSourceID						= SCOPE_IDENTITY()

									INSERT		dbo.MDBSourceSystem ( MDBSourceID, MDBComputerName, Role, Status, Enabled )
									SELECT		
												MDBSourceID							= @MDBSourceID,
												MDBComputerName						= @MDBPrimaryName,
												Role								= 1,
												Status								= 1,
												Enabled								= 1
									UNION ALL
									SELECT
												MDBSourceID							= @MDBSourceID,
												MDBComputerName						= @MDBSecondaryName,
												Role								= 2,
												Status								= 1,
												Enabled								= 1
						END TRY
						BEGIN CATCH
						END CATCH

			END

			EXEC		dbo.CreateMDBLinkedServer	
												@MDBPrimaryName			= @MDBPrimaryName,
												@MDBSecondaryName		= @MDBSecondaryName,
												@JobOwnerLoginName		= @JobOwnerLoginName,
												@JobOwnerLoginPWD		= @JobOwnerLoginPWD


			EXEC		dbo.CreateMDBJob	
												@RegionID				= @RegionID, 
												@RegionIDPK				= @RegionIDPK, 
												@MDBName				= @MDBComputerNamePrefix,
												@JobOwnerLoginName		= @JobOwnerLoginName,
												@JobOwnerLoginPWD		= @JobOwnerLoginPWD



END


GO
