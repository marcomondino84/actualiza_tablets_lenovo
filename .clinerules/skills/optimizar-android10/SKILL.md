---
name: optimizacion-android10
description: Fase 10 (OBLIGATORIA) - Optimización de rendimiento post-flasheo para tablets Lenovo Yoga Tab 3 con Android 10 / LineageOS 17.1.
---

# Skill: Optimización Post-Flasheo Android 10

## Propósito
Optimizar el rendimiento y reducir el consumo de recursos en tablets con hardware modesto (Snapdragon 210, 1GB/2GB RAM) tras flashear LineageOS 17.1.

## Cuándo ejecutar
Siempre después de:
1. Flashear ROM LineageOS 17.1 y GApps.
2. Iniciar el sistema y verificar hardware (Fase 8).

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

## Reglas
- Ejecutar siempre como Fase 10 obligatoria.
- Verificar aplicación de ajustes y registrar en `PLAN-FLASHEO.md`.