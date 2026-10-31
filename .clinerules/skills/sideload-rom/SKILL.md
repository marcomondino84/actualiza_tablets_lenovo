---
name: sideload-rom
description: Fase 6 - Enviar ROM LineageOS 17.1 vía ADB sideload tras el wipe de datos.
---

# Skill: Sideload ROM

## Propósito
Instalar la ROM LineageOS 17.1 en el dispositivo mediante ADB sideload desde Lineage Recovery.

## Prerrequisitos
- Fase 5 completada (wipe / format data en Lineage Recovery).
- Archivo ZIP de ROM LineageOS 17.1 verificado por SHA256.
- Dispositivo en Lineage Recovery con ADB habilitado.

## Comandos
```cmd
adb sideload lineage-17.1-*.zip
```

## Evidencia esperada
- Progreso de instalación llegando al 100%.
- Sin errores de verificación o escritura.

## Reglas
- SHA256 de la ROM verificada antes del sideload.
- Registrar el resultado en `PLAN-FLASHEO.md`.