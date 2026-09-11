/* 
TASKS:
    1.FIND THE SKILLS THAT ARE REQUIRED FOR THE HIGHEST PAYING DATA ANALYST JOBS.
    2.USE TOP 10 JOBS TO IDENTIFY THE SKILLS.
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        name AS company_name,
        job_location,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_location = 'Anywhere' 
        AND job_title_short= 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;


/* Analysis:

-SQL: Required by 100% of roles (8/8 jobs).

-Python: Required by 87.5% of roles (7/8 jobs).

-Tableau: Required by 75% of roles (6/8 jobs).

-R: Required by 50% of roles (4/8 jobs).

-Snowflake / Pandas / Excel: Each required by 37.5% of roles (3/8 jobs).

-Cloud & Enterprise Platforms:Azure,AWS,Oracle,Power BI,Go,and Atlassian toolchains(Jira/Confluence/Bitbucket) each appear in 25% of listings (2/8 jobs).
*/
