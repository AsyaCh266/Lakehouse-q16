DESCRIBE system.runtime.queries;
SELECT query_id,state,created,started,"end",queued_time_ms,analysis_time_ms,planning_time_ms,
       date_diff('millisecond',started,"end") AS started_to_end_ms,query
FROM system.runtime.queries
WHERE query LIKE '%Q16_BENCH_%' AND query NOT LIKE '%runtime.queries%'
ORDER BY created DESC LIMIT 100;
