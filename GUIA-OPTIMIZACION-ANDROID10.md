# Guía de optimización — movida al documento principal

Este contenido ya **no vive acá**. Se integró como **Fase 10 — Optimización post-flasheo**
en el documento principal:

```
/home/admin/Descargas/GUIA-FLASHEO-REUTILIZABLE.md
```

Motivo: dos copias del mismo procedimiento se desincronizan. El flasheo y la optimización
son el mismo trabajo sobre el mismo equipo, así que van en un solo documento.

Qué contiene esa fase:

- Baseline medido (RAM, zram, carga, paquetes, almacenamiento, densidad).
- Animaciones en **0** (opción válida en este hardware; 0.5 si se prefiere conservar feedback visual).
- Densidad a 213 dpi (valor stock) sin tocar la resolución física.
- Paquetes desactivados: `com.google.android.feedback`, `com.google.android.apps.pixelmigrate`, `com.google.android.googlequicksearchbox` (buscador/Assistant).
- Play Store: restringida en segundo plano (`RUN_ANY_IN_BACKGROUND ignore`). Las actualizaciones de apps se hacen desde Play Store cuando el usuario la abre.
- Qué **no** hacer y por qué (governor, zram, fstrim, dm-verity: requieren root).
- Trampas encontradas y puerta de verificación.

El registro por equipo sigue en `PLAN-FLASHEO.md` y `PLAN-FLASHEO-2.md`.
