-- Drop the table crm_cust_info if it already exists in the bronze schema.
DROP TABLE IF EXISTS bronze.crm_cust_info;
-- Create the crm_cust_info table in the bronze schema.
CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,         -- Customer ID.
    cst_key             VARCHAR(50), -- Customer key.
    cst_firstname       VARCHAR(50), -- Customer first name.
    cst_lastname        VARCHAR(50), -- Customer last name.
    cst_marital_status  VARCHAR(50), -- Customer marital status.
    cst_gndr            VARCHAR(50), -- Customer gender.
    cst_create_date     DATE         -- Date the customer record was created.
);

-- Drop the table crm_prd_info if it already exists in the bronze schema.
DROP TABLE IF EXISTS bronze.crm_prd_info;
-- Create the crm_prd_info table in the bronze schema.
CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,         -- Product ID.
    prd_key      VARCHAR(50), -- Product key.
    prd_nm       VARCHAR(50), -- Product name.
    prd_cost     INT,         -- Product cost.
    prd_line     VARCHAR(50), -- Product line.
    prd_start_dt DATE,        -- Product start date.
    prd_end_dt   DATE         -- Product end date.
);

-- Drop the table crm_sales_details if it already exists in the bronze schema.
DROP TABLE IF EXISTS bronze.crm_sales_details;
-- Create the crm_sales_details table in the bronze schema.
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  VARCHAR(50), -- Sales order number.
    sls_prd_key  VARCHAR(50), -- Sales product key.
    sls_cust_id  INT,         -- Sales customer ID.
    sls_order_dt INT,         -- Sales order date.
    sls_ship_dt  INT,         -- Sales ship date.
    sls_due_dt   INT,         -- Sales due date.
    sls_sales    INT,         -- Sales amount.
    sls_quantity INT,         -- Sales quantity.
    sls_price    INT          -- Sales price.
);

-- Drop the table erp_loc_a101 if it already exists in the bronze schema.
DROP TABLE IF EXISTS bronze.erp_loc_a101;
-- Create the erp_loc_a101 table in the bronze schema.
CREATE TABLE bronze.erp_loc_a101 (
    cid    VARCHAR(50), -- Customer identifier.
    cntry  VARCHAR(50)  -- Country.
);

-- Drop the table erp_cust_az12 if it already exists in the bronze schema.
DROP TABLE IF EXISTS bronze.erp_cust_az12;
-- Create the erp_cust_az12 table in the bronze schema.
CREATE TABLE bronze.erp_cust_az12 (
    cid    VARCHAR(50), -- Customer identifier.
    bdate  DATE,        -- Birthdate.
    gen    VARCHAR(50)  -- Gender.
);

-- Drop the table erp_px_cat_g1v2 if it already exists in the bronze schema.
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
-- Create the erp_px_cat_g1v2 table in the bronze schema.
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           VARCHAR(50), -- Product category identifier.
    cat          VARCHAR(50), -- Category name.
    subcat       VARCHAR(50), -- Subcategory.
    maintenance  VARCHAR(50)  -- Maintenance details.
);
