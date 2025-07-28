/*  
Question: What skills are required for the top-paying data scientist jobs?  

- Use the top 10 highest-paying Data Scientist jobs from first query  

- Add the specific skills required for these roles  

- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
  helping job seekers understand which skills to develop that align with top salaries  

*/

SELECT
    jobs.*,
    skills_dim.skills AS skills
FROM(
    SELECT
        job_postings_fact.job_id AS job_id,
        job_postings_fact.job_title_short AS Job_Title,
        job_postings_fact.job_via AS Job_Via,
        job_postings_fact.job_schedule_type AS Job_Schedule,
        job_postings_fact.job_health_insurance AS Health_Insurance,
        job_postings_fact.job_country AS Country,
        job_postings_fact.salary_year_avg AS Salary_per_year,
        company_dim.name AS Company_Name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE 
       (job_title_short LIKE 'Data Scientist%' OR job_title_short LIKE '%Machine Learning%') AND
        AND job_location IN ('Remote', 'Anywhere') 
        AND salary_year_avg IS NOT NULL 
        AND job_country NOT IN ('United States', 'Sudan')
    ORDER BY
        salary_year_avg DESC
    LIMIT 
        10) AS jobs

INNER JOIN skills_job_dim ON skills_job_dim.job_id = jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id   
ORDER BY
    Salary_per_year DESC;

