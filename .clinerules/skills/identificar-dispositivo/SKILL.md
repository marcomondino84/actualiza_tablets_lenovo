---
name: identificar-dispositivo
description: Fase 0 - Identificar codename exacto, ABI y particiones de la tablet Lenovo Yoga Tab 3 antes de cualquier operación de flasheo.
---

# Skill: Identificar Dispositivo

## Propósito
Extraer el codename exacto (`mimbre` para YT3-X50F, `bamboo` para YT3-850F), la arquitectura ABI (32-bit) y la información de particiones del dispositivo conectado.

## Prerrequisitos
- Tablet encendida y conectada por USB con depuración USB habilitada.
- ADB disponible en el PATH.

## Comandos
```cmd
adb devices
adb shell getprop ro.product.device
adb shell getprop ro.product.cpu.abi
adb shell getprop ro.build.version.release
```

## Evidencia esperada
- `List of devices attached` con el serial del dispositivo.
- `ro.product.device` = `mimbre` o `bamboo`.
- `ro.product.cpu.abi` = ABI de 32 bits (ej. `armeabi-v7a`).
- `ro.build.version.release` = versión de Android stock.

## Reglas
- No proceder a la Fase 1 si el codename no es `mimbre` o `bamboo`.
- Registrar el codename detectado en `PLAN-FLASHEO.md`.