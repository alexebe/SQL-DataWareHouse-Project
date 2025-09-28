
USE DataWarehouse;
GO
--We replace all abreviation by meaningfull values
--NULL values become 'n/a'
TRUNCATE TABLE silver.crm_cust_info;
insert into silver.crm_cust_info
    (
    cst_id ,
    cst_key ,
    cst_firstname ,
    cst_lastname ,
    cst_marital_status ,
    cst_gndr ,
    cst_create_date
    )
select
    cst_id ,
    cst_key ,
    trim(cst_firstname) cst_firstname,
    trim(cst_lastname) cst_lastname,
    case upper(trim(cst_marital_status)) 
        when 'M' then 'Maried'    
        when 'S' then 'Single'
        else 'n/a' 
    end as cst_marital_status,
    case upper(trim(cst_gndr))
        when 'M' then 'Male'    
        when 'F' then 'Female'
        else 'n/a'
    end as cst_gndr,
    cst_create_date

from
    (select cst_id ,
        cst_key ,
        cst_firstname ,
        cst_lastname ,
        cst_marital_status ,
        cst_gndr ,
        cst_create_date
    from(
    select *,
            rank() over(partition by cst_id order by cst_create_date desc) rk
        from bronze.crm_cust_info
) t
    where rk = 1 and cst_id is not null)
m;

TRUNCATE TABLE silver.crm_prd_info;
INSERT INTO silver.crm_prd_info
    ( prd_id ,
    cat_id ,
    prd_key ,
    prd_nm ,
    prd_cost ,
    prd_line ,
    prd_start_dt ,
    prd_end_dt
    )
SELECT
    prd_id ,
    REPLACE(SUBSTRING(trim(prd_key), 1, 5), '-', '_') as cat_id,
    SUBSTRING(trim(prd_key), 7, LEN(trim(prd_key))) as prd_key ,
    TRIM(prd_nm) ,
    ISNULL(prd_cost, 0) prd_cost,
    case UPPER(prd_line) 
        when 'M' THEN 'Mountain'
        when 'R' THEN 'Road'
        when 'S' THEN 'Other Sales'
        when 'T' THEN 'Touring'
        else 'n/a'
        end prd_line,
    prd_start_dt ,
    LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) AS prd_end_dt
from bronze.crm_prd_info;

TRUNCATE TABLE silver.crm_sales_details;
INSERT INTO silver.crm_sales_details
    (
    sls_ord_num ,
    sls_prd_key ,
    sls_cust_id ,
    sls_order_dt ,
    sls_ship_dt ,
    sls_due_dt ,
    sls_sales ,
    sls_quantity ,
    sls_price
    )
select
    TRIM(sls_ord_num) sls_ord_num ,
    TRIM(sls_prd_key)  sls_prd_key,
    sls_cust_id,
    CASE LEN(sls_order_dt) 
        WHEN 8 THEN CAST(sls_order_dt AS DATE)
        else null
    end as sls_order_dt,
    CASE LEN(sls_ship_dt) 
        WHEN 8 THEN CAST(sls_ship_dt AS DATE)
        else null
    end as sls_ship_dt ,
    CASE LEN(sls_due_dt) 
        WHEN 8 THEN CAST(sls_due_dt AS DATE)
        else null
    end as sls_due_dt ,
    CASE 
        WHEN (sls_sales <= 0 or sls_sales is null) THEN isnull(abs(sls_quantity), 1) * abs(sls_price)
        ELSE ABS(sls_sales)
    END AS sls_sales ,
    CASE 
        WHEN (sls_quantity <= 0 or sls_quantity is null) THEN  abs(sls_sales) / isnull(abs(sls_quantity), 1) 
        ELSE ABS(sls_quantity)
    END AS    sls_quantity ,
    CASE 
        WHEN (sls_price <= 0 or sls_price is null) THEN  abs(sls_sales) / abs(sls_quantity) 
        ELSE ABS(sls_price)
    END AS    sls_price
from bronze.crm_sales_details;

TRUNCATE TABLE silver.erp_px_cat_g1v2;
INSERT INTO silver.erp_px_cat_g1v2
    (id,
    cat,
    subcat,
    maintenance
    )
select
    trim(id),
    trim(cat),
    trim(subcat),
    trim(maintenance)
from bronze.erp_px_cat_g1v2;

TRUNCATE TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12
(
    cid,
    bdate,
    gen
)
select 
trim(cid),
CAST(bdate AS DATE),
CASE  
    WHEN  TRIM(UPPER(gen)) in ('F', 'FEMALE') THEN 'Female'
    WHEN  TRIM(UPPER(gen)) in ('M', 'MALE') THEN 'Male'
    ELSE 'n/a'
END gen
from bronze.erp_cust_az12;

TRUNCATE TABLE silver.erp_loc_a101;
INSERT INTO silver.erp_loc_a101
(
    cid,
    cntry
)
select 
trim(cid),
CASE 
    WHEN len(cntry) >= 1 THEN TRIM(UPPER(cntry))
    WHEN (len(cntry) = 0 OR cntry is null) THEN 'n/a'
END cntry
from bronze.erp_loc_a101;


