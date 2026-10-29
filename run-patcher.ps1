$adb = Join-Path $PSScriptRoot "tools\platform-tools\adb.exe"
$patcherSh = Join-Path $PSScriptRoot "firmware\patcher_extracted\patch-aboot.sh"

Write-Host "Subiendo patch-aboot.sh a la tablet..."
& $adb push $patcherSh /tmp/patch-aboot.sh
& $adb shell "chmod 755 /tmp/patch-aboot.sh"

Write-Host "Ejecutando en modo de prueba (DRYRUN=1)..."
$dryrunOut = & $adb shell "DRYRUN=1 /tmp/patch-aboot.sh"
$dryrunOut

