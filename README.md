# iag_project

A dbt project for transforming and and build pipeline for StackOverflow dataset.  
This project organizes raw sources into staging models for transformation and finally the fact tables for aggregated records.

---
---

## 🚀 Getting Started

### 1. Install dbt
Make sure you have dbt installed. For example, with pip:
pip install dbt-core

### 2. Clone the repository
git clone https://github.com/sbutola007/iag_project.git
cd iag_project

### 3. Set up your profiles.yml
iag_project:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: "/Users/technofun/db/iag_project.duckdb"
      extensions: ['parquet', 'httpfs']
      threads: 4


### 4. Install dependencies
dbt deps

### 5. Run the project
dbt run


### 6. Test the models
dbt test

### 7. Generate docs
dbt docs generate
dbt docs serve
