CREATE SCHEMA IF NOT EXISTS bench.lakehouse;
SET SESSION bench.compression_codec = 'GZIP';
CREATE TABLE bench.lakehouse.part_parquet_gzip WITH (format='PARQUET') AS SELECT * FROM bronze.lakehouse.part;
CREATE TABLE bench.lakehouse.partsupp_parquet_gzip WITH (format='PARQUET') AS SELECT * FROM bronze.lakehouse.partsupp;
CREATE TABLE bench.lakehouse.supplier_parquet_gzip WITH (format='PARQUET') AS SELECT * FROM bronze.lakehouse.supplier;
