WITH reference AS (SELECT p.brand, p.type, p.size, count(DISTINCT ps.suppkey) AS supplier_cnt
FROM bronze.lakehouse.partsupp ps
JOIN bronze.lakehouse.part p ON p.partkey=ps.partkey
WHERE p.brand <> 'Brand#45'
  AND p.type NOT LIKE 'MEDIUM POLISHED%'
  AND p.size IN (49,14,23,45,19,3,36,9)
  AND ps.suppkey NOT IN (
    SELECT suppkey FROM bronze.lakehouse.supplier
    WHERE comment LIKE '%Customer%Complaints%'
  )
GROUP BY p.brand,p.type,p.size),
missing AS (SELECT * FROM reference EXCEPT SELECT * FROM gold.lakehouse.q16_supplier_count),
extra AS (SELECT * FROM gold.lakehouse.q16_supplier_count EXCEPT SELECT * FROM reference)
SELECT 'missing_in_gold' AS check_name,count(*) AS differences FROM missing
UNION ALL SELECT 'extra_in_gold', count(*) FROM extra;
SELECT count(*) AS bad_suppliers_in_silver
FROM silver.lakehouse.q16_candidates c
JOIN bronze.lakehouse.supplier s ON s.suppkey=c.suppkey
WHERE s.comment LIKE '%Customer%Complaints%';
SELECT count(*) AS silver_rows FROM silver.lakehouse.q16_candidates;
SELECT count(*) AS gold_rows FROM gold.lakehouse.q16_supplier_count;
