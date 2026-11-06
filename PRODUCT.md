# Product

<!-- impeccable:product-schema 1 -->

## Platform

adaptive (Mobile & Web)

## Users

Atletas, miembros de gimnasio y entusiastas del fitness y la vida saludable que buscan registrar sus entrenamientos, nutrición y progreso con una experiencia visual de alto nivel, moderna y sin fricción.

## Product Purpose

**AuraFit / CalAI Style (Fitness & Sport Hub)**: Aplicación móvil y web de alto rendimiento para el seguimiento de entrenamiento, conteo de macros y hábitos fitness con estética premium.
Esta primera épica entrega el sistema integral de acceso (Login, Registro, Recuperación/Social Mock y Home dashboard de bienvenida con métricas rápidas).

## Positioning

Estética visual inspirada en **Cal AI** (`https://www.calai.app/`):
- Modo oscuro dominante (Deep Onyx / Jet Black / Charcoal).
- Acentos vibrantes de alto contraste (Volt Neon / Lime Gym `#CCFF00` / `#D4FF00` y Cyan tech `#00F0FF`).
- Jerarquía tipográfica contundente, moderna (sans-serif geométrica tipo Grotesque / Inter / SF Pro).
- Tarjetas con bordes sutiles y micro-gradientes (bento cards).
- Componentes táctiles definidos, botones tipo píldora de alto impacto y feedback interactivo.

## Operating Context

- Se ejecuta en **Móvil (Android/iOS)** y **Web/Desktop (Chrome/Windows)** con diseño adaptativo y centrado con ancho óptimo para formularios en pantallas grandes.
- Autenticación modular (`AuthRepository`) con implementación Mock en memoria (retrasos de red reales de 1.2s, validaciones estrictas y credenciales predeterminadas).

## Capabilities and Constraints

- Stack: Flutter 3.47 / Dart 3.13, Material 3 Dark.
- Componentes clave:
  - Header con isotipo fitness de vanguardia y badge de estatus.
  - Formulario reactivo de Login con `GlobalKey<FormState>` y validaciones en tiempo real.
  - Alternancia de visibilidad de contraseña con animación de icono.
  - Botón de acción principal con loader integrado (sin alterar dimensiones).
  - Acciones sociales estilizadas (Continuar con Google y Apple).
  - Pantalla de Registro conectada al mismo repositorio de autenticación.
  - Pantalla Home con dashboard fitness inicial (calorías/macros demo, saludo y botón de Logout).

## Evidence on Hand

- Referencia visual directa: `https://www.calai.app/`.
- Credenciales Mock:
  - Email: `athlete@calai.fit` (o `demo@calai.app`)
  - Password: `Password123!`

## Product Principles

1. **High-Performance Aesthetic**: Cero apariencia de plantilla corporativa aburrida o gris estándar. La interfaz debe transmitir energía, disciplina y precisión tecnológica (vibe Cal AI).
2. **Instant Feedback**: Cada interacción (foco, validación, botón presionado) entrega retroalimentación clara e inmediata.
3. **Rock-solid Validation**: Validación estricta sin ser agresiva antes del primer toque.
4. **Clean Architecture**: Separación estricta entre presentación, controladores de estado (`ChangeNotifier`), repositorio (`AuthRepository`) y modelos.
