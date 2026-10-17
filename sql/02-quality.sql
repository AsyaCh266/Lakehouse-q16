SELECT 'part' AS table_name, count(*) AS rows FROM bronze.lakehouse.part
UNION ALL SELECT 'partsupp', count(*) FROM bronze.lakehouse.partsupp
UNION ALL SELECT 'supplier', count(*) FROM bronze.lakehouse.supplier;
SELECT partkey, count(*) FROM bronze.lakehouse.part GROUP BY partkey HAVING count(*)<>1;
SELECT suppkey, count(*) FROM bronze.lakehouse.supplier GROUP BY suppkey HAVING count(*)<>1;
SELECT partkey, suppkey, count(*) FROM bronze.lakehouse.partsupp GROUP BY partkey,suppkey HAVING count(*)<>1;
SELECT count(*) AS orphan_parts FROM bronze.lakehouse.partsupp ps
LEFT JOIN bronze.lakehouse.part p ON p.partkey=ps.partkey WHERE p.partkey IS NULL;
SELECT count(*) AS orphan_suppliers FROM bronze.lakehouse.partsupp ps
LEFT JOIN bronze.lakehouse.supplier s ON s.suppkey=ps.suppkey WHERE s.suppkey IS NULL;
SELECT count(*) AS invalid_part FROM bronze.lakehouse.part
WHERE partkey IS NULL OR brand IS NULL OR type IS NULL OR size IS NULL;
SELECT count(*) AS invalid_supplier FROM bronze.lakehouse.supplier
WHERE suppkey IS NULL OR comment IS NULL;
SELECT count(*) AS complaint_suppliers FROM bronze.lakehouse.supplier
WHERE comment LIKE '%Customer%Complaints%';
