---
name: sideload-gapps
description: Fase 7 - Instalar MindTheGapps 10.0 inmediatamente después del sideload de la ROM, sin reiniciar.
---

# Skill: Sideload GApps

## Propósito
Instalar Google Apps (MindTheGapps ARM 32-bit) inmediatamente después de la ROM, sin reiniciar el sistema entre medio.

## Prerrequisitos
- Fase 6 completada (ROM LineageOS instalada sin reiniciar).
- Archivo ZIP de MindTheGapps 10.0 ARM 32-bit verificado por SHA256.
- Dispositivo aún en Lineage Recovery (pantalla de verificación).

## Comandos
```cmd
adb sideload MindTheGapps-*.zip
```

## Evidencia esperada
- Instalación completa sin errores.
- Pantalla de verificación: tocar `Volumen Abajo -> Yes -> Power` para confirmar.

## Reglas críticas
- Debe realizarse **inmediatamente después del sideload de la ROM, sin reiniciar el sistema entre medio**.
- En la pantalla de verificación tocar `Volumen Abajo -> Yes -> Power`.
- Registrar el resultado en `PLAN-FLASHEO.md`.