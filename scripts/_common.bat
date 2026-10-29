@echo off
set "PROJECT_ROOT=%~dp0.."
set "PATH=%PROJECT_ROOT%\tools\platform-tools;%PATH%"

where adb >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] No se encontro adb.exe en tools\platform-tools ni en el PATH.
    pause
    exit /b 1
)

