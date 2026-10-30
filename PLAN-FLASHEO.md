# Plan y Registro de Flasheo — Tablets Lenovo

## Dispositivo 4 (Sesión Actual: 30/10/2026)
- **Número de Serie:** `4f5dccaf`
- **Modelo Comercial:** Lenovo Yoga Tab 3 10.1" (YT3-X50F)
- **Codename:** `mimbre` / MSM8909 (32-bit `armeabi-v7a`)
- **Android Stock Base:** 6.0.1 Marshmallow (`YT3-X50F_S000120_170616_ROW`)
- **Nueva ROM instalada:** LineageOS 17.1 (Android 10) con Google Play Store
- **Estado Bootloader:** `Device unlocked: true`
- **Aboot Stock SHA256 (Doble lectura idéntica):** `160ac7577e9d57404ab203a7c12fe9240f21b2e72de88caa964b323dca7f6ab8`
- **Backup local en PC:** `firmware\backups\aboot-stock-4f5dccaf.img`
- **Revisión reconocida por patcher v5:** `YT3-X50F user dump (attestation 2017-06-15)`
- **Aboot Parcheado:** Parche aplicado y verificado en flash (DTB @ 0x82e00000 / Ramdisk @ 0x84000000)
- **Lineage Recovery:** Escrito en partición `recovery`
- **ROM Instalada:** `lineage-17.1-20260816-UNOFFICIAL-mimbre.zip` (Transferencia 1.00x)
- **GApps Instaladas:** `MindTheGapps-10.0.0-arm-20230922_081033.zip` (Transferencia 1.00x)

---

## Puertas de Verificación (Dispositivo `4f5dccaf`)

| Puerta | Fase | Pregunta clave | Evidencia requerida | Estado |
|---|---|---|---|---|
| **0** | Identificación | ¿Qué equipo es exactamente? | YT3-X50F (`mimbre`), MSM8909, 32-bit | ✅ ABIERTA |
| **1** | Artefactos | ¿Los archivos son genuinos? | SHA256 verificado y archivado localmente | ✅ ABIERTA |
| **2** | Bootloader | ¿Se puede escribir en particiones? | `Device unlocked: true` | ✅ ABIERTA |
| **3** | Backup & Aboot | ¿Kernel puede arrancar recovery moderno? | Backup aboot verificado 2 veces + aboot parcheado verificado | ✅ ABIERTA |
| **4** | Recovery | ¿Recovery definitivo arranca? | Lineage Recovery en pantalla + `adb devices` en `recovery` | ✅ ABIERTA |
| **5** | Wipe | ¿Datos viejos eliminados? | Format data completado en Lineage Recovery (`/data` limpia) | ✅ ABIERTA |
| **6** | ROM | ¿La ROM se escribió completa? | `lineage-17.1-*-mimbre.zip` transferido y escrito OK (1.00x) | ✅ ABIERTA |
| **7** | GApps | ¿GApps quedó completo? | `MindTheGapps-10.0.0-arm.zip` transferido e instalado OK (1.00x) | ✅ ABIERTA |
| **8** | Hardware | ¿Todo el hardware responde? | Pantalla 800x1280, 4 núcleos, cámara trasera, batería, Play Store OK | ✅ ABIERTA |
| **9** | Documentar | ¿Todo registrado? | Documentación actualizada en PLAN-FLASHEO.md | ✅ ABIERTA |
| **10** | Optimización | ¿Animaciones, densidad y bloatware optimizados? | Animaciones 0x, densidad 213, paquetes google deshabilitados, Play Store restringida | ✅ ABIERTA |

---

## Historial de Dispositivos Previos

### Dispositivo 3 (Sesión 29/10/2026 - Tarde 2)
- **Número de Serie:** `4f1accee`
- **Modelo comercial:** Lenovo Yoga Tab 3 10.1" (YT3-X50F)
- **Aboot Stock SHA256:** `160ac7577e9d57404ab203a7c12fe9240f21b2e72de88caa964b323dca7f6ab8`
- **Estado:** 100% completado con LineageOS 17.1 + GApps.

### Dispositivo 2 (Sesión 29/10/2026 - Tarde 1)
- **Número de Serie:** `6bb8d082`
- **Modelo comercial:** Lenovo Yoga Tab 3 10.1" (YT3-X50F)
- **Aboot Stock SHA256:** `19690765669b8cf5f91d6ba4056a2c2fdbe9789c33545aec591249c746c1b2c8`
- **Aboot Parcheado SHA256:** `6b80d4506ba6bdbcc7eb80625106d0b4883a997b25e9d941b5d03890d7b48436`
- **Estado:** 100% completado con LineageOS 17.1 + GApps.

### Dispositivo 1 (Sesión 29/10/2026 - Mañana)
- **Número de Serie:** `4f5dccdb`
- **Modelo comercial:** Lenovo Yoga Tab 3 10.1" (YT3-X50F)
- **Aboot Stock SHA256:** `160ac7577e9d57404ab203a7c12fe9240f21b2e72de88caa964b323dca7f6ab8`
- **Aboot Parcheado SHA256:** `ac7df5fa226cde742fb65feb736beee5eec2696d423d943e2a841378e583891e`
- **Estado:** 100% completado con LineageOS 17.1 + GApps.
