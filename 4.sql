SELECT region.province, SUM(t.tcnt) AS cnt
  FROM (SELECT code, COUNT(code) AS tcnt
          FROM weather WHERE date LIKE '2016-05-%' AND avg_relative_humidity > 70.0
	  GROUP BY code) AS t
  INNER JOIN region ON t.code = region.code
  GROUP BY region.province
  ORDER BY cnt DESC
  LIMIT 3;
