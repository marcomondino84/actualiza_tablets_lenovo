@echo off
call "%~dp0_common.bat"

echo ========================================================
echo   FASE 4: FLASH RECOVERY DEFINITIVO (LINEAGE RECOVERY)
echo ========================================================
echo.
echo Comprobando dispositivo en modo Fastboot...
fastboot devices
echo.

set "REC_IMG="
for %%f in ("%PROJECT_ROOT%\firmware\recovery\recovery*.img") do set "REC_IMG=%%f"

if "%REC_IMG%"=="" (
    echo [ERROR] No se encontro archivo recovery*.img en firmware\recovery\
    echo Por favor coloca la imagen del recovery compatible en esa carpeta.
    pause
    exit /b 1
)

echo Imagen detectada: %REC_IMG%
echo.
set /p CONFIRMAR="Deseas flashear este recovery ahora? (S/N): "
if /i not "%CONFIRMAR%"=="S" (
    echo Cancelado.
    pause
    exit /b 0
)

echo.
echo Flasheando particion recovery...
fastboot flash recovery "%REC_IMG%"

echo.
echo Reiniciando hacia el recovery definitivo...
fastboot reboot recovery

echo.
echo ========================================================
echo   AVISO CRITICO PARA LINEAGE RECOVERY:
echo   Si 'adb devices' dice 'unauthorized':
echo   En la tablet entra a:
echo      Advanced  ->  Enable ADB
echo   (Esto es runtime-only y se repite si haces Format data)
echo ========================================================
echo.
pause

