@echo off
call "%~dp0_common.bat"

echo ========================================================
echo   FASE 6: SIDELOAD DE ROM (LINEAGEOS)
echo ========================================================
echo.
echo NOTA: Asegurate de haber hecho 'Factory reset -> Format data/factory reset'
echo y en Lineage Recovery selecciona:
echo    Apply update  ->  Apply from ADB
echo.
echo Comprobando estado del recovery por ADB...
adb devices
echo.

set "ROM_ZIP="
for %%f in ("%PROJECT_ROOT%\firmware\rom\lineage*.zip") do set "ROM_ZIP=%%f"

if "%ROM_ZIP%"=="" (
    for %%f in ("%PROJECT_ROOT%\firmware\rom\*.zip") do set "ROM_ZIP=%%f"
)

if "%ROM_ZIP%"=="" (
    echo [ERROR] No se encontro archivo ROM .zip en firmware\rom\
    pause
    exit /b 1
)

echo ROM detectada: %ROM_ZIP%
echo.
pause

echo.
echo Enviando ROM mediante ADB Sideload...
adb sideload "%ROM_ZIP%"

echo.
echo ========================================================
echo   REGLA DE VERIFICACION (PUERTA 6):
echo   Verifica en la pantalla / log del recovery:
echo     wrote N blocks; expected N
echo   Si ambos numeros coinciden, la escritura fue exitosa.
echo   ATENCION: NO REINICIES si vas a instalar GApps ahora.
echo ========================================================
echo.
pause

