$adb = "c:\xampp\htdocs\Actualiza Tablets Lenovo\tools\platform-tools\adb.exe"

Write-Host "Aplicando el parche al aboot en la tablet..."
$applyOut = & $adb shell "/tmp/patch-aboot.sh"
$applyOut

Write-Host "Verificando nueva lectura de la particion aboot..."
$newHash = (& $adb shell "dd if=/dev/block/bootdevice/by-name/aboot bs=494816 count=1 2>/dev/null | sha256sum").Trim()
Write-Host "Hash de la particion parcheada: $newHash"

