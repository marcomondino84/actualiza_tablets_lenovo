@echo off
call "%~dp0_common.bat"

echo ========================================================
echo   FASE 3: BACKUP DEL ABOOT (BOOTLOADER STOCK)
echo ========================================================
echo.
echo NOTA: La tablet debe estar en TWRP (cargado en RAM).
echo.
adb devices
echo.

set "BACKUP_DIR=%PROJECT_ROOT%\firmware\backups"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

echo Realizando 1ra lectura por dd...
adb shell "dd if=/dev/block/by-name/aboot of=/tmp/aboot-stock-1.img 2>/dev/null"
echo Realizando 2da lectura por dd...
adb shell "dd if=/dev/block/by-name/aboot of=/tmp/aboot-stock-2.img 2>/dev/null"

echo.
echo Obteniendo hashes SHA256 en la tablet:
adb shell "sha256sum /tmp/aboot-stock-1.img /tmp/aboot-stock-2.img"

echo.
echo Descargando backup a la PC host...
adb pull /tmp/aboot-stock-1.img "%BACKUP_DIR%\aboot-stock.img"

echo.
echo Calculando hash SHA256 en la PC:
powershell -Command "Get-FileHash -Algorithm SHA256 '%BACKUP_DIR%\aboot-stock.img'"

echo.
echo ========================================================
echo   REGLA DE VERIFICACION (PUERTA 3):
echo   Ambas lecturas deben dar exactamente el mismo SHA256.
echo   Backup seguro guardado en:
echo   firmware\backups\aboot-stock.img
echo ========================================================
echo.
pause

