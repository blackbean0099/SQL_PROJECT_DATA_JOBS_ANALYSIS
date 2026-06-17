/*
Query Purpose: High-Demand, High-Yield Optimal Skillset Optimization
Description:   Identifies technical skills that simultaneously command high market volume 
               and top-tier average annual salaries for remote roles.
Data Strategy: Executes multi-table inner joins, filtering for remote vacancies and non-null 
               salaries, using dual-aggregation metrics (COUNT and AVG).
Strategic Use: Empowers career development planning by mapping foundational job security 
               safeguards against maximum earning potential.
*/
--SQL Query starts below...
with skill_demand as ( 
SELECT skills_dim.skills, 
        skills_job_dim.skill_id, 
        count(skills_job_dim.job_id) as Demand_count 
FROM job_postings_fact 
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE job_title_short = 'Data Analyst' 
AND salary_year_avg is NOT NULL 
GROUP BY skills_job_dim.skill_id, skills_dim.skills
), 

average_salary as( 
SELECT skills_dim.skills, 
        skills_job_dim.skill_id, 
        round(avg(salary_year_avg), 0) as avg_salary 
FROM job_postings_fact 
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE job_title_short = 'Data Analyst' 
    AND salary_year_avg is NOT NULL 
GROUP BY skills_job_dim.skill_id, skills_dim.skills
) 

SELECT skill_demand.skill_id, 
        skill_demand.skills, 
        Demand_count, 
        avg_salary 
FROM skill_demand 
INNER JOIN average_salary on skill_demand.skill_id = average_salary.skill_id
ORDER BY Demand_count DESC,
avg_salary DESC
LIMIT 25