-- DO NOT execute until you replace 6011675729501415944 in both statements with
-- the original snapshot_id saved BEFORE running 09-time-travel-change.sql.
SELECT count(*) FROM silver.lakehouse.q16_recovery_demo FOR VERSION AS OF 6011675729501415944;
ALTER TABLE silver.lakehouse.q16_recovery_demo EXECUTE rollback_to_snapshot(6011675729501415944);
SELECT count(*) AS restored_rows FROM silver.lakehouse.q16_recovery_demo;
SELECT count(*) AS demo_rows_must_be_zero FROM silver.lakehouse.q16_recovery_demo WHERE partkey=-1;

