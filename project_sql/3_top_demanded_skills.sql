/*  TASKS:

    1.FIND THE TOP 5 IN-DEMAND SKILLS FOR THE DATA ANALYIST POSITION NO MATTER THE JOB TYPE.
    2.CHECK TO SEE IF THERE IS A DIFFERENCE IN RESULTS WHEN THE POSITION IS REMOTE.
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
    job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY jobs_count DESC
LIMIT 5;


-- Checking if the results are different for the remote job postings.

SELECT 
    skills,
    COUNT (job_postings_fact.job_id) AS jobs_count
FROM 
    job_postings_fact
JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    jobs_count DESC
LIMIT 5;

/* 
    1.THE TOP 5 SKILLS THAT ARE IN DEMAND FOR DATA ANALYST POSITION ARE:

        1.SQL
        2.EXCEL
        3.PYTHON
        4.TABLEAU
        5.POWER BI

    2. THERE IS NO CHANGE IN THE ORDER WHEN THE POSITION IS REMOTE.
*/
