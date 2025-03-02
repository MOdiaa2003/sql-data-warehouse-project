-- Create a dedicated database for the Data Warehouse project.
-- Organize data into three layers based on Medallion Architecture.
-- Bronze schema: stores raw, unprocessed data.
-- Silver schema: holds cleansed and standardized data.
-- Gold schema: contains business-ready, modeled data.
-- This structure supports efficient data integration and analytics.


-- Create the DataWarehouse database.
CREATE DATABASE DataWarehouse;

-- Note: To execute the following commands, you must connect to the DataWarehouse database.
-- In psql, you can switch databases with: \c DataWarehouse

-- Create the 'bronze' schema for storing raw data.
CREATE SCHEMA bronze;

-- Create the 'silver' schema for cleaned and standardized data.
CREATE SCHEMA silver;

-- Create the 'gold' schema for business-ready, modeled data.
CREATE SCHEMA gold;
