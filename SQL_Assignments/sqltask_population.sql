-- Creating the Database
create database world_factbook;
use world_factbook;

create table CIA_factbook(
country	varchar(100), 
area integer,
birth_rate decimal(38,3), 
death_rate decimal(38,3),
infant_mortality_rate decimal(38,3),
internet_users	integer,
life_exp_at_birth decimal(38,3),	
maternal_mortality_rate integer,
net_migration_rate	decimal(38,2),
population	integer,
population_growth_rate decimal(38,2)
);

select * from cia_factbook;

-- Loading the Values in the Table

LOAD DATA INFILE 'D:\cia_factbook.csv'
INTO TABLE CIA_factbook
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(@col1, @col2, @col3, @col4, @col5, @col6, @col7, @col8, @col9, @col10, @col11)
set country = @col1, 
area = if(@col2 = 'NA', NULL, @col2), 
birth_rate = if(@col3 = 'NA', NULL, @col3), 
death_rate = if(@col4 = 'NA', NULL, @col4),
infant_mortality_rate = if(@col5 = 'NA', NULL, @col5), 
internet_users = if(@col6 = 'NA', NULL, @col6), 
life_exp_at_birth = if(@col7 = 'NA', NULL, @col7),
maternal_mortality_rate  = if(@col8 = 'NA', NULL, @col8),
net_migration_rate = if(@col9 = 'NA', NULL, @col9), 
population = if(@col10 = 'NA', NULL, @col10), 
population_growth_rate = if(@col11 = 'NA', NULL, @col11);
			

-- Question1 - country with highest population
select country, population 
from cia_factbook 
where population = 
(select max(population) from cia_factbook);

-- Question2 - country with lowest population
select country, population 
from cia_factbook 
where population = 
(select min(population) from cia_factbook);

-- Question3 - country with highest population growth
select country, population_growth_rate 
from cia_factbook 
where population_growth_rate = 
(select max(population_growth_rate) from cia_factbook);

-- Question5 - country with high density using order by and limit
select country, area, population, (population/area) 
as population_density 
from cia_factbook 
order by (population/area)
desc limit 1;

-- Question5 - country with high density by max() function
select country, area, population,(population/area) 
as population_density
from cia_factbook
where (population/area) = 
(select max(population/area) from cia_factbook);
 

