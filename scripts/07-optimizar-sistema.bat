@echo off
call "%~dp0_common.bat"

echo ========================================================
echo   FASE 10: OPTIMIZACION POST-FLASHEO (ANDROID 10)
echo ========================================================
echo.
adb devices
echo.

echo [1/5] Obteniendo Baseline del Sistema...
echo --- Memoria y Swap ---
adb shell "cat /proc/meminfo | grep -E 'MemTotal|MemFree|MemAvailable|Cached|SwapTotal|SwapFree'"
echo --- Carga y Uptime ---
adb shell uptime
echo --- Densidad y Resolucion Actual ---
adb shell wm size
adb shell wm density
echo.

echo [2/5] Desactivando animaciones (0x para maxima fluidez)...
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0
echo   - Escalas de animacion ajustadas a 0.
echo.

echo [3/5] Ajustando densidad de pantalla a 213 dpi (stock)...
adb shell wm density 213
echo   - Densidad configurada a 213 dpi.
echo.

echo [4/5] Ajustando servicios de sistema...
REM Mantenemos los paquetes y Play Store con permisos normales para descargas
adb shell cmd appops set com.android.vending RUN_ANY_IN_BACKGROUND allow
adb shell cmd appops set com.android.vending RUN_IN_BACKGROUND allow
echo   - Play Store configurada con permisos completos de descarga.
echo.

echo ========================================================
echo   VERIFICACION DE AJUSTES APLICADOS
echo ========================================================
echo Animaciones:
adb shell settings get global window_animation_scale
adb shell settings get global transition_animation_scale
adb shell settings get global animator_duration_scale
echo Densidad:
adb shell wm density
echo Paquetes Deshabilitados:
adb shell pm list packages -d
echo Permiso en segundo plano Play Store:
adb shell cmd appops get com.android.vending RUN_ANY_IN_BACKGROUND
echo.
echo ========================================================
echo   Optimizacion completada con exito.
echo ========================================================
echo.
pause

