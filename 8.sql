with
years as (select * from match_info where season = '2015/2016'),
home as
(select league_id, home_team_id as id, IF((home_team_score > away_team_score), 1, 0) as win,
       home_player_1 as p1, home_player_2 as p2, home_player_3 as p3,
       home_player_4 as p4, home_player_5 as p5, home_player_6 as p6,
       home_player_7 as p7, home_player_8 as p8, home_player_9 as p9,
       home_player_10 as p10, home_player_11 as p11,
       (IF(home_player_1, 1, 0) + IF(home_player_2, 1, 0) + IF(home_player_3, 1, 0) +
       IF(home_player_4, 1, 0) + IF(home_player_5, 1, 0) + IF(home_player_6, 1, 0) +
       IF(home_player_7, 1, 0) + IF(home_player_8, 1, 0) + IF(home_player_9, 1, 0) +
       IF(home_player_10, 1, 0) + IF(home_player_11, 1, 0)) as cnt
       from years),
away as
(select league_id, away_team_id as id, IF((away_team_score > home_team_score), 1, 0) as win,
       away_player_1 as p1, away_player_2 as p2, away_player_3 as p3,
       away_player_4 as p4, away_player_5 as p5, away_player_6 as p6,
       away_player_7 as p7, away_player_8 as p8, away_player_9 as p9,
       away_player_10 as p10, away_player_11 as p11,
       (IF(away_player_1, 1, 0) + IF(away_player_2, 1, 0) + IF(away_player_3, 1, 0) +
       IF(away_player_4, 1, 0) + IF(away_player_5, 1, 0) + IF(away_player_6, 1, 0) +
       IF(away_player_7, 1, 0) + IF(away_player_8, 1, 0) + IF(away_player_9, 1, 0) +
       IF(away_player_10, 1, 0) + IF(away_player_11, 1, 0)) as cnt
       from years),
SP as (select player_api_id as id, height from player),
hh as 
(select h.league_id as id, sum(h.win) as hw, count(h.win) as hc from  
 (select home.league_id, home.win,
        ((IFNULL(h1.height, 0) + IFNULL(h2.height, 0) + IFNULL(h3.height, 0) +
          IFNULL(h4.height, 0) + IFNULL(h5.height, 0) + IFNULL(h6.height, 0) +
          IFNULL(h7.height, 0) + IFNULL(h8.height, 0) + IFNULL(h9.height, 0) +
          IFNULL(h10.height, 0) + IFNULL(h11.height, 0)) / home.cnt) as avg_height
 from home
 left join SP h1  on home.p1 = h1.id
 left join SP h2  on home.p2 = h2.id
 left join SP h3  on home.p3 = h3.id
 left join SP h4  on home.p4 = h4.id
 left join SP h5  on home.p5 = h5.id
 left join SP h6  on home.p6 = h6.id
 left join SP h7  on home.p7 = h7.id
 left join SP h8  on home.p8 = h8.id
 left join SP h9  on home.p9 = h9.id
 left join SP h10 on home.p10 = h10.id
 left join SP h11 on home.p11 = h11.id)
 as h where h.avg_height > 180.0 group by h.league_id),
aa as 
(select a.league_id as id, sum(a.win) as aw, count(a.win) as ac from  
 (select away.league_id, away.win,
        ((IFNULL(a1.height, 0) + IFNULL(a2.height, 0) + IFNULL(a3.height, 0) +
          IFNULL(a4.height, 0) + IFNULL(a5.height, 0) + IFNULL(a6.height, 0) +
          IFNULL(a7.height, 0) + IFNULL(a8.height, 0) + IFNULL(a9.height, 0) +
          IFNULL(a10.height, 0) + IFNULL(a11.height, 0)) / away.cnt) as avg_height
 from away
 left join SP a1  on away.p1 = a1.id
 left join SP a2  on away.p2 = a2.id
 left join SP a3  on away.p3 = a3.id
 left join SP a4  on away.p4 = a4.id
 left join SP a5  on away.p5 = a5.id
 left join SP a6  on away.p6 = a6.id
 left join SP a7  on away.p7 = a7.id
 left join SP a8  on away.p8 = a8.id
 left join SP a9  on away.p9 = a9.id
 left join SP a10 on away.p10 = a10.id
 left join SP a11 on away.p11 = a11.id)
 as a where a.avg_height > 180.0 group by a.league_id)
 
select league.name, round((tot.aw+tot.hw)/(tot.ac + tot.hc), 4) as prob
 from (select aa.id, aa.aw, hh.hw, aa.ac, hh.hc from aa left join hh on aa.id = hh.id
       union
       select hh.id, aa.aw, hh.hw, aa.ac, hh.hc from hh left join aa on hh.id = aa.id) as tot
 left join league on league.id = tot.id
 order by league.name;
