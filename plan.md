# Plan de Trabajo y ÃƒÆ’Ã¢â‚¬Â°picas: LoginFlutter (Estilo Cal AI / Gym Fitness)

Este archivo gestiona el roadmap, las ÃƒÆ’Ã‚Â©picas, las fases de desarrollo y el progreso de cada funcionalidad en **LoginFlutter**.
La estructura de archivos vive en [`structure.md`](file:///D:/scripts-csharp/ProFlutters/LoginFlutter/structure.md) y el contexto del producto en [`PRODUCT.md`](file:///D:/scripts-csharp/ProFlutters/LoginFlutter/PRODUCT.md).

---

## ÃƒÆ’Ã¢â‚¬Â°pica 1: Acceso Fitness Premium (Login, Registro y Home Dashboard)

Crear el flujo de autenticaciÃƒÆ’Ã‚Â³n de alta gama inspirado en el lenguaje visual de **Cal AI** (`https://www.calai.app/`):
- Tema Dark de alto contraste (`#090A0C`, `#121418`, `#1B1E24`).
- Acentos deportivos en **Volt Neon / Lime Green** (`#CCFF00`) y **Cyan Glow** (`#00F0FF`).
- TipografÃƒÆ’Ã‚Â­a moderna con pesos contrastados y micro-badges.
- Tarjetas con bordes ultra-delgados (`#262A33`) y sombras suaves.

### Credenciales de prueba (Mock)
- **Email:** `demo@calai.app`
- **Password:** `Calai2026!`

---

## Fases de Trabajo

### Fase 1: Fundaciones Core y Tokens de DiseÃƒÆ’Ã‚Â±o Cal AI
- [x] Definir tokens de diseÃƒÆ’Ã‚Â±o en `lib/core/constants/app_colors.dart` (Volt Neon `#CCFF00`, Deep Dark `#090A0C`, Surface Dark `#14171D`, Border `#242833`, Text White `#FFFFFF`, Muted Silver `#8F97A6`).
- [x] Definir tipografÃƒÆ’Ã‚Â­as en `lib/core/constants/app_text_styles.dart` y espaciados en `lib/core/constants/app_spacing.dart`.
- [x] Configurar cadenas y mensajes en `lib/core/constants/app_strings.dart`.
- [x] Implementar utilidades de validaciÃƒÆ’Ã‚Â³n en `lib/core/utils/validators.dart` (email estricto, password seguro, nombre).
- [x] Configurar tema oscuro integral Material 3 en `lib/core/theme/app_theme.dart`.
- [x] Configurar rutas en `lib/core/routing/app_routes.dart`.

### Fase 2: Capa de Datos (Modelos, Excepciones y Repositorio Mock)
- [x] Crear `lib/features/auth/data/models/user_model.dart`.
- [x] Crear `lib/features/auth/data/exceptions/auth_exception.dart`.
- [x] Definir interfaz abstracta `lib/features/auth/data/repositories/auth_repository.dart`.
- [x] Implementar `lib/features/auth/data/repositories/mock_auth_repository.dart` con latencia artificial (1.2s), control de credenciales y persistencia en memoria.

### Fase 3: Controlador de Estado de SesiÃƒÆ’Ã‚Â³n
- [x] Implementar `lib/features/auth/presentation/controllers/auth_controller.dart` usando `ChangeNotifier`.
- [x] Manejar estados: `initial`, `loading`, `authenticated`, `error`.
- [x] Conectar mÃƒÆ’Ã‚Â©todos `login`, `register`, `loginWithSocial` y `logout`.

### Fase 4: Componentes Reutilizables de UI (EstÃƒÆ’Ã‚Â©tica Cal AI)
- [x] `lib/features/auth/presentation/widgets/custom_text_field.dart`: Input oscuro estilizado con bordes reactivos al foco, prefijo de icono fitness y toggle de visibilidad.
- [x] `lib/features/auth/presentation/widgets/custom_primary_button.dart`: BotÃƒÆ’Ã‚Â³n pÃƒÆ’Ã‚Â­ldora en Volt Neon (`#CCFF00`) con texto en negro profundo y spinner de carga integrado.
- [x] `lib/features/auth/presentation/widgets/social_login_button.dart`: Botones minimalistas para Google y Apple con iconos limpios.
- [x] `lib/features/auth/presentation/widgets/auth_error_banner.dart`: NotificaciÃƒÆ’Ã‚Â³n de error con micro-borde rojizo y texto claro.

### Fase 5: Pantalla de Login (Cal AI Style)
- [x] Crear `lib/features/auth/presentation/screens/login_screen.dart`:
  - Badge superior tipo "AI FITNESS TRACKER / GYM".
  - TÃƒÆ’Ã‚Â­tulo audaz con energÃƒÆ’Ã‚Â­a deportiva: "Eleva tu rendimiento."
  - Formulario reactivo (`FormKey`).
  - Inputs con autocompletado y validaciones visuales.
  - BotÃƒÆ’Ã‚Â³n principal de Login.
  - Separador y accesos sociales (Google / Apple).
  - Enlace al Registro.
  - Centrado responsivo para web/desktop y mobile.

### Fase 6: Pantalla de Registro
- [x] Crear `lib/features/auth/presentation/screens/register_screen.dart` con campos de nombre, email, password y confirmaciÃƒÆ’Ã‚Â³n.
- [x] ConexiÃƒÆ’Ã‚Â³n al controlador para registrar nuevo usuario y navegar directamente.

### Fase 7: Pantalla Home (Dashboard Fitness de Bienvenida)
- [x] Crear `lib/features/home/presentation/screens/home_screen.dart`:
  - Tarjeta bento de bienvenida con saludo personalizado.
  - Tarjetas rÃƒÆ’Ã‚Â¡pidas con estadÃƒÆ’Ã‚Â­sticas mock (CalorÃƒÆ’Ã‚Â­as objetivo, ProteÃƒÆ’Ã‚Â­nas, Entrenamientos).
  - BotÃƒÆ’Ã‚Â³n de cierre de sesiÃƒÆ’Ã‚Â³n (*Logout*) con retorno seguro al Login.

### Fase 8: Ensamble y VerificaciÃƒÆ’Ã‚Â³n
- [x] Conectar `lib/app.dart` y `lib/main.dart` con los proveedores y tema.
- [x] Comprobar anÃƒÆ’Ã‚Â¡lisis estÃƒÆ’Ã‚Â¡tico (`flutter analyze` - 0 errores).
- [x] Ejecutar suite de pruebas unitarias y de widgets (`flutter test` - 9/9 passed).

---

## ÃƒÆ’Ã¢â‚¬Â°pica 2: Refinamiento Visual y Animaciones Fluidas (Estilo Apple)

Elevar la experiencia de usuario a un nivel de acabado **Apple-grade / Premium iOS**:
- **Profundidad y Glassmorphism:** Fondos con sutiles orbes de luz ambiental (aurora blur con `BackdropFilter`), tarjetas con acabado de cristal esmerilado y bordes ultra-finos (hairline borders) con gradiente de luz cenital.
- **Micro-interacciones y Feedback HÃƒÆ’Ã‚Â¡ptico Visual:** Efecto de compresiÃƒÆ’Ã‚Â³n y escala elÃƒÆ’Ã‚Â¡stica (`0.97`) en botones al presionar, tal como en iOS.
- **Entrada Coreografiada (Staggered Animation):** ApariciÃƒÆ’Ã‚Â³n fluida y progresiva con curvas `Curves.easeOutCubic` / `Curves.easeOutExpo` para el header, inputs, botÃƒÆ’Ã‚Â³n principal y accesos sociales.
- **Foco con Halo de Luz Suave:** Efecto de resplandor sutil e interactivo al seleccionar cada campo de texto.

### Fases de Trabajo

#### Fase 1: Fondo Ambiental con Gradientes OrgÃƒÆ’Ã‚Â¡nicos y Glassmorphism
- [x] Crear componente `lib/core/widgets/apple_ambient_background.dart` con orbes de luz desenfocados (Volt Neon + Cyan apagado) y `BackdropFilter`.
- [x] Crear `lib/core/widgets/glass_container.dart` con superficie translÃƒÆ’Ã‚Âºcida y borde hairline reflectivo.

#### Fase 2: Micro-animaciones y Feedback TÃƒÆ’Ã‚Â¡ctil (Press-scale)
- [x] Implementar `lib/core/widgets/pressable_scale.dart` para respuesta tÃƒÆ’Ã‚Â¡ctil elÃƒÆ’Ã‚Â¡stica inmediata en botones y tarjetas.
- [x] Integrar el efecto de escala en `custom_primary_button.dart` y `social_login_button.dart`.

#### Fase 3: Entrada Coreografiada Progresiva (Staggered Entrance)
- [x] Crear `lib/core/widgets/staggered_entrance.dart` para controlar la apariciÃƒÆ’Ã‚Â³n secuencial de los elementos de la pantalla (fade + slide up sutil de 18px).
- [x] Aplicar la coreografÃƒÆ’Ã‚Â­a en `login_screen.dart` y `register_screen.dart`.

#### Fase 4: Acabado de Inputs con Brillo Reactivo al Foco
- [x] Mejorar `custom_text_field.dart` con transiciÃƒÆ’Ã‚Â³n animada de borde y sombra difusa al recibir foco.
- [x] Suavizar la alternancia de visibilidad de contraseÃƒÆ’Ã‚Â±a con `AnimatedSwitcher`.

#### Fase 5: VerificaciÃƒÆ’Ã‚Â³n, AnÃƒÆ’Ã‚Â¡lisis y Pruebas
- [x] Validar con `flutter analyze` (0 errores).
- [x] Ejecutar suite de pruebas `flutter test` (9/9 pasadas).
- [x] Probar fluidez visual y compatibilidad responsive.

---

## ÃƒÆ’Ã¢â‚¬Â°pica 3: Layout Editorial "Libro Abierto" Adaptativo y Alto Contraste

Resolver la falta de contraste visual entre fondo y modal, y convertir el acceso en una experiencia de **"Libro Abierto" (Book Spread)** en pantallas grandes, que se pliega en un modal limpio en pantallas mÃƒÆ’Ã‚Â³viles:
- **Alto Contraste y SeparaciÃƒÆ’Ã‚Â³n ÃƒÆ’Ã¢â‚¬Å“ptica:** Superficies del modal con tono grafito/carbÃƒÆ’Ã‚Â³n elevado (`#181B24` a `#202532`), bordes perimetrales con reflejo de luz (`rgba(255, 255, 255, 0.16)`), sombras de profundidad realistas e inputs con contraste diferenciado (`#232836` con bordes `#363E52`).
- **Formato Libro en Pantallas Grandes (>= 850px):**
  - **PÃƒÆ’Ã‚Â¡gina Izquierda (Portada Visual / Showcase Cal AI):** Emblema de atleta, vitrina de caracterÃƒÆ’Ã‚Â­sticas de nutriciÃƒÆ’Ã‚Â³n/macros con badges de neÃƒÆ’Ã‚Â³n, frase de impacto y orbe de energÃƒÆ’Ã‚Â­a deportiva.
  - **Lomo Central (Book Spine):** Separador sutil con hendidura y lÃƒÆ’Ã‚Â­nea de luz que da el efecto fÃƒÆ’Ã‚Â­sico de pÃƒÆ’Ã‚Â¡ginas abiertas.
  - **PÃƒÆ’Ã‚Â¡gina Derecha (Formulario Interactivo):** Formulario de login/registro perfectamente jerarquizado y visible.
- **Formato Modal en Pantallas PequeÃƒÆ’Ã‚Â±as (< 850px):** Se pliega automÃƒÆ’Ã‚Â¡ticamente en una tarjeta modal vertical limpia y centrada para mÃƒÆ’Ã‚Â³vil.

### Fases de Trabajo

#### Fase 1: CalibraciÃƒÆ’Ã‚Â³n de Contraste y Tokens Visuales
- [x] Ajustar `app_colors.dart` para lograr una separaciÃƒÆ’Ã‚Â³n nÃƒÆ’Ã‚Â­tida (superficie del modal vs fondo, inputs con contraste legible).
- [x] Actualizar `app_theme.dart` para reflejar las nuevas superficies y bordes visibles.

#### Fase 2: Componente Libro Adaptativo (`BookSpreadContainer`)
- [x] Crear `lib/features/auth/presentation/widgets/book_spread_card.dart` con `LayoutBuilder` para detectar pantallas grandes (>= 860px) y mÃƒÆ’Ã‚Â³viles (< 860px).
- [x] Construir la pÃƒÆ’Ã‚Â¡gina izquierda del libro (Showcase deportivo Cal AI: badges, anillo de macros demo, testimonio/frase de atleta).
- [x] Integrar el lomo central con hendidura y bisel luminoso.

#### Fase 3: IntegraciÃƒÆ’Ã‚Â³n en Pantalla de Login y Registro
- [x] Actualizar `login_screen.dart` para usar `BookSpreadCard`.
- [x] Actualizar `register_screen.dart` con el mismo formato libro adaptativo.

#### Fase 4: Pruebas, AnÃƒÆ’Ã‚Â¡lisis y VerificaciÃƒÆ’Ã‚Â³n
- [x] Ejecutar `flutter analyze` y resolver cualquier detalle (0 issues).
- [x] Ejecutar `flutter test` asegurando que las pruebas de widget pasen en todos los tamaÃƒÆ’Ã‚Â±os (9/9 pasadas).

---

## ÃƒÆ’Ã¢â‚¬Â°pica 4: Centrado Perfecto, Cristal TranslÃƒÆ’Ã‚Âºcido Apple (Liquid Glass) y Fondo Space Gray

Ajustar la atmÃƒÆ’Ã‚Â³sfera general para que el cristal esmerilado translÃƒÆ’Ã‚Âºcido se aprecie claramente y el modal quede centrado tanto vertical como horizontalmente:
- **Fondo Space Gray / Titanio Oscuro:** Cambiar el negro absoluto por un tono carbÃƒÆ’Ã‚Â³n/titanio suave (`#10131B` a `#151923`) con orbes de luz aurora (Volt y Cyan) mÃƒÆ’Ã‚Â¡s vibrantes que se traslucen a travÃƒÆ’Ã‚Â©s del cristal.
- **Cristal TranslÃƒÆ’Ã‚Âºcido Apple (Frosted Liquid Glass):** Convertir el contenedor del libro y del modal en superficies semitransparentes (`BackdropFilter` con `sigma: 35.0`, tinte vÃƒÆ’Ã‚Â­treo `rgba(255, 255, 255, 0.05)` a `rgba(22, 28, 40, 0.45)`) con biseles de luz especular (`rgba(255, 255, 255, 0.22)`).
- **Centrado Absoluto en Pantalla:** Asegurar centrado vertical y horizontal exacto en cualquier resoluciÃƒÆ’Ã‚Â³n mediante `LayoutBuilder` y `SingleChildScrollView(child: ConstrainedBox(minHeight: viewportHeight, child: Center(...)))`.

### Fases de Trabajo

#### Fase 1: CalibraciÃƒÆ’Ã‚Â³n del Fondo y Orbes de Luz
- [x] Modificar `app_colors.dart` para cambiar el fondo a Space Gray (`#0E121A`) y definir transparencias de cristal Apple.
- [x] Actualizar `apple_ambient_background.dart` con orbes de luz mÃƒÆ’Ã‚Â¡s presentes para que se vean a travÃƒÆ’Ã‚Â©s del cristal.

#### Fase 2: RediseÃƒÆ’Ã‚Â±o TranslÃƒÆ’Ã‚Âºcido de `BookSpreadCard`
- [x] Aplicar `BackdropFilter` de alta definiciÃƒÆ’Ã‚Â³n y capas translÃƒÆ’Ã‚Âºcidas a las pÃƒÆ’Ã‚Â¡ginas del libro.
- [x] Ajustar el lomo central con transparencias para no romper el efecto de cristal.

#### Fase 3: Centrado Vertical y Horizontal Absoluto
- [x] Implementar centrado total en el viewport en `login_screen.dart` y `register_screen.dart`.

#### Fase 4: Pruebas y VerificaciÃƒÆ’Ã‚Â³n
- [x] Ejecutar `flutter analyze` (0 errores).
- [x] Ejecutar `flutter test` (9/9 pasadas).

---

## ÃƒÆ’Ã¢â‚¬Â°pica 5: Cristal Ultra-TranslÃƒÆ’Ã‚Âºcido Apple y Fondo Aurora de Alto Contraste

Hacer que la transparencia del modal sea 100% evidente y llamativa al estilo Apple (macOS / visionOS):
- **Causa del problema:** En un fondo casi uniforme u oscuro, el desenfoque no tiene elementos cromÃƒÆ’Ã‚Â¡ticos que refractar y parece una tarjeta sÃƒÆ’Ã‚Â³lida.
- **SoluciÃƒÆ’Ã‚Â³n Visual Apple:**
  - **Fondo Aurora DinÃƒÆ’Ã‚Â¡mico:** Fondo enriquecido con tonos azul zafiro medianoche (`#121927`), ÃƒÆ’Ã‚Â­ndigo profundo (`#16132C`) y orbes vibrantes de luz (Cian Tech, Volt Neon y Magenta/Cobalto sutil) que pasan directamente detrÃƒÆ’Ã‚Â¡s del modal.
  - **Efecto Cristal Ultra-TranslÃƒÆ’Ã‚Âºcido (Pure Liquid Glass):** Relleno vÃƒÆ’Ã‚Â­treo con tinte blanco translÃƒÆ’Ã‚Âºcido (`rgba(255, 255, 255, 0.07)` a `rgba(255, 255, 255, 0.02)`) sobre `BackdropFilter` de 32px.
  - **Bisel Especular Cenital:** Borde con gradiente de luz real (borde superior e izquierdo con reflejo blanco de alta definiciÃƒÆ’Ã‚Â³n `rgba(255,255,255, 0.35)` que simula el filo de una lÃƒÆ’Ã‚Â¡mina de cristal real).
  - **Inputs TranslÃƒÆ’Ã‚Âºcidos:** Campos de formulario que tambiÃƒÆ’Ã‚Â©n permiten ver la refracciÃƒÆ’Ã‚Â³n de luz por detrÃƒÆ’Ã‚Â¡s.

### Fases de Trabajo

#### Fase 1: Fondo CromÃƒÆ’Ã‚Â¡tico Aurora Apple
- [x] Enriquecer `apple_ambient_background.dart` con una atmÃƒÆ’Ã‚Â³sfera de gradientes zafiro/ÃƒÆ’Ã‚Â­ndigo y 4 orbes luminosos estratÃƒÆ’Ã‚Â©gicamente ubicados detrÃƒÆ’Ã‚Â¡s del libro.

#### Fase 2: Material de Cristal Ultra-TranslÃƒÆ’Ã‚Âºcido en `BookSpreadCard`
- [x] Reemplazar fondos oscuros por tinte blanco cristalino (`Colors.white.withValues(alpha: 0.06)` a `0.03`).
- [x] Implementar bisel especular en los bordes para simular el brillo del corte del vidrio (`Colors.white.withValues(alpha: 0.28)`).
- [x] Hacer que ambas pÃƒÆ’Ã‚Â¡ginas (izquierda y derecha) sean translÃƒÆ’Ã‚Âºcidas para que el fondo se aprecie a travÃƒÆ’Ã‚Â©s de todo el libro.

#### Fase 3: Inputs y Componentes VÃƒÆ’Ã‚Â­treos
- [x] Ajustar `custom_text_field.dart` y `social_login_button.dart` para armonizar con el cristal sin perder legibilidad.

#### Fase 4: Pruebas y VerificaciÃƒÆ’Ã‚Â³n
- [x] Ejecutar `flutter analyze` (0 errores).
- [x] Ejecutar `flutter test` (9/9 pasadas).

---

## ÃƒÆ’Ã¢â‚¬Â°pica 6: CompilaciÃƒÆ’Ã‚Â³n y Entrega del APK Android

Configurar el toolchain de Android (JDK 17 + Android SDK & Cmdline-tools + Gradle 9.3) y generar el paquete instalable `.apk` para dispositivos mÃƒÆ’Ã‚Â³viles Android:
- ConfiguraciÃƒÆ’Ã‚Â³n de Microsoft OpenJDK 17 en entorno portÃƒÆ’Ã‚Â¡til.
- ConfiguraciÃƒÆ’Ã‚Â³n de Android cmdline-tools y aceptaciÃƒÆ’Ã‚Â³n de licencias oficiales de Google.
- VinculaciÃƒÆ’Ã‚Â³n sin espacios en ruta mediante junction `C:\Android\Sdk`.
- CompilaciÃƒÆ’Ã‚Â³n en modo release: `flutter build apk --release`.
- GeneraciÃƒÆ’Ã‚Â³n exitosa del binario firmado: [`app-release.apk`](file:///D:/scripts-csharp/ProFlutters/LoginFlutter/build/app/outputs/flutter-apk/app-release.apk) (46.5 MB).

---

## ÃƒÆ’Ã¢â‚¬Â°pica 7: RediseÃƒÆ’Ã‚Â±o Integral BOSSUX (Bienvenida con Video, Login Limpio, Home Bento & Floating Navbar)

Transformar la aplicaciÃƒÆ’Ã‚Â³n en **BOSSUX**, una experiencia fitness y de nutriciÃƒÆ’Ã‚Â³n deportiva de alta gama basada en las referencias visuales de `img/`:
- **Nombre e Identidad de Marca:** **BOSSUX** (eliminando cualquier referencia a "Calz").
- **Paleta de Colores (`img/gama_Colores`):** Fondo carbÃƒÆ’Ã‚Â³n profundo (`#0D0F14`, `#13161F`), acentos deportivos en **Volt Lime / Verde NeÃƒÆ’Ã‚Â³n** (`#D4FE11` / `#CCFF00`), superficies translÃƒÆ’Ã‚Âºcidas con efecto cristal esmerilado (*glassmorphism*) y bordes de luz ultra-finos (`rgba(255, 255, 255, 0.08)`).
- **Flujo de Pantallas:**
  1. `WelcomeScreen` (Bienvenida / Onboarding con video fitness en bucle continuo).
  2. `LoginScreen` (Acceso minimalista BOSSUX: correo, botÃƒÆ’Ã‚Â³n continuar, Google auth y botÃƒÆ’Ã‚Â³n atrÃƒÆ’Ã‚Â¡s).
  3. `RegisterScreen` (Registro integrado y coherente con el estilo translÃƒÆ’Ã‚Âºcido BOSSUX).
  4. `HomeScreen` (Dashboard Bento Grid: selector semanal de dÃƒÆ’Ã‚Â­as, anillos de macros, racha de fuego ÃƒÂ°Ã…Â¸Ã¢â‚¬ÂÃ‚Â¥ y registros recientes).
  5. `CustomBottomNavBar` (Dock inferior flotante translÃƒÆ’Ã‚Âºcido con accesos y botÃƒÆ’Ã‚Â³n de acciÃƒÆ’Ã‚Â³n rÃƒÆ’Ã‚Â¡pida `+`).

### DecisiÃƒÆ’Ã‚Â³n de Arquitectura: Video de Fondo en Bienvenida
- **Estrategia Recomendada:** **Asset de Video Local (`assets/videos/fitness_bg.mp4`)**.
  - **Causa:** En un APK de prueba, un video local garantiza carga instantÃƒÆ’Ã‚Â¡nea (0 ms), reproducciÃƒÆ’Ã‚Â³n fluida en bucle sin buffering, funciona sin conexiÃƒÆ’Ã‚Â³n a internet y evita caÃƒÆ’Ã‚Â­das por enlaces caÃƒÆ’Ã‚Â­dos o polÃƒÆ’Ã‚Â­ticas CORS.
  - **OptimizaciÃƒÆ’Ã‚Â³n:** Video comprimido en H.264 / 720p (4 a 8 segundos) que pesa entre 2 y 4 MB, manteniendo el APK liviano.
  - **Fallback:** Gradiente ambiental animado con orbes Volt mientras se carga o en caso de error.

---

### Fases de Trabajo - ÃƒÆ’Ã¢â‚¬Â°pica 7

#### Fase 1: ActualizaciÃƒÆ’Ã‚Â³n de Identidad, Paleta de Colores y Dependencias
- [x] Incorporar la dependencia `video_player` en `pubspec.yaml` y configurar la carpeta `assets/videos/` y `assets/images/`.
- [x] Actualizar `lib/core/constants/app_colors.dart` con la paleta oficial **BOSSUX** (Volt Lime `#D4FE11`, Dark Slate `#0D0F14`, Surface `#141822`, Glass Tint, Anillos de macros: Rojo ProteÃƒÆ’Ã‚Â­na `#FF5252`, Naranja Carbos `#FFA726`, Azul Grasa `#42A5F5`).
- [x] Actualizar `lib/core/constants/app_strings.dart` con los textos de **BOSSUX**.

#### Fase 2: Pantalla de Bienvenida con Video de Fondo (`WelcomeScreen`)
- [x] Crear `lib/features/auth/presentation/screens/welcome_screen.dart` inspirada en `img/loginIMG/WhatsApp Image 2026-11-04 at 4.53.png.jpeg`:
  - Capa de fondo con video en bucle y oscurecimiento degradado para mÃƒÆ’Ã‚Â¡xima legibilidad.
  - PÃƒÆ’Ã‚Â­ldora de idioma superior (`ÃƒÂ°Ã…Â¸Ã¢â‚¬Â¡Ã‚ÂªÃƒÂ°Ã…Â¸Ã¢â‚¬Â¡Ã‚Â¸ ES`).
  - Eslogan motivacional BOSSUX de gran tamaÃƒÆ’Ã‚Â±o.
  - BotÃƒÆ’Ã‚Â³n principal "Ãƒâ€šÃ‚Â¡Comenzar!" / "Ãƒâ€šÃ‚Â¡Perfecto!" en Volt Lime / Blanco.
  - Enlace inferior "Ãƒâ€šÃ‚Â¿Ya tienes una cuenta? Iniciar sesiÃƒÆ’Ã‚Â³n".
- [x] Configurar la ruta inicial `/welcome` en `app_routes.dart`.

#### Fase 3: RediseÃƒÆ’Ã‚Â±o de la Pantalla de Login BOSSUX (`LoginScreen`)
- [x] Adaptar `lib/features/auth/presentation/screens/login_screen.dart` segÃƒÆ’Ã‚Âºn `img/loginIMG/Screenshot 2026-11-04 111237.png`:
  - BotÃƒÆ’Ã‚Â³n superior de retroceso (`<-`) que regresa a la pantalla de bienvenida.
  - Isotipo / Logotipo exclusivo de **BOSSUX** (sin la manzana ni "Calz").
  - TÃƒÆ’Ã‚Â­tulo: "BOSSUX: contador de calorÃƒÆ’Ã‚Â­as y fitness".
  - SubtÃƒÆ’Ã‚Â­tulo: "Inicia sesiÃƒÆ’Ã‚Â³n con el mÃƒÆ’Ã‚Â©todo que usaste para crear tu cuenta".
  - Campo de entrada translÃƒÆ’Ã‚Âºcido para correo electrÃƒÆ’Ã‚Â³nico.
  - BotÃƒÆ’Ã‚Â³n "Continuar" reactivo.
  - Separador "o" y botÃƒÆ’Ã‚Â³n social "Continuar con Google".
  - Enlace a tÃƒÆ’Ã‚Â©rminos de uso y polÃƒÆ’Ã‚Â­ticas de privacidad en el pie de pÃƒÆ’Ã‚Â¡gina.

#### Fase 4: Pantalla Home Dashboard y Bento Grid (`HomeScreen`)
- [x] RediseÃƒÆ’Ã‚Â±ar `lib/features/home/presentation/screens/home_screen.dart` segÃƒÆ’Ã‚Âºn `img/homeIMG/Screenshot 2026-11-04 110639.png` y `110744.png`:
  - Barra superior con logo BOSSUX, medidor de racha (ÃƒÂ°Ã…Â¸Ã¢â‚¬ÂÃ‚Â¥ 1) y avatar.
  - Selector de dÃƒÆ’Ã‚Â­as de la semana horizontal (semana actual con selecciÃƒÆ’Ã‚Â³n activa).
  - Tarjeta principal de calorÃƒÆ’Ã‚Â­as (consumidas / restantes con anillo circular).
  - TrÃƒÆ’Ã‚Â­o de tarjetas Bento para macros: ProteÃƒÆ’Ã‚Â­na (g), Carbohidratos (g) y Grasas (g) con indicadores circulares de color.
  - SecciÃƒÆ’Ã‚Â³n "Recently logged" con tarjetas de alimentos registrados y estado vacÃƒÆ’Ã‚Â­o alternativo.

#### Fase 5: Barra de NavegaciÃƒÆ’Ã‚Â³n Flotante (`FloatingBottomNavBar`)
- [x] Crear `lib/features/home/presentation/widgets/floating_bottom_nav_bar.dart` segÃƒÆ’Ã‚Âºn `img/NAVBAR/Screenshot 2026-11-04 110744.png` y `img/gama_Colores`:
  - Contenedor flotante translÃƒÆ’Ã‚Âºcido con efecto glassmorphism.
  - Iconos de navegaciÃƒÆ’Ã‚Â³n: Inicio (`Home`), AnalÃƒÆ’Ã‚Â­ticas (`BarChart`), Ajustes (`Settings`).
  - BotÃƒÆ’Ã‚Â³n de acciÃƒÆ’Ã‚Â³n flotante circular central/lateral `+` en Volt Lime para registro rÃƒÆ’Ã‚Â¡pido.

#### Fase 6: Pruebas, AnÃƒÆ’Ã‚Â¡lisis EstÃƒÆ’Ã‚Â¡tico y CompilaciÃƒÆ’Ã‚Â³n del APK BOSSUX
- [x] Validar con `flutter analyze` asegurando 0 errores.
- [x] Actualizar y verificar pruebas de widget en `test/` (9/9 pasadas).
- [x] Generar nuevo ejecutable `.apk` listo para pruebas en Android.

---

## Registro de Progreso

| Fecha | Fase | DescripciÃƒÆ’Ã‚Â³n | Estado |
| :--- | :--- | :--- | :--- |
| 2026-11-03 | Fase 1 | Tokens de diseÃƒÆ’Ã‚Â±o, tipografÃƒÆ’Ã‚Â­a, espaciado y tema Cal AI | Completado |
| 2026-11-03 | Fase 2 | Modelos, Excepciones y Repositorio Mock | Completado |
| 2026-11-03 | Fase 3 | Controlador reactivo `AuthController` | Completado |
| 2026-11-03 | Fase 4 | Inputs oscuros, botÃƒÆ’Ã‚Â³n Volt Neon, botones sociales | Completado |
| 2026-11-03 | Fase 5 | Pantalla de Login Cal AI con autofill demo | Completado |
| 2026-11-03 | Fase 6 | Pantalla de Registro con validaciones completas | Completado |
| 2026-11-03 | Fase 7 | Pantalla Home con Bento Grid de mÃƒÆ’Ã‚Â©tricas deportivas | Completado |
| 2026-11-03 | Fase 8 | Ensamble, anÃƒÆ’Ã‚Â¡lisis estÃƒÆ’Ã‚Â¡tico (0 issues) y tests (9/9 passed) | Completado |
| 2026-11-03 | ÃƒÆ’Ã¢â‚¬Â°pica 2 | Animaciones fluidas, ambient glow, glassmorphism y micro-escalas Apple | Completado |
| 2026-11-03 | ÃƒÆ’Ã¢â‚¬Â°pica 3 | Layout "Libro Abierto" adaptativo y separaciÃƒÆ’Ã‚Â³n de contraste nÃƒÆ’Ã‚Â­tido | Completado |
| 2026-11-03 | ÃƒÆ’Ã¢â‚¬Â°pica 4 | Cristal translÃƒÆ’Ã‚Âºcido Apple, centrado total y fondo Space Gray | Completado |
| 2026-11-03 | ÃƒÆ’Ã¢â‚¬Â°pica 5 | Cristal ultra-translÃƒÆ’Ã‚Âºcido Apple y fondo Aurora cromÃƒÆ’Ã‚Â¡tico | Completado |
| 2026-11-03 | ÃƒÆ’Ã¢â‚¬Â°pica 6 | Entorno Android (JDK 17 + SDK) y compilaciÃƒÆ’Ã‚Â³n de `app-release.apk` | Completado |
| 2026-11-04 | Ãƒâ€°pica 7 | RediseÃƒÂ±o BOSSUX: Video Welcome, Login minimalista, Home Bento, Floating Navbar y nuevo APK | Completado |
| 2026-11-04 | Mejora Visual | TransiciÃ³n a Clean Light Style (Apple Health / Cal AI Light): fondos off-white, tarjetas blancas y APK | Completado |
| 2026-11-04 | Mejora Visual & Módulos | Cristal translúcido Apple Liquid Glass (Titanium mesh), vistas completas de Analytics y Settings, y APK | Completado |
