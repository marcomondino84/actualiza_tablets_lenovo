---
name: backup-aboot
description: Fase 3 - Doble lectura y validación SHA256 de la partición crítica aboot antes de parchear.
---

# Skill: Backup de Aboot

## Propósito
Realizar doble respaldo de la partición `aboot` y verificar su integridad mediante SHA256 antes de parchear.

## Prerrequisitos
- Fase 2 completada (bootloader desbloqueado).
- TWRP arrancado en RAM temporal.

## Comandos
```cmd
adb shell dd if=/dev/block/platform/msm_sdcc.1/by-name/aboot of=/sdcard/aboot_backup1.img
adb shell dd if=/dev/block/platform/msm_sdcc.1/by-name/aboot of=/sdcard/aboot_backup2.img
adb pull /sdcard/aboot_backup1.img
adb pull /sdcard/aboot_backup2.img
sha256sum aboot_backup1.img aboot_backup2.img
```

## Evidencia esperada
- Dos archivos de respaldo generados.
- Los hash SHA256 de ambos backups deben coincidir exactamente.

## Reglas de seguridad
- NUNCA saltar este paso. Sin backup verificado de `aboot`, la tablet queda irrecuperable si algo sale mal.
- Los dos hash deben ser idénticos antes de continuar a la parcheo.
- Registrar los hash en `PLAN-FLASHEO.md`.