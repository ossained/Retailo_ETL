/* CUSTOMERS — DATA TYPE FIXES */
ALTER TABLE main.customers ALTER COLUMN date_of_birth TYPE DATE;

/* CUSTOMERS — QUALITY CHECKS */

-- Row count
SELECT COUNT(*) AS row_count_customers FROM main.customers;

-- Null completeness
SELECT
  SUM(CASE WHEN name IS NULL THEN 1 END) AS missing_name,
  SUM(CASE WHEN email IS NULL THEN 1 END) AS missing_email,
  SUM(CASE WHEN state IS NULL THEN 1 END) AS missing_state,
  SUM(CASE WHEN gender IS NULL THEN 1 END) AS missing_gender,
  SUM(CASE WHEN address IS NULL THEN 1 END) AS missing_address,
  SUM(CASE WHEN customer_id IS NULL THEN 1 END) AS missing_customer_id,
  SUM(CASE WHEN date_of_birth IS NULL THEN 1 END) AS missing_date_of_birth
FROM main.customers;

-- Duplicate check
SELECT customer_id, COUNT(*) 
FROM main.customers 
GROUP BY customer_id 
HAVING COUNT(*) > 1;

-- Validity checks
SELECT * FROM main.customers WHERE email NOT LIKE '%@%';
SELECT * FROM main.customers WHERE LOWER(gender) NOT IN ('male','female','other');
SELECT * FROM main.customers WHERE date_of_birth IS NULL;
SELECT * FROM main.customers WHERE DATE_DIFF('year', date_of_birth, CURRENT_DATE) < 18;

-- Business logic
SELECT * FROM main.customers WHERE TRIM(name) = '';
SELECT * FROM main.customers WHERE TRIM(address) = '';
SELECT * FROM main.customers WHERE LOWER(state) IN ('unknown','n/a','none');

-- Schema
DESCRIBE main.customers;

/* PRODUCTS — DATA TYPE FIXES */
ALTER TABLE main.products ALTER COLUMN price TYPE DECIMAL(34,2);
ALTER TABLE main.products ALTER COLUMN stock_quantity TYPE INTEGER;
ALTER TABLE main.products ALTER COLUMN product_ratings TYPE DECIMAL(2,1);
ALTER TABLE main.products ALTER COLUMN expiration_date TYPE DATE;
ALTER TABLE main.products ALTER COLUMN manufacturing_date TYPE DATE;

/* PRODUCTS — QUALITY CHECKS */

-- Row count
SELECT COUNT(*) AS row_count_products FROM main.products;

-- Null completeness
SELECT
  SUM(CASE WHEN sku IS NULL THEN 1 END) AS missing_sku,
  SUM(CASE WHEN price IS NULL THEN 1 END) AS missing_price,
  SUM(CASE WHEN product_id IS NULL THEN 1 END) AS missing_product_id,
  SUM(CASE WHEN product_name IS NULL THEN 1 END) AS missing_product_name,
  SUM(CASE WHEN product_tags IS NULL THEN 1 END) AS missing_product_tags,
  SUM(CASE WHEN stock_quantity IS NULL THEN 1 END) AS missing_stock_quantity,
  SUM(CASE WHEN expiration_date IS NULL THEN 1 END) AS missing_expiration_date,
  SUM(CASE WHEN product_ratings IS NULL THEN 1 END) AS missing_product_ratings,
  SUM(CASE WHEN warranty_period IS NULL THEN 1 END) AS missing_warranty_period,
  SUM(CASE WHEN product_category IS NULL THEN 1 END) AS missing_product_category,
  SUM(CASE WHEN manufacturing_date IS NULL THEN 1 END) AS missing_manufacturing_date,
  SUM(CASE WHEN product_dimensions IS NULL THEN 1 END) AS missing_product_dimensions,
  SUM(CASE WHEN product_description IS NULL THEN 1 END) AS missing_product_description,
  SUM(CASE WHEN color_size_variations IS NULL THEN 1 END) AS missing_color_size_variations
FROM main.products;

-- Duplicate check
SELECT product_id, COUNT(*) 
FROM main.products 
GROUP BY product_id 
HAVING COUNT(*) > 1;

-- Validation
SELECT * FROM main.products WHERE price IS NULL OR price < 0;
SELECT * FROM main.products WHERE stock_quantity IS NULL OR stock_quantity < 0;
SELECT * FROM main.products WHERE product_ratings NOT BETWEEN 0 AND 5;
SELECT * FROM main.products WHERE expiration_date IS NULL;
SELECT * FROM main.products WHERE manufacturing_date IS NULL;

-- Business logic
SELECT * FROM main.products WHERE expiration_date <= manufacturing_date;
SELECT * FROM main.products WHERE TRIM(product_name) = '';
SELECT * FROM main.products WHERE LOWER(product_category) IN ('unknown','n/a','none');

-- Schema
DESCRIBE main.products;

/* SALES — DATA TYPE FIXES */
ALTER TABLE main.sales ALTER COLUMN sales TYPE DECIMAL(38,2);
ALTER TABLE main.sales ALTER COLUMN profit TYPE DECIMAL(38,2);
ALTER TABLE main.sales ALTER COLUMN discount TYPE DECIMAL(38,2);
ALTER TABLE main.sales ALTER COLUMN quantity TYPE INTEGER;
ALTER TABLE main.sales ALTER COLUMN row_id TYPE INTEGER;
ALTER TABLE main.sales ALTER COLUMN ship_date TYPE DATE;
ALTER TABLE main.sales ALTER COLUMN order_date TYPE DATE;

/* SALES — QUALITY CHECKS */

-- Row count
SELECT COUNT(*) AS row_count_sales FROM main.sales;

-- Null completeness
SELECT
  SUM(CASE WHEN city IS NULL THEN 1 END) AS missing_city,
  SUM(CASE WHEN sales IS NULL THEN 1 END) AS missing_sales,
  SUM(CASE WHEN state IS NULL THEN 1 END) AS missing_state,
  SUM(CASE WHEN profit IS NULL THEN 1 END) AS missing_profit,
  SUM(CASE WHEN region IS NULL THEN 1 END) AS missing_region,
  SUM(CASE WHEN row_id IS NULL THEN 1 END) AS missing_row_id,
  SUM(CASE WHEN country IS NULL THEN 1 END) AS missing_country,
  SUM(CASE WHEN segment IS NULL THEN 1 END) AS missing_segment,
  SUM(CASE WHEN category IS NULL THEN 1 END) AS missing_category,
  SUM(CASE WHEN discount IS NULL THEN 1 END) AS missing_discount,
  SUM(CASE WHEN order_id IS NULL THEN 1 END) AS missing_order_id,
  SUM(CASE WHEN quantity IS NULL THEN 1 END) AS missing_quantity,
  SUM(CASE WHEN ship_date IS NULL THEN 1 END) AS missing_ship_date,
  SUM(CASE WHEN ship_mode IS NULL THEN 1 END) AS missing_ship_mode,
  SUM(CASE WHEN order_date IS NULL THEN 1 END) AS missing_order_date,
  SUM(CASE WHEN product_id IS NULL THEN 1 END) AS missing_product_id,
  SUM(CASE WHEN customer_id IS NULL THEN 1 END) AS missing_customer_id,
  SUM(CASE WHEN postal_code IS NULL THEN 1 END) AS missing_postal_code,
  SUM(CASE WHEN product_name IS NULL THEN 1 END) AS missing_product_name,
  SUM(CASE WHEN sub_category IS NULL THEN 1 END) AS missing_sub_category,
  SUM(CASE WHEN customer_name IS NULL THEN 1 END) AS missing_customer_name
FROM main.sales;

-- Duplicate checks
SELECT row_id, COUNT(*) 
FROM main.sales 
GROUP BY row_id 
HAVING COUNT(*) > 1;

SELECT order_id, product_id, COUNT(*) 
FROM main.sales 
GROUP BY order_id, product_id 
HAVING COUNT(*) > 1;

-- Validation
SELECT * FROM main.sales WHERE sales IS NULL OR sales < 0;
SELECT * FROM main.sales WHERE profit IS NULL;
SELECT * FROM main.sales WHERE discount NOT BETWEEN 0 AND 1;
SELECT * FROM main.sales WHERE quantity IS NULL OR quantity <= 0;
SELECT * FROM main.sales WHERE order_date IS NULL OR ship_date IS NULL;

-- Business logic
SELECT * FROM main.sales WHERE ship_date < order_date;
SELECT * FROM main.sales WHERE profit > sales;

-- Schema
DESCRIBE main.sales;


describe main.products