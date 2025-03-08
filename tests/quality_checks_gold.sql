/*
Script Purpose:
1. Ensure customer keys are unique in gold.dim_customers.
2. Ensure product keys are unique in gold.dim_products.
3. Confirm that every sales record links to valid customer and product records.
4. Detect errors to maintain reliable, clean Gold Layer data.
*/

-- =============================================================================
-- Checking 'gold.dim_customers'
-- =============================================================================
-- Verify that each customer_key is unique.
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- =============================================================================
-- Checking 'gold.dim_products'
-- =============================================================================
-- Verify that each product_key is unique.
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- =============================================================================
-- Checking 'gold.fact_sales'
-- =============================================================================
-- Ensure every sales record has matching customer and product records.
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p ON p.product_key = f.product_key
WHERE p.product_key IS NULL 
   OR c.customer_key IS NULL;
