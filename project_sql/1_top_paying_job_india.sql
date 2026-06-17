/*
 Query Purpose: Peak Market Value Analysis for Indian market
 Description:   Isolates the top 10 highest-paying remote Data Analyst positions.
 Data Cleaning: Filters out job postings missing explicit financial compensation (IS NOT NULL).
 Strategic Use: Benchmarks premium earning potential and identifies top-tier 
 employment opportunities within the current remote job market.
 */
-- SQL Query starts below...

SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM job_postings_fact
    LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'India'
    AND salary_year_avg is NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10