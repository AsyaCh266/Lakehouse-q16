CREATE SCHEMA IF NOT EXISTS bench.lakehouse;
SET SESSION bench.compression_codec = 'SNAPPY';
CREATE TABLE bench.lakehouse.part_parquet_snappy WITH (format='PARQUET') AS SELECT * FROM bronze.lakehouse.part;
CREATE TABLE bench.lakehouse.partsupp_parquet_snappy WITH (format='PARQUET') AS SELECT * FROM bronze.lakehouse.partsupp;
CREATE TABLE bench.lakehouse.supplier_parquet_snappy WITH (format='PARQUET') AS SELECT * FROM bronze.lakehouse.supplier;
