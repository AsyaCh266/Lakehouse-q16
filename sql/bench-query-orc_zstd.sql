/* Q16_BENCH_orc_zstd */
SELECT p.brand, p.type, p.size, count(DISTINCT ps.suppkey) AS supplier_cnt
FROM bench.lakehouse.partsupp_orc_zstd ps
JOIN bench.lakehouse.part_orc_zstd p ON p.partkey=ps.partkey
WHERE p.brand <> 'Brand#45'
  AND p.type NOT LIKE 'MEDIUM POLISHED%'
  AND p.size IN (49,14,23,45,19,3,36,9)
  AND ps.suppkey NOT IN (
    SELECT suppkey FROM bench.lakehouse.supplier_orc_zstd
    WHERE comment LIKE '%Customer%Complaints%'
  )
GROUP BY p.brand,p.type,p.size
ORDER BY supplier_cnt DESC,p.brand,p.type,p.size;
