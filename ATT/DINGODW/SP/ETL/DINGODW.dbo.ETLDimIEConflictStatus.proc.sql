



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimIEConflictStatus'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimIEConflictStatus
GO

CREATE PROCEDURE dbo.ETLDimIEConflictStatus 
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
// Module:  dbo.ETLDimIEConflictStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimIEConflictStatus table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimIEConflictStatus.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimIEConflictStatus	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON

				DECLARE				@Total														INT
				
				INSERT				dbo.DimIEConflictStatus ( IEConflictStatusID,IEConflictStatusValue )
				SELECT				t.IEConflictStatusID, 
									t.IEConflictStatusValue
				FROM			(
									SELECT				DISTINCT 
														IEConflictStatusID						= CONFLICT_STATUS, 
														IEConflictStatusValue					= CONFLICT_STATUSValue
									FROM				#tmp_AllSpots x
									WHERE				x.NSTATUS								IS NOT NULL
								) t
				LEFT JOIN			dbo.DimIEConflictStatus d
				ON					t.IEConflictStatusID										= d.IEConflictStatusID
				AND					t.IEConflictStatusValue										= d.IEConflictStatusValue
				WHERE				d.IEConflictStatusID										IS NULL
				SELECT				@Total														= @@ROWCOUNT

				--IF					( @Total > 0 )
				--BEGIN
					--Insert into DINGODB.dbo.EventLog table.
				--END


END
GO


