SELECT 'bronze.part' AS table_name, count(*) AS data_files, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM bronze.lakehouse."part$files" WHERE content=0
UNION ALL
SELECT 'bronze.partsupp' AS table_name, count(*) AS data_files, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM bronze.lakehouse."partsupp$files" WHERE content=0
UNION ALL
SELECT 'bronze.supplier' AS table_name, count(*) AS data_files, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM bronze.lakehouse."supplier$files" WHERE content=0
UNION ALL
SELECT 'silver.q16_candidates' AS table_name, count(*) AS data_files, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM silver.lakehouse."q16_candidates$files" WHERE content=0
UNION ALL
SELECT 'gold.q16_supplier_count' AS table_name, count(*) AS data_files, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM gold.lakehouse."q16_supplier_count$files" WHERE content=0;
