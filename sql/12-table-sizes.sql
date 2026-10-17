SELECT 'bronze.part' AS table_name,
       SUM(file_size_in_bytes) AS size_bytes,
       ROUND(SUM(file_size_in_bytes) / 1000000.0, 3) AS size_mb
FROM bronze.lakehouse."part$files"
UNION ALL
SELECT 'bronze.partsupp',
       SUM(file_size_in_bytes),
       ROUND(SUM(file_size_in_bytes) / 1000000.0, 3)
FROM bronze.lakehouse."partsupp$files"
UNION ALL
SELECT 'bronze.supplier',
       SUM(file_size_in_bytes),
       ROUND(SUM(file_size_in_bytes) / 1000000.0, 3)
FROM bronze.lakehouse."supplier$files"
UNION ALL
SELECT 'silver.q16_candidates',
       SUM(file_size_in_bytes),
       ROUND(SUM(file_size_in_bytes) / 1000000.0, 3)
FROM silver.lakehouse."q16_candidates$files"
UNION ALL
SELECT 'gold.q16_supplier_count',
       SUM(file_size_in_bytes),
       ROUND(SUM(file_size_in_bytes) / 1000000.0, 3)
FROM gold.lakehouse."q16_supplier_count$files"