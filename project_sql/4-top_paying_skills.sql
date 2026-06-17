/*
 Query Purpose: Financial Premium Analysis by Technical Skillset
 Description:   Calculates and ranks global average annual salary benchmarks per technical skill.
 Data Strategy: Executes an inner join across postings and skill indices, filtering out undisclosed salaries.
 Strategic Use: Maps the direct economic value of technical competencies, allowing professionals 
 to focus their development on maximum-earning platforms and architectures.
 */
--SQL Query starts below...

SELECT skills,
    round(avg(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg is NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
limit 25

    /*
     ===============================================================================
     EXECUTIVE SUMMARY & KEY INSIGHTS (HIGHEST PAYING SKILLS)
     ===============================================================================
     1. Premium Niche Valuation: High-yield tech stacks value specialized execution 
     over raw market volume. Web3 infrastructure (Solidity) and NoSQL scaling 
     architectures (Couchbase) command the market's peak monetization tiers.
     
     2. AI & Deep Learning Density: Frameworks linked to predictive modeling, neural 
     networks, and natural language processing (PyTorch, Keras, Hugging Face, 
     TensorFlow) cluster tightly between $120k–$127k, reflecting an active enterprise 
     investment premium.
     
     3. The Operations Convergence: Data automation and deployment engineering 
     capabilities (Terraform, Kafka, Airflow) reflect an increasing organizational 
     willingness to incentivize professionals managing large-scale, automated 
     data delivery pipelines.
     ===============================================================================
     */