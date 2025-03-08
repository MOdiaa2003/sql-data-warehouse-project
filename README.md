# sql-data-warehouse-project

![Project Architecture](docs/Data_warhouse.drawio%20(1).png)

- **Bronze Layer:** Raw data ingestion from source systems (ERP, CRM) with minimal or no transformation.
- **Silver Layer:** Cleaned, standardized, and enriched data for intermediate processing.
- **Gold Layer:** Business-ready data models (dimensions and facts) for analytics and reporting.

# Data Warehouse & Analytics Project

Welcome to the **Data Warehouse & Analytics Project** repository! This project showcases a comprehensive data warehousing and analytics solution—from raw data ingestion to delivering actionable insights. The project is built using modern data engineering practices and follows the Medallion Architecture (Bronze, Silver, Gold) to ensure clean, reliable data for business intelligence.

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
In today’s data-driven world, efficient data pipelines and robust analytics platforms are essential for informed decision-making. This repository demonstrates how to build a modern Data Warehouse using a layered approach, enabling:
- Ingestion of raw data from multiple sources (ERP, CRM)
- Cleansing, standardization, and enrichment of data
- Creation of analytical models with fact and dimension views
- Delivery of insights through SQL-based reporting

---

## Data Architecture
**Medallion Architecture Overview:**

1. **Bronze Layer:**  
   - **Raw Data:** Ingests data from source systems with no or minimal transformation.
   - **Storage:** Data is stored as-is, preserving its original format.

2. **Silver Layer:**  
   - **Cleansed Data:** Data is cleaned, standardized, and enriched.
   - **Transformation:** Includes necessary data validations and enrichment processes.

3. **Gold Layer:**  
   - **Business-Ready Data:** Data is integrated and modeled into dimensions and facts.
   - **Usage:** Supports reporting, analytics, and business intelligence.

---

## Project Overview
### Key Components:
- **Data Architecture:** Implements the Medallion Architecture (Bronze, Silver, Gold).
- **ETL Pipelines:** Extract, transform, and load data from CSV sources into a PostgreSQL data warehouse.
- **Data Modeling:** Designs fact and dimension tables to support analytical queries.
- **Analytics & Reporting:** Provides actionable insights through SQL-based analytics and dashboards.

---

## Skills & Expertise
This project is ideal for showcasing or developing expertise in:
- SQL Development
- Data Architecture & Data Warehousing
- Data Engineering & ETL Pipeline Development
- Data Modeling
- Data Analytics

---

## Tools & Resources
- **Datasets:** Raw CSV files from ERP and CRM systems.
- **PostgreSQL:** Database system hosting the data warehouse.
- **pgAdmin:** Interface for managing and querying PostgreSQL.
- **Git & GitHub:** Version control and collaboration.
- **DrawIO:** For creating and updating architecture and data flow diagrams.
- **Notion:** For organizing project tasks, notes, and documentation.

---

## Project Requirements
### Data Engineering
- **Objective:** Build a modern data warehouse to centralize and standardize sales data.
- **Data Sources:** ERP & CRM CSV files.
- **Data Quality:** Cleanse data to address quality issues.
- **Integration:** Consolidate data into an analytics-friendly model.
- **Scope:** Focus on current data, no historization required.

### Data Analysis
- **Objective:** Provide insights into customer behavior, product performance, and sales trends.
- **Deliverables:** SQL-based reports and dashboards to support strategic decisions.

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
│   └── Data_warhouse.drawio (1).png     # Project architecture diagram
│
├── scripts/                            # SQL scripts for ETL & transformations
│   ├── bronze/                         # Extract & load raw data
│   ├── silver/                         # Clean & transform data
│   └── gold/                           # Create analytical models
│
├── tests/                              # Test scripts & quality checks
│
├── README.md                           # Project overview & instructions
├── LICENSE                             # License information
├── .gitignore                          # Ignored files & folders
└── requirements.txt                    # Dependencies & requirements
