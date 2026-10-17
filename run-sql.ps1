param([Parameter(Mandatory=$true)][string]$File)
$ErrorActionPreference = 'Stop'
$full = (Resolve-Path -LiteralPath $File).Path
docker cp $full 'trino:/tmp/q16-script.sql'
if ($LASTEXITCODE -ne 0) { throw 'Cannot copy SQL file into Trino' }
docker exec trino trino --file /tmp/q16-script.sql --output-format CSV_HEADER
if ($LASTEXITCODE -ne 0) { throw "Trino failed: $File" }
