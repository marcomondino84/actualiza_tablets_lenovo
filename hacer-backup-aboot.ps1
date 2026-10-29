$adb = "c:\xampp\htdocs\Actualiza Tablets Lenovo\tools\platform-tools\adb.exe"
$backupDir = "c:\xampp\htdocs\Actualiza Tablets Lenovo\firmware\backups"

Write-Host "Buscando la particion aboot..."
$abootPath = (& $adb shell "ls /dev/block/bootdevice/by-name/aboot 2>/dev/null || ls /dev/block/by-name/aboot 2>/dev/null").Trim()
Write-Host "Ruta aboot: $abootPath"

Write-Host "1ra lectura por dd..."
& $adb shell "dd if=$abootPath of=/tmp/aboot1.img"
Write-Host "2da lectura por dd..."
& $adb shell "dd if=$abootPath of=/tmp/aboot2.img"

Write-Host "Calculando SHA256 en la tablet..."
$hashes = & $adb shell "sha256sum /tmp/aboot1.img /tmp/aboot2.img"
Write-Host $hashes

Write-Host "Descargando backup seguro a la PC..."
& $adb pull /tmp/aboot1.img "$backupDir\aboot-stock.img"

$pcHash = (Get-FileHash -Algorithm SHA256 "$backupDir\aboot-stock.img").Hash
Write-Host "Hash en PC: $pcHash"

