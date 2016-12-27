



USE DINGODW
GO

IF ISNULL(OBJECT_ID('dbo.ETLDimIEStatus'), 0) > 0 
	DROP PROCEDURE dbo.ETLDimIEStatus
GO

CREATE PROCEDURE dbo.ETLDimIEStatus 
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
// Module:  dbo.ETLDimIEStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populate DINGODW.dbo.DimIEStatus table which is definition table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGORS.dbo.ETLDimIEStatus.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				EXEC			dbo.ETLDimIEStatus	
//
*/ 
BEGIN



				SET					TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET					NOCOUNT ON

				DECLARE				@Total														INT
				
				INSERT				dbo.DimIEStatus ( IEStatusID,IEStatusValue )
				SELECT				t.IEStatusID, 
									t.IEStatusValue
				FROM			(
									SELECT				DISTINCT 
														IEStatusID								= NSTATUS, 
														IEStatusValue							= NSTATUSValue
									FROM				#tmp_AllSpots x
									WHERE				x.NSTATUS								IS NOT NULL
								) t
				LEFT JOIN			dbo.DimIEStatus d
				ON					t.IEStatusID												= d.IEStatusID
				AND					t.IEStatusValue												= d.IEStatusValue
				WHERE				d.IEStatusID												IS NULL
				SELECT				@Total														= @@ROWCOUNT

				--IF					( @Total > 0 )
				--BEGIN
					--Insert into DINGODB.dbo.EventLog table.
				--END


END
GO


