USE DataWarehouse;
GO

drop table if exists bronze.crm_cust_info;
create table bronze.crm_cust_info
(
    cst_id int,
    cst_key varchar(20),
    cst_firstname nvarchar(30),
    cst_lastname nvarchar(30),
    cst_marital_status varchar(20),
    cst_gndr varchar(20),
    cst_create_date DATE
);

drop table if exists bronze.crm_prd_info;
create table bronze.crm_prd_info
(
    prd_id int,
    prd_key nvarchar(50),
    prd_nm nvarchar(50),
    prd_cost int,
    prd_line nvarchar(10),
    prd_start_dt date,
    prd_end_dt date,
);


drop table if exists bronze.crm_sales_details;
create table bronze.crm_sales_details
(
    sls_ord_num nvarchar(20),
    sls_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt date,
    sls_ship_dt date,
    sls_due_dt date,
    sls_sales int,
    sls_quantity int,
    sls_price int
);

drop table if exists bronze.erp_cust_az12;
create table bronze.erp_cust_az12
(
    cid nvarchar(50),
    bdate date,
    gen nvarchar(20)
);

drop table if exists bronze.erp_loc_a101;
create table bronze.erp_loc_a101
(
    cid nvarchar(50),
    cntry nvarchar(50)
);

drop table if exists bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2
(
    id nvarchar(50),
    cat nvarchar(50),
    subcat nvarchar(50),
    maintenance nvarchar(50),
);