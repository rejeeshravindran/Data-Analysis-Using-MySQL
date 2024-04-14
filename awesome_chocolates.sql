--Analysing the Business data from a chocolate company and finding valuable insights 


-- selecting all the items from the table 
select * from sales;
select SaleDate, Amount, Customers, Boxes from sales;

--finding the amount per boxes of sale
select SaleDate, Amount, Customers, Boxes , Amount/Boxes as 'Amount Per Box'  from sales;

--finding the orders with amount above 10000
select * from sales
where Amount > 10000 order by Amount desc;

--showing only item with a specific id and ordering by amount in ascending
select * from sales 
where GeoID='G1'
order by PID, Amount ASC; 

--showing items with above 10000 in amount and also with saledate after a certain date
select * from sales
where amount > 10000, and SaleDate >= '2022-01-01'

--finding boxes with a range
select * from sales 
where boxes between 0 and 50;

--showing the sale for weekday eg: friday
select  Amount, Boxes , SaleDate , weekday(saledate) as ' day of the week '
from sales where weekday(saledate)=4;

--finding the sales person name with a beginning letter 'b'
select * from people
where Salesperson like 'b%';

--finding the sales person name with a letter 'b' inside 
select * from people
where Salesperson like '%b%';

--categorising the sale according to the amount 

select Amount, SaleDate,

	case when Amount < 1000 then ' less than 1k' 
		 when Amount < 5000 then ' less than 5k' 
		 when Amount < 10000 then ' less than 10k' 
         else '10k or more'
         end as 'amount category'
	from sales;


--joining 2 tables with the same corresponding  id's
select * from sales;
select * from people;

select s.SaleDate , p.salesperson, s.Amount , s.SPID  from sales as s 
join people as p on s.SPID=p.SPID ;  

--joining 2 tables with the same corresponding  id's using left join so that the 
#column names in the left will be preserved  
  select s.SaleDate , s.Amount , pr.PID, pr.product from sales as s 
  left join products as pr on pr.PID=s.PID;
  
 --merging columns from 3 different tables and filtering the data according to the location
 select s.SaleDate , s.Amount , pr.PID, pr.product , s.SPID , 
 p.salesperson, g.geo
 , g.GeoID
 from sales as s 
  join products as pr on pr.PID=s.PID
  join geo as g on g.GeoID= s.GeoID
  join people as p on p.SPID = s.SPID 
  where g.Geo in ('India', 'UK') order by salesperson;
         



