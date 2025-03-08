# sql-data-warehouse-project

![Project Architecture](docs/Data_warhouse.drawio (1).png)

- **Bronze Layer:** Raw data ingestion from source systems (ERP, CRM) with minimal or no transformation.
- **Silver Layer:** Cleaned, standardized, and enriched data for intermediate processing.
- **Gold Layer:** Business-ready data models (dimensions and facts) for analytics and reporting.

# Data Warehouse & Analytics Project

Welcome to the **Data Warehouse & Analytics Project** repository! This project showcases a comprehensive data warehousing and analytics solution, from ingestion of raw data to delivering actionable insights. By following industry best practices, this repository highlights modern techniques in **Data Engineering**, **Data Modeling**, and **Data Analytics**.

---

## Table of Contents
1. [Introduction](#introduction)  
2. [Data Architecture](#data-architecture)  
3. [Project Overview](#project-overview)  
4. [Skills & Expertise](#skills--expertise)  
5. [Tools & Resources](#tools--resources)  
6. [Project Requirements](#project-requirements)  
   - [Data Engineering](#data-engineering)  
   - [Data Analysis](#data-analysis)  
7. [Repository Structure](#repository-structure)  
8. [License](#license)

---

## Introduction
In today’s data-driven world, organizations rely on efficient data pipelines and robust analytics platforms to make informed decisions. This repository demonstrates a modern approach to building a **Data Warehouse** using the **Medallion Architecture**—Bronze, Silver, and Gold layers—enabling you to:

- Ingest data from various sources (ERP, CRM)  
- Cleanse and standardize data  
- Model data for business intelligence  
- Deliver insights via SQL-based reports and dashboards  

Whether you’re a professional looking to refine your skills or a student eager to learn, this project offers a hands-on experience in designing and implementing an end-to-end data solution.

---

## Data Architecture
Below is a high-level illustration of the **Medallion Architecture** approach:

1. **Bronze Layer**  
   - **Raw Data** stored as-is from CSV files (CRM, ERP).  
   - **No transformations** applied.  
   - Data model: *None (as-is)*.  
   - **Load**: Batch processing, full load, truncate & insert.

2. **Silver Layer**  
   - **Cleaned & Standardized Data**.  
   - **Transformations**: Data cleansing, standardization, normalization, derived columns, data enrichment.  
   - Data model: *None (as-is)*.  
   - **Load**: Batch processing, full load, truncate & insert.

3. **Gold Layer**  
   - **Business-Ready Data**.  
   - **Transformations**: Data integration, aggregations, business logic.  
   - Data model: *Star schema, Flat tables, Aggregated tables*.  
   - **Object Type**: Views (no additional load).

These layers collectively enable a **robust, scalable, and efficient** data warehouse, ready to be consumed by various analytics tools.

---

## Project Overview
### Key Components:
- **Data Architecture**: Implements a Modern Data Warehouse using **Bronze, Silver, and Gold** layers.  
- **ETL Pipelines**: Extract, transform, and load data from CSV sources into a SQL Server database.  
- **Data Modeling**: Design **fact** and **dimension** tables for optimal analytical queries.  
- **Analytics & Reporting**: Generate insights with SQL queries, BI tools, and dashboards.

---

## Skills & Expertise
This project is ideal for showcasing or developing expertise in:
- **SQL Development**  
- **Data Architecture**  
- **Data Engineering**  
- **ETL Pipeline Development**  
- **Data Modeling**  
- **Data Analytics**

---

## Tools & Resources
- **Datasets**: CSV files from ERP and CRM systems.  
- **SQL Server Express**: Lightweight database engine for hosting the warehouse.  
- **SQL Server Management Studio (SSMS)**: Graphical interface for managing and querying databases.  
- **Git & GitHub**: Version control and collaboration platform.  
- **DrawIO**: Create and maintain diagrams for data flow, architecture, and modeling.  
- **Notion**: Organize project tasks, notes, and documentation.  
- **Notion Project Steps**: Detailed phases and tasks for the entire project lifecycle.  

All tools listed are **free** to use.

---

## Project Requirements
### Data Engineering
**Objective**  
Develop a modern data warehouse using SQL Server to centralize sales data, enabling robust analytics and decision-making.

**Specifications**  
- **Data Sources**: Two CSV files (ERP & CRM).  
- **Data Quality**: Cleanse data to resolve quality issues.  
- **Integration**: Combine sources into a single, analytics-friendly data model.  
- **Scope**: Focus on the latest dataset only; no historization required.  
- **Documentation**: Provide a clear data model for stakeholders and analytics teams.

### Data Analysis
**Objective**  
Create **SQL-based analytics** that offer detailed insights into:
- **Customer Behavior**  
- **Product Performance**  
- **Sales Trends**  

These insights drive strategic decisions and surface key business metrics.

---

## Repository Structure
```plaintext
data-warehouse-project/
│
├── datasets/                           # Raw CSV files (ERP, CRM)
│
├── docs/                               # Project documentation & diagrams
│   ├── etl.drawio                      # Visual ETL processes
│   ├── data_architecture.drawio        # High-level architecture
│   ├── data_catalog.md                 # Dataset field descriptions
│   ├── data_flow.drawio                # Data flow diagram
│   ├── data_models.drawio              # Star schema & other models
│   ├── naming-conventions.md           # Guidelines for tables, columns, etc.
│
├── scripts/                            # SQL scripts for ETL & transformations
│   ├── bronze/                         # Extract & load raw data
│   ├── silver/                         # Clean & transform data
│   ├── gold/                           # Create analytical models
│
├── tests/                              # Test scripts & quality checks
│
├── README.md                           # Project overview & instructions
├── LICENSE                             # License information
├── .gitignore                          # Ignored files & folders
└── requirements.txt                    # Dependencies & requirements
