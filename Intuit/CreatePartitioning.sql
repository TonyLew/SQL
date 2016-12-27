

/*

-- Creates a partition function called myRangePF1 that will partition a table into four partitions  
CREATE PARTITION FUNCTION myRangePF1 (int)  
    AS RANGE LEFT FOR VALUES (1, 100, 1000) ;  
GO  
-- Creates a partition scheme called myRangePS1 that applies myRangePF1 to the four filegroups created above  
CREATE PARTITION SCHEME myRangePS1  
    AS PARTITION myRangePF1  
    TO (test1fg, test2fg, test3fg, test4fg) ;  
GO  
-- Creates a partitioned table called PartitionTable that uses myRangePS1 to partition col1  
CREATE TABLE PartitionTable (col1 int PRIMARY KEY, col2 char(10))  
    ON myRangePS1 (col1) ;  
GO  


*/

-- drop partition function myRangePF1
-- Creates a partition function called myRangePF1 that will partition a table into four partitions  
CREATE PARTITION FUNCTION DateRangePF (date)  
    AS RANGE LEFT FOR VALUES ('2015-01-01', '2016-01-01', '2017-01-01') ;  
GO  
-- Creates a partition scheme called myRangePS1 that applies myRangePF1 to the four filegroups created above  
CREATE PARTITION SCHEME DateRangePS
    AS PARTITION DateRangePF  
    TO ( [Primary], [Primary], [Primary], [Primary] ) ;  
GO  


