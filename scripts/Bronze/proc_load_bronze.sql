/*
This PostgreSQL stored procedure load_bronze:

Truncates and reloads data from multiple CSV files into the bronze schema.
Logs each step using RAISE NOTICE for better tracking.
Measures execution time for each TRUNCATE and COPY operation.
Computes the total duration for all table operations.
Implements exception handling to capture and log errors.
Ensures a structured and efficient data loading process. 
*/
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    duration INTERVAL;
    total_duration INTERVAL := INTERVAL '0 seconds'; -- Initialize total duration
    error_message TEXT;
    error_code TEXT;
BEGIN
    -- General Procedure Start Message
    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '================================================';

    BEGIN
        -- CRM Tables
        RAISE NOTICE '------------------------------------------------';
        RAISE NOTICE 'Loading CRM Tables';
        RAISE NOTICE '------------------------------------------------';

        -- crm_cust_info
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        RAISE NOTICE '>> Inserting Data Into: bronze.crm_cust_info';
        EXECUTE format('COPY bronze.crm_cust_info FROM %L DELIMITER '','' CSV HEADER;', 
                       'F:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv');
        end_time := clock_timestamp();
        duration := end_time - start_time;
        total_duration := total_duration + duration;
        RAISE NOTICE '>> Time Taken: % seconds', EXTRACT(EPOCH FROM duration);

        -- crm_prd_info
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        RAISE NOTICE '>> Inserting Data Into: bronze.crm_prd_info';
        EXECUTE format('COPY bronze.crm_prd_info FROM %L DELIMITER '','' CSV HEADER;', 
                       'F:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv');
        end_time := clock_timestamp();
        duration := end_time - start_time;
        total_duration := total_duration + duration;
        RAISE NOTICE '>> Time Taken: % seconds', EXTRACT(EPOCH FROM duration);

        -- crm_sales_details
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        RAISE NOTICE '>> Inserting Data Into: bronze.crm_sales_details';
        EXECUTE format('COPY bronze.crm_sales_details FROM %L DELIMITER '','' CSV HEADER;', 
                       'F:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv');
        end_time := clock_timestamp();
        duration := end_time - start_time;
        total_duration := total_duration + duration;
        RAISE NOTICE '>> Time Taken: % seconds', EXTRACT(EPOCH FROM duration);

        -- ERP Tables
        RAISE NOTICE '------------------------------------------------';
        RAISE NOTICE 'Loading ERP Tables';
        RAISE NOTICE '------------------------------------------------';

        -- erp_cust_az12
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        RAISE NOTICE '>> Inserting Data Into: bronze.erp_cust_az12';
        EXECUTE format('COPY bronze.erp_cust_az12 FROM %L DELIMITER '','' CSV HEADER;', 
                       'F:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv');
        end_time := clock_timestamp();
        duration := end_time - start_time;
        total_duration := total_duration + duration;
        RAISE NOTICE '>> Time Taken: % seconds', EXTRACT(EPOCH FROM duration);

        -- erp_loc_a101
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        RAISE NOTICE '>> Inserting Data Into: bronze.erp_loc_a101';
        EXECUTE format('COPY bronze.erp_loc_a101 FROM %L DELIMITER '','' CSV HEADER;', 
                       'F:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv');
        end_time := clock_timestamp();
        duration := end_time - start_time;
        total_duration := total_duration + duration;
        RAISE NOTICE '>> Time Taken: % seconds', EXTRACT(EPOCH FROM duration);

        -- erp_px_cat_g1v2
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        RAISE NOTICE '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
        EXECUTE format('COPY bronze.erp_px_cat_g1v2 FROM %L DELIMITER '','' CSV HEADER;', 
                       'F:/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv');
        end_time := clock_timestamp();
        duration := end_time - start_time;
        total_duration := total_duration + duration;
        RAISE NOTICE '>> Time Taken: % seconds', EXTRACT(EPOCH FROM duration);

        -- Print Total Duration
        RAISE NOTICE '================================================';
        RAISE NOTICE 'Bronze Layer Loading Completed Successfully';
        RAISE NOTICE 'Total Duration: % seconds', EXTRACT(EPOCH FROM total_duration);
        RAISE NOTICE '================================================';

    EXCEPTION
        WHEN OTHERS THEN
            -- Capture Error Details
            error_message := SQLERRM;
            error_code := SQLSTATE;

            -- Error Logging
            RAISE NOTICE '==========================================';
            RAISE NOTICE 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
            RAISE NOTICE 'Error Message: %', error_message;
            RAISE NOTICE 'Error Code: %', error_code;
            RAISE NOTICE '==========================================';

            -- Raise the error to stop execution
            RAISE EXCEPTION 'PROCESS FAILED: %', error_message;
    END;
END $$;
