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
      backgroundColor: const Color(0xFF0C0F16),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Lienzo Base: Titanio carbón profundo
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF141923),
                  Color(0xFF0F131C),
                  Color(0xFF0A0D13),
                ],
              ),
            ),
          ),

          // 2. Orbe de Luz 1: Volt Lime Deportivo (Superior derecho)
          Positioned(
            top: -size.height * 0.05,
            right: -size.width * 0.15,
            width: size.width * 0.75,
            height: size.height * 0.45,
            child: IgnorePointer(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 95.0, sigmaY: 95.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFD4FE11).withValues(alpha: 0.18),
                        const Color(0xFFD4FE11).withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 3. Orbe de Luz 2: Cian Tech (Centro izquierda)
          Positioned(
            top: size.height * 0.35,
            left: -size.width * 0.20,
            width: size.width * 0.70,
            height: size.height * 0.40,
            child: IgnorePointer(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF00F0FF).withValues(alpha: 0.14),
                        const Color(0xFF0077FF).withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 4. Orbe de Luz 3: Índigo / Púrpura suave (Inferior)
          Positioned(
            bottom: -size.height * 0.1,
            right: size.width * 0.1,
            width: size.width * 0.8,
            height: size.height * 0.45,
            child: IgnorePointer(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 110.0, sigmaY: 110.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF6366F1).withValues(alpha: 0.15),
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
