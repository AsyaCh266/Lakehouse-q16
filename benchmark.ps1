param([int]$Repeats = 5, [switch]$All)
$ErrorActionPreference='Stop'
if ($Repeats -lt 3) { throw 'Use at least three measured runs' }
$tags=@('parquet_gzip','parquet_zstd','orc_gzip','orc_zstd')
if ($All) { $tags=@('parquet_none','parquet_snappy','parquet_gzip','parquet_zstd','orc_none','orc_snappy','orc_gzip','orc_zstd') }
function Exec-SqlFile([string]$name,[string]$out) {
    $full=(Resolve-Path -LiteralPath $name).Path
    docker cp $full 'trino:/tmp/q16-bench.sql' | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Copy failed: $name" }
    $timer=[Diagnostics.Stopwatch]::StartNew()
    $result = docker exec trino trino --file /tmp/q16-bench.sql --output-format CSV_HEADER
    $code=$LASTEXITCODE
    $timer.Stop()
    if ($code -ne 0) { throw "Query failed: $name" }
    $result | Set-Content -Encoding UTF8 $out
    return [math]::Round($timer.Elapsed.TotalMilliseconds,3)
}
$stamp=Get-Date -Format 'yyyyMMdd-HHmmss'
$dest="results/bench-$stamp"
New-Item -ItemType Directory -Force $dest | Out-Null
$writes=@()
foreach ($tag in $tags) {
    $ms=Exec-SqlFile "sql/bench-create-$tag.sql" "$dest/create-$tag.txt"
    $writes += [pscustomobject]@{variant=$tag;write_wall_ms=$ms}
    $writes | Export-Csv "$dest/writes.csv" -NoTypeInformation -Encoding UTF8
    Exec-SqlFile "sql/bench-verify-$tag.sql" "$dest/verify-$tag.csv" | Out-Null
    Exec-SqlFile "sql/bench-query-$tag.sql" "$dest/warmup-$tag.csv" | Out-Null
}
$times=@()
for ($run=1; $run -le $Repeats; $run++) {
    # Random order reduces systematic bias between variants.
    foreach ($tag in ($tags | Sort-Object {Get-Random})) {
        $ms=Exec-SqlFile "sql/bench-query-$tag.sql" "$dest/query-$tag-$run.csv"
        $times += [pscustomobject]@{variant=$tag;run=$run;query_wall_ms=$ms}
        $times | Export-Csv "$dest/times.csv" -NoTypeInformation -Encoding UTF8
    }
}
$summary=foreach ($g in ($times | Group-Object variant)) {
    $a=@($g.Group.query_wall_ms | Sort-Object)
    $n=$a.Count
    $median=if($n%2 -eq 1){$a[[int][math]::Floor($n/2)]}else{($a[$n/2-1]+$a[$n/2])/2}
    [pscustomobject]@{variant=$g.Name;runs=$n;median_wall_ms=$median;min_wall_ms=$a[0];max_wall_ms=$a[-1]}
}
$summary | Export-Csv "$dest/summary.csv" -NoTypeInformation -Encoding UTF8
$summary | Format-Table
Write-Host "Results saved in $dest"
