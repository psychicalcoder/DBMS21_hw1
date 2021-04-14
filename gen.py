line = \
("left join (select upset.id, avg(pa.overall_rating) as ra{ai}\n"
"            from upset, player_attributes as pa\n"
"            where upset.away_player_{ai} = pa.player_api_id and pa.overall_rating is not null and\n"
"            (pa.date between adddate(adddate(upset.date, interval -6 month), interval 1 day) and upset.date)\n"
"            group by upset.id) as a{ai} on h{ai}.id = ans.id")

line = \
("  left join (select upset.id, timestampdiff(YEAR, p.birthday, upset.date) as aa{c}\n"
"              from upset, player as p\n"
"	       where upset.away_player_{c} = p.player_api_id and p.birthday is not null\n"
"	    ) as ag{c} on ag{c}.id = upset.id")

for i in range(1, 12):
    print(line.format(c=i))
