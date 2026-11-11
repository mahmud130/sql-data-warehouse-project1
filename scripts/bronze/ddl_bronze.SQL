CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME , @batch_end_time DATETIME;
	BEGIN TRY
		
		SET @batch_start_time = GETDATE();

		PRINT '===========================';
		PRINT 'Loading Bronze Layer';
		PRINT '==========================';

		PRINT '--------------------------';
		PRINT 'Loading CRM Table';
		PRINT '---------------------------';

		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING TABLE : bronze.crm_cust_info';
		PRINT '>>INSERTING TABLE : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '... Load Duration: ' +CAST ( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '.......................'
		
		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING TABLE : bronze.crm_prd_info';
		PRINT '>>INSERTING TABLE : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '... Load Duration: ' +CAST ( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '.......................'


		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING TABLE : bronze.crm_sales_details';
		PRINT '>>INSERTING TABLE : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '... Load Duration: ' +CAST ( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '.......................'


		SET @start_time = GETDATE();
		PRINT '--------------------------';
		PRINT 'Loading ERP Table';
		PRINT '---------------------------';

		PRINT '>>TRUNCATING TABLE : bronze.erp_CUST_AZ12';
		PRINT '>>INSERTING TABLE : bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12 
		BULK INSERT bronze.erp_CUST_AZ12 
		FROM 'E:\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '... Load Duration: ' +CAST ( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '.......................'


		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING TABLE : bronze.erp_LOC_A101';
		PRINT '>>INSERTING TABLE : bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101
		BULK INSERT bronze.erp_LOC_A101
		FROM 'E:\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '... Load Duration: ' +CAST ( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '.......................'



		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING TABLE : bronze.erp_PX_CAT_G1V2';
		PRINT '>>INSERTING TABLE : bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'E:\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '... Load Duration: ' +CAST ( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '.......................'

		SET @batch_end_time = GETDATE();

		PRINT('=============================')
		PRINT 'Loading Bronze layer is completed'
		PRINT '    -- Total Load Duration : ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT('=============================')

	END TRY

	BEGIN CATCH
		PRINT '===================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message : ' + ERROR_MESSAGE();
		PRINT '===================='
	END CATCH

END
