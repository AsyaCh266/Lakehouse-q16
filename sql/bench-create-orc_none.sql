CREATE SCHEMA IF NOT EXISTS bench.lakehouse;
SET SESSION bench.compression_codec = 'NONE';
CREATE TABLE bench.lakehouse.part_orc_none WITH (format='ORC') AS SELECT * FROM bronze.lakehouse.part;
CREATE TABLE bench.lakehouse.partsupp_orc_none WITH (format='ORC') AS SELECT * FROM bronze.lakehouse.partsupp;
CREATE TABLE bench.lakehouse.supplier_orc_none WITH (format='ORC') AS SELECT * FROM bronze.lakehouse.supplier;
