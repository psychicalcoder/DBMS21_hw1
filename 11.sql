inner join (select upset.id, avg(pa.overall_rating) as rh2
             from upset, player_attributes as pa
             where upset.home_player_2 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h2 on h2.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh3
             from upset, player_attributes as pa
             where upset.home_player_3 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h3 on h3.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh4
             from upset, player_attributes as pa
             where upset.home_player_4 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h4 on h4.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh5
             from upset, player_attributes as pa
             where upset.home_player_5 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h5 on h5.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh6
             from upset, player_attributes as pa
             where upset.home_player_6 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h6 on h6.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh2
             from upset, player_attributes as pa
             where upset.home_player_2 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h2 on h2.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh3
             from upset, player_attributes as pa
             where upset.home_player_3 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h3 on h3.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh4
             from upset, player_attributes as pa
             where upset.home_player_4 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h4 on h4.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh5
             from upset, player_attributes as pa
             where upset.home_player_5 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h5 on h5.id = ans.id
inner join (select upset.id, avg(pa.overall_rating) as rh6
             from upset, player_attributes as pa
             where upset.home_player_6 = pa.player_api_id and pa.overall_rating is not null and
             (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)
             group by upset.id) as h6 on h6.id = ans.id
