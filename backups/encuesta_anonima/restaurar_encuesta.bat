@echo off
set "PATH=%~dp0..\..\tools\platform-tools;%PATH%"
echo Abriendo Encuesta Anonima en la tablet...
adb shell am start -a android.intent.action.VIEW -d "https://docs.google.com/forms/d/e/1FAIpQLSdTigK-JMopMGpmU9VzWaQgAuk9F3DLRLoKEjvAAInRbrifzQ/viewform"
echo.
echo Presiona en los tres puntos de Chrome y selecciona "Agregar a la pantalla principal"
pause
