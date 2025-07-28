/*
Question: What are the top-paying data scientist jobs?

- Identify the top 10 highest-paying Data Scientist roles that are available 
   remotely but just for countries outside of the US.

- Focus on job postings with specified salaries (remove nulls).

- Why? Highlight the top-paying opportunities for Data Scientists, 
  offering insights into employment opportunities.
*/


SELECT
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
    (job_title_short LIKE 'Data Scientist%' OR job_title_short LIKE '%Machine Learning%') 
    AND job_location IN ('Remote', 'Anywhere')
    AND salary_year_avg IS NOT NULL 
    AND job_country NOT IN ('United States', 'Sudan')
ORDER BY
    salary_year_avg DESC
LIMIT 
    10;


