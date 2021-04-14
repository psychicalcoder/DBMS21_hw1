with 
upset as (select * from match_info where B365H > B365A),
homeweak as (
select ans.id, IF(ans.home_team_score>ans.away_team_score, 1, 0) as home_win,
       cast(home_player_avg_rating as decimal(38, 2)) as home_player_avg_rating,
       cast(away_player_avg_rating as decimal(38, 2)) as away_player_avg_rating,
       IF(home_player_avg_rating > away_player_avg_rating, IF(ans.home_team_score > ans.away_team_score, B365H-1, -1), 0) as profit
from (select id, home_team_score, away_team_score, B365H from upset) as ans
left join (select upset.id, ((IFNULL(rh1, 0) + IFNULL(rh2, 0) + IFNULL(rh3, 0) +
                         IFNULL(rh4, 0) + IFNULL(rh5, 0) + IFNULL(rh6, 0) +
			 IFNULL(rh7, 0) + IFNULL(rh8, 0) + IFNULL(rh9, 0) +
			 IFNULL(rh10, 0) + IFNULL(rh11, 0)) /
			(IF(rh1, 1, 0) + IF(rh2, 1, 0) + IF(rh3, 1, 0) +
			 IF(rh4, 1, 0) + IF(rh5, 1, 0) + IF(rh6, 1, 0) +
			 IF(rh7, 1, 0) + IF(rh8, 1, 0) + IF(rh9, 1, 0) +
			 IF(rh10, 1, 0) + IF(rh11, 1, 0))
		        ) as home_player_avg_rating
from upset
  left join (select upset.id, avg(pa.overall_rating) as rh1
  	       from upset, player_attributes as pa
	       where upset.home_player_1 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
               group by upset.id) as h1 on h1.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh2
	       from upset, player_attributes as pa
	       where upset.home_player_2 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h2 on h2.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh3
	       from upset, player_attributes as pa
	       where upset.home_player_3 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h3 on h3.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh4
	       from upset, player_attributes as pa
	       where upset.home_player_4 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h4 on h4.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh5
	       from upset, player_attributes as pa
	       where upset.home_player_5 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h5 on h5.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh6
	       from upset, player_attributes as pa
	       where upset.home_player_6 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h6 on h6.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh7
	       from upset, player_attributes as pa
	       where upset.home_player_7 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h7 on h7.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh8
	       from upset, player_attributes as pa
	       where upset.home_player_8 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h8 on h8.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh9
	       from upset, player_attributes as pa
	       where upset.home_player_9 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h9 on h9.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh10
	       from upset, player_attributes as pa
	       where upset.home_player_10 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h10 on h10.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh11
	       from upset, player_attributes as pa
	       where upset.home_player_11 = pa.player_api_id and pa.attacking_work_rate is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h11 on h11.id = upset.id) as hr on hr.id = ans.id
left join (select upset.id, ((IFNULL(ra1, 0) + IFNULL(ra2, 0) + IFNULL(ra3, 0) +
                              IFNULL(ra4, 0) + IFNULL(ra5, 0) + IFNULL(ra6, 0) +
			      IFNULL(ra7, 0) + IFNULL(ra8, 0) + IFNULL(ra9, 0) +
			      IFNULL(ra10, 0) + IFNULL(ra11, 0)) /
			     (IF(ra1, 1, 0) + IF(ra2, 1, 0) + IF(ra3, 1, 0) +
			      IF(ra4, 1, 0) + IF(ra5, 1, 0) + IF(ra6, 1, 0) +
			      IF(ra7, 1, 0) + IF(ra8, 1, 0) + IF(ra9, 1, 0) +
			      IF(ra10, 1, 0) + IF(ra11, 1, 0))
			    ) as away_player_avg_rating
from upset
  left join (select upset.id, avg(pa.overall_rating) as ra1
	      from upset, player_attributes as pa
	      where upset.away_player_1 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a1 on a1.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra2
	      from upset, player_attributes as pa
	      where upset.away_player_2 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a2 on a2.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra3
	      from upset, player_attributes as pa
	      where upset.away_player_3 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a3 on a3.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra4
	      from upset, player_attributes as pa
	      where upset.away_player_4 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a4 on a4.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra5
	      from upset, player_attributes as pa
	      where upset.away_player_5 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a5 on a5.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra6
	      from upset, player_attributes as pa
	      where upset.away_player_6 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a6 on a6.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra7
	      from upset, player_attributes as pa
	      where upset.away_player_7 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a7 on a7.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra8
	      from upset, player_attributes as pa
	      where upset.away_player_8 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a8 on a8.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra9
	      from upset, player_attributes as pa
	      where upset.away_player_9 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a9 on a9.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra10
	      from upset, player_attributes as pa
	      where upset.away_player_10 = pa.player_api_id and pa.attacking_work_rate is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a10 on a10.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra11
              from upset, player_attributes as pa
              where upset.away_player_11 = pa.player_api_id and pa.attacking_work_rate is not null and
              (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
              group by upset.id) as a11 on a11.id = upset.id) as ar on ar.id = ans.id
where home_player_avg_rating is not null and away_player_avg_rating is not null
order by ans.id)
select count(*), avg(profit) from homeweak;
