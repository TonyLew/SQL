



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimSpotConflictStatus'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimSpotConflictStatus
GO

CREATE PROCEDURE dbo.ETLDimSpotConflictStatus 
AS
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
// Module:  dbo.ETLDimSpotConflictStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimSpotConflictStatus table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimSpotConflictStatus.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimSpotConflictStatus	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON

				DECLARE				@Total														INT
				
				INSERT				dbo.DimSpotConflictStatus ( SpotConflictStatusID,SpotConflictStatusValue )
				SELECT				t.SpotConflictStatusID, 
									t.SpotConflictStatusValue
				FROM			(
									SELECT				DISTINCT 
														SpotConflictStatusID					= CONFLICT_STATUS, 
														SpotConflictStatusValue					= CONFLICT_STATUSValue
									FROM				#tmp_AllSpots x
									WHERE				x.NSTATUS								IS NOT NULL
								) t
				LEFT JOIN			dbo.DimSpotConflictStatus d
				ON					t.SpotConflictStatusID										= d.SpotConflictStatusID
				AND					t.SpotConflictStatusValue									= d.SpotConflictStatusValue
				WHERE				d.SpotConflictStatusID										IS NULL
				SELECT				@Total														= @@ROWCOUNT

				--IF					( @Total > 0 )
				--BEGIN
					--Insert into DINGODB.dbo.EventLog table.
				--END


END
GO


