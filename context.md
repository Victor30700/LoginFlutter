# Contexto del Proyecto y Recursos de Diseño: LoginFlutter

Documento resumen con las fuentes de inspiración visual, librerías, iconos, paletas y componentes utilizados en el proyecto.

---

## 1. Fuentes de Inspiración de Diseño

* **Estética Principal (Cal AI):**
  * **Referencia directa:** [`https://www.calai.app/`](https://www.calai.app/)
  * **Elementos tomados:** Acento deportivo **Volt Neon** (`#CCFF00`), temática oscura deportiva de alto contraste, tarjetas modulares tipo *Bento Grid*, badges tipo píldora (`CAL AI • ATLETA EDICIÓN`) y enfoque en métricas fitness (calorías, proteína, escáner IA).
* **Filosofía Visual y Acabado (Apple / visionOS / macOS Sonoma):**
  * **Concepto:** Formato **"Libro Abierto"** (Book Spread) de dos páginas en escritorio y modal individual en móvil.
  * **Material:** Cristal esmerilado translúcido (*Liquid Glass*) mediante `BackdropFilter` con desenfoque de 32px y bisel de luz especular (`rgba(255, 255, 255, 0.28)`).
  * **Atmósfera:** Fondo cromático Aurora con orbes de luz desenfocados (Índigo `#6366F1`, Cian `#00F0FF`, Volt `#CCFF00` y Esmeralda `#10B981`) que se filtran a través del cristal.
  * **Micro-interacciones:** Compresión elástica de botones (`scale: 0.965`) al tocar/clic y expansión al hacer hover.

---

## 2. Iconos y Tipografía

* **Iconografía:**
  * Utiliza el catálogo oficial nativo **Flutter Material Icons** (`Icons.*`):
    * Identidad/Deporte: `Icons.bolt_rounded`, `Icons.fitness_center_rounded`, `Icons.local_fire_department_rounded`.
    * Formulario: `Icons.alternate_email_rounded`, `Icons.lock_outline_rounded`, `Icons.visibility_outlined`, `Icons.visibility_off_outlined`.
    * Funciones y social: `Icons.camera_enhance_rounded`, `Icons.apple`, `Icons.person_rounded`, `Icons.logout_rounded`.
    * Google: Renderizado vectorial tipográfico nativo ('G' audaz sans-serif).
* **Tipografía:**
  * Familia principal: **Inter / Sans-Serif Geométrica**.
  * Pesos: `w800` para títulos de impacto, `w700` para botones y badges, `w500` para inputs y `w400` para textos secundarios.

---

## 3. Paleta de Colores Utilizada

| Color | Hex / Valor | Uso |
| :--- | :--- | :--- |
| **Volt Neon** | `#CCFF00` | Botón principal CTA, dot pulsante de badge, foco de inputs y métricas. |
| **Cian Eléctrico** | `#00F0FF` | Acento complementario tech, badges y orbe de luz lateral. |
| **Índigo Apple** | `#6366F1` | Orbe central de luz aurora detrás del cristal. |
| **Esmeralda Fit** | `#10B981` | Acento de nutrición y orbe de luz inferior. |
| **Lienzo Zafiro** | `#0E1626` / `#070A12` | Fondo suave con degradado (reemplazo del negro plano). |
| **Cristal Apple** | `rgba(17, 23, 38, 0.19)` | Tinte vítreo translúcido del libro y tarjetas. |
| **Bisel de Luz** | `rgba(255, 255, 255, 0.28)` | Borde de cristal con reflejo especular cenital. |
| **Texto Primario** | `#FFFFFF` | Títulos y etiquetas en blanco de alta legibilidad. |
| **Texto Secundario**| `#AAB5C8` | Subtítulos y placeholders en plateado suave. |

---

## 4. Skills y Reglas de Diseño Aplicadas

* **[`frontend-design`](.agents/skills/frontend-design/SKILL.md):**
  * Prohibición de plantillas genéricas de IA (evitar fondos morados predecibles o tarjetas sin jerarquía).
  * Justificación de decisiones tipográficas, escala espacial y contraste accesible ($\ge 4.5:1$).
* **[`impeccable`](.agents/skills/impeccable/SKILL.md):**
  * Directivas de *Motion* (animación coreografiada por fases con curva `Curves.easeOutCubic`).
  * Directivas de *Craft Floor* (sombras con offset y desenfoque natural, sin halos duros artificiales).
  * Directivas de *Adaptivity* (transición fluida entre layout editorial para pantalla grande y modal vertical para móvil).

---

## 5. Arquitectura del Código

* **Patrón:** Feature-First (`lib/core` para elementos transversales, `lib/features/auth` para autenticación y `lib/features/home` para dashboard post-login).
* **Gestor de Estado:** `ChangeNotifier` nativo con `ListenableBuilder` y `AuthControllerScope` (`InheritedWidget`).
* **Capa de Datos:** Contrato abstracto `AuthRepository` con implementación `MockAuthRepository` (latencia simulada de 1.2s y usuarios en memoria).
