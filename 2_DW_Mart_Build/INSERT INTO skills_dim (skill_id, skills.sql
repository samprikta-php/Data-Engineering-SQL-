

SELECT 'Company Dim' AS table_name, COUNT(*) AS record_count FROM company_dim
UNION ALL
SELECT 'Skills Dim', COUNT(*) FROM skills_dim
UNION ALL
SELECT 'Job Posting Fact',COUNT(*) FROM job_postings_fact
UNION ALL 
SELECT 'Skills Job Dim',COUNT(*) FROM skills_job_dim;


SELECT '===  Company Dimension Sample ===' AS info;
SELECT * FROM company_dim LIMIT 5;
SELECT '=== Skills Dimension Table ===' AS info;
SELECT * FROM skills_dim LIMIT 5;
SELECT '=== Job Posting fact Table ===' AS info;
SELECT * FROM job_postings_fact LIMIT 5;
SELECT '=== Loading company_dim Table ===' AS info;
SELECT * FROM skills_job_dim LIMIT 5;