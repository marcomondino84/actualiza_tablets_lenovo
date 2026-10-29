@echo off
call "%~dp0_common.bat"

echo ========================================================
echo   FASE 7: SIDELOAD DE GAPPS (GOOGLE APPS)
echo ========================================================
echo.
echo NOTA: Sin reiniciar despues de la ROM, en Lineage Recovery selecciona:
echo    Apply update  ->  Apply from ADB
echo.
echo Comprobando estado del recovery por ADB...
adb devices
echo.

set "GAPPS_ZIP="
for %%f in ("%PROJECT_ROOT%\firmware\gapps\*.zip") do set "GAPPS_ZIP=%%f"

if "%GAPPS_ZIP%"=="" (
    echo [ERROR] No se encontro archivo GApps .zip en firmware\gapps\
    pause
    exit /b 1
)

echo GApps detectado: %GAPPS_ZIP%
echo.
echo [ATENCION A LA PANTALLA]:
echo Aparecera el mensaje esperado:
echo   'Signature verification failed - Install anyway?'
echo Presiona VOLUMEN ABAJO para marcar 'Yes' y confirma con BOTON POWER.
echo (Si tocas Power directo, se cancela la instalacion).
echo.
pause

echo.
echo Enviando GApps mediante ADB Sideload...
adb sideload "%GAPPS_ZIP%"

echo.
echo ========================================================
echo   Instalacion completada. Ahora puedes reiniciar:
echo   'Reboot system now' en el recovery.
echo ========================================================
echo.
pause

