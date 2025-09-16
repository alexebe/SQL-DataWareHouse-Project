USE DataWarehouse;
GO

TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info
FROM '/media/datasets/source_crm/cust_info.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\r\n', -- Or '\r\n' depending on your file's line endings
    FIRSTROW = 2, -- Skip header row if present
    TABLOCK
);

TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info
FROM '/media/datasets/source_crm/prd_info.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\r\n', -- Or '\r\n' depending on your file's line endings
    FIRSTROW = 2, -- Skip header row if present
    TABLOCK
);

TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details
FROM '/media/datasets/source_crm/sales_details.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\r\n', -- Or '\r\n' depending on your file's line endings
    FIRSTROW = 2, -- Skip header row if present
    TABLOCK
);

TRUNCATE TABLE bronze.erp_cust_az12;
BULK INSERT bronze.erp_cust_az12
FROM '/media/datasets/source_erp/cust_az12.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\r\n', -- Or '\r\n' depending on your file's line endings
    FIRSTROW = 2, -- Skip header row if present
    TABLOCK
);

TRUNCATE TABLE bronze.erp_loc_a101;
BULK INSERT bronze.erp_loc_a101
FROM '/media/datasets/source_erp/loc_a101.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\r\n', -- Or '\r\n' depending on your file's line endings
    FIRSTROW = 2, -- Skip header row if present
    TABLOCK
);

TRUNCATE TABLE bronze.erp_px_cat_g1v2;
BULK INSERT bronze.erp_px_cat_g1v2
FROM '/media/datasets/source_erp/px_cat_g1v2.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\r\n', -- Or '\r\n' depending on your file's line endings
    FIRSTROW = 2, -- Skip header row if present
    TABLOCK
);
