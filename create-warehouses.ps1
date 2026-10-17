$ErrorActionPreference = 'Stop'
# Fresh server only: on rerun use the manual instructions in README.
$body = '{"accept-terms-of-use":true}'
Invoke-RestMethod -Method Post -Uri 'http://localhost:8181/management/v1/bootstrap' -ContentType 'application/json' -Body $body
foreach ($layer in @('bronze','silver','gold','bench')) {
    $request = @{
        'warehouse-name' = $layer
        'project-id' = '00000000-0000-0000-0000-000000000000'
        'storage-profile' = @{
            type='s3'; bucket=$layer; 'key-prefix'=''
            endpoint='http://host.docker.internal:9000'; region='us-east-1'
            'path-style-access'=$true; flavor='s3-compat'; 'sts-enabled'=$false
        }
        'storage-credential' = @{
            type='s3'; 'credential-type'='access-key'
            'aws-access-key-id'='minioadmin'; 'aws-secret-access-key'='minioadmin'
        }
    }
    $json = $request | ConvertTo-Json -Depth 8
    $json | Set-Content -Encoding UTF8 "warehouse-$layer.json"
    Invoke-RestMethod -Method Post -Uri 'http://localhost:8181/management/v1/warehouse' -ContentType 'application/json' -Body $json
}
