/*
Answer: What are the top skills based on salary?

- Look at the average salary associated with each skill for Data Scientist/Machine Learning positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Scientists/ Machine Learning.
  and helps identify the most finantially rewarding skills to acquire or improve.
*/

SELECT
    ROUND(AVG(jobs.salary_year_avg), 2) AS Average_Salary,
    skills_dim.skills AS skill
FROM
    job_postings_fact AS jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id 
WHERE
    (jobs.job_title_short LIKE 'Data Scientist%' OR jobs.job_title_short LIKE '%Machine Learning%') 
    AND jobs.salary_year_avg IS NOT NULL 
    AND jobs.job_country NOT IN ('United States', 'Sudan')
GROUP BY
    skill
ORDER BY
    Average_Salary DESC;


    