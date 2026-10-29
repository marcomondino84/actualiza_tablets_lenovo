$zip = "c:\xampp\htdocs\Actualiza Tablets Lenovo\firmware\patcher-v6.zip"
$dest = "c:\xampp\htdocs\Actualiza Tablets Lenovo\firmware\patcher_extracted"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest | Out-Null }
Expand-Archive -Path $zip -DestinationPath $dest -Force
Get-Content "$dest\patch-aboot.sh" | Select-Object -First 60

