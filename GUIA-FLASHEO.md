# Guía de flasheo — Android viejo a LineageOS (reutilizable)

Playbook operativo para reemplazar el firmware stock de una tablet o teléfono Android
antiguo por LineageOS. Nació del flasheo real de una Lenovo Yoga Tab 3 (YT3-X50F,
codename `mimbre`) y de los errores que costaron tiempo ahí. Cada fase tiene una
**puerta de verificación**: si la puerta no se abre con evidencia, no se avanza.

---

## La regla de oro

> **Nunca avanzar sobre un supuesto. Solo sobre evidencia.**

Tres consecuencias prácticas:

| Situación | Lo que NO vale | Lo que SÍ vale |
|---|---|---|
| ¿El paquete es el correcto? | "El nombre dice mimbre" | SHA256 igual en **dos fuentes independientes** |
| ¿La ROM se escribió? | "El sideload dijo 100 %" | `wrote N blocks; expected N` en el log del recovery |
| ¿El GApps quedó instalado? | "El instalador terminó bien" | **MD5 de cada archivo** contra el ZIP |
| ¿Qué modelo es? | "Es una Yoga Tab 3" | Codename exacto + `ro.product.device` |
| ¿El bootloader está abierto? | "Corrí el comando y no dio error" | `Device unlocked: true` en `fastboot getvar all` |

Si un dato solo se puede observar mirando la pantalla del equipo, **preguntar**. No inferirlo.

---

## Camino rápido (las 9 puertas)

```
[0] Identificar codename  →  [1] Bajar y verificar artefactos  →  [2] Desbloquear
        ↓                                                              ↓
[3] TWRP en RAM + backup aboot + parchear  →  [4] Recovery definitivo
        ↓
[5] Wipe  →  [6] ROM  →  [7] GApps (sin reiniciar)  →  [8] Verificar hardware  →  [9] Documentar
```

| Puerta | Pregunta que responde | Evidencia que la abre |
|---|---|---|
| 0 | ¿Qué equipo es exactamente? | codename + ABI + mapa de particiones leídos del equipo |
| 1 | ¿Los archivos son genuinos? | SHA256 idéntico en 2 fuentes + auditoría del ZIP |
| 2 | ¿Puedo escribir en las particiones? | `Device unlocked: true`, `tampered: false` |
| 3 | ¿El kernel puede arrancar un recovery moderno? | `aboot` parcheado y backup verificado 2 veces |
| 4 | ¿El recovery definitivo arranca? | recovery en pantalla + `adb devices` en estado `recovery` |
| 5 | ¿Los datos viejos se fueron? | Format data completado, `/data` vacía |
| 6 | ¿La ROM se escribió completa? | `wrote N blocks; expected N` |
| 7 | ¿GApps quedó completo? | MD5 1:1 contra el ZIP |
| 8 | ¿Todo el hardware funciona? | checklist de hardware por adb |

---

## Fase 0 — Identificación (riesgo: ninguno)

Lo primero es el **codename**, no el nombre comercial. Un mismo nombre de marketing
suele cubrir 4 variantes incompatibles entre sí.

```bash
adb shell getprop ro.product.device      # codename
adb shell getprop ro.product.cpu.abilist # armeabi-v7a  vs  arm64-v8a,armeabi-v7a
adb shell getprop ro.build.version.release
```

Mapa real de esta familia, como ejemplo de por qué importa:

| Codename | Modelo | Nota |
|---|---|---|
| `bamboo` | YT3-850F | Wi-Fi |
| `bamboolte` | YT3-850L / 850M | con RIL |
| **`mimbre`** | **YT3-X50F** | Wi-Fi, 10.1" |
| `mimbrelte` | YT3-X50L / X50M | con RIL |

**No son intercambiables.** Un recovery de `bamboo` en un `mimbre` es un ladrillo.

Guardar además el mapa de particiones, que después define si algo entra o no:

```bash
adb shell ls -l /dev/block/by-name/
adb shell cat /proc/partitions
```

| Partición | Uso típico | Riesgo si se toca |
|---|---|---|
| `system` | ROM | reflashable |
| `boot` | kernel | reflashable |
| `recovery` | recovery | reflashable |
| `userdata` | datos | se pierde todo |
| `aboot` | bootloader | **ladrillo si se corrompe** → backup obligatorio |
| `persist`, `modem`, `fsg`, `modemst1/2` | calibración Wi-Fi/BT/IMEI | **nunca tocar** |

---

## Fase 1 — Artefactos (riesgo: ninguno, y es la fase que más se saltea)

### Regla de las dos fuentes

Todo archivo que se va a flashear se verifica contra **dos orígenes independientes**.
Si los hashes no coinciden, se para. Un solo origen no prueba nada: prueba que el
servidor devolvió lo que el servidor tiene.

```bash
sha256sum archivo.zip
# comparar con el segundo origen, byte a byte:
cmp -s copia-a.zip copia-b.zip && echo IDENTICOS
```

Fuentes que funcionaron bien: releases oficiales del proyecto, SourceForge (API
`best_release.json` publica los hashes), GitHub Releases, y espejos de archivo
(`archive.org`) como segunda opinión.

### Auditar un ZIP antes de flashearlo

Un ZIP de ROM o de GApps trae su propia cadena de integridad. Se puede verificar aunque
el recovery no confíe en la clave:

```bash
# 1) firma PKCS#7 sobre CERT.SF
openssl smime -verify -inform DER -in META-INF/CERT.RSA -content META-INF/CERT.SF -noverify

# 2) digest de MANIFEST.MF declarado en CERT.SF  ==  hash real de MANIFEST.MF
# 3) cada digest de MANIFEST.MF  ==  hash real del archivo correspondiente
```

Si el paso 1 dice `Verification successful` y el 3 da 0 archivos con digest incorrecto,
el paquete no fue alterado desde que su autor lo firmó. Eso es independiente de si el
recovery confía o no en esa clave.

### Qué mirar dentro del paquete

| Chequeo | Cómo | Por qué |
|---|---|---|
| Arquitectura | `lib/arm/` vs `lib/arm64/`, y el `build.prop` interno | un paquete arm64 no arranca en un equipo 32-bit |
| Versión de Android | `ro.build.version.sdk` esperado | SDK equivocado = aborto o crash |
| Esquema de instalación | `system/` en la raíz del ZIP | overlay a `/system`, no imagen completa |
| Instalador | `META-INF/com/google/android/update-binary` | saber qué chequeos va a hacer |

---

## Fase 2 — Desbloqueo del bootloader (riesgo: ALTO — borra todo)

```bash
adb reboot bootloader
fastboot oem unlock-go          # el comando exacto varía por fabricante
fastboot getvar all 2>&1 | grep -E "unlocked|tampered"
```

Puerta: `Device unlocked: true` **y** `tampered: false`.

Desbloquear **borra el equipo**. Es el único momento en que se puede hacer backup del
stock, así que si se quiere conservar algo, se saca antes.

---

## Fase 3 — TWRP en RAM, backup del `aboot` y parcheo (riesgo: ALTO)

Esta es la fase menos obvia y la que más se subestima.

### Por qué hace falta un paso extra

Los ports de LineageOS para estos SoC viejos necesitan un `aboot` (bootloader)
**parcheado**: el `aboot` stock carga el kernel en una dirección que no coincide con la
que declara el recovery moderno. Si se flashea Lineage Recovery sin parchear, el equipo
muere en silencio — sin mensaje, sin fastboot, nada.

En el caso real el parche movió dos direcciones:

```
DTB      0x81e00000  ->  0x82e00000
ramdisk  0x82000000  ->  0x84000000
```

### El orden correcto

1. **Bootear TWRP en RAM**, no flashearlo:
   ```bash
   fastboot boot twrp-<version>-<codename>.img
   ```
   En RAM no se escribe nada: si el recovery no arranca, se apaga y listo.

2. **Backup propio del `aboot`, por `dd`, antes de que el patcher toque nada:**
   ```bash
   dd if=/dev/block/by-name/aboot of=/tmp/aboot-stock.img
   sha256sum /tmp/aboot-stock.img
   ```
   Leerlo **dos veces** y comparar. Si los dos hashes no coinciden, el backup no sirve.
   Sacar una copia fuera del equipo.

3. **Correr el patcher con DRYRUN** y leer la salida antes de aplicar.

4. Aplicar, y **verificar releyendo la partición**.

Puerta: backup verificado 2 veces + fuera del equipo, y `aboot` parcheado confirmado en
lectura.

> **Nunca** usar `FORCE=1` para saltear el backup. Nunca.

### Por qué TWRP y no Lineage Recovery acá

TWRP de estos equipos es el **kernel stock** con un recovery encima: por eso arranca
antes del parche. Lineage Recovery no.

---

## Fase 4 — Recovery definitivo (riesgo: medio)

```bash
fastboot flash recovery recovery-<codename>.img
fastboot reboot recovery
```

Puerta: recovery en pantalla y `adb devices` mostrando estado `recovery`.

### Detalle que cuesta medio día: `Enable ADB`

En Lineage Recovery, `adb` recién instalado aparece como `unauthorized`. No hay diálogo
RSA. La solución está en el menú:

```
Advanced  ->  Enable ADB
```

Eso setea `ro.adb.secure.recovery=0` y reinicia `adbd`.

> **Es runtime-only.** No persiste. Después de **cada** Format data o reboot a recovery
> hay que volver a hacerlo. Si `adb` dice `unauthorized`, es esto.

### Menú de Lineage Recovery (17.1)

```
Reboot system now
Apply update      ->  Apply from ADB | Choose from <volumen>
Factory reset     ->  Format data/factory reset
Advanced          ->  Mount /system | View recovery logs | Enable ADB | Run graphics test
```

---

## Fase 5 — Wipe (riesgo: medio)

`Factory reset` -> `Format data/factory reset` -> confirmar.

`/data` queda en el filesystem que la ROM espera (frecuentemente **f2fs**, que TWRP de
estos ports **no puede montar** — su kernel es solo ext4). Consecuencia práctica: no se
puede sembrar `/data/misc/adb/adb_keys` desde TWRP. Para eso está `Enable ADB`.

---

## Fase 6 — ROM (riesgo: medio)

**Flashear la ROM en Lineage Recovery, no en TWRP.** Motivo concreto: el `updater-script`
de la ROM usa rutas `/dev/block/by-name/...`, que **solo existen en Lineage Recovery**.
En TWRP el script falla.

```bash
adb sideload lineage-<version>-<codename>.zip
```

Puerta — leer el **log del recovery**, no el porcentaje del host:

```
wrote 257241 blocks; expected 257241      # system
wrote  32295 blocks; expected  32295      # vendor / cache
```

Si los dos números no coinciden, la escritura quedó corta. No reiniciar: repetir.

---

## Fase 7 — GApps (riesgo: medio)

LineageOS **no** trae apps de Google, por licencias. Si se quieren, van acá.

### Elegir el paquete correcto

| Dato del equipo | Paquete |
|---|---|
| `armeabi-v7a` sin arm64 | GApps **ARM 32-bit** |
| `arm64-v8a` | GApps **ARM64** |
| Android 10 (SDK 29) | build **10.0.0** |

Un paquete de arquitectura equivocada no arranca, aunque "pese lo mismo".

### El orden es obligatorio

> Si se arrancó el sistema **antes** de instalar GApps, hay que hacer factory reset
> primero. Si no, Play Services entra en crash loop.

O sea: `Format data` -> sideload GApps -> recién ahí el primer arranque.

### `Signature verification failed` es esperado

El recovery confía solo en las claves de Lineage y en la `testkey` con la que se firmó
la ROM. Las GApps se firman con otra clave, así que la verificación falla. En builds
`userdebug` el recovery ofrece:

```
Signature verification failed
Install anyway?
    No        <- el cursor arranca acá
    Yes
```

Bajar una vez (Volumen Abajo) y confirmar con Power. **Si se toca Power directo, se
elige `No`.**

Esto no es un agujero de seguridad: el paquete se verificó por hash y por su propia
cadena PKCS#7 antes de mandarlo.

### Verificar por hash, no por código de salida

El instalador de MindTheGapps es un shell script (`update-binary`) que:

1. descomprime a `/tmp`
2. chequea arquitectura (`uname -m` vs `build.prop`)
3. monta `system` y chequea SDK
4. chequea espacio
5. genera `addon.d/30-gapps.sh`
6. **copia** con `cp --preserve=a -r ./* "$SYSTEM_OUT/"`

La verificación honesta es comparar cada archivo instalado contra el ZIP:

```bash
# host
cd extraido/system && find . -type f | sort | while read f; do
  printf "%s  %s\n" "$(md5sum "$f" | cut -d' ' -f1)" "${f#./}"; done > host.md5

# device (con system montada)
adb shell "cd /mnt/system/system && md5sum \$(cat /tmp/filelist.txt)" > dev.md5
diff <(sort host.md5) <(sort dev.md5) && echo "TODO OK"
```

Puerta: **todos** los hashes coinciden.

---

## Fase 8 — Verificación de hardware (riesgo: ninguno)

```bash
adb shell getprop ro.lineage.version
adb shell uname -a
adb shell cat /proc/cpuinfo | grep -c processor
adb shell dumpsys battery | grep -E "level|status|health"
adb shell wm size; adb shell wm density
adb shell dumpsys input | grep -iE "touch|slot"
adb shell dumpsys media.camera | grep -iE "Number of camera|Facing"
adb shell dumpsys sensorservice | head -40
adb shell ip addr show wlan0
adb shell settings get global bluetooth_on
adb shell pm list packages | wc -l
```

Comparar contra lo que el hardware **debe** tener. Ejemplo: el X50F tiene **una sola**
cámara (trasera); si aparecen dos, algo está mal.

---

## Fase 10 — Optimización post-flasheo (Android 10) (riesgo: ninguno)

Esta fase se ejecuta una vez que LineageOS 17.1 y GApps ya están instalados y el hardware verificado.
Su objetivo es maximizar la fluidez, reducir consumo de RAM y batería en este procesador (Snapdragon 210 / MSM8909 con 1GB/2GB RAM).

### 1. Medición de Baseline (Estado Inicial)
```bash
adb shell cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable|Cached|SwapTotal|SwapFree"
adb shell cat /proc/swaps
adb shell uptime
adb shell wm size
adb shell wm density
adb shell pm list packages | wc -l
adb shell df -h /data
```

### 2. Animaciones a 0 (o 0.5)
Desactivar animaciones elimina el retardo de renderizado gráfico de la GPU/CPU:
```bash
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0
```

### 3. Densidad de Pantalla a 213 dpi
Mantiene el valor stock óptimo para paneles 800x1280 sin distorsión de elementos UI:
```bash
adb shell wm density 213
```

### 4. Desactivación de Telemetría y Paquetes Pesados
Inhabilita servicios de Google en segundo plano que saturan la CPU/RAM:
```bash
adb shell pm disable-user --user 0 com.google.android.feedback
adb shell pm disable-user --user 0 com.google.android.apps.pixelmigrate
adb shell pm disable-user --user 0 com.google.android.googlequicksearchbox
```

### 5. Restricción en Segundo Plano para Google Play Store
Evita escaneos y descargas espontáneas en segundo plano. Las apps se actualizan normalmente cuando el usuario abre la Play Store:
```bash
adb shell cmd appops set com.android.vending RUN_ANY_IN_BACKGROUND ignore
```

### 6. Qué NO hacer (y por qué)
- **No tocar CPU Governor / Frecuencias**: Requiere root y puede generar inestabilidad térmica.
- **No modificar ZRAM / Swappiness a mano**: La configuración por defecto del kernel LineageOS ya está ajustada para este SoC.
- **No forzar fstrim manual ni tocar dm-verity**: Requiere privilegios root no disponibles / innecesarios.

### 7. Puerta de Verificación Post-Optimización
Comprobar que los valores quedaron aplicados:
```bash
adb shell settings get global window_animation_scale    # Retorna 0
adb shell settings get global transition_animation_scale # Retorna 0
adb shell settings get global animator_duration_scale   # Retorna 0
adb shell wm density                                    # Retorna Physical: 800x1280 Override: 213
adb shell pm list packages -d                           # Muestra feedback, pixelmigrate, googlequicksearchbox
adb shell cmd appops get com.android.vending RUN_ANY_IN_BACKGROUND # Retorna ignore
```

---

## Tabla de IDs USB (para saber en qué modo está)

| ID | Modo |
|---|---|
| `18d1:4ee1` | Android normal, **solo MTP** (sin depuración) |
| `18d1:4ee7` | Android, cargando + debug |
| `17ef:7933` | Android con **adb** activo (Lenovo) |
| `18d1:d00d` | **fastboot** |
| `18d1:d001` | **Lineage Recovery** |
| `18d1:4ee2` | **TWRP** |

