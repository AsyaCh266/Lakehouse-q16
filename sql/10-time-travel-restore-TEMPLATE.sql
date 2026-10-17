-- DO NOT execute until you replace SNAPSHOT_ID in both statements with
-- the original snapshot_id saved BEFORE running 09-time-travel-change.sql.
SELECT count(*) FROM silver.lakehouse.q16_recovery_demo FOR VERSION AS OF SNAPSHOT_ID;
ALTER TABLE silver.lakehouse.q16_recovery_demo EXECUTE rollback_to_snapshot(SNAPSHOT_ID);
SELECT count(*) AS restored_rows FROM silver.lakehouse.q16_recovery_demo;
SELECT count(*) AS demo_rows_must_be_zero FROM silver.lakehouse.q16_recovery_demo WHERE partkey=-1;
