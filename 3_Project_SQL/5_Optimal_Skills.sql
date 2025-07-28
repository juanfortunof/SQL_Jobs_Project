/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?

- Identify skills in high demand and associated with high average salaries for Data Scientist roles
- Concentrates on positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
  offering strategic insights for career development in data science
*/

SELECT
    COUNT(*) AS job_count,
    ROUND(AVG(jobs.salary_year_avg), 0) AS Average_Salary,
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
HAVING
    COUNT(*) > 100
ORDER BY
    job_count DESC,
    Average_Salary DESC;


