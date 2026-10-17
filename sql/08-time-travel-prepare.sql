CREATE TABLE silver.lakehouse.q16_recovery_demo WITH (format='PARQUET') AS
SELECT * FROM silver.lakehouse.q16_candidates;
SELECT count(*) AS original_rows FROM silver.lakehouse.q16_recovery_demo;
SELECT committed_at,snapshot_id,operation FROM silver.lakehouse."q16_recovery_demo$snapshots" ORDER BY committed_at DESC;
