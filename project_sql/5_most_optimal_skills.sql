/*
TASK:
    1.IDENTIFY THE MOST OPTIMAL SKILLS BASED ON HIGH SALARY AND HIGH NUMBER OF JOB POSTINGS FOR DATA ANALYST POSITION.
    2.COMPARE THE RESULTS FOR SKILLS WHEN PRIORITY IS HIGH SALARY AND WHEN PRIORITY IS HIGH NUMBER OF JOB POSTINGS.
*/

--RESULTS BASED ON THE JOB POSTINGS AS A PRIORITY.

SELECT 
    skills_dim.skill_id,
    skills,
    ROUND(AVG (salary_year_avg),0) AS avg_salary,
    COUNT (job_postings_fact.job_id) AS total_jobs
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY skills,skills_dim.skill_id
ORDER BY total_jobs DESC,avg_salary DESC
LIMIT 10;

/*
RESULTS BASED ON HIGH SALARY AS A PRIORITY. 
    ADDITIONAL FILTER WHERE NUMBER OF JOBS POSTINGS IS HIGHER THAN 35 IS ADDED HERE TO AVOID ANOMALIES OF JOBS WITH VERY HIGH SALARY BUT ONLY FEW POSTINGS. 
*/

SELECT 
    skills_dim.skill_id,
    skills,
    ROUND(AVG (salary_year_avg),0) AS avg_salary,
    COUNT (job_postings_fact.job_id) AS total_jobs
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY skills,skills_dim.skill_id
HAVING COUNT (job_postings_fact.job_id) > 35
ORDER BY avg_salary DESC,total_jobs DESC
LIMIT 10;


/* 

    -High-volume skills present lower barriers to entry with high market liquidity, but cap out near ~$101k (python). 

    -High-salary skills require specialized engineering capabilities (kafka, pyspark, airflow) that command a ~20–30% salary premium over broad analyst tools.

    -The demand list reflects General Analyst / BI Roles (sql, excel, tableau, power bi). 
    
    -The salary list reflects Data Engineering & DevOps Roles (spark, databricks, gcp, git, linux).

    -Sql and python represent the baseline prerequisite skills required to get through automated resume screening. 
    
    -Tools like kafka ($130k) or airflow ($116k) act as ceiling raisers for senior engineering roles.
*/