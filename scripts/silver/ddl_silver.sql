USE DataWarehouse;
GO

drop table if exists silver.crm_cust_info;
create table silver.crm_cust_info
(
    cst_id int,
    cst_key varchar(20),
    cst_firstname nvarchar(30),
    cst_lastname nvarchar(30),
    cst_marital_status varchar(20),
    cst_gndr varchar(20),
    cst_create_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

drop table if exists silver.crm_prd_info;
create table silver.crm_prd_info
(
    prd_id int,
    cat_id nvarchar(50),
    prd_key nvarchar(50),
    prd_nm nvarchar(50),
    prd_cost int,
    prd_line nvarchar(20),
    prd_start_dt date,
    prd_end_dt date,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);


drop table if exists silver.crm_sales_details;
create table silver.crm_sales_details
(
    sls_ord_num nvarchar(20),
    sls_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt date, --Different from bronze
    sls_ship_dt date, --Different from bronze
    sls_due_dt date, --Different from bronze
    sls_sales int,
    sls_quantity int,
    sls_price int,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

drop table if exists silver.erp_cust_az12;
create table silver.erp_cust_az12
(
    cid nvarchar(50),
    bdate date, --Different from bronze
    gen nvarchar(20),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

drop table if exists silver.erp_loc_a101;
create table silver.erp_loc_a101
(
    cid nvarchar(50),
    cntry nvarchar(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

drop table if exists silver.erp_px_cat_g1v2;
create table silver.erp_px_cat_g1v2
(
    id nvarchar(50),
    cat nvarchar(50),
    subcat nvarchar(50),
    maintenance nvarchar(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);