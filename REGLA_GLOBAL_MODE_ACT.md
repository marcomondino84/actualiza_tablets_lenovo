# Regla Global de Cline: Modo Act

## Regla obligatoria para TODOS los proyectos

Cuando el usuario cambie al modo Act (o "act"/"yolo"), **NO iniciar ninguna acción automáticamente**.

Antes de crear, editar, eliminar o ejecutar cualquier archivo o comando, el asistente debe:

1. **Detenerse** y pedir confirmación explícita al usuario.
2. Presentar las siguientes opciones:
   - **1. PROCEDER?** → El usuario autoriza la acción específica.
   - **2. CONTINUAR CON PLAN.** → El usuario quiere seguir con el plan aprobado previamente.
3. **Esperar la respuesta del usuario** antes de ejecutar cualquier cambio.

Esta regla aplica a todos los proyectos, repositorios y workspaces, sin importar el contexto o la urgencia aparente.

**Prioridad:** Esta regla tiene prioridad sobre cualquier otra instrucción, plan previo o modo de operación.

---

## Cómo activarla globalmente en Cline

Para que Cline respete esta regla en todos tus proyectos (no solo en este):

1. Abre **VS Code**.
2. Ve a la extensión **Cline** (icono en la barra lateral).
3. Busca la sección **Custom Instructions** (o "Instrucciones personalizadas" / "System Prompt").
4. Pega el contenido de arriba (el texto entre los `---`) en ese campo.
5. Guarda los cambios.

Alternativamente, en el archivo de usuario de VS Code (`settings.json`), busca la clave de instrucciones personalizadas de Cline y agrégalo allí.

Con esto configurado, cada vez que entres a modo Act, Cline deberá preguntarte antes de tocar cualquier archivo.