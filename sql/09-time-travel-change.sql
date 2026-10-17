INSERT INTO silver.lakehouse.q16_recovery_demo (partkey,suppkey,brand,type,size,validation_note)
VALUES (-1,-1,'DEMO','DEMO',-1,'recovery experiment');
SELECT count(*) AS changed_rows FROM silver.lakehouse.q16_recovery_demo;
SELECT * FROM silver.lakehouse.q16_recovery_demo WHERE partkey=-1;
