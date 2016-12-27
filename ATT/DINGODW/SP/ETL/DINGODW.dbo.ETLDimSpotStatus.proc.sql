



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimSpotStatus'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimSpotStatus
GO

CREATE PROCEDURE dbo.ETLDimSpotStatus 
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
// Module:  dbo.ETLDimSpotStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimSpotStatus table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimSpotStatus.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimSpotStatus	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON

				DECLARE				@Total														INT
				
				INSERT				dbo.DimSpotStatus ( SpotStatusID,SpotStatusValue )
				SELECT				t.SpotStatusID, 
									t.SpotStatusValue
				FROM			(
									SELECT				DISTINCT 
														SpotStatusID							= NSTATUS, 
														SpotStatusValue							= NSTATUSValue
									FROM				#tmp_AllSpots x
									WHERE				x.NSTATUS								IS NOT NULL
								) t
				LEFT JOIN			dbo.DimSpotStatus d
				ON					t.SpotStatusID												= d.SpotStatusID
				AND					t.SpotStatusValue											= d.SpotStatusValue
				WHERE				d.SpotStatusID												IS NULL
				SELECT				@Total														= @@ROWCOUNT

				--IF					( @Total > 0 )
				--BEGIN
					--Insert into DINGODB.dbo.EventLog table.
				--END


END
GO


