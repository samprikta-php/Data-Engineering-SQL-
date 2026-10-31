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

## Data Engineering Skills Demonstrated

1. ETL Pipeline Development

- Extract: Loads raw CSV files directly from Google Cloud Storage using DuckDB's `httpfs` extension.
- Transform: Performs data cleaning, normalization, data type conversions (`CAST`, `DATE_TRUNC`), and quality filtering.
- Load: Implements repeatable and idempotent table creation using `DROP TABLE IF EXISTS` patterns.

2. Incremental Data Processing

- Implements `MERGE` statements to handle incremental data updates through `INSERT`, `UPDATE`, and `DELETE` operations within a single statement.
- Ensures efficient synchronization of target tables with updated source data.

3. Pipeline Orchestration

- Uses a master SQL script (`build_dw_marts.sql`) to coordinate and execute the complete data pipeline.
- Automates the execution of data warehouse transformation and mart-building processes.

## Dimensional Modeling Skills Demonstrated

1. Star Schema Design

- Designs a dimensional data model with a central fact table (`job_postings_fact`) connected to dimension tables such as `company_dim` and `skills_dim`.
- Establishes clear relationships between fact and dimension tables to support analytical queries.

2. Bridge Table Implementation

- Handles many-to-many relationships using bridge tables such as `skills_job_dim`, `bridge_company_location`, and `bridge_job_title`.
- Enables flexible analysis across multiple business dimensions.

3. Grain Definition

- Defines clear fact table granularity to ensure accurate data representation at different levels of analysis, including:

- Skill + Month
- Company + Job Title + Location + Month

4. Additive Measures

- Implements additive metrics, including counts and sums, that can be consistently aggregated across relevant dimensions.

5. Surrogate Key Generation

- Demonstrates sequential surrogate key generation using CTEs and self-joins.
- Applies this approach optionally during the `company_mart` build process.


## Advanced SQL Techniques Demonstrated

1. DDL (Data Definition Language) Operations

- Uses `CREATE TABLE`, `DROP TABLE`, and `CREATE SCHEMA` to manage database structures and organize data warehouse objects.

2. DML (Data Manipulation Language) Operations

- Implements `INSERT INTO ... SELECT` statements with explicit column mapping to load and transform data from CSV sources.

3. MERGE Operations

- Implements incremental data processing using `MERGE INTO` with `WHEN MATCHED`, `WHEN NOT MATCHED`, and `WHEN NOT MATCHED BY SOURCE` clauses.
- Demonstrates production-ready upsert patterns to handle inserts, updates, and deletions within a single statement.

4. Common Table Expressions (CTEs)

- Uses CTEs to structure complex SQL transformations, simplify query logic, and convert categorical values into boolean flags.

5. Date and Time Functions

- Applies `DATE_TRUNC('month')` and `EXTRACT(quarter)` to create time-based dimensions and support temporal analysis.

6. String Manipulation Functions

- Uses `STRING_AGG` to concatenate values and `REPLACE` to clean and standardize string data.

7. Conditional and Boolean Logic

- Implements `CASE WHEN` expressions to convert categorical attributes into aggregatable flags, including remote work availability, health insurance benefits, and degree requirements.

## Data Quality & Production-Ready Practices

1. Idempotent Pipeline Execution

- Designs scripts to be safely re-executed without creating duplicate records or unintended side effects.
- Ensures consistent results across repeated pipeline runs.

2. Data Validation & Integrity

- Incorporates validation queries at each stage of the pipeline to verify data accuracy, consistency, and completeness.
- Helps identify data quality issues early in the transformation process.

3. Data Type Management

- Defines appropriate data types, including `VARCHAR`, `INTEGER`, `DOUBLE`, `BOOLEAN`, and `TIMESTAMP`, to ensure data consistency and type safety.

4. Schema Organization

- Organizes database objects into dedicated schemas (`flat_mart`, `skills_mart`, `priority_mart`, and `company_mart`) for better modularity, maintainability, and logical separation.

5. Error Handling & Execution Monitoring

- Structures SQL script execution with clear error reporting and progress indicators.
- Improves pipeline traceability, troubleshooting, and operational reliability.




