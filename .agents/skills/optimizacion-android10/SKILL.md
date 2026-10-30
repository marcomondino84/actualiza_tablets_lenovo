---
name: optimizacion-android10
description: Optimización de rendimiento post-flasheo para tablets Lenovo Yoga Tab 3 (Android 10 / LineageOS 17.1). Ejecutar siempre después de la verificación de hardware y restauración de aplicaciones.
---

# Optimización Post-Flasheo Android 10 (Lenovo Yoga Tab 3 / MSM8909)

Este skill define el procedimiento estándar y automatizado de optimización para tablets con LineageOS 17.1 (Android 10) sobre procesadores modestos (Snapdragon 210, 1GB/2GB RAM).

## Cuándo ejecutar
Siempre después de:
1. Flashear ROM LineageOS 17.1 y GApps.
2. Iniciar el sistema y verificar hardware (Fase 8).
3. Restaurar o instalar aplicaciones necesarias (Mixing Station, etc.).

## Ejecución Automatizada
El script está disponible en:
```cmd
scripts\07-optimizar-sistema.bat
```
o desde el menú principal `menu.bat` opción `[7]`.

## Comandos que ejecuta

### 1. Escalas de animación a 0 (máxima fluidez y respuesta táctil)
```bash
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0
```

### 2. Densidad de pantalla stock (213 dpi)
```bash
adb shell wm density 213
```

### 3. Desactivación de bloatware y servicios de telemetría en segundo plano
```bash
adb shell pm disable-user --user 0 com.google.android.feedback
adb shell pm disable-user --user 0 com.google.android.apps.pixelmigrate
adb shell pm disable-user --user 0 com.google.android.googlequicksearchbox
```

### 4. Restricción de ejecución en segundo plano para Google Play Store
Evita que los servicios de Google actualicen o escaneen mientras la tablet se usa para mezcla en vivo:
```bash
adb shell cmd appops set com.android.vending RUN_ANY_IN_BACKGROUND ignore
```

### 5. Verificación
```bash
adb shell settings get global window_animation_scale
adb shell settings get global transition_animation_scale
adb shell settings get global animator_duration_scale
adb shell wm density
adb shell pm list packages -d
adb shell cmd appops get com.android.vending RUN_ANY_IN_BACKGROUND
```

