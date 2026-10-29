$zip = Join-Path $PSScriptRoot "firmware\patcher-v6.zip"
$dest = Join-Path $PSScriptRoot "firmware\patcher_extracted"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest | Out-Null }
Expand-Archive -Path $zip -DestinationPath $dest -Force
Get-Content "$dest\patch-aboot.sh" | Select-Object -First 60

