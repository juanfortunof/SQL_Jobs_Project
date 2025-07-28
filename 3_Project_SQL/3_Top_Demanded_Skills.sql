/*

Question: What are  the most in-demand skills for Data Scientists and Machine Learning Engineers?

- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the most valuable skills for job seekers.*/

SELECT
    COUNT(*) AS job_count,
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
    job_count DESC
LIMIT 
    5;

    