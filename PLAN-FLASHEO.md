# Plan y Registro de Flasheo — Tablet Lenovo

## Datos del Dispositivo
- **Fecha de sesión:** 29/10/2026
- **Modelo comercial:** Lenovo Yoga Tab 3 10.1" (YT3-X50F)
- **Codename (`ro.product.device`):** `mimbre` / `YT3-X50F`
- **SoC / Procesador:** Qualcomm Snapdragon 210 (MSM8909)
- **Arquitectura (`ro.product.cpu.abilist`):** 32-bit (`armeabi-v7a`)
- **Android Stock Base:** 6.0.1 Marshmallow
- **Nueva ROM instalada:** LineageOS 17.1 (Android 10) con Google Apps
- **Número de Serie:** `4f5dccdb`
- **Estado Bootloader:** `Device unlocked: true`, `Device tampered: false`

---

## Puertas de Verificación (Estado)

| Puerta | Fase | Pregunta clave | Evidencia requerida | Estado |
|---|---|---|---|---|
| **0** | Identificación | ¿Qué equipo es exactamente? | YT3-X50F (`mimbre`), MSM8909, 32-bit | ✅ ABIERTA |
| **1** | Artefactos | ¿Los archivos son genuinos? | SHA256 verificado y archivado localmente | ✅ ABIERTA |
| **2** | Bootloader | ¿Se puede escribir en particiones? | `Device unlocked: true`, `tampered: false` | ✅ ABIERTA |
| **3** | Backup & Aboot | ¿Kernel puede arrancar recovery moderno? | Backup aboot verificado 2 veces + aboot parcheado verificado | ✅ ABIERTA |
| **4** | Recovery | ¿Recovery definitivo arranca? | Lineage Recovery en pantalla + `adb devices` en `recovery` | ✅ ABIERTA |
| **5** | Wipe | ¿Datos viejos eliminados? | Format data completado en Lineage Recovery (`/data` limpia) | ✅ ABIERTA |
| **6** | ROM | ¿La ROM se escribió completa? | `lineage-17.1-*-mimbre.zip` transferido y escrito OK | ✅ ABIERTA |
| **7** | GApps | ¿GApps quedó completo? | `MindTheGapps-10.0.0-arm.zip` transferido e instalado OK | ✅ ABIERTA |
| **8** | Hardware | ¿Todo el hardware responde? | Verificación tras primer arranque del sistema | ⏳ Siguiente paso |

---

## Evidencia Registrada de la Sesión
- **Aboot Stock SHA256 (Doble lectura idéntica):** `160ac7577e9d57404ab203a7c12fe9240f21b2e72de88caa964b323dca7f6ab8`
- **Backup en PC host:** `firmware\backups\aboot-stock.img`
- **Aboot Parcheado SHA256:** `ac7df5fa226cde742fb65feb736beee5eec2696d423d943e2a841378e583891e` (DTB @ 0x82e00000 / Ramdisk @ 0x84000000)
- **Lineage Recovery:** Escrito en partición `recovery`
- **ROM Instalada:** `lineage-17.1-20260816-UNOFFICIAL-mimbre.zip`
- **GApps Instaladas:** `MindTheGapps-10.0.0-arm-20230922_081033.zip`
