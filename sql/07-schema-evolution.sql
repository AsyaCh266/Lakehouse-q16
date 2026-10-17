ALTER TABLE silver.lakehouse.q16_candidates ADD COLUMN quality_note varchar;
SELECT partkey,suppkey,quality_note FROM silver.lakehouse.q16_candidates LIMIT 5;
ALTER TABLE silver.lakehouse.q16_candidates RENAME COLUMN quality_note TO validation_note;
DESCRIBE silver.lakehouse.q16_candidates;
SELECT partkey,suppkey,validation_note FROM silver.lakehouse.q16_candidates LIMIT 5;
