/*
 Query Purpose: High-Value Skillset Mapping Analysis
 Description:   Identifies specific technical skills required for the top 10 highest-paying in India.
 Data Lineage:  Dependent on the filtered compensation baseline established in Query 1.
 Strategic Use: Empowers candidates to optimize their learning curriculum by identifying 
 the exact tools and platforms commanding peak market value.
 */
-- SQL Query starts below...

with top_paying_jobs as (
    SELECT job_id,
        job_title,
        job_location,
        salary_year_avg,
        name as company_name
    FROM job_postings_fact
        LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'India'
        AND salary_year_avg is NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
---------------------------------------------------------
/*
===============================================================================
EXECUTIVE SUMMARY & KEY INSIGHTS
===============================================================================
1. The Core Trinity: SQL (70%), Excel (60%), and Python (50%) are the 
   absolute most demanded skills across the highest-paying remote roles.

2. The Skill Premium: In this specific top-tier bracket, BI and workflow 
   tools (Excel, Flow) map to the highest average salaries (~$96k), out-earning 
   niche AI/ML frameworks like TensorFlow and PyTorch (~$79k).

3. Enterprise Footprint: Major corporate entities (Clarivate, Deutsche Bank, 
   Cargill) dominate the premium compensation market, requiring a hybrid 
   knowledge of both modern data stacks and legacy enterprise tools (Oracle).
===============================================================================
*/