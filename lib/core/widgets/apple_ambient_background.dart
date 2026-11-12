import 'dart:ui';
import 'package:flutter/material.dart';

/// Fondo dinámico con atmósfera cromática estilo Apple (Liquid Titanium & Ambient Aurora).
/// Los orbes de luz en segundo plano se refractan a través de los contenedores de cristal,
/// creando un auténtico efecto de cristal esmerilado translúcido (VisionOS / macOS).
class AppleAmbientBackground extends StatelessWidget {
  final Widget child;

  const AppleAmbientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFF07090E),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Lienzo Base: Obsidian / Space Black limpio (estilo Apple Dark Mode)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F1219),
                  Color(0xFF090B10),
                  Color(0xFF050609),
                ],
              ),
            ),
          ),

          // 2. Atmósfera Zafiro muy tenue (Superior derecha, sin resplandor neón)
          Positioned(
            top: -size.height * 0.08,
            right: -size.width * 0.18,
            width: size.width * 0.78,
            height: size.height * 0.42,
            child: IgnorePointer(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 115.0, sigmaY: 115.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF0A84FF).withValues(alpha: 0.10),
                        const Color(0xFF004099).withValues(alpha: 0.03),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 3. Profundidad Azul Real muy sutil (Centro izquierda)
          Positioned(
            top: size.height * 0.34,
            left: -size.width * 0.22,
            width: size.width * 0.72,
            height: size.height * 0.40,
            child: IgnorePointer(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 120.0, sigmaY: 120.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF1D4ED8).withValues(alpha: 0.07),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 4. Profundidad Índigo Apple discreta (Inferior)
          Positioned(
            bottom: -size.height * 0.12,
            right: size.width * 0.08,
            width: size.width * 0.80,
            height: size.height * 0.44,
            child: IgnorePointer(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 120.0, sigmaY: 120.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF5E5CE6).withValues(alpha: 0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 5. Contenido interactivo
          child,
        ],
      ),
    );
  }
}
