# Data Warehouse & Mart Build:Production ETL Pipleline
Built an end-to-end data engineering pipeline that ingests raw CSV files from Google Cloud Storage, transforms them into a star-schema data warehouse, and develops analytical data marts to support reporting and business insights.
<img width="1620" height="768" alt="image" src="https://github.com/user-attachments/assets/4bfc6a6b-1147-4454-a5b2-58ac95eac7c8" />
🧾 Executive Summary (For Hiring Managers)<br/>
✅ Pipeline scope:  Built a complete data engineering pipeline to transform raw CSV files into a star-schema data warehouse and analytical data marts.<br/>
✅ Data modeling: Designed a star schema with fact tables, dimensions, and bridge tables for many-to-many relationships.<br/>
✅ ETL development:  Implemented robust Extract, Transform, Load (ETL) workflows with idempotent processing and data quality validation.<br/>
✅ Mart architecture: Developed specialized analytical data marts (Flat, Skills, and Priority) with additive measures and incremental update strategies to support efficient reporting and analysis.<br/>
# Problem :
 Raw job posting data is stored in flat CSV files in Google Cloud Storage, making it difficult for analysts to efficiently query the data and extract meaningful insights.
 Which skills are most in-demand over time?
 What are hiring trends by company and location?
 How do salary patterns vary by role and skill?
# Challenge :
Data teams need a centralized data warehouse to ensure consistent, reliable, and standardized analytics across the organization. They also require specialized data marts that use pre-aggregated data to reduce query complexity, optimize resource utilization, and improve performance for frequently used analytical queries.

# Solution:
Develop an end-to-end ETL pipeline to extract CSV files from Google Cloud Storage, transform and normalize the data into a star schema data warehouse with separate fact and dimension tables, and build specialized data marts for flat queries, skill demand analysis, and priority role tracking to improve query performance and support targeted business insights.

## Pipeline Architecture-
<img width="1620" height="768" alt="image" src="https://github.com/user-attachments/assets/c723c56b-960c-48ad-a77a-e58b3205a6a8" />

🧰 Technology Used:  

☁️ Data Source: Google Cloud Storage (GCS) for storing raw job posting data in CSV format.  
🦆 Analytical Database: DuckDB for high-performance analytical processing, with the httpfs extension enabling access to files stored in GCS.  
💻 Query Language: SQL for creating database structures, ingesting raw data, transforming datasets, and building analytical tables.  
🏗️ Data Architecture: Star schema design using fact, dimension, and bridge tables to organize job market data for efficient analysis.  
🛠️ Development Environment: Visual Studio Code for writing and maintaining SQL scripts, alongside the DuckDB CLI for executing database operations.  
⚙️ ETL Automation: A centralized master SQL script to coordinate data extraction, transformation, loading, and data mart creation.  
🔄 Source Control: Git and GitHub for versioning SQL scripts, tracking modifications, and maintaining the project codebase.  


### Data Warehouse
The data warehouse follows a star schema architecture, comprising `company_dim`, `skills_dim`, `job_postings_fact`, and `skills_job_dim` tables to organize job posting data and enable efficient, structured analytical queries. 
<img width="1586" height="1254" alt="1_2_Data_Warehouse" src="https://github.com/user-attachments/assets/b7bb839b-0121-468a-91a7-eec71e6631d8" />

SQL Files:

- `01_create_tables_dw.sql` – Creates the data warehouse star schema with four core tables.
- `02_load_schema_dw.sql` – Extracts CSV files from Google Cloud Storage (GCS) and loads the data into the warehouse tables.

Purpose: Establishes a centralized, reliable source of truth for analytical queries using a star schema.

Grain: One row per job posting in the `job_postings_fact` table.  
FLAT MART:
<img width="1656" height="1248" alt="1_2_Flat_Mart" src="https://github.com/user-attachments/assets/f97b7688-f813-4ba3-b26f-9018df708104" />
SQL File: `03_create_flat_mart.sql` – Creates a consolidated, denormalized table by joining all relevant dimensions.

Purpose: Provides a unified, query-ready dataset for efficient ad-hoc analysis and reporting.

Grain: One row per job posting, enriched with all associated dimensional attributes.
<img width="1644" height="728" alt="1_2_Skills_Mart" src="https://github.com/user-attachments/assets/4c4a63e1-34e9-4d8a-af8a-b780f5d5b358" />

A consolidated, denormalized table containing all relevant dimensional attributes to enable simplified and flexible ad-hoc querying.
Priority Mart
Priority role tracking with incremental updates using MERGE operations.
<img width="1976" height="1316" alt="1_2_Priority_Mart" src="https://github.com/user-attachments/assets/015f1e2b-be2a-4dff-adbd-34f11a50e889" />
SQL Files:
05_create_priority_mart.sql – Initial build of priority roles and jobs snapshot
06_update_priority_mart.sql – Incremental update using MERGE (upsert pattern)  

Purpose: Maintain a prioritized record of job postings and track job snapshot changes over time.

Grain: One row per job posting, with an assigned priority level.

Key Features: Implements `MERGE` operations for incremental data updates, demonstrating production-ready upsert patterns that support `INSERT`, `UPDATE`, and `DELETE` operations within a single statement.

