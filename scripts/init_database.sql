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
