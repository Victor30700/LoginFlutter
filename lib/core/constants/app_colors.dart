import 'package:flutter/material.dart';

/// Paleta de colores oficial BOSSUX (Edición Apple Liquid Glass & Titanium):
/// Diseñada específicamente para lograr el efecto de cristal translúcido esmerilado
/// genuino de Apple (VisionOS / macOS), con refracción de luz ambiental sobre fondo titanio.
class AppColors {
  AppColors._();

  // Fondos y Atmósfera Titanio Espacial (Space Black / Obsidian Apple)
  static const Color background = Color(0xFF0B0D13);
  static const Color backgroundGradientStart = Color(0xFF10131B);
  static const Color backgroundGradientEnd = Color(0xFF050609);

  // Cristal Translúcido Líquido (Apple Liquid Glass)
  static const Color glassSurface = Color(0x0EFFFFFF);       // Tinte sutil 5.5%
  static const Color glassSurfaceElevated = Color(0x17FFFFFF);
  static const Color surface = Color(0xFF141720);
  static const Color surfaceElevated = Color(0xFF1C202B);
  static const Color surfaceInput = Color(0x0FFFFFFF);       // Input translúcido
  static const Color surfaceGlass = Color(0x12FFFFFF);

  // Bordes Especulares Cenitales (Bisel fino estilo iOS / macOS)
  static const Color border = Color(0x1AFFFFFF);             // 10% blanco translúcido
  static const Color borderGlass = Color(0x28FFFFFF);        // Reflejo sutil en el borde
  static const Color borderFocused = Color(0xFF0A84FF);      // Foco Apple System Blue
  static const Color borderMuted = Color(0x12FFFFFF);

  // Acentos Apple System Blue (Dark Mode calibrado, sin neón)
  static const Color primary = Color(0xFF0A84FF);            // Apple Dark Mode Blue
  static const Color primaryAccent = Color(0xFF409CFF);      // Azul legible sobre oscuro
  static const Color primaryDark = Color(0xFF0066CC);        // Profundidad sutil
  static const Color primaryGlow = Color(0x1C0A84FF);        // Tinte ambiental suave

  // Acentos complementarios calibrados iOS
  static const Color cyanAccent = Color(0xFF5AC8FA);         // Apple System Teal/Sky
  static const Color cyanGlow = Color(0x185AC8FA);
  static const Color indigoAccent = Color(0xFF5E5CE6);       // Apple System Indigo

  // Atmósfera y Lienzo BOSSUX / FitPulse (Fondo para modelo sin fondo)
  static const Color bossuxDarkCanvas = Color(0xFF090D16);
  static const Color bossuxDarkCanvasEnd = Color(0xFF04060A);
  static const Color bossuxAuraCyan = Color(0xFF00E5FF);
  static const Color bossuxAuraBlue = Color(0xFF142B4E);
  static const Color bossuxSheetGlass = Color(0xE01A2234);
  static const Color bossuxSheetBorder = Color(0x38FFFFFF);
  static const Color bossuxPillButton = Color(0xFFFFFFFF);
  static const Color bossuxPillText = Color(0xFF090D16);

  // Anillos e indicadores de Nutrición / Macros
  static const Color macroProtein = Color(0xFFFF5252);       // Coral / Rojo Proteína
  static const Color macroCarbs = Color(0xFFFFA726);         // Ámbar / Naranja Carbohidratos
  static const Color macroFat = Color(0xFF42A5F5);           // Azul Grasas
  static const Color caloriesBurn = Color(0xFFFF6D00);       // Llama / Calorías

  // Tipografía y textos de alta legibilidad
  static const Color textPrimary = Color(0xFFFFFFFF);         // Blanco nítido
  static const Color textSecondary = Color(0xFFA1AAB8);       // Gris plata iOS legible
  static const Color textMuted = Color(0xFF6E7685);           // Gris para placeholders
  static const Color textOnPrimary = Color(0xFFFFFFFF);       // Blanco sobre Apple Blue #0A84FF

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
