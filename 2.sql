SELECT DISTINCT infection_case FROM patient_info
  WHERE sex="male" and age<30 and province="Seoul" and city="Gangnam-gu"
  ORDER BY infection_case ASC;
