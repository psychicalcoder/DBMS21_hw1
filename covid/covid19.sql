DROP TABLE IF EXISTS patient_info;
DROP TABLE IF EXISTS search_trend;
DROP TABLE IF EXISTS time;
DROP TABLE IF EXISTS time_age;
DROP TABLE IF EXISTS time_gender;
DROP TABLE IF EXISTS time_province;
DROP TABLE IF EXISTS weather;
DROP TABLE IF EXISTS region;

CREATE TABLE patient_info ( id varchar(10) not null, sex varchar(10), age int, province varchar(20), city varchar(20), infection_case varchar(100), primary key (id) );
CREATE TABLE search_trend ( date date not null, cold float, flu float, pneumonia float, coronavirus float, primary key (date) );
CREATE TABLE time ( date date not null, test int, negative int, confirmed int, released int, deceased int, primary key (date) );
CREATE TABLE time_age ( date date not null, age int not null, confirmed int, deceased int, primary key (date, age) );
CREATE TABLE time_gender ( date date not null, sex varchar(10) not null, confirmed int, deceased int, primary key (date, sex) );
CREATE TABLE time_province ( date date not null, province varchar(20) not null,  confirmed int, released int, deceased int, primary key (date, province) );
CREATE TABLE region (code int not null, province varchar(20), city varchar(20), elementary_school_count int, kindergarten_count int, university_count int, elderly_population_ratio float, elderly_alone_ratio float, nursing_home_count int, primary key (code) );
CREATE TABLE weather (code int not null, date date not null, avg_temp float, most_wind_direction int, avg_relative_humidity float, primary key (code, date), foreign key (code) references region(code) );

-- load csv
LOAD DATA LOCAL INFILE './patient_info.csv' INTO TABLE patient_info
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 lines;
LOAD DATA LOCAL INFILE './search_trend.csv' INTO TABLE search_trend
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 lines;
LOAD DATA LOCAL INFILE './time.csv' INTO TABLE time
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 lines;
LOAD DATA LOCAL INFILE './time_province.csv' INTO TABLE time_province
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 lines;
LOAD DATA LOCAL INFILE './region.csv' INTO TABLE region
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 lines;
LOAD DATA LOCAL INFILE './time_age.csv' INTO TABLE time_age
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 lines;
LOAD DATA LOCAL INFILE './time_gender.csv' INTO TABLE time_gender
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 lines;
LOAD DATA LOCAL INFILE './weather.csv' INTO TABLE weather
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 lines;

SELECT TABLE_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE();
-- end load csv

SELECT COUNT(*) FROM search_trend WHERE cold > 0.2;

SELECT DISTINCT infection_case FROM patient_info
  WHERE sex="male" and age<30 and province="Seoul" and city="Gangnam-gu"
  ORDER BY infection_case ASC;

SELECT province, city, elementary_school_count AS cnt
  FROM region WHERE province<>city
  ORDER BY cnt DESC
  LIMIT 3;

SELECT region.province, SUM(t.tcnt) AS cnt
  FROM (SELECT code, COUNT(code) AS tcnt
          FROM weather WHERE date LIKE '2016-05-%' AND avg_relative_humidity > 70.0
	  GROUP BY code) AS t
  INNER JOIN region ON t.code = region.code
  GROUP BY region.province
  ORDER BY cnt DESC
  LIMIT 3;

SELECT code, COUNT(code) FROM weather
  WHERE date LIKE '2016-05-%' AND
        avg_relative_humidity > 70
  GROUP BY code;

with cte as
  (select province, date, confirmed, (confirmed - IFNULL( lag(confirmed, 1)
     over (partition by province order by date asc), 0)) as s_confirmed
     from time_province where province in
       (select province from region
          where province = city and elderly_population_ratio > (select avg(elderly_population_ratio)
          from region where province = city)))
select cte.province, cte.date from cte inner join 
(select cte.province, max(s_confirmed) as sc from cte group by province) as mx
on cte.province = mx.province and cte.s_confirmed = mx.sc
order by cte.province, cte.date asc;

-- | Jeollanam-do      | 2020-03-04 |         4 |          -1 |

with cte as
  (select date,
          confirmed as confirmed_accumulate,
	  (confirmed - IFNULL( lag(confirmed, 1) over (order by date asc), 0)) as confirmed_add,
	  deceased as dead_accumulate,
	  (deceased - IFNULL( lag(deceased, 1) over (order by date asc), 0)) as dead_add
   from time)
select t.date, t.coronavirus,
       cte.confirmed_accumulate,
       cte.confirmed_add,
       cte.dead_accumulate,
       cte.dead_add
  from (select date, coronavirus
          from search_trend
          where coronavirus > (select avg(cor.coronavirus)+2*std(cor.coronavirus)
                                 from (select coronavirus from search_trend
			                 where (date between '2019-12-25' and '2020-06-29'))
			         as cor)) as t
  inner join cte on t.date = cte.date;
