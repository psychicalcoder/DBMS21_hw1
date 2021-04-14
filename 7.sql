with
ss as (select * from match_info where season = '2015/2016' and league_id = (select id from league where name = 'Italy Serie A')),
ids as 
(select distinct home_player_1 as id from ss where home_player_1 is not null
union
select distinct home_player_2 from ss where home_player_2 is not null
union
select distinct home_player_3 from ss where home_player_3 is not null
union
select distinct home_player_4 from ss where home_player_4 is not null
union
select distinct home_player_5 from ss where home_player_5 is not null
union
select distinct home_player_6 from ss where home_player_6 is not null
union
select distinct home_player_7 from ss where home_player_7 is not null
union
select distinct home_player_8 from ss where home_player_8 is not null
union
select distinct home_player_9 from ss where home_player_9 is not null
union
select distinct home_player_10 from ss where home_player_10 is not null
union
select distinct home_player_11 from ss where home_player_11 is not null
union
select distinct away_player_1 from ss where away_player_1 is not null
union
select distinct away_player_2 from ss where away_player_2 is not null
union
select distinct away_player_3 from ss where away_player_3 is not null
union
select distinct away_player_4 from ss where away_player_4 is not null
union
select distinct away_player_5 from ss where away_player_5 is not null
union
select distinct away_player_6 from ss where away_player_6 is not null
union
select distinct away_player_7 from ss where away_player_7 is not null
union
select distinct away_player_8 from ss where away_player_8 is not null
union
select distinct away_player_9 from ss where away_player_9 is not null
union
select distinct away_player_10 from ss where away_player_10 is not null
union
select distinct away_player_11 from ss where away_player_11 is not null),
latest as
(select player_api_id as uid, max(date) as date
   from player_attributes
   where long_shots is not null
   group by player_api_id)
select lr.preferred_foot, cast(avg(lr.long_shots) as decimal(38,2)) as avg_long_shots
from (select pa.player_api_id, pa.preferred_foot, pa.long_shots
      from (select * from player_attributes
            where long_shots is not null) as pa
      inner join latest on pa.player_api_id = latest.uid and
                           pa.date = latest.date and
			   pa.player_api_id in (select * from ids)
      ) as lr
group by lr.preferred_foot;
