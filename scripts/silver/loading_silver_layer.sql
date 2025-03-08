/*
Purpose:
- Automates the Silver layer ETL process by truncating target tables and inserting cleaned, transformed data from the Bronze layer.
- Logs the duration of each load step and the overall process for performance tracking.
- Incorporates robust error handling to capture and report any issues during execution.
- Provides clear notifications throughout, ending with a final success message.
*/
CREATE OR REPLACE PROCEDURE load_silver_layer()
LANGUAGE plpgsql
AS
$$
DECLARE
    batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    duration INTERVAL;
BEGIN
    -- Capture overall batch start time
    batch_start_time := NOW();
    
    -- Initial header prints
    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Silver Layer';
    RAISE NOTICE '================================================';

    ------------------------------------------------------------------
    -- Step 1: Load CRM Customer Information (silver.crm_cust_info)
    ------------------------------------------------------------------
    start_time := NOW();
    RAISE NOTICE '================================================';
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading CRM Tables: silver.crm_cust_info';
    RAISE NOTICE '------------------------------------------------';
    
    RAISE NOTICE '>> Truncating Table: silver.crm_cust_info';
    TRUNCATE TABLE silver.crm_cust_info;
    RAISE NOTICE '>> Inserting Data Into: silver.crm_cust_info';
    
    INSERT INTO silver.crm_cust_info (
        cst_id, 
        cst_key, 
        cst_firstname, 
        cst_lastname, 
        cst_marital_status, 
        cst_gndr,
        cst_create_date
    )
    SELECT 
        cst_id,
        cst_key,
        trim(cst_firstname),
        trim(cst_lastname),
        CASE
            WHEN upper(cst_marital_status) = 'S' THEN 'Single'
            WHEN upper(cst_marital_status) = 'M' THEN 'Married'
            ELSE 'N/a'
        END AS cst_marital_status,
        CASE
            WHEN upper(cst_gndr) = 'F' THEN 'Female'
            WHEN upper(cst_gndr) = 'M' THEN 'Male'
            ELSE 'N/a'
        END AS cst_gndr,
        cst_create_date
    FROM (
         SELECT *, row_number() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag 
         FROM bronze.crm_cust_info
         ) AS res
    WHERE res.flag = 1;
    
    end_time := NOW();
    duration := end_time - start_time;
    RAISE NOTICE 'Duration for Loading CRM Tables (silver.crm_cust_info): %', duration;

    ------------------------------------------------------------------
    -- Step 2: Load CRM Product Information (silver.crm_prd_info)
    ------------------------------------------------------------------
    start_time := NOW();
    RAISE NOTICE '================================================';
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading CRM Product Info: silver.crm_prd_info';
    RAISE NOTICE '------------------------------------------------';
    
    RAISE NOTICE '>> Truncating Table: silver.crm_prd_info';
    TRUNCATE TABLE silver.crm_prd_info;
    RAISE NOTICE '>> Inserting Data Into: silver.crm_prd_info';
    
    INSERT INTO silver.crm_prd_info (
        prd_id,
        cat_id,
        prd_key,
        prd_nm,
        prd_cost,
        prd_line,
        prd_start_dt,
        prd_end_dt
    )
    SELECT  
           prd_id,
           replace(substring(prd_key, 1, 5), '-', '_') AS cat_id,
           substring(prd_key FROM 5 FOR char_length(prd_key)) AS prd_key,
           prd_nm,
           COALESCE(prd_cost, 0) AS prd_cost,
           CASE
                WHEN upper(trim(prd_line)) = 'M' THEN 'Mountain'
                WHEN upper(trim(prd_line)) = 'R' THEN 'Road'
                WHEN upper(trim(prd_line)) = 'S' THEN 'Other Sales'
                WHEN upper(trim(prd_line)) = 'T' THEN 'Touring'
                ELSE 'n/a'
           END AS prd_line,
           CAST(prd_start_dt AS DATE),
           CAST(lead(prd_start_dt - 1) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) AS DATE) AS prd_end_dt
    FROM bronze.crm_prd_info;
    
    end_time := NOW();
    duration := end_time - start_time;
    RAISE NOTICE 'Duration for Loading CRM Product Info (silver.crm_prd_info): %', duration;

    ------------------------------------------------------------------
    -- Step 3: Load CRM Sales Details (silver.crm_sales_details)
    ------------------------------------------------------------------
    start_time := NOW();
    RAISE NOTICE '================================================';
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading CRM Sales Details: silver.crm_sales_details';
    RAISE NOTICE '------------------------------------------------';
    
    RAISE NOTICE '>> Truncating Table: silver.crm_sales_details';
    TRUNCATE TABLE silver.crm_sales_details;
    RAISE NOTICE '>> Inserting Data Into: silver.crm_sales_details';
    
    INSERT INTO silver.crm_sales_details (
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt,
        sls_sales,
        sls_quantity,
        sls_price
    )
    SELECT 
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        CASE 
            WHEN char_length(sls_order_dt::text) = 8 THEN to_date(sls_order_dt::text, 'YYYYMMDD')
            ELSE NULL
        END AS converted_sls_order_dt,
        CASE 
            WHEN char_length(sls_ship_dt::text) = 8 THEN to_date(sls_ship_dt::text, 'YYYYMMDD')
            ELSE NULL
        END AS sls_ship_dt,
        CASE 
            WHEN char_length(sls_due_dt::text) = 8 THEN to_date(sls_due_dt::text, 'YYYYMMDD')
            ELSE NULL
        END AS sls_due_dt,  
        CASE 
            WHEN sls_sales <> ABS(sls_price)*sls_quantity OR sls_sales IS NULL OR sls_sales <= 0
                THEN ABS(sls_price)*sls_quantity
            ELSE sls_sales 
        END AS sls_sales,
        sls_quantity,
        CASE 
            WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales/sls_quantity
            ELSE sls_price 
        END AS sls_price
    FROM bronze.crm_sales_details;
    
    end_time := NOW();
    duration := end_time - start_time;
    RAISE NOTICE 'Duration for Loading CRM Sales Details (silver.crm_sales_details): %', duration;

    ------------------------------------------------------------------
    -- Step 4: Load ERP Customer Data (silver.erp_cust_az12)
    ------------------------------------------------------------------
    start_time := NOW();
    RAISE NOTICE '================================================';
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading ERP Customer Data: silver.erp_cust_az12';
    RAISE NOTICE '------------------------------------------------';
    
    RAISE NOTICE '>> Truncating Table: silver.erp_cust_az12';
    TRUNCATE TABLE silver.erp_cust_az12;
    RAISE NOTICE '>> Inserting Data Into: silver.erp_cust_az12';
    
    INSERT INTO silver.erp_cust_az12 (
        cid,
        bdate,
        gen
    )
    SELECT 
        CASE
            WHEN cid LIKE 'NAS%' THEN substring(cid FROM 4)
            ELSE cid
        END AS cid,
        CASE 
            WHEN bdate > NOW() THEN NULL
            ELSE bdate
        END AS bdate,
        CASE 
            WHEN upper(trim(gen)) IN ('M','MALE') THEN 'Male'
            WHEN upper(trim(gen)) IN ('F','FEMALE') THEN 'Female'
            ELSE 'n/a'
        END AS gen  
    FROM bronze.erp_cust_az12;
    
    end_time := NOW();
    duration := end_time - start_time;
    RAISE NOTICE 'Duration for Loading ERP Customer Data (silver.erp_cust_az12): %', duration;

    ------------------------------------------------------------------
    -- Step 5: Load ERP Location Data (silver.erp_loc_a101)
    ------------------------------------------------------------------
    start_time := NOW();
    RAISE NOTICE '================================================';
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading ERP Location Data: silver.erp_loc_a101';
    RAISE NOTICE '------------------------------------------------';
    
    RAISE NOTICE '>> Truncating Table: silver.erp_loc_a101';
    TRUNCATE TABLE silver.erp_loc_a101;
    RAISE NOTICE '>> Inserting Data Into: silver.erp_loc_a101';
    
    INSERT INTO silver.erp_loc_a101 (
        cid,
        cntry
    )
    SELECT 
        replace(cid, '-', ''),
        CASE 
            WHEN trim(cntry) = 'DE' THEN 'Germany'
            WHEN trim(cntry) IN ('US','USA') THEN 'United States'
            WHEN trim(cntry) = '' OR trim(cntry) IS NULL THEN 'n/a'
            ELSE trim(cntry)
        END AS cntry
    FROM bronze.erp_loc_a101;
    
    end_time := NOW();
    duration := end_time - start_time;
    RAISE NOTICE 'Duration for Loading ERP Location Data (silver.erp_loc_a101): %', duration;

    ------------------------------------------------------------------
    -- Step 6: Load ERP Product Category Data (silver.erp_px_cat_g1v2)
    ------------------------------------------------------------------
    start_time := NOW();
    RAISE NOTICE '================================================';
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading ERP Product Category Data: silver.erp_px_cat_g1v2';
    RAISE NOTICE '------------------------------------------------';
    
    RAISE NOTICE '>> Truncating Table: silver.erp_px_cat_g1v2';
    TRUNCATE TABLE silver.erp_px_cat_g1v2;
    RAISE NOTICE '>> Inserting Data Into: silver.erp_px_cat_g1v2';
    
    INSERT INTO silver.erp_px_cat_g1v2 (
        id,
        cat,
        subcat,
        maintenance
    )
    SELECT
        id,
        cat,
        subcat,
        maintenance
    FROM bronze.erp_px_cat_g1v2;
    
    end_time := NOW();
    duration := end_time - start_time;
    RAISE NOTICE 'Duration for Loading ERP Product Category Data (silver.erp_px_cat_g1v2): %', duration;

    ------------------------------------------------------------------
    -- Overall duration
    ------------------------------------------------------------------
    batch_end_time := NOW();
    duration := batch_end_time - batch_start_time;
    RAISE NOTICE '================================================';
    RAISE NOTICE 'Total Duration for Loading Process: %', duration;
    RAISE NOTICE '================================================';

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '==========================================';
    RAISE NOTICE 'ERROR OCCURRED DURING LOADING SILVER LAYER';
    RAISE NOTICE 'Error Message: %', SQLERRM;
    RAISE NOTICE 'SQLSTATE: %', SQLSTATE;
    RAISE NOTICE '==========================================';
END;
$$;
