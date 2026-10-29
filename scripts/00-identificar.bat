@echo off
call "%~dp0_common.bat"

echo ========================================================
echo   FASE 0: IDENTIFICACION DEL DISPOSITIVO
echo ========================================================
echo.
echo Comprobando conexion ADB...
adb devices
echo.

set "OUT_FILE=%PROJECT_ROOT%\firmware\backups\identificacion_tablet.txt"
if not exist "%PROJECT_ROOT%\firmware\backups" mkdir "%PROJECT_ROOT%\firmware\backups"

echo Extrayendo propiedades del dispositivo...
echo ======================================================== > "%OUT_FILE%"
echo   DATOS DE IDENTIFICACION TABLET >> "%OUT_FILE%"
echo ======================================================== >> "%OUT_FILE%"

echo. >> "%OUT_FILE%"
echo [Codename / Dispositivo]: >> "%OUT_FILE%"
adb shell getprop ro.product.device | tee -a "%OUT_FILE%" 2>nul || adb shell getprop ro.product.device >> "%OUT_FILE%"

echo. >> "%OUT_FILE%"
echo [Modelo comercial]: >> "%OUT_FILE%"
adb shell getprop ro.product.model >> "%OUT_FILE%"

echo. >> "%OUT_FILE%"
echo [Arquitectura / ABI]: >> "%OUT_FILE%"
adb shell getprop ro.product.cpu.abilist >> "%OUT_FILE%"

echo. >> "%OUT_FILE%"
echo [Android Version Stock]: >> "%OUT_FILE%"
adb shell getprop ro.build.version.release >> "%OUT_FILE%"

echo. >> "%OUT_FILE%"
echo [Build ID]: >> "%OUT_FILE%"
adb shell getprop ro.build.display.id >> "%OUT_FILE%"

echo. >> "%OUT_FILE%"
echo [Particiones /dev/block/by-name/]: >> "%OUT_FILE%"
adb shell ls -l /dev/block/by-name/ >> "%OUT_FILE%" 2>nul

echo. >> "%OUT_FILE%"
echo [Particiones /proc/partitions]: >> "%OUT_FILE%"
adb shell cat /proc/partitions >> "%OUT_FILE%" 2>nul

echo.
echo ========================================================
echo   RESULTADOS OBTENIDOS:
echo ========================================================
for /f "delims=" %%i in ('adb shell getprop ro.product.device') do set "CODENAME=%%i"
for /f "delims=" %%i in ('adb shell getprop ro.product.model') do set "MODEL=%%i"
for /f "delims=" %%i in ('adb shell getprop ro.product.cpu.abilist') do set "ABI=%%i"
for /f "delims=" %%i in ('adb shell getprop ro.build.version.release') do set "ANDROID_VER=%%i"

echo  - Codename:          %CODENAME%
echo  - Modelo Comercial:  %MODEL%
echo  - Arquitectura ABI:  %ABI%
echo  - Version Android:   %ANDROID_VER%
echo ========================================================
echo.
echo Guardado informe completo en:
echo firmware\backups\identificacion_tablet.txt
echo.
pause

