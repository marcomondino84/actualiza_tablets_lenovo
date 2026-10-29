@echo off
call "%~dp0_common.bat"

echo ========================================================
echo   FASE 2: DESBLOQUEO DEL BOOTLOADER
echo ========================================================
echo.
echo [ADVERTENCIA CRITICA]
echo Desbloquear el bootloader BORRARA COMPLETAMENTE todos
echo los datos de la tablet (Factory Reset forzado).
echo.
set /p CONFIRMAR="Deseas continuar? (S/N): "
if /i not "%CONFIRMAR%"=="S" (
    echo Operacion cancelada.
    pause
    exit /b 0
)

echo.
echo Reiniciando tablet en modo Bootloader / Fastboot...
adb reboot bootloader

echo.
echo Esperando a que el dispositivo aparezca en modo Fastboot...
timeout /t 5 /nobreak >nul
fastboot devices

echo.
echo Intentando desbloqueo OEM (fastboot oem unlock-go)...
fastboot oem unlock-go

echo.
echo Comprobando estado del bootloader:
fastboot getvar all 2>&1 | findstr /i "unlocked tampered"

echo.
echo ========================================================
echo   REGLA DE VERIFICACION (PUERTA 2):
echo   Debe aparecer:
echo     Device unlocked: true
echo     Device tampered: false
echo ========================================================
echo.
pause

