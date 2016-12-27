



select TOP 100 
transactiondate, DimCustomerId
from dbo.FactTransaction
group by transactiondate, DimCustomerId
order by transactiondate, DimCustomerId

select * from dbo.FactTransactionMonthly
select COUNT(1) from dbo.FactTransactionMonthly

select COUNT(1) from dbo.FactTransaction	--1948		4695
select COUNT(1) from dbo.DimCreditCardType	--6
select COUNT(1) from dbo.DimCustomer		--200

select * from dbo.StgTransaction		--200


FactTransactionMonthly

select * from dbo.StgCustomerD1		--200
select * from dbo.STGCustomer		--200
where customerid = '4266961000081701'

select * from dbo.DimCustomer		--200
where customerid = '4266961000081701'
order by customerid 
4266961000081701	2/5/2003	Non-Quickbooks	IMS	DECLINED



--drop table FactTransaction
--drop table DimCreditCardType
--drop table DimCustomer


