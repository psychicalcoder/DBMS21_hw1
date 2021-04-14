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
