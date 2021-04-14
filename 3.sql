SELECT province, city, elementary_school_count AS cnt
  FROM region WHERE province<>city
  ORDER BY cnt DESC
  LIMIT 3;
