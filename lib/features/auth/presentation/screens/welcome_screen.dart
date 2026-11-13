import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/pressable_scale.dart';

/// Pantalla de Bienvenida y Onboarding de BOSSUX.
/// Inspirada en la estética FitPulse: Atleta con aura eléctrica sobre lienzo oscuro,
/// logo oficial BOSSUX y tarjeta inferior translúcida con botones de Registro y Login.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _navigateToRegister() {
    Navigator.of(context).pushNamed(AppRoutes.register);
  }

  void _navigateToLogin() {
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: AppColors.bossuxDarkCanvas,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Lienzo de Fondo con Gradiente Radial y Atmósfera Eléctrica
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.bossuxDarkCanvas,
                  Color(0xFF0C1322),
                  AppColors.bossuxDarkCanvasEnd,
                ],
              ),
            ),
          ),

          // 2. Halo Radial de Luz Eléctrica (Detrás de la Atleta)
          Positioned(
            top: screenHeight * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: screenWidth * 0.9,
                height: screenWidth * 0.9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.bossuxAuraCyan.withValues(alpha: 0.35),
                      AppColors.bossuxAuraBlue.withValues(alpha: 0.25),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // 3. Modelo Atleta Recortada (PNG transparente de alta definición)
          Positioned(
            top: screenHeight * 0.06,
            bottom: screenHeight * 0.26,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/model_nobg.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox();
              },
            ),
          ),

          // 4. Barra Superior (SafeArea + Logo Oficial BOSSUX)
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logotipo Oficial BOSSUX
                    Image.asset(
                      'assets/logo/logo_bossux.png',
                      height: 32,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                          'BOSSUX',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        );
                      },
                    ),

                    // Badge de Idioma discreto
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.16),
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🇪🇸', style: TextStyle(fontSize: 12)),
                          SizedBox(width: 4),
                          Text(
                            'ES',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 5. Tarjeta Flotante Inferior de Cristal (Glassmorphic Bottom Sheet)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16.0,
                0,
                16.0,
                mediaQuery.padding.bottom > 0 ? mediaQuery.padding.bottom + 8 : 16.0,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(24.0, 14.0, 24.0, 22.0),
                      decoration: BoxDecoration(
                        color: AppColors.bossuxSheetGlass,
                        borderRadius: BorderRadius.circular(36.0),
                        border: Border.all(
                          color: AppColors.bossuxSheetBorder,
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.40),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Indicador de arrastre superior (Pill handle)
                          Center(
                            child: Container(
                              width: 44,
                              height: 4.5,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.35),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Título de Impacto en Español
                          const Text(
                            AppStrings.welcomeHeroTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                              letterSpacing: -0.6,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Subtítulo Motivacional en Español
                          Text(
                            AppStrings.welcomeHeroSubtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.72),
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400,
                              height: 1.35,
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Fila de Acciones: Botón Píldora "REGISTRARSE" con Flecha + "o Iniciar sesión"
                          Row(
                            children: [
                              // Botón "REGISTRARSE" tipo píldora con flecha circular
                              Expanded(
                                flex: 6,
                                child: PressableScale(
                                  onTap: _navigateToRegister,
                                  child: Container(
                                    height: 52,
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(26),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withValues(alpha: 0.15),
                                          blurRadius: 16,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 14.0),
                                          child: Text(
                                            AppStrings.welcomeSignUpAction,
                                            style: TextStyle(
                                              color: Color(0xFF090D16),
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF090D16),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 14),

                              // Acción secundaria "o Iniciar sesión"
                              Expanded(
                                flex: 5,
                                child: PressableScale(
                                  onTap: _navigateToLogin,
                                  child: Container(
                                    height: 52,
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppStrings.welcomeOrLogInAction,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.90),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
