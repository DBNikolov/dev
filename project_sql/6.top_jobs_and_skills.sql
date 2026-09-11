/* 
TASK:
    1.WHICH ARE THE TOP PAYING JOBS BASED ON AVERAGE SALARY.
    2.WHICH ARE THE MOST REQUIRED SKILLS FOR THE MOST PAYING JOBS.
*/

SELECT 
    job_title_short,
    ROUND(AVG (salary_year_avg),0) AS avg_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY avg_salary DESC

/* 
THE TOP 5 HIGHEST PAID JOBS ON AVERAGE ARE:
    1.SENIOR DATA SCIENTIST
    2.SENIOR DATA ENGINEER
    3.DATA SCIENTIST
    4.DATA ENGINEER
    5.MACHINE LEARINING OPERATOR
*/


SELECT 
    skills,
    COUNT (job_postings_fact.job_id) AS jobs_count
FROM job_postings_fact
JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Scientist' OR
    job_title_short = 'Senior Data Scientist' OR
    job_title_short = 'Machine Learning Engineer' OR
    job_title_short = 'Data Engineer' OR
    job_title_short = 'Senior Data Engineer') AND
    salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY jobs_count DESC
LIMIT 10;

/* 
THE TOP 10 MOST REQUIRED SKILLS FOR THE TOP 5 PAYING JOBS ARE:

    1.PYTHON
    2.SQL
    3.AWS
    4.SPARK
    5.R
    6.AZURE
    7.JAVA
    8.TABLEAU
    9.HADOOP
    10.SNOWFLAKE
*/