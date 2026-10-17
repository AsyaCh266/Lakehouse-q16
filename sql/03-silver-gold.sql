SET SESSION silver.compression_codec = 'ZSTD';
CREATE TABLE silver.lakehouse.q16_candidates WITH (format='PARQUET') AS
SELECT p.partkey, ps.suppkey, p.brand, p.type, p.size
FROM bronze.lakehouse.partsupp ps
JOIN bronze.lakehouse.part p ON p.partkey=ps.partkey
WHERE p.brand <> 'Brand#45'
  AND p.type NOT LIKE 'MEDIUM POLISHED%'
  AND p.size IN (49,14,23,45,19,3,36,9)
  AND ps.suppkey NOT IN (
    SELECT suppkey FROM bronze.lakehouse.supplier
    WHERE comment LIKE '%Customer%Complaints%'
  );
SET SESSION gold.compression_codec = 'ZSTD';
CREATE TABLE gold.lakehouse.q16_supplier_count WITH (format='PARQUET') AS
SELECT brand, type, size, count(DISTINCT suppkey) AS supplier_cnt
FROM silver.lakehouse.q16_candidates
GROUP BY brand,type,size;
SELECT * FROM gold.lakehouse.q16_supplier_count
ORDER BY supplier_cnt DESC,brand,type,size;
