-- Creating the Database
create database road_safetyUK;
use road_safetyUK;

-- Creating the Table structures
create table accidents(
accident_index varchar(30),
accident_severity integer
);

create table vehicles(
accident_index varchar(30),
vehicle_code integer);

create table vehicle_types(
 vehicle_code integer,
 vehicle_type varchar(50));
 
 -- Loading the Values in the tables 
 
  LOAD DATA INFILE 'D:\\Full_SatckDataAnalytics_Notes\\SQL\\Road_Safety_Data\\Accidents_2015.csv'
 INTO TABLE accidents
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS
 (@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
 @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
 @dummy, @dummy, @dummy, @dummy)
 SET accident_index = @col1, accident_severity = @col2;
 
 
 LOAD DATA INFILE 'D:\\Full_SatckDataAnalytics_Notes\\SQL\\Road_Safety_Data\\Vehicles_2015.csv'
 INTO TABLE vehicles
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS
 (@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
 @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy) 
 SET accident_index = @col1, vehicle_code = @col2;
 
 LOAD DATA INFILE 'D:\\Full_SatckDataAnalytics_Notes\\SQL\\Road_Safety_Data\\vehicle_types.csv'
 INTO TABLE vehicle_types
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS;

 select count(*) from accidents;
 select count(*) from vehicles;
 select count(*) from vehicle_types;
 
-- Q2. Accident Severity and Total Accidents per vehicle type
select vt.vehicle_type, avg(a.accident_severity) as Accident_Severity, count(v.accident_index) as Total_Accidents
from accidents a 
inner join vehicles v
on a.accident_index = v.accident_index
inner join vehicle_types vt
on v.vehicle_code = vt.vehicle_code
group by vt.vehicle_type;

-- Q3. Average Severity by vehicle type
select vt.vehicle_type, avg(a.accident_severity) as Avg_Accident_Severity
from accidents a 
inner join vehicles v
on a.accident_index = v.accident_index
inner join vehicle_types vt
on v.vehicle_code = vt.vehicle_code
group by vt.vehicle_type;

-- Q4. Average Severity and Total Accidents by Motorcycles
select count(a.accident_index) as Total_Accidents_by_motorcycles, 
avg(a.accident_severity) as Average_Accident_Severity_by_motorcycles
from accidents a 
inner join vehicles v
on a.accident_index = v.accident_index
inner join vehicle_types vt
on v.vehicle_code = vt.vehicle_code
where vt.vehicle_type like '%Motorcycle%';

-- Average Severity and Total Accidents caused by per Motorcycle type
select vt.vehicle_type, avg(a.accident_severity) as Avg_Accident_Severity
from accidents a 
inner join vehicles v
on a.accident_index = v.accident_index
inner join vehicle_types vt
on v.vehicle_code = vt.vehicle_code
group by vt.vehicle_type
having vt.vehicle_type like '%Motorcycle%';

-- Q1. Median Severity value of accidents caused by various motorcycles by sql query
SET @row_index := -1;
SELECT AVG(num.sev) as median_value
FROM (
    SELECT @row_index:=@row_index + 1 AS row_index, sev
    FROM severity
    ORDER BY sev
  ) AS num
  WHERE num.row_index 
  IN (FLOOR(@row_index / 2) , CEIL(@row_index / 2));
  
  -- creating new severity table 
create table severity( veh_type varchar(50), sev integer);

-- inserting severity values of motorcycle types to new table Severity
insert into severity 
select vt.vehicle_type, a.accident_severity
from accidents a 
inner join vehicles v
on a.accident_index = v.accident_index
inner join vehicle_types vt
on v.vehicle_code = vt.vehicle_code
where vt.vehicle_type like '%Motorcycle%';









 