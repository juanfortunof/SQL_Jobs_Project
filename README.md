# Introduction

This project explores the job market for Data Scientists and Machine Learning Engineers using real-world job posting data. The goal is to identify top-paying roles, in-demand skills, and optimal career strategies through SQL analysis.

Want to see the SQL Queries? Click [here](/3_Project_SQL/)

# Background

With the rapid growth of data-driven industries, understanding which skills and roles offer the best opportunities is crucial for job seekers. This project analyzes job postings to uncover trends in salaries, skill demand, and remote work opportunities for Data Science professionals.

# Tools I Used

- **SQL** (for data analysis and querying)
- **PostgreSQL** (The database system)
- **Git and Github** (Version control)
- **VS Code** (for code editing and project management)

# The Analysis

I wrote several SQL queries to answer key questions:

1. **Top Paying Jobs**: Identified the highest-paying remote Data Scientist and Machine Learning roles outside the US, focusing on jobs with specified salaries.

```sql
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
```
2. **Top Paying Skills**: Determined which skills are most associated with high salaries in these roles.

```sql
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
```

3. **Top In Demand Skills**: Found the skills most frequently required for Data Scientist and Machine Learning Engineer positions.

```sql
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
```

4. **Skills by Salary**: Analyzed the average salary associated with each skill to highlight the most financially rewarding ones.

```sql
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
```

5. **Optimal Skills**: Combined demand and salary data to recommend skills that offer both high job security and financial benefits.

```sql
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
```

# What I Learned

- Remote opportunities for Data Scientists outside of the US are good and often offer competitive salaries, but the majority of opportunities come from US based companies (Remotely and Onsite), also the highest salaries are usually from US companies.
- Cloud computing skills are essential, Data Scientists and Machine Learning Engineers must know one of them, like AWS, Microsoft Azure and Google Cloud.
- Pytorch and Tensorflow are a must have for data scientist and machine learning engineers.
- There is a high diversity of companies looking for data scientist and mchine learning engineers. Not only the big tech companies appear on the searches.

# Conclusions

Analyzing job postings with SQL provides valuable insights for job seekers in Data Science. By focusing on remote roles, salary data, and skill requirements, it's possible to identify optimal career paths and skillsets to pursue for maximum impact and financial reward.
