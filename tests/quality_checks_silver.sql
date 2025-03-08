/*
Purpose:
This script performs comprehensive data quality checks across various project tables.
It validates data consistency, detects anomalies, and ensures adherence to data standards.
Checks include whitespace issues, duplicates, invalid dates, unexpected prefixes, and integrity constraints.
These validations support maintaining high-quality, reliable data in our project repository.
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Data Quality Check: Identify customers whose first or last names contain extra whitespace.
SELECT cst_firstname, cst_lastname
FROM silver.crm_cust_info
WHERE cst_firstname != trim(crm_cust_info.cst_firstname)
   OR cst_lastname != trim(crm_cust_info.cst_lastname);

--------------------------------------------------
-- Data Quality Check: Retrieve all distinct marital status values to verify consistency.
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info;

--------------------------------------------------
-- Data Quality Check: Retrieve all distinct gender values to verify data integrity.
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;

---------------------------
-- Data Quality Check: Identify duplicate customer IDs or missing IDs.
SELECT crm_cust_info.cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY crm_cust_info.cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

----------------------------
-- Data Quality Check: Ensure customer IDs contain only numeric characters.
SELECT cst_id
FROM silver.crm_cust_info
WHERE cst_id::TEXT !~ '^[0-9]+$';

------------------------------
-- Data Quality Check: Check if any text fields contain numeric characters.
SELECT cst_firstname, cst_lastname, cst_marital_status, cst_gndr
FROM silver.crm_cust_info
WHERE 
    cst_firstname ~ '[0-9]' OR
    cst_lastname ~ '[0-9]' OR
    cst_marital_status ~ '[0-9]' OR
    cst_gndr ~ '[0-9]';

--------------------------------------
-- Data Quality Check: Identify records missing a creation date.
SELECT cst_create_date 
FROM silver.crm_cust_info
WHERE cst_create_date IS NULL;


-- ====================================================================
-- Checking 'silver.crm_prd_info'
-- ====================================================================
-- Data Quality Check: Identify duplicate product IDs in the Silver layer.
SELECT prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

---------------------------
-- Data Quality Check: Find records in Silver where the product key is missing.
SELECT prd_key
FROM silver.crm_prd_info
WHERE prd_key IS NULL;

--------------------------------------------------------
-- Data Quality Check: Identify duplicate product records in Silver.
SELECT prd_id, prd_key, prd_nm, COUNT(*) AS cnt
FROM silver.crm_prd_info
GROUP BY prd_id, prd_key, prd_nm
HAVING COUNT(*) > 1;

-----------------------------------------------
-- Data Quality Check: Check for extra whitespace in product names.
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != trim(prd_nm);

---------------------------------
-- Data Quality Check: Validate that product costs are not negative and are present.
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-------------------------------------
-- Data Quality Check: Retrieve distinct product lines to verify consistency.
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

----------------------------------
-- Data Quality Check: Identify records where the product start date is later than the end date.
SELECT *
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt;


-- ====================================================================
-- Checking 'silver.crm_sales_details'
-- ====================================================================
-- Data Quality Check: Identify sales records in Silver where the order number has extra whitespace.
SELECT *
FROM silver.crm_sales_details
WHERE sls_ord_num != trim(sls_ord_num);

------------------------------------------
-- Data Quality Check: Find sales records where the order date is later than ship or due dates.
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

----------------------------------------------------------
-- Data Quality Check: Validate sales data integrity.
SELECT sls_price, sls_quantity, sls_sales
FROM silver.crm_sales_details
WHERE (sls_price * sls_quantity != sls_sales)
   OR (sls_price IS NULL OR sls_quantity IS NULL OR sls_sales IS NULL)
   OR (sls_price <= 0 OR sls_quantity <= 0 OR sls_sales <= 0)
ORDER BY sls_price, sls_quantity, sls_sales;


-- ====================================================================
-- Checking 'bronze.erp_cust_az12'
-- ====================================================================
-- Data Quality Check: Retrieve records from ERP customer table where the customer ID starts with 'NASA'.
SELECT *
FROM bronze.erp_cust_az12  
WHERE cid LIKE 'NASA%';

------------------------------------------------------------
-- Data Quality Check: Verify birth date values.
SELECT *
FROM bronze.erp_cust_az12;

SELECT NOW();

SELECT bdate
FROM bronze.erp_cust_az12 
WHERE bdate < '1924-01-01' OR bdate > NOW();

--------------------------------------------
-- Data Quality Check: Retrieve all distinct gender values.
SELECT DISTINCT gen 
FROM bronze.erp_cust_az12;


-- ====================================================================
-- Checking 'bronze.erp_loc_a101'
-- ====================================================================
-- Data Quality Check: Retrieve all customer IDs from the ERP location table.
SELECT cid
FROM bronze.erp_loc_a101;

-----------------------
-- Data Quality Check: Retrieve distinct country codes from the ERP location table.
SELECT DISTINCT cntry
FROM bronze.erp_loc_a101;


-- ====================================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- ====================================================================
-- Data Quality Check: Check for unwanted spaces in category, subcategory, or maintenance fields.
SELECT * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Data Quality Check: Retrieve distinct maintenance values to verify data standardization.
SELECT DISTINCT maintenance 
FROM silver.erp_px_cat_g1v2;
