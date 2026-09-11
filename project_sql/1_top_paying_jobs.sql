/*TASKS 
1.Find the top 10 highest paying jobs that are:
    -DATA ANALYST POSITION.
    -REMOTE.
    -SORT THEM BY SALARY AND REMOVE NULL VALUES.
*/

SELECT 
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim
    ON company_dim.company_id= job_postings_fact.company_id
WHERE job_location = 'Anywhere' 
    AND job_title_short= 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10; 