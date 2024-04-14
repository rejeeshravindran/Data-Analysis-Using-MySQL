--selecting the data we are going to use 

select location, date, total_cases, total_deaths, new_cases,population
from sql_pro.dbo.deaths order by 1,2;

--looking at total cases vs total death 

--chance of dying in the country if you get a positive covid result 
select location, date,  total_deaths, total_cases , (cast(total_deaths as float) /cast(total_cases as float))*100 as 'death percentage'
from sql_pro.dbo.deaths where location like '%india%' order by 1,2;

--looking at total cases vs population

select location, date, population, total_cases , (cast(total_cases  as float) /cast(population as float))*100 as 
'percentage of population who are covid positive'
from sql_pro.dbo.deaths where location like '%india%' order by 1,2;

--looking at the countries with highest covid positive counts

select location, population, max(total_cases) as 'highest positive count' , max((cast(total_cases as float) /cast(population as float))*100)  as 
'percentage of highest covid positive counts' 
from sql_pro.dbo.deaths 
--where location like '%India%'
group by  location, population 
order by 'percentage of highest covid positive counts'  desc;

--showing countries highest death count per population
--breaking down by continent

select  continent, max(total_deaths) as 'total death', max((cast(total_deaths as float) /cast(population as float))*100) as
'death percentage' 
from sql_pro.dbo.deaths 
--where location like '%india%' 
where continent is not null
group by continent
order by 'total death' desc ;

-- global analysis

select  date, sum(new_cases) as 'total case', sum(cast(new_deaths as float)) as 'total death' ,
sum(cast(new_deaths as float)) /sum(cast(new_cases as float))*100 as
'death percentage' 
from sql_pro.dbo.deaths 
--where location like '%india%' 
where new_cases <>0
group by date 
order by 1,2
 
 -- looking at the total vaccination taken by population 
 --USE CTE 

 with vac_pop ( continent , location,  date ,  population , new_vaccinations, ongoingvaccination )
 as (

 select de.continent ,de.location,  de.date , de.population , vac.new_vaccinations, 
 sum(convert(float,vac.new_vaccinations )) over (partition by de.location order by de.location , de.date  ) 
 as ongoingvaccination -- ('ongoing vaccination'/population)*100 as 'percentage '
 from sql_pro.dbo.deaths de join sql_pro.dbo.vaccinations vac  on
 de.location = vac.location  and de.date=vac.date
 where de.continent is not null
 )

 select *  , (ongoingvaccination/population)*100 as percentage from vac_pop;

-- using temp table


create Table #vaccinationpercentage
(
Continent nvarchar(300),  
location nvarchar(300),
date datetime,
total_vaccinations float,
population int,
new_vaccination int ,
ongoingvaccination float );


insert into #vaccinationpercentage 

 select de.continent ,de.location,  de.date ,total_vaccinations , de.population , vac.new_vaccinations, 
 sum(convert(float,vac.new_vaccinations )) over (partition by de.location order by de.location , de.date  ) 
 as ongoingvaccination -- ('ongoing vaccination'/population)*100 as 'percentage '
 from sql_pro.dbo.deaths de join sql_pro.dbo.vaccinations vac  on
 de.location = vac.location  and de.date=vac.date
 where de.continent is not null
  select *  , (ongoingvaccination/population)*100 as percentage from #vaccinationpercentage ;

  --creating view for visualisation

  create view vaccinationpercentageglobal as
(
   select de.continent ,de.location,  de.date , de.population , vac.new_vaccinations, 
 sum(convert(float,vac.new_vaccinations )) over (partition by de.location order by de.location , de.date  ) 
 as ongoingvaccination -- ('ongoing vaccination'/population)*100 as 'percentage '
 from sql_pro.dbo.deaths de join sql_pro.dbo.vaccinations vac  on
 de.location = vac.location  and de.date=vac.date
 where de.continent is not null )


  select*from vaccinationpercentageglobal;

  
 --looking at total cases vs population

 create view total_cases_vs_population as

select location, date, population, total_cases , (cast(total_cases  as float) /cast(population as float))*100 as 
'percentage of population who are covid positive'
from sql_pro.dbo.deaths where location like '%india%' --order by 1,2;