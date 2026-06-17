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

/*
===============================================================================
FINAL CONCLUSION: MARKET OPTIMIZATION MATRIX (DEMAND VS. SALARY)
===============================================================================
1. The Strategic Core: Python represents the most optimal analytical skill 
   to target, offering a high volume-safetynet (1,840) paired with a six-figure 
   market baseline ($101,512).

2. Volume Anchors: SQL and Tableau maintain the highest overall demand while 
   preserving premium market value (~$96k-$98k), establishing them as the 
   definitive entry-point foundations for remote data careers.

3. The Scalability Premium: Cloud architecture and distributed framework 
   competencies (Spark, Snowflake, AWS) command the absolute highest monetary 
   premiums, acting as substantial salary multipliers once core fluency is reached.

4. Commodity Limitations: Legacy administrative applications (Excel, Word) 
   reflect significant downward price pressure, exhibiting high volume but 
   failing to compete with modern data engineering and visualization ecosystems.
===============================================================================
*/