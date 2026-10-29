# Flasheador y Actualizador de Tablets Lenovo (LineageOS)

Suite de automatización y documentación para actualizar y revivir tablets Android antiguas de Lenovo (familia **Yoga Tab 3** / **MSM8909**: `YT3-X50F` / `mimbre`, `YT3-850F` / `bamboo`), reemplazando el firmware obsoleto por **LineageOS 17.1 (Android 10)** con Google Play Store.

Basado en el principio de **puertas de verificación con evidencia obligatoria** (sin suposiciones).

---

## 🚀 Inicio Rápido

### 1. Clonar el repositorio
```bash
git clone https://github.com/TU_USUARIO/actualiza-tablets-lenovo.git
cd actualiza-tablets-lenovo
```

### 2. Preparar el entorno (ADB, Fastboot y Drivers)
Ejecutá el script de preparación en PowerShell:
```powershell
powershell -ExecutionPolicy Bypass -File .\setup-tools.ps1
```
*(Descarga e instala automáticamente los binarios oficiales de Google Android Platform-Tools).*

### 3. Descargar los artefactos verificados (ROM, Recovery, TWRP, Patcher, GApps)
```powershell
powershell -ExecutionPolicy Bypass -File .\descargar-artefactos.ps1
```

### 4. Ejecutar el menú interactivo
Hacé doble clic en **`menu.bat`** o ejecutalo desde la consola:
```cmd
menu.bat
```

---

## 📋 Las 9 Puertas de Verificación

```
[0] Identificar codename  →  [1] Bajar y verificar artefactos  →  [2] Desbloquear
        ↓                                                              ↓
[3] TWRP en RAM + backup aboot + parchear  →  [4] Recovery definitivo
        ↓
[5] Wipe  →  [6] ROM  →  [7] GApps (sin reiniciar)  →  [8] Verificar hardware  →  [9] Documentar
```

| Puerta | Fase | Pregunta que responde | Evidencia que la abre |
|---|---|---|---|
| **0** | Identificación | ¿Qué equipo es exactamente? | Codename exacto (`mimbre` / `bamboo`) + ABI 32-bit |
| **1** | Artefactos | ¿Los archivos son genuinos? | SHA256 verificado contra fuentes oficiales |
| **2** | Bootloader | ¿Se puede escribir en particiones? | `Device unlocked: true`, `tampered: false` |
| **3** | Backup & Aboot | ¿Kernel puede arrancar recovery moderno? | Backup `aboot` verificado 2 veces por `dd` + parche de memoria LK |
| **4** | Recovery | ¿Recovery definitivo arranca? | Lineage Recovery en pantalla + `adb devices` en `recovery` |
| **5** | Wipe | ¿Datos viejos eliminados? | Format data completado en Lineage Recovery (`/data` limpia) |
| **6** | ROM | ¿La ROM se escribió completa? | `wrote N blocks; expected N` |
| **7** | GApps | ¿GApps quedó completo? | MindTheGapps ARM 32-bit instalado sin reiniciar tras la ROM |
| **8** | Hardware | ¿Todo el hardware responde? | Checklist adb: pantalla, touch, cámaras, Wi-Fi, BT, audio |

---

## 📁 Estructura del Proyecto

- `menu.bat`: Lanzador interactivo guiado paso a paso.
- `setup-tools.ps1`: Descarga y configura Google platform-tools automáticamente.
- `descargar-artefactos.ps1`: Descarga y calcula hashes SHA256 de los firmwares.
- `GUIA-FLASHEO.md`: Playbook operativo completo con lecciones aprendidas y trampas de diagnóstico.
- `PLAN-FLASHEO.md`: Plantilla de registro de evidencia y checklist por dispositivo.
- `scripts/`:
  - `00-identificar.bat`: Extrae codename exacto, ABI y particiones.
  - `01-desbloquear-bootloader.bat`: Desbloqueo OEM en modo fastboot.
  - `02-backup-aboot.bat`: Doble lectura y validación SHA256 de partición crítica `aboot`.
  - `03-flashear-recovery.bat`: Escritura del recovery permanente (Lineage Recovery).
  - `04-sideload-rom.bat`: Envío de ROM LineageOS vía ADB sideload.
  - `05-sideload-gapps.bat`: Envío de Google Apps vía ADB sideload.
  - `06-verificar-hardware.bat`: Chequeo automático de sensores, batería, display y Wi-Fi.

---

## ⚠️ Reglas Críticas
1. **Nunca usar `FORCE=1` ni saltear el backup de `aboot`**: Si el bootloader se corrompe sin backup, la tablet queda irrecuperable.
2. **`Enable ADB` en Lineage Recovery**: Si el recovery muestra `unauthorized`, ir a `Advanced -> Enable ADB` (es runtime-only).
3. **Instalación de GApps**: Debe realizarse **inmediatamente después del sideload de la ROM, sin reiniciar el sistema entre medio**. En la pantalla de verificación tocar `Volumen Abajo -> Yes -> Power`.
