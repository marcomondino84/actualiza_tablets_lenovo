# Lenovo Yoga Tab 3 (bamboo / mimbre) — LineageOS 17.1 (Android 10)

Unofficial LineageOS 17.1 (Android 10) for the Lenovo Yoga Tab 3 family, based on the
Qualcomm Snapdragon 212 (MSM8909/APQ8009).

Maintainer: **mrfernan** (dobraeuyan)

## Project Sweden

The Yoga Tab 3 family is part of **Project Sweden**, the unified effort to bring a
Treble-compliant LineageOS 17.1 to the Snapdragon 210 family. It shipped with Android 5.1
Lollipop (kernel 3.10) and **has no `/vendor` partition**, so the project repurposes
the `cache` partition as `/vendor` ("cache-as-vendor") to satisfy Project Treble.

| Project Sweden pillar | On this device |
|---|---|
| Kernel | Stock 3.10 ? common **4.9.337** |
| Vendor layer | cache-as-vendor (no native `/vendor`) |
| system-as-root | Yes (`/system` mounted at `/`) |
| 64-bit binder | Yes |
| GSI flavor | `arm32_binder64-ab-vndklite` |

## Which device do I have?

This port targets the **Yoga Tab 3**. It shipped in two sizes (8-inch and 10-inch), each
with several variants. **They are not interchangeable** — flashing the wrong image can
leave your device unbootable. Check the model number printed on the back of the device,
retail box, or under **Settings** on stock firmware:

| Model | Codename | Variant / Notes |
|---|---|---|
| YT3-850F | `bamboo` | 8" (Wi-Fi only) |
| YT3-850L | `bamboolte` | 8" (LTE) |
| YT3-850M | `bamboolte` | 8" (LTE) |
| YT3-X50F | `mimbre` | 10" (Wi-Fi only) |
| YT3-X50L | `mimbrelte` | 10" (LTE) |
| YT3-X50M | `mimbrelte` | 10" (LTE) |

## What works

- **Accel sensor**
- **Adoptable storage**
- **Audio**
- **Battery / charging**
- **Bluetooth**
- **Camera**
- **Display**
- **DRM**
- **Encryption**
- **GPS**
- **Hardware Dec/Enc**
- **Hotspot**
- **Jack 3.5mm**
- **LED**
- **LiveDisplay**
- **Light sensor**
- **Magnetometer sensor**
- **Micro SD**
- **Microphone**
- **SELinux**
- **TEE**
- **Touchscreen**
- **USB**
- **Vibration**
- **WiFi**
- **WiFi Direct**

## Known issues

### General

- **WiFi Display**

### bamboolte / mimbrelte

- **RIL**

## Installation (first-time / clean flash)

Installing wipes your device. You need an unlocked bootloader first.
You NEED to be on stock Android 6.

1. Reboot to the bootloader:
   ```
   adb reboot bootloader
   ```
2. Boot TWRP:
   ```
   fastboot boot twrp-3.7.0_9-0-<model>.img
   ```
3. Flash the aboot patcher from internal storage or SD Card. You can also sideload it:
   ```
   adb sideload patcher-v2.zip
   ```
4. Reboot to the bootloader again:
   ```
   adb reboot bootloader
   ```
5. Flash and boot Lineage Recovery:
   ```
   fastboot flash recovery recovery-<model>.img
   ```
   ```
   fastboot boot recovery-<model>.img
   ```
6. **Wipe ? Format Data / Factory Reset**
7. Flash the ROM from SD Card. You can also sideload it:
   ```
   adb sideload lineage-17.1-<date>-UNOFFICIAL-<model>.zip
   ```
8. *(Optional)* Flash a 32-bit ARM GApps / MicroG package the same way, or Magisk.
9. Reboot to system.

## Generic System Image (GSI)

As a Treble-compliant device, a `arm32_binder64-ab-vndklite` GSI can be installed.

## Reporting issues / Contact

Telegram Group: https://t.me/msm8909chat

When reporting a problem, please include:

- Your exact model
- The build date from the filename
- Steps to reproduce
- `adb logcat` and/or `dmesg` output

