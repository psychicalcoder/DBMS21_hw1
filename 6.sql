with cte as
  (select date,
          confirmed as confirmed_accumulate,
	  (confirmed - IFNULL( lag(confirmed, 1) over (order by date asc), 0)) as confirmed_add,
	  deceased as dead_accumulate,
	  (deceased - IFNULL( lag(deceased, 1) over (order by date asc), 0)) as dead_add
   from time)
select t.date, cast(t.coronavirus as decimal(38,2)) as coronavirus,
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
