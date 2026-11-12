
----- crm_cust_info -----------

-- Check for Nulls or Duplicates in Primary Key
-- Expectation : No Result 



SELECT
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL



-- check for unwanted spaces
-- Expectation no result

SELECT cst_lastname
FROM silver.crm_cust_info 
WHERE cst_lastname != TRIM(cst_lastname)


-- Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

SELECT * FROM silver.crm_cust_info
 

--------------- crm_prd_info ----------



-- Check for Nulls or Duplicates in Primary Key
-- Expectation : No Result 



SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL



-- check for unwanted spaces
-- Expectation no result

SELECT prd_nm
FROM silver.crm_prd_info 
WHERE prd_nm != TRIM(prd_nm)


-- Check for NULLs or Negative Numbers
-- Expectation : No Result

SELECT prd_cost
FROM silver.crm_prd_info 
WHERE prd_cost < 0  OR prd_cost IS NULL

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info



-- Check for Invalid Date Orders

SELECT 
*
FROM  silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT * FROM silver.crm_cust_info




--------- crm_sales_details -----------

-- Chekc for Invalid Dates

SELECT
NULLIF(sls_order_dt, 0) sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 OR 
LEN(sls_order_dt) != 8 OR
sls_order_dt > 205002332 OR
sls_order_dt < 19000123

SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt




--- Check Data Consistency: Between Sales, Quantity and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or Negative

-- If Sales is negative, zero, or null, derive it using Quantity and Price
-- If Price is zero or null, calculate it using Sales and Quantity
-- If Price is negative, convert it to a positive value

SELECT
	sls_sales,
	sls_quantity,
	sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0

 


SELECT * FROM silver.crm_sales_details





-------------------- erp_CUST_AZ12  ----------

SELECT
	CASE 
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
		ELSE cid
	END cid,
	bdate,
	gen
FROM silver.erp_CUST_AZ12
WHERE bdate < '1924-01-01' OR bdate > GETDATE() 



-- Data Standardization and consistency

SELECT DISTINCT
	gen,
	CASE 
		WHEN TRIM(UPPER(gen)) IN ('F', 'FEMALE') THEN 'Female'
		WHEN TRIM(UPPER(gen)) IN ('M', 'MALE') THEN 'Male'
		ELSE 'n/a'
	END AS gen
FROM silver.erp_CUST_AZ12


SELECT DISTINCT gen FROM silver.erp_CUST_AZ12

SELECT * FROM silver.erp_CUST_AZ12







------------- erp_LOC_A101 ---------------

SELECT
	REPLACE(cid, '-','') cid,
	CASE 
		WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		WHEN TRIM(cntry) IN ('US' , 'USA') THEN 'United States'
		WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		ELSE TRIM(cntry)
	END cntry
FROM bronze.erp_LOC_A101


------ Data Standardization and consistency
SELECT DISTINCT
	cntry AS old_cntry,
		CASE 
		WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		WHEN TRIM(cntry) IN ('US' , 'USA') THEN 'United States'
		WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		ELSE TRIM(cntry)
	END cntry
FROM bronze.erp_LOC_A101




SELECT * FROM silver.erp_LOC_A101


------------- erp_PX_CAT_G1V2 ----------



--- Chekc unwanted spaces
SELECT 
	id,
	cat,
	subcat,
	maintanance
FROM bronze.erp_PX_CAT_G1V2 
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintanance != TRIM(maintanance)



-- Data Standardization & consistency
 
SELECT * FROM bronze.erp_PX_CAT_G1V2 
SELECT * FROM silver.crm_prd_info
