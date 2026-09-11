/* 
TASK:
    1.FIND THE HIGHEST PAYING SKILLS FOR DATA ANALYST POSITION BASED ON THE SALARY FOR ALL JOB POSTINGS .
    2.COMPARE IT TO THE JOBS THAT ARE REMOTE ONLY.
*/

--FIND THE HIGHEST PAYING SKILLS BASED ON THE SALARY FOR ALL JOBS.

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 10;

--FIND THE HIGHEST PAYING SKILLS FOR REMOTE JOBS ONLY.

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 10;


/*
    -ALL Jobs leans heavily toward lower-level infrastructure, legacy systems, and niche specialized tech (Solidity, VMware, Golang, Terraform). 

    -Home Jobs shifts heavily toward Data Science / Data Engineering (PySpark, Pandas, Jupyter) and asynchronous collaboration tools (Bitbucket, GitLab).
    
    -Only 2 out of 10 skills overlap across both lists: Couchbase ($160,515) and DataRobot ($155,486).

    -Remote positions have a higher median baseline ($154,993 vs. $152,000) and far lower variance (std dev of ~$19.7k vs. ~$78.8k), 
    indicating more predictable salary bands for work-from-home roles.
*/