# Reglas y Procedimientos del Proyecto: Actualización Tablets Lenovo

## Flujo Estándar de Flasheo por Dispositivo
Al procesar una nueva tablet Lenovo Yoga Tab 3 (YT3-X50F / mimbre):
1. **Fase 0:** Identificar dispositivo y serial (`adb devices` / `getprop`).
2. **Fase 1:** Verificar integridad de artefactos SHA256 locales.
3. **Fase 2:** Desbloquear bootloader (`fastboot oem unlock-go`).
4. **Fase 3:** Arrancar TWRP en RAM temporal, respaldar `aboot` stock 2 veces (verificar SHA256) y parchear `aboot`.
5. **Fase 4:** Flashear Lineage Recovery definitivo.
6. **Fase 5:** Wipe / Format data en recovery.
7. **Fase 6:** Sideload ROM LineageOS 17.1.
8. **Fase 7:** Sideload MindTheGapps 10.0.
9. **Fase 8:** Reiniciar sistema y verificar hardware (ADB).
10. **Fase 10 (OBLIGATORIA - Optimización Android 10):**
    Ejecutar siempre el proceso de optimización (`scripts\07-optimizar-sistema.bat` o skill `optimizacion-android10`):
    - Animaciones en 0.
    - Densidad a 213 dpi.
    - Asegurar permisos completos de Play Store para descargas e instalación de apps de Google (Drive, Sheets, Docs, etc.).
    - Verificar aplicación de ajustes y registrar en `PLAN-FLASHEO.md`.

