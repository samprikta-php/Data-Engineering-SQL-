SELECT 
    job_title_short,
    salary_hour_avg,
    salary_year_avg,
CASE    
   WHEN salary_your_avg IS NOT NULL THEN salary_year_avg,
   WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
END AS standardized_salary
FROM
   job_postings_pack
WHERE salary_year_avg IS NOT NULL AND salary_hour_avg IS NOT NULL
LIMIT 10;

--Handling Missing Data
--Filter Null salary values
-- SELECT 
--    job_title,
--     CASE
--        WHEN job_title Like '%Data%' AND job_title Like '%Analyst%' THEN 'Data Analyst'
--    END AS job_title_category    
--    job_title_short
-- FROM job_postings_fact
-- ORDER BY RANDOM()
-- LIMIT 20;
SELECT
   job_title_short,
   COUNT(*) AS total_postings,
   MEDIAN(
          CASE
            WHEN salary_year_avg <100-000 THEN salary_year_avg
         END 
    )AS median_low_salary,
    MEDIAN(
         CASE
            WHEN salary_year_avg >=100-000 THEN salary_year_avg
         END 
    )AS median_high_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY job_title_short;
    ---conditional package--

WITH salaries AS(
SELECT 
    job_title_short,
    salary_hour_avg,
    salary_year_avg,
    CASE 
      WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
      WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
END AS standardized_salary 
FROM
    job_postings_fact

 )

SELECT
    *,
   CASE
      WHEN  standardized_salary  IS NULL THEN 'Missing'
      WHEN  standardized_salary < 75_000 THEN 'Low'
      WHEN  standardized_salary < 150_000 THEN 'Medium'
   ELSE 'High'
   END AS salary_bucket
   FROM salaries
   ORDER BY  standardized_salary
   LIMIT 10;




   