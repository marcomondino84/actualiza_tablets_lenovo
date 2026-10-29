$ErrorActionPreference = 'Stop'
$toolsDir = Join-Path $PSScriptRoot "tools"
$driverZip = Join-Path $toolsDir "usb_driver.zip"
$destDir = $toolsDir

Write-Host "Descargando Google USB Driver oficial..."
Invoke-WebRequest -Uri "https://dl.google.com/android/repository/usb_driver_r13-windows.zip" -OutFile $driverZip
Write-Host "Descomprimiendo en $destDir..."
Expand-Archive -Path $driverZip -DestinationPath $destDir -Force
Remove-Item $driverZip -Force

$infPath = Join-Path $destDir "usb_driver\android_winusb.inf"
Write-Host "Instalando driver con pnputil desde $infPath..."
$res = & pnputil.exe /add-driver $infPath /install
$res

