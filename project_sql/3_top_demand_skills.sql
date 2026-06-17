/*
 Query Purpose: Macro Market Demand Analysis for Skills
 Description:   Identifies the top 5 most frequently requested skills across all unfiltered job postings.
 Data Strategy: Executes a structural inner join across the core postings and skills schemas.
 Strategic Use: Benchmarks foundational market expectations, allowing professionals to align 
 their core capabilities with maximum volume-based hiring patterns.
 */
--SQL Query starts below...

SELECT skills,
    count(skills_job_dim.job_id) as Demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
    ORDER BY Demand_count DESC
limit 5

/*
===============================================================================
EXECUTIVE SUMMARY & KEY INSIGHTS (MACRO MARKET DEMAND)
===============================================================================
1. Foundational Baseline: SQL dominates wide-scale market demand with over 92k 
   postings (30.6%), confirming it as an absolute prerequisite for modern 
   data analytics infrastructure.

2. Business Criticality: Excel remains a critical pillar of business operations, 
   securing the #2 spot (22.1%) and pacing ahead of pure development languages.

3. Visualization Ecosystem: Modern Business Intelligence is dominated by a 
   two-way market split. Tableau retains a minor competitive edge (15.4%) 
   over Power BI (13.0%) across unfiltered global vacancies.
===============================================================================
*/