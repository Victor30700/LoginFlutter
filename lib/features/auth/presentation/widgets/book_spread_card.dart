import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Contenedor adaptativo estilo "Libro Abierto" con auténtico cristal translúcido esmerilado Apple
/// (Liquid Glass) donde los orbes de luz cromáticos del fondo se aprecian con total claridad.
class BookSpreadCard extends StatelessWidget {
  final Widget formContent;
  final Widget? customCover;

  const BookSpreadCard({
    super.key,
    required this.formContent,
    this.customCover,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        final isDesktop = viewportConstraints.maxWidth >= AppSpacing.breakpointDesktop;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
              minWidth: viewportConstraints.maxWidth,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.lg,
                ),
                child: isDesktop
                    ? _buildOpenBookDesktop(context)
                    : _buildMobileModal(context),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Formato Libro Abierto de 2 páginas en cristal líquido translúcido (Desktop/Web)
  Widget _buildOpenBookDesktop(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: AppSpacing.maxBookWidth,
        minHeight: AppSpacing.minBookHeight,
      ),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.roundedBook,
        boxShadow: [
          // Sombra de profundidad difusa Apple
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 50.0,
            spreadRadius: 4.0,
            offset: const Offset(0, 20),
          ),
          // Resplandor cian perimetral tenue
          BoxShadow(
            color: AppColors.cyanAccent.withValues(alpha: 0.16),
            blurRadius: 36.0,
            spreadRadius: -4.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppSpacing.roundedBook,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 32.0, sigmaY: 32.0),
          child: Container(
            decoration: BoxDecoration(
              // Tinte translúcido vítreo: deja ver el fondo cromático por detrás
              color: const Color(0x30111726),
              borderRadius: AppSpacing.roundedBook,
              // Bisel especular de cristal cortado al estilo Apple
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.28),
                width: 1.5,
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // PÁGINA IZQUIERDA: Portada / Showcase Visual Deportivo (Translúcida)
                  Expanded(
                    flex: 5,
                    child: customCover ?? _buildDefaultVisualCover(),
                  ),

                  // LOMO CENTRAL TRANSLÚCIDO DEL LIBRO
                  _buildBookSpine(),

                  // PÁGINA DERECHA: Formulario de Autenticación (Translúcido)
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.03),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.xl,
                      ),
                      child: Center(
                        child: formContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Formato Modal Translúcido para pantallas móviles (< 860px)
  Widget _buildMobileModal(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: AppSpacing.maxFormWidth,
      ),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.roundedLg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.50),
            blurRadius: 40.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppSpacing.roundedLg,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28.0, sigmaY: 28.0),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: const Color(0x35141B2D),
              borderRadius: AppSpacing.roundedLg,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 1.4,
              ),
            ),
            child: formContent,
          ),
        ),
      ),
    );
  }

  /// Lomo central translúcido con hendidura y sombras ópticas de libro
  Widget _buildBookSpine() {
    return Container(
      width: 18.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.black.withValues(alpha: 0.2),
            Colors.black.withValues(alpha: 0.55),
            Colors.white.withValues(alpha: 0.22), // Línea de brillo central del lomo
            Colors.black.withValues(alpha: 0.4),
            Colors.black.withValues(alpha: 0.1),
          ],
          stops: const [0.0, 0.45, 0.5, 0.55, 1.0],
        ),
      ),
    );
  }

  /// Portada visual para la página izquierda del libro en cristal translúcido
  Widget _buildDefaultVisualCover() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.indigoAccent.withValues(alpha: 0.06),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header de la página izquierda
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryGlow.withValues(alpha: 0.25),
                  borderRadius: AppSpacing.roundedPill,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.65),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.8),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Text(
                      'CAL AI • ATLETA EDICIÓN',
                      style: AppTextStyles.badge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Tu nutrición y fuerza,\ncalculadas al milímetro.',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                  color: Colors.white,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'La tecnología de seguimiento de macros que usan atletas de élite para optimizar su rendimiento diario.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ],
          ),

          // Tarjeta interactiva de métricas demo estilo Bento Glass ultra-translúcida
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: AppSpacing.roundedMd,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.20),
                width: 1.2,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bolt_rounded,
                            size: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const Text(
                          'Métricas en vivo',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '98% Precisión IA',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricTile('Calorías', '2,450 kcal', AppColors.primary),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: _buildMetricTile('Proteína', '185 g', AppColors.cyanAccent),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Footer de la página izquierda: Testimonio de Atleta
          Row(
            children: [
              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                  border: Border.all(color: AppColors.primary, width: 1.8),
                ),
                child: const Icon(Icons.fitness_center_rounded, size: 18.0, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"La mejor herramienta que he usado para mi corte."',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      'Carlos M. — Levantador de Potencia',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile(String label, String value, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: AppSpacing.roundedSm,
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.0)),
          const SizedBox(height: 2.0),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
