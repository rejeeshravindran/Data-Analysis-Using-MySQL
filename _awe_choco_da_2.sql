
#joining 2 tables with the same corresponding  id's
select * from sales;
select * from people;

select s.SaleDate , p.salesperson, s.Amount , s.SPID  from sales as s 
join people as p on s.SPID=p.SPID ;  

#joining 2 tables with the same corresponding  id's using left join so that the 
#column names in the left will be preserved  
  select s.SaleDate , s.Amount , pr.PID, pr.product from sales as s 
  left join products as pr on pr.PID=s.PID;
  
 #merging columns from 3 different tables and filtering the data according to the location
 select s.SaleDate , s.Amount , pr.PID, pr.product , s.SPID , 
 p.salesperson, g.geo
 , g.GeoID
 from sales as s 
  join products as pr on pr.PID=s.PID
  join geo as g on g.GeoID= s.GeoID
  join people as p on p.SPID = s.SPID 
  where g.Geo in ('India', 'UK') order by salesperson;
  
  
  
  
  