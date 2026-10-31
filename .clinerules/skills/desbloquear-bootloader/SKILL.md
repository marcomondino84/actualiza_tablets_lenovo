---
name: desbloquear-bootloader
description: Fase 2 - Desbloquear el bootloader OEM en modo fastboot de la tablet Lenovo Yoga Tab 3.
---

# Skill: Desbloquear Bootloader

## Propósito
Desbloquear el bootloader para permitir escritura en particiones y flasheo de recovery personalizado.

## Prerrequisitos
- Fase 0 completada (codename confirmado).
- Tablet en modo fastboot (`adb reboot bootloader`).

## Comandos
```cmd
fastboot oem unlock-go
```

## Evidencia esperada
- `Device unlocked: true`
- `tampered: false`

## Reglas de seguridad
- NUNCA usar `FORCE=1`.
- Confirmar que el dispositivo sea `mimbre` o `bamboo` antes de ejecutar.
- Si el comando falla, detenerse y pedir confirmación humana.
- Registrar el resultado en `PLAN-FLASHEO.md`.