# Reglas del Proyecto: Actualización Tablets Lenovo

## ⚠️ Reglas de seguridad (NUNCA saltar)
1. NUNCA usar `FORCE=1` ni saltear el backup de `aboot`. Sin backup, la tablet queda irrecuperable.
2. SIEMPRE verificar SHA256 de los artefactos antes de flashear.
3. Instalar GApps inmediatamente después del sideload de la ROM, sin reiniciar entre medio.
4. Si ADB muestra `unauthorized` en recovery, ir a `Advanced -> Enable ADB` (es runtime-only).
5. Nunca flashear sin confirmar el codename exacto del dispositivo (`mimbre` o `bamboo`).

## Flujo estándar (9 puertas de verificación)
[0] Identificar → [1] Artefactos → [2] Desbloquear → [3] Backup aboot + parchear → 
[4] Recovery → [5] Wipe → [6] ROM → [7] GApps → [8] Verificar hardware → [9] Documentar

## Contexto técnico
- Dispositivos soportados: YT3-X50F (mimbre), YT3-850F (bamboo) - MSM8909, ABI 32-bit
- Scripts en: scripts/ (00-identificar.bat a 06-verificar-hardware.bat)
- Menú interactivo: menu.bat
- Documentación: GEMINI.md, GUIA-FLASHEO.md, PLAN-FLASHEO.md
- Optimización post-flasheo: scripts/07-optimizar-sistema.bat o skill optimizacion-android10

## Reglas de operación con Cline
- Siempre verificar que el dispositivo esté conectado (`adb devices` / `fastboot devices`) antes de ejecutar comandos.
- Nunca sugerir saltar pasos de verificación de integridad.
- Si un comando de `fastboot`, `adb flash` o `dd` falla, detenerse y pedir confirmación humana antes de continuar.
- Los scripts `.ps1` requieren PowerShell; los `.bat` requieren CMD.