@echo off
call "%~dp0_common.bat"

echo ========================================================
echo   FASE 8: VERIFICACION DE HARDWARE Y SISTEMA
echo ========================================================
echo.
adb devices
echo.

echo --- LineageOS Version ---
adb shell getprop ro.lineage.version
echo.

echo --- Kernel ---
adb shell uname -a
echo.

echo --- Procesadores / Nucleos ---
adb shell "cat /proc/cpuinfo | grep -c processor"
echo.

echo --- Estado de Bateria ---
adb shell dumpsys battery | findstr /i "level status health temperature"
echo.

echo --- Pantalla y Resolucion ---
adb shell wm size
adb shell wm density
echo.

echo --- Camaras ---
adb shell dumpsys media.camera | findstr /i "Number Facing"
echo.

echo --- Wi-Fi ---
adb shell ip addr show wlan0 | findstr /i "inet "
echo.

echo --- Bluetooth (1=on, 0=off) ---
adb shell settings get global bluetooth_on
echo.

echo --- Google Play Services y Store instalados? ---
adb shell pm list packages | findstr /i "google.android.gms com.android.vending"
echo.
echo ========================================================
echo   Comprueba los resultados con las especificaciones.
echo ========================================================
echo.
pause

