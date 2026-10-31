---
name: flashear-recovery
description: Fase 4 - Flashear Lineage Recovery definitivo en la partición de recovery.
---

# Skill: Flashear Recovery

## Propósito
Escribir el recovery permanente (Lineage Recovery) en la partición de recovery del dispositivo.

## Prerrequisitos
- Fase 3 completada (backup de aboot verificado dos veces por SHA256).
- Imagen de recovery válida descargada y verificada.

## Comandos
```cmd
fastboot flash recovery recovery.img
fastboot boot recovery.img
```

## Evidencia esperada
- `wrote N blocks; expected N` (escritura completa).
- Lineage Recovery arranca en pantalla.
- `adb devices` muestra el dispositivo en modo `recovery`.

## Reglas
- Verificar SHA256 de `recovery.img` antes de flashear.
- Registrar el resultado en `PLAN-FLASHEO.md`.