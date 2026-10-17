WITH actual AS (SELECT p.brand, p.type, p.size, count(DISTINCT ps.suppkey) AS supplier_cnt
FROM bench.lakehouse.partsupp_parquet_gzip ps
JOIN bench.lakehouse.part_parquet_gzip p ON p.partkey=ps.partkey
WHERE p.brand <> 'Brand#45'
  AND p.type NOT LIKE 'MEDIUM POLISHED%'
  AND p.size IN (49,14,23,45,19,3,36,9)
  AND ps.suppkey NOT IN (
    SELECT suppkey FROM bench.lakehouse.supplier_parquet_gzip
    WHERE comment LIKE '%Customer%Complaints%'
  )
GROUP BY p.brand,p.type,p.size),
a AS (SELECT * FROM actual EXCEPT SELECT * FROM gold.lakehouse.q16_supplier_count),
b AS (SELECT * FROM gold.lakehouse.q16_supplier_count EXCEPT SELECT * FROM actual)
SELECT (SELECT count(*) FROM a)+(SELECT count(*) FROM b) AS differences;
