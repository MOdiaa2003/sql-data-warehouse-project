# Naming Conventions

This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the data warehouse.

---

## Table of Contents
- [General Principles](#general-principles)
- [Table Naming Conventions](#table-naming-conventions)
  - [Bronze Rules](#bronze-rules)
  - [Silver Rules](#silver-rules)
  - [Gold Rules](#gold-rules)
- [Column Naming Conventions](#column-naming-conventions)
  - [Surrogate Keys](#surrogate-keys)
  - [Technical Columns](#technical-columns)
- [Stored Procedures](#stored-procedures)

---

## General Principles
- **Naming Conventions:** Use `snake_case` with lowercase letters and underscores (`_`) to separate words.
- **Language:** Use English for all names.
- **Avoid Reserved Words:** Do not use SQL reserved words as object names.

---

## Table Naming Conventions

### Bronze Rules
- **Format:** `<sourcesystem>_<entity>`
  - **sourcesystem:** Name of the source system (e.g., `crm`, `erp`).
  - **entity:** Exact table name from the source system.
- **Example:** `crm_customer_info` – Represents customer information from the CRM system.

### Silver Rules
- **Format:** `<sourcesystem>_<entity>`
  - **sourcesystem:** Name of the source system (e.g., `crm`, `erp`).
  - **entity:** Exact table name from the source system.
- **Example:** `crm_customer_info` – Represents customer information from the CRM system.

### Gold Rules
- **Format:** `<category>_<entity>`
  - **category:** Describes the role of the table, such as `dim` (dimension) or `fact` (fact table).
  - **entity:** Descriptive name of the table aligned with the business domain.
- **Examples:**
  - `dim_customers` – Dimension table for customer data.
  - `fact_sales` – Fact table containing sales transactions.

---

## Column Naming Conventions

### Surrogate Keys
- **Format:** `<table_name>_key`
  - **table_name:** Refers to the name of the table or entity.
  - **_key:** Suffix indicating a surrogate key.
- **Example:** `customer_key` in the `dim_customers` table.

### Technical Columns
- **Format:** `dwh_<column_name>`
  - **dwh:** Prefix for system-generated metadata.
  - **column_name:** Descriptive name indicating the column's purpose.
- **Example:** `dwh_load_date` – Stores the date when the record was loaded.

---

## Stored Procedures
- **Naming Pattern:** `load_<layer>`
  - **layer:** The layer being loaded (e.g., `bronze`, `silver`, or `gold`).
- **Examples:**
  - `load_bronze` – Stored procedure for loading data into the Bronze layer.
  - `load_silver` – Stored procedure for loading data into the Silver layer.
  - `load_gold` – Stored procedure for loading data into the Gold layer.
