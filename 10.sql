-- select pa.overall_rating from player_attribute as pa where pa.date >= date_sub(, interval 3 month)

-- home_team_score, away_team_score, B365H, B365A, WHH, WHA, SJH, SJA
with 
upset as (select * from match_info where (home_team_score > away_team_score + 4) and (B365H > B365A and B365H > B365D or WHH > WHA and WHH > WHD or SJH > SJA and SJH > SJD) 
       	   	     	                  or
			                 (away_team_score > home_team_score + 4) and (B365A > B365H and B365A > B365D or WHA > WHH and WHA > WHD or SJA > SJH and SJA > SJD))
select ans.id,
       cast(home_player_avg_age as decimal(38, 2)) as home_player_avg_age,
       cast(away_player_avg_age as decimal(38, 2)) as away_player_avg_age,
       cast(home_player_avg_rating as decimal(38, 2)) as home_player_avg_rating,
       cast(away_player_avg_rating as decimal(38, 2)) as away_player_avg_rating
from (select id from upset) as ans
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
	       where upset.home_player_1 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
               group by upset.id) as h1 on h1.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh2
	       from upset, player_attributes as pa
	       where upset.home_player_2 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h2 on h2.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh3
	       from upset, player_attributes as pa
	       where upset.home_player_3 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h3 on h3.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh4
	       from upset, player_attributes as pa
	       where upset.home_player_4 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h4 on h4.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh5
	       from upset, player_attributes as pa
	       where upset.home_player_5 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h5 on h5.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh6
	       from upset, player_attributes as pa
	       where upset.home_player_6 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h6 on h6.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh7
	       from upset, player_attributes as pa
	       where upset.home_player_7 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h7 on h7.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh8
	       from upset, player_attributes as pa
	       where upset.home_player_8 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h8 on h8.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh9
	       from upset, player_attributes as pa
	       where upset.home_player_9 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h9 on h9.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh10
	       from upset, player_attributes as pa
	       where upset.home_player_10 = pa.player_api_id and pa.overall_rating is not null and
	       (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	       group by upset.id) as h10 on h10.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as rh11
	       from upset, player_attributes as pa
	       where upset.home_player_11 = pa.player_api_id and pa.overall_rating is not null and
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
	      where upset.away_player_1 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a1 on a1.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra2
	      from upset, player_attributes as pa
	      where upset.away_player_2 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a2 on a2.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra3
	      from upset, player_attributes as pa
	      where upset.away_player_3 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a3 on a3.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra4
	      from upset, player_attributes as pa
	      where upset.away_player_4 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a4 on a4.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra5
	      from upset, player_attributes as pa
	      where upset.away_player_5 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a5 on a5.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra6
	      from upset, player_attributes as pa
	      where upset.away_player_6 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a6 on a6.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra7
	      from upset, player_attributes as pa
	      where upset.away_player_7 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a7 on a7.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra8
	      from upset, player_attributes as pa
	      where upset.away_player_8 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a8 on a8.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra9
	      from upset, player_attributes as pa
	      where upset.away_player_9 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a9 on a9.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra10
	      from upset, player_attributes as pa
	      where upset.away_player_10 = pa.player_api_id and pa.overall_rating is not null and
	      (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
	      group by upset.id) as a10 on a10.id = upset.id
  left join (select upset.id, avg(pa.overall_rating) as ra11
              from upset, player_attributes as pa
              where upset.away_player_11 = pa.player_api_id and pa.overall_rating is not null and
              (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
              group by upset.id) as a11 on a11.id = upset.id) as ar on ar.id = ans.id
left join (select upset.id, ((IFNULL(ha1, 0) + IFNULL(ha2, 0) + IFNULL(ha3, 0) +
			      IFNULL(ha4, 0) + IFNULL(ha5, 0) + IFNULL(ha6, 0) +
			      IFNULL(ha7, 0) + IFNULL(ha8, 0) + IFNULL(ha9, 0) +
			      IFNULL(ha10, 0) + IFNULL(ha11, 0)) /
			     (IF(ha1, 1, 0) + IF(ha2, 1, 0) + IF(ha3, 1, 0) +
                              IF(ha4, 1, 0) + IF(ha5, 1, 0) + IF(ha6, 1, 0) +
			      IF(ha7, 1, 0) + IF(ha8, 1, 0) + IF(ha9, 1, 0) +
			      IF(ha10, 1, 0) + IF(ha11, 1, 0))
			    ) as home_player_avg_age
from upset
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha1
              from upset, player as p
	      where upset.home_player_1 = p.player_api_id and p.birthday is not null
	    ) as hg1 on hg1.id = upset.id 
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha2
              from upset, player as p
	      where upset.home_player_2 = p.player_api_id and p.birthday is not null
	    ) as hg2 on hg2.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha3
              from upset, player as p
	      where upset.home_player_3 = p.player_api_id and p.birthday is not null
	    ) as hg3 on hg3.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha4
              from upset, player as p
	      where upset.home_player_4 = p.player_api_id and p.birthday is not null
	    ) as hg4 on hg4.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha5
              from upset, player as p
	      where upset.home_player_5 = p.player_api_id and p.birthday is not null
	    ) as hg5 on hg5.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha6
              from upset, player as p
	      where upset.home_player_6 = p.player_api_id and p.birthday is not null
	    ) as hg6 on hg6.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha7
              from upset, player as p
	      where upset.home_player_7 = p.player_api_id and p.birthday is not null
	    ) as hg7 on hg7.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha8
              from upset, player as p
	      where upset.home_player_8 = p.player_api_id and p.birthday is not null
	    ) as hg8 on hg8.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha9
              from upset, player as p
	      where upset.home_player_9 = p.player_api_id and p.birthday is not null
	    ) as hg9 on hg9.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha10
              from upset, player as p
	      where upset.home_player_10 = p.player_api_id and p.birthday is not null
	    ) as hg10 on hg10.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as ha11
              from upset, player as p
	      where upset.home_player_11 = p.player_api_id and p.birthday is not null
	    ) as hg11 on hg11.id = upset.id) as hage on hage.id = ans.id
left join (select upset.id, ((IFNULL(aa1, 0) + IFNULL(aa2, 0) + IFNULL(aa3, 0) +
			      IFNULL(aa4, 0) + IFNULL(aa5, 0) + IFNULL(aa6, 0) +
			      IFNULL(aa7, 0) + IFNULL(aa8, 0) + IFNULL(aa9, 0) +
			      IFNULL(aa10, 0) + IFNULL(aa11, 0)) /
			     (IF(aa1, 1, 0) + IF(aa2, 1, 0) + IF(aa3, 1, 0) +
                              IF(aa4, 1, 0) + IF(aa5, 1, 0) + IF(aa6, 1, 0) +
			      IF(aa7, 1, 0) + IF(aa8, 1, 0) + IF(aa9, 1, 0) +
			      IF(aa10, 1, 0) + IF(aa11, 1, 0))
			    ) as away_player_avg_age
from upset
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa1
              from upset, player as p
	       where upset.away_player_1 = p.player_api_id and p.birthday is not null
	    ) as ag1 on ag1.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa2
              from upset, player as p
	       where upset.away_player_2 = p.player_api_id and p.birthday is not null
	    ) as ag2 on ag2.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa3
              from upset, player as p
	       where upset.away_player_3 = p.player_api_id and p.birthday is not null
	    ) as ag3 on ag3.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa4
              from upset, player as p
	       where upset.away_player_4 = p.player_api_id and p.birthday is not null
	    ) as ag4 on ag4.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa5
              from upset, player as p
	       where upset.away_player_5 = p.player_api_id and p.birthday is not null
	    ) as ag5 on ag5.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa6
              from upset, player as p
	       where upset.away_player_6 = p.player_api_id and p.birthday is not null
	    ) as ag6 on ag6.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa7
              from upset, player as p
	       where upset.away_player_7 = p.player_api_id and p.birthday is not null
	    ) as ag7 on ag7.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa8
              from upset, player as p
	       where upset.away_player_8 = p.player_api_id and p.birthday is not null
	    ) as ag8 on ag8.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa9
              from upset, player as p
	       where upset.away_player_9 = p.player_api_id and p.birthday is not null
	    ) as ag9 on ag9.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa10
              from upset, player as p
	       where upset.away_player_10 = p.player_api_id and p.birthday is not null
	    ) as ag10 on ag10.id = upset.id
  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa11
              from upset, player as p
	       where upset.away_player_11 = p.player_api_id and p.birthday is not null
	    ) as ag11 on ag11.id = upset.id) as aage on aage.id = ans.id
where home_player_avg_rating is not null and away_player_avg_rating is not null and
      home_player_avg_age is not null and away_player_avg_age is not null
order by ans.id;
