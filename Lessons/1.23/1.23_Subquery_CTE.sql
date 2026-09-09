--Subquery
SELECT * 
FROM (

    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL OR
    salary_hour_avg IS NOT NULL
)
limit 10;

--CTE

WITH valid_salaries AS(

    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL OR
    salary_hour_avg IS NOT NULL
)

SELECT *
FROM valid_salaries;

SELECT 
  job_title_short,
  (
    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
  )AS market_median_salary
   FROM job_postings_fact
   LIMIT 10;


SELECT 
  job_title_short,
  MEDIAN(salary_year_avg)AS median_salary,
  (
    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact 
    WHERE job_work_from_home = TRUE

  )AS market_remote_median_salary
   FROM (
    SELECT 
     job_title_short,
     salary_year_avg
      FROM job_postings_fact
      WHERE job_work_from_home= TRUE
    ) AS clean_jobs
   WHERE salary_year_avg IS NOT NULL 
   GROUP BY job_title_short
   LIMIT 10;
--senario subquery havings
   SELECT 
  job_title_short,
  MEDIAN(salary_year_avg)AS median_salary,
  (
    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact 
    WHERE job_work_from_home = TRUE

  )AS market_remote_median_salary
   FROM (
    SELECT 
     job_title_short,
     salary_year_avg
      FROM job_postings_fact
      WHERE job_work_from_home= TRUE
    ) AS clean_jobs
   WHERE salary_year_avg IS NOT NULL 
   GROUP BY job_title_short
   HAVING MEDIAN(salary_hour_avg) >(  

    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact 
    WHERE job_work_from_home = TRUE
    )

   
   LIMIT 10;
   --CTE example



SELECT * FROM RANGE(3) AS src(key);

SELECT * FROM RANGE(2) AS tgt(key);

SELECT * 
FROM range(3) AS src(key)
WHERE EXISTS(
  SELECT 123
   FROM range(2) AS tgt(key)
   WHERE tgt.key =src.key
);

SELECT * 
FROM  skills_job_dim
ORDER BY job_id
Limit 40;

SELECT * 
FROM  job_postings_fact AS tgt
  WHERE NOT EXISTS(
    SELECT *
    FROM skills_job_dim AS src
    WHERE tgt.job_id = src.job.id

  )

ORDER BY job_id
Limit 40;