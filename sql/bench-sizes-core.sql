SELECT 'parquet_gzip' AS variant, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM (SELECT file_size_in_bytes FROM bench.lakehouse."part_parquet_gzip$files" WHERE content=0
UNION ALL
SELECT file_size_in_bytes FROM bench.lakehouse."partsupp_parquet_gzip$files" WHERE content=0
UNION ALL
SELECT file_size_in_bytes FROM bench.lakehouse."supplier_parquet_gzip$files" WHERE content=0)
UNION ALL
SELECT 'parquet_zstd' AS variant, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM (SELECT file_size_in_bytes FROM bench.lakehouse."part_parquet_zstd$files" WHERE content=0
UNION ALL
SELECT file_size_in_bytes FROM bench.lakehouse."partsupp_parquet_zstd$files" WHERE content=0
UNION ALL
SELECT file_size_in_bytes FROM bench.lakehouse."supplier_parquet_zstd$files" WHERE content=0)
UNION ALL
SELECT 'orc_gzip' AS variant, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM (SELECT file_size_in_bytes FROM bench.lakehouse."part_orc_gzip$files" WHERE content=0
UNION ALL
SELECT file_size_in_bytes FROM bench.lakehouse."partsupp_orc_gzip$files" WHERE content=0
UNION ALL
SELECT file_size_in_bytes FROM bench.lakehouse."supplier_orc_gzip$files" WHERE content=0)
UNION ALL
SELECT 'orc_zstd' AS variant, sum(file_size_in_bytes) AS data_bytes, round(sum(file_size_in_bytes)/1048576.0,3) AS data_mib FROM (SELECT file_size_in_bytes FROM bench.lakehouse."part_orc_zstd$files" WHERE content=0
UNION ALL
SELECT file_size_in_bytes FROM bench.lakehouse."partsupp_orc_zstd$files" WHERE content=0
UNION ALL
SELECT file_size_in_bytes FROM bench.lakehouse."supplier_orc_zstd$files" WHERE content=0);
