SELECT 'silver_q16_candidates' AS table_name, count(*) AS row_count
FROM silver.lakehouse.q16_candidates
UNION ALL
SELECT 'gold_q16_supplier_count', count(*)
FROM gold.lakehouse.q16_supplier_count;
