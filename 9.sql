with
years as (select * from match_info where season = '2015/2016'),
homewin as (select home_team_id as id, count(home_team_id) as pnt
            from years where home_team_score > away_team_score group by home_team_id),
awaywin as (select away_team_id as id, count(away_team_id) as pnt2
            from years where home_team_score < away_team_score group by away_team_id),
homeeven as (select home_team_id as id, count(home_team_id) as pnt
             from years where home_team_score = away_team_score group by home_team_id),
awayeven as (select away_team_id as id, count(away_team_id) as pnt2
             from years where home_team_score = away_team_score group by away_team_id),
win as (select wfj.id, (IFNULL(wfj.pnt, 0) + IFNULL(wfj.pnt2, 0)) as pnt
         from (select homewin.id, homewin.pnt, awaywin.pnt2
	         from homewin left join awaywin on homewin.id = awaywin.id
               union
	       select awaywin.id, homewin.pnt, awaywin.pnt2
	         from awaywin left join homewin on awaywin.id = homewin.id)
	 as wfj),
even as (select efj.id, (IFNULL(efj.pnt, 0) + IFNULL(efj.pnt2, 0)) as pnt2
         from (select homeeven.id, homeeven.pnt, awayeven.pnt2 from homeeven
	         left join awayeven on homeeven.id = awayeven.id
               union
	       select awayeven.id, homeeven.pnt, awayeven.pnt2 from awayeven
	         left join homeeven on awayeven.id = homeeven.id)
	 as efj),
we as (select win.id, win.pnt, even.pnt2 from win
       left join even on win.id = even.id
       union
       select even.id, win.pnt, even.pnt2 from even
       left join win on even.id = win.id),

home as (select home_team_id as id, count(home_team_id) as cnt
         from years group by home_team_id),

away as (select away_team_id as id, count(away_team_id) as cnt
     	 from years group by away_team_id),
hpa as (select fj.id, (IFNULL(fj.hcnt, 0) + IFNULL(fj.acnt, 0)) as cnt
        from (select home.id, home.cnt as hcnt, away.cnt as acnt
	        from home left join away on home.id = away.id
	      union
	      select away.id, home.cnt as hcnt, away.cnt as acnt
	        from away left join home on away.id = home.id) as fj),

greats as (select t.id, ((2.0 * IFNULL(t.pnt,0) + IFNULL(t.pnt2, 0)) / t.cnt) as pnts
      	 from (select hpa.id, we.pnt, we.pnt2, hpa.cnt from hpa
	         left join we on hpa.id = we.id) as t
	 order by pnts desc limit 5),
hp as (select home_team_id as id, (home_team_score - away_team_score) as win_score
       from years where home_team_id in (select id from greats)
       union all
       select away_team_id as id, (away_team_score - home_team_score) as win_score
       from years where away_team_id in (select id from greats))
select teams.team_long_name, raw.avg_win_score
from (select id, cast(avg(win_score) as decimal(38,2)) as avg_win_score from hp group by id) as raw
inner join (select team.id, team.team_long_name, greats.pnts from team
            inner join greats on team.id = greats.id) as teams	    
  on teams.id = raw.id
  order by teams.pnts desc;
