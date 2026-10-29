@echo off
setlocal
cd /d "%~dp0"
set "PATH=%~dp0tools\platform-tools;%PATH%"

:MENU
cls
echo ===================================================================
echo           FLASHEO Y ACTUALIZACION TABLETS LENOVO (LINEAGEOS)
echo ===================================================================
echo.
echo   [0] Fase 0: Identificar tablet conectada (Codename, ABI, Particiones)
echo   [1] Fase 2: Desbloquear Bootloader (fastboot oem unlock-go)
echo   [2] Fase 3: Backup de particion 'aboot' (en TWRP RAM)
echo   [3] Fase 4: Flashear Recovery definitivo (Lineage Recovery)
echo   [4] Fase 6: Flashear ROM LineageOS (ADB Sideload)
echo   [5] Fase 7: Flashear GApps (ADB Sideload)
echo   [6] Fase 8: Test y Verificacion de Hardware (ADB)
echo.
echo   [D] Ver Dispositivos conectados (adb devices / fastboot devices)
echo   [S] Abrir linea de comandos ADB Shell
echo   [G] Abrir Guia Operativa (GUIA-FLASHEO.md)
echo   [P] Abrir Plan y Registro (PLAN-FLASHEO.md)
echo   [X] Salir
echo ===================================================================
set /p OPC="Selecciona una opcion: "

if /i "%OPC%"=="0" call "%~dp0scripts\00-identificar.bat" & goto MENU
if /i "%OPC%"=="1" call "%~dp0scripts\01-desbloquear-bootloader.bat" & goto MENU
if /i "%OPC%"=="2" call "%~dp0scripts\02-backup-aboot.bat" & goto MENU
if /i "%OPC%"=="3" call "%~dp0scripts\03-flashear-recovery.bat" & goto MENU
if /i "%OPC%"=="4" call "%~dp0scripts\04-sideload-rom.bat" & goto MENU
if /i "%OPC%"=="5" call "%~dp0scripts\05-sideload-gapps.bat" & goto MENU
if /i "%OPC%"=="6" call "%~dp0scripts\06-verificar-hardware.bat" & goto MENU

if /i "%OPC%"=="D" (
    echo.
    echo --- Dispositivos ADB ---
    adb devices
    echo.
    echo --- Dispositivos Fastboot ---
    fastboot devices
    echo.
    pause
    goto MENU
)

if /i "%OPC%"=="S" (
    echo Entrando a ADB Shell...
    adb shell
    pause
    goto MENU
)

if /i "%OPC%"=="G" (
    start notepad.exe "%~dp0GUIA-FLASHEO.md"
    goto MENU
)

if /i "%OPC%"=="P" (
    start notepad.exe "%~dp0PLAN-FLASHEO.md"
    goto MENU
)

if /i "%OPC%"=="X" exit /b 0

goto MENU

