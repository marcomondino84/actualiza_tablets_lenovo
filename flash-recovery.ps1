$adb = "c:\xampp\htdocs\Actualiza Tablets Lenovo\tools\platform-tools\adb.exe"
$fb = "c:\xampp\htdocs\Actualiza Tablets Lenovo\tools\platform-tools\fastboot.exe"
$rec = "c:\xampp\htdocs\Actualiza Tablets Lenovo\firmware\recovery\recovery-mimbre.img"

Write-Host "Reiniciando tablet a modo Bootloader..."
& $adb reboot bootloader
Start-Sleep -Seconds 5

Write-Host "Verificando dispositivo en Fastboot..."
& $fb devices

Write-Host "Flasheando recovery-mimbre.img a la particion recovery..."
& $fb flash recovery $rec

Write-Host "Iniciando Lineage Recovery..."
& $fb boot $rec

