/// Cadenas de texto del sistema BOSSUX (Nutrición y Fitness con IA).
class AppStrings {
  AppStrings._();

  // Branding
  static const String appName = 'BOSSUX';
  static const String appTagline = 'FITNESS & NUTRITION AI';
  static const String demoBadge = 'BOSSUX PRO';

  // Pantalla de Bienvenida (Welcome Screen - FitPulse / BOSSUX Style)
  static const String welcomeHeroTitle = 'Inicia sesión para\ntu éxito fitness';
  static const String welcomeHeroSubtitle = 'Impulsa tu entrenamiento con una experiencia dinámica diseñada para un estilo de vida saludable.';
  static const String welcomeSignUpAction = 'REGISTRARSE';
  static const String welcomeOrLogInAction = 'o Iniciar sesión';
  static const String welcomeHeadline = 'Tu cámara ahora es un contador de calorías';
  static const String welcomeButton = '¡Perfecto!';
  static const String welcomeAlreadyAccount = '¿Ya tienes una cuenta? ';
  static const String welcomeSignIn = 'Iniciar sesión';
  static const String languageEs = '🇪🇸 ES';

  // Pantalla de Login BOSSUX
  static const String loginTitle = 'BOSSUX: contador de calorías';
  static const String loginSubtitle = 'Inicia sesión con el método que usaste para crear tu cuenta';
  static const String emailHint = 'Introduce tu correo electrónico';
  static const String continueButton = 'Continuar';
  static const String orDivider = 'o';
  static const String continueWithGoogle = 'Continuar con Google';
  static const String continueWithApple = 'Continuar con Apple';
  static const String legalTermsDisclaimer = 'Al continuar, aceptas los Términos de uso y Política de privacidad';
  
  // Enlaces de autenticación secundaria
  static const String emailLabel = 'Correo electrónico';
  static const String passwordLabel = 'Contraseña';
  static const String passwordHint = 'Mínimo 8 caracteres';
  static const String forgotPassword = '¿Olvidaste tu contraseña?';
  static const String signInButton = 'Iniciar sesión';
  static const String noAccountPrompt = '¿Aún no tienes cuenta? ';
  static const String registerLink = 'Regístrate aquí';

  // Registro
  static const String registerTitle = 'Crea tu perfil BOSSUX.';
  static const String registerSubtitle = 'Empieza hoy a transformar tus hábitos con nutrición inteligente.';
  static const String nameLabel = 'Nombre completo';
  static const String nameHint = 'Ej. Alex Hunter';
  static const String confirmPasswordLabel = 'Confirmar contraseña';
  static const String confirmPasswordHint = 'Repite tu contraseña';
  static const String signUpButton = 'Crear cuenta';
  static const String hasAccountPrompt = '¿Ya tienes una cuenta? ';
  static const String loginLink = 'Inicia sesión';

  // Validaciones
  static const String emailRequired = 'Por favor ingresa tu correo electrónico';
  static const String emailInvalid = 'Ingresa un correo electrónico válido (ej. atleta@bossux.app)';
  static const String passwordRequired = 'Por favor ingresa tu contraseña';
  static const String passwordTooShort = 'La contraseña debe tener al menos 8 caracteres';
  static const String passwordRequirements = 'Debe incluir al menos una letra y un número';
  static const String nameRequired = 'Por favor ingresa tu nombre';
  static const String nameTooShort = 'El nombre debe tener al menos 2 caracteres';
  static const String passwordsDoNotMatch = 'Las contraseñas no coinciden';

  // Errores
  static const String invalidCredentials = 'El correo o la contraseña son incorrectos.';
  static const String userAlreadyExists = 'Ya existe una cuenta registrada con este correo.';
  static const String networkError = 'Error de conexión. Inténtalo nuevamente.';
  static const String genericError = 'Ocurrió un error inesperado al procesar la solicitud.';

  // Dashboard / Home BOSSUX
  static const String welcomeBack = '¡Bienvenido a BOSSUX!';
  static const String athleteRole = 'PRO MEMBER';
  static const String logoutButton = 'Cerrar sesión';
  static const String caloriesBurned = 'Calorías totales';
  static const String proteinTarget = 'Proteína diaria';
  static const String workoutsCompleted = 'Entrenamientos';
  static const String recentlyLogged = 'Recently logged';
  static const String emptyLoggedTitle = 'No has registrado alimentos hoy';
  static const String emptyLoggedSubtitle = 'Comienza a monitorear tus comidas tomando una foto rápida.';
}
