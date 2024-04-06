select * from sales;
select SaleDate, Amount, Customers, Boxes from sales;

#finding the amount per boxes of sale
select SaleDate, Amount, Customers, Boxes , Amount/Boxes as 'Amount Per Box'  from sales;

#finding the orders with amount above 10000
select * from sales
where Amount > 10000 order by Amount desc;

#showing only item with a specific id and ordering by amount in ascending
select * from sales 
where GeoID='G1'
order by PID, Amount ASC; 

#showing items with above 10000 in amount and also with saledate after a certain date
select * from sales
where amount > 10000, and SaleDate >= '2022-01-01'

#finding boxes with a range
select * from sales 
where boxes between 0 and 50;

#showing the sale for weekday eg: friday
select  Amount, Boxes , SaleDate , weekday(saledate) as ' day of the week '
from sales where weekday(saledate)=4;

#finding the sales person name with a beginning letter 'b'
select * from people
where Salesperson like 'b%';

#finding the sales person name with a letter 'b' inside 
select * from people
where Salesperson like '%b%';

#categorising the sale according to the amount 

select Amount, SaleDate,

	case when Amount < 1000 then ' less than 1k' 
		 when Amount < 5000 then ' less than 5k' 
		 when Amount < 10000 then ' less than 10k' 
         else '10k or more'
         end as 'amount category'
	from sales;
         



