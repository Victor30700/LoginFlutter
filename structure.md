# Estructura del Proyecto: LoginFlutter (BOSSUX • Fitness Hub)

Este archivo documenta la organización y el propósito de cada directorio y archivo en la aplicación.
Las fases y progreso de implementación se encuentran en [`plan.md`](file:///D:/scripts-csharp/ProFlutters/LoginFlutter/plan.md), y los lineamientos de diseño en [`PRODUCT.md`](file:///D:/scripts-csharp/ProFlutters/LoginFlutter/PRODUCT.md) y [`context.md`](file:///D:/scripts-csharp/ProFlutters/LoginFlutter/context.md).

---

## Árbol de Directorios y Archivos

```text
LoginFlutter/
├── .gitignore                               # Configuración de exclusiones de Git (APKs, builds, caches)
├── analysis_options.yaml                    # Reglas de linter y calidad de código Dart
├── pubspec.yaml                             # Dependencias, SDK y declaración de assets/videos
├── pubspec.lock                             # Bloqueo determinista de versiones de dependencias
├── README.md                                # Documentación principal del repositorio y guía rápida
├── PRODUCT.md                               # Contexto del producto y especificaciones de diseño
├── plan.md                                  # Épicas, fases de trabajo y progreso
├── structure.md                             # Estructura técnica y catálogo de archivos del proyecto
├── context.md                               # Fuentes de diseño, iconos, paletas y tokens visuales
│
├── assets/                                  # Recursos estáticos de la aplicación
│   └── videos/
│       └── fitness_bg.mp4                   # Video de entrenamiento en bucle para pantalla de bienvenida
│
├── img/                                     # Capturas de pantalla y referencias visuales de diseño
│   ├── gama_Colores/                        # Paleta deportiva de referencia
│   ├── homeIMG/                             # Capturas de la pantalla Home y widgets
│   ├── loginIMG/                            # Capturas del flujo de acceso y bienvenida
│   └── NAVBAR/                              # Referencias del Dock de navegación flotante
│
├── lib/
│   ├── main.dart                            # Punto de entrada: inicializa dependencias y ejecuta BossuxApp
│   ├── app.dart                             # BossuxApp: configuración de MaterialApp, temas y rutas
│   │
│   ├── core/                                # Código transversal y compartido (Design System & Utils)
│   │   ├── constants/
│   │   │   ├── app_colors.dart              # Paleta deportiva (Volt Neon #CCFF00, Cyan, Slate, Onyx)
│   │   │   ├── app_spacing.dart             # Escala de espaciados y radios de curvatura
│   │   │   ├── app_strings.dart             # Textos centralizados en español (etiquetas, botones, errores)
│   │   │   └── app_text_styles.dart         # Jerarquía tipográfica geométrica (estilo Inter / SF Pro)
│   │   ├── routing/
│   │   │   └── app_routes.dart              # Rutas nombradas (/welcome, /login, /register, /home) y guards
│   │   ├── theme/
│   │   │   └── app_theme.dart               # ThemeData de Material 3 Dark personalizado con tokens
│   │   ├── utils/
│   │   │   └── validators.dart              # Validadores de formularios (email RFC 5322, password, nombres)
│   │   └── widgets/                         # Componentes visuales Apple Liquid Glass y micro-interacciones
│   │       ├── apple_ambient_background.dart# Fondo degradado con orbes difuminados de luz aurora
│   │       ├── glass_container.dart         # Contenedor esmerilado translúcido con bisel reflectivo
│   │       ├── pressable_scale.dart         # Micro-interacción de compresión elástica (resorte táctil)
│   │       └── staggered_entrance.dart      # Animación de entrada progresiva por fases (curva cúbica)
│   │
│   └── features/                            # Módulos organizados por funcionalidad (Feature-First)
│       ├── auth/                            # Módulo de Autenticación y Acceso
│       │   ├── data/
│       │   │   ├── exceptions/
│       │   │   │   └── auth_exception.dart      # Excepciones tipadas (credenciales inválidas, usuario existente)
│       │   │   ├── models/
│       │   │   │   └── user_model.dart          # Modelo inmutable de usuario (id, nombre, email, proveedor)
│       │   │   └── repositories/
│       │   │       ├── auth_repository.dart     # Contrato abstracto independiente de la implementación
│       │   │       └── mock_auth_repository.dart# Implementación en memoria con latencia y usuarios demo
│       │   └── presentation/
│       │       ├── controllers/
│       │       │   ├── auth_controller.dart     # ChangeNotifier: estado reactivo de sesión, carga y errores
│       │       │   └── auth_controller_scope.dart# InheritedWidget para inyección de dependencias en árbol
│       │       ├── screens/
│       │       │   ├── welcome_screen.dart      # Bienvenida con video en bucle y selector de idioma
│       │       │   ├── login_screen.dart        # Login Cal AI con campos reactivos y acceso Google/Apple
│       │       │   └── register_screen.dart     # Registro de nuevos atletas con validaciones estrictas
│       │       └── widgets/
│       │           ├── auth_error_banner.dart   # Banner animado de errores sobre el formulario
│       │           ├── book_spread_card.dart    # Contenedor adaptativo estilo "Libro Abierto" (Web/Móvil)
│       │           ├── custom_primary_button.dart# Botón Volt Neon con spinner de carga integrado
│       │           ├── custom_text_field.dart   # Input con alternador de visibilidad y validación en vivo
│       │           └── social_login_button.dart # Botones de autenticación social (Google y Apple)
│       │
│       └── home/                            # Módulo Dashboard del Atleta (Post-login)
│           └── presentation/
│               ├── screens/
│               │   └── home_screen.dart         # Dashboard Bento Grid: selector de fecha, calorías y macros
│               └── widgets/
│                   ├── analytics_view.dart      # Gráficos semanales de rendimiento, macros y agua
│                   ├── floating_bottom_nav_bar.dart# Dock flotante visionOS con selector de tab y botón (+)
│                   └── settings_view.dart       # Vista de perfil Pro, objetivos nutricionales y ajustes
│
└── test/
    ├── widget_test.dart                     # Smoke test: renderizado de Welcome y transición a Login
    ├── core/
    │   └── utils/
    │       └── validators_test.dart         # Pruebas unitarias de validadores de email y password
    └── features/
        └── auth/
            └── data/
                └── mock_auth_repository_test.dart# Pruebas unitarias completas de autenticación y registro
```

---

## Descripción Detallada por Capas

### 1. `lib/core/` (Capa Transversal)
* **`constants/`**: Contiene la única fuente de verdad para valores inmutables en la app:
  * `AppColors`: Paleta de alto contraste inspirada en Cal AI (Volt Neon `#CCFF00`, Cian Eléctrico `#00F0FF`, Índigo Aurora `#6366F1`, Canvas Ónix `#070A12`).
  * `AppSpacing`: Escala uniforme de espaciados (4px a 48px) y radios de borde (`radiusMd: 16`, `radiusLg: 24`, `radiusPill: 999`).
  * `AppStrings`: Textos internacionalizables en español para evitar cadenas sueltas en widgets.
  * `AppTextStyles`: Jerarquía tipográfica con pesos semibold y bold para estética deportiva.
* **`routing/`**: Centraliza nombres de rutas (`/welcome`, `/login`, `/register`, `/home`) y gestiona transiciones adaptativas.
* **`theme/`**: Configura `ThemeData` en modo oscuro Material 3 con estilos personalizados para inputs, botones y efectos de foco.
* **`utils/`**: Utilidades puras reutilizables como validaciones de correo electrónico, longitud de clave y coincidencia de confirmación.
* **`widgets/`**: Biblioteca de micro-componentes de interfaz:
  * `AppleAmbientBackground`: Genera una atmósfera reactiva con orbes de color difuminados.
  * `GlassContainer`: Implementa cristal líquido mediante `BackdropFilter` con desenfoque gaussiano de 32px y bisel especular.
  * `PressableScale`: Añade micro-interacciones táctiles de compresión física (`0.965`) en clics/taps.
  * `StaggeredEntrance`: Orquesta la entrada suave en cascada de los elementos en pantalla.

### 2. `lib/features/auth/` (Módulo de Acceso)
Sigue principios de **Clean Architecture** y **Separación de Responsabilidades**:
* **`data/`**:
  * **Contrato (`auth_repository.dart`)**: Define la interfaz abstracta (`signIn`, `signUp`, `signInWithGoogle`, `signOut`, `currentUser`). Permite migrar en el futuro a Firebase Auth, Supabase o una API REST sin alterar la capa de presentación.
  * **Implementación (`mock_auth_repository.dart`)**: Emula comportamiento de red real con latencia de 1.2 segundos, almacenamiento en memoria y usuarios predefinidos (`athlete@calai.fit`).
  * **Excepciones (`auth_exception.dart`)**: Tipificación de errores (`InvalidCredentialsException`, `EmailAlreadyInUseException`, `NetworkException`).
* **`presentation/`**:
  * **Controlador (`auth_controller.dart`)**: Extiende `ChangeNotifier` para gestionar estados inmutables (`idle`, `loading`, `authenticated`, `error`).
  * **Inyección (`auth_controller_scope.dart`)**: Utiliza `InheritedWidget` para entregar el controlador de forma limpia en el árbol de widgets.
  * **Pantallas**:
    * `WelcomeScreen`: Introducción con video deportivo en segundo plano (`fitness_bg.mp4`), badge de idioma y botón CTA de entrada.
    * `LoginScreen`: Formulario responsivo con layout estilo libro abierto en escritorio y modal en dispositivos móviles.
    * `RegisterScreen`: Flujo de creación de cuenta de atleta con confirmación de clave y validación en vivo.

### 3. `lib/features/home/` (Dashboard del Atleta)
* **`HomeScreen`**: Hub principal para atletas autenticados:
  * Selector de días de la semana interactivo.
  * Anillo de progreso calórico con desglose de macronutrientes (Proteínas, Carbohidratos, Grasas).
  * Registro de comidas recientes con sellos de tiempo y valores energéticos.
* **`widgets/`**:
  * `FloatingBottomNavBar`: Dock flotante con efecto de vidrio, navegación entre secciones y botón rápido de registro (+).
  * `AnalyticsView`: Gráfico de barras semanal interactivo con métricas de salud (calorías quemadas, agua, pasos).
  * `SettingsView`: Configuración de metas nutricionales, perfil del atleta, interruptores de sincronización y botón de cierre de sesión.

---

## Flujo de Datos y Dependencias

```mermaid
flowchart TD
    subgraph UI ["Capa de Presentación"]
        W["WelcomeScreen"] --> L["LoginScreen"]
        L <--> R["RegisterScreen"]
        L --> H["HomeScreen"]
        Screens["Screens & Widgets"]
    end

    subgraph State ["Capa de Estado"]
        Scope["AuthControllerScope (InheritedWidget)"]
        Controller["AuthController (ChangeNotifier)"]
    end

    subgraph DomainData ["Capa de Dominio y Datos"]
        Contract["AuthRepository (Interfaz Abstracta)"]
        Mock["MockAuthRepository (Memoria & 1.2s delay)"]
        FutureBackend["Firebase / REST API (Futuro)"]
        Models["UserModel & AuthException"]
    end

    Screens --> Scope
    Scope --> Controller
    Controller --> Contract
    Mock -. implementa .-> Contract
    FutureBackend -. implementa .-> Contract
    Contract --> Models
```
