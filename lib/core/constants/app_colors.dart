import 'package:flutter/material.dart';

/// Paleta de colores oficial BOSSUX (Edición Apple Liquid Glass & Titanium):
/// Diseñada específicamente para lograr el efecto de cristal translúcido esmerilado
/// genuino de Apple (VisionOS / macOS), con refracción de luz ambiental sobre fondo titanio.
class AppColors {
  AppColors._();

  // Fondos y Atmósfera Titanio Espacial (Permite refracción de cristal)
  static const Color background = Color(0xFF0F1219);
  static const Color backgroundGradientStart = Color(0xFF151A24);
  static const Color backgroundGradientEnd = Color(0xFF0A0D14);

  // Cristal Translúcido Líquido (Pure Apple Liquid Glass)
  static const Color glassSurface = Color(0x18FFFFFF);       // Tinte blanco translúcido
  static const Color glassSurfaceElevated = Color(0x24FFFFFF);
  static const Color surface = Color(0xFF151A24);
  static const Color surfaceElevated = Color(0xFF1C2230);
  static const Color surfaceInput = Color(0x15FFFFFF);       // Input translúcido con desenfoque
  static const Color surfaceGlass = Color(0x1AFFFFFF);

  // Bordes Especulares Cenitales (Bisel de corte de cristal Apple)
  static const Color border = Color(0x26FFFFFF);             // 15% blanco translúcido
  static const Color borderGlass = Color(0x38FFFFFF);        // Reflejo de luz en el borde
  static const Color borderFocused = Color(0xFFD4FE11);      // Foco activo Volt Lime
  static const Color borderMuted = Color(0x14FFFFFF);

  // Acentos deportivos BOSSUX
  static const Color primary = Color(0xFFD4FE11);            // Volt Lime de alta visibilidad
  static const Color primaryAccent = Color(0xFFD4FE11);
  static const Color primaryDark = Color(0xFF99BF00);
  static const Color primaryGlow = Color(0x40D4FE11);

  // Acentos complementarios de luz ambiental
  static const Color cyanAccent = Color(0xFF00F0FF);
  static const Color cyanGlow = Color(0x3000F0FF);
  static const Color indigoAccent = Color(0xFF6366F1);

  // Anillos e indicadores de Nutrición / Macros
  static const Color macroProtein = Color(0xFFFF5252);       // Coral / Rojo Proteína
  static const Color macroCarbs = Color(0xFFFFA726);         // Ámbar / Naranja Carbohidratos
  static const Color macroFat = Color(0xFF42A5F5);           // Azul Grasas
  static const Color caloriesBurn = Color(0xFFFF6D00);       // Llama / Calorías

  // Tipografía y textos de alta legibilidad
  static const Color textPrimary = Color(0xFFFFFFFF);         // Blanco nítido
  static const Color textSecondary = Color(0xFFA5B0C2);       // Plateado suave legible
  static const Color textMuted = Color(0xFF6E788A);           // Gris para placeholders
  static const Color textOnPrimary = Color(0xFF0F1219);       // Oscuro sobre Volt Lime

  // Estados
  static const Color error = Color(0xFFFF453A);
  static const Color errorSurface = Color(0x25FF453A);
  static const Color success = Color(0xFF30D158);
  static const Color successSurface = Color(0x2530D158);

  // Botón Google y accesos sociales
  static const Color googleButtonBg = Color(0xFFFFFFFF);
  static const Color googleButtonText = Color(0xFF1F2937);
  static const Color socialButtonBg = Color(0x20FFFFFF);
  static const Color socialButtonBorder = Color(0x30FFFFFF);
}
