import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../data/models/plan_model.dart';

/// Tarjeta visual de un Plan BOSSUX con estética Apple Liquid Glass.
/// Muestra destacadamente:
/// 1. Fotografía real del servidor con fallback deportivo.
/// 2. Nombre del plan (`plan`).
/// 3. Precio de venta (`precio` en Volt Lime).
/// 4. Cantidad / Duración (`tiempo`).
class PlanCard extends StatelessWidget {
  final PlanModel plan;
  final VoidCallback? onSelect;

  const PlanCard({
    super.key,
    required this.plan,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onSelect,
      child: GlassContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        borderRadius: BorderRadius.circular(24.0),
        backgroundColor: AppColors.glassSurface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera: Imagen del plan con overlay de badges
            _buildImageHeader(),

            const SizedBox(height: 14.0),

            // Fila de metadatos: Duración / Cantidad y Estado
            Row(
              children: [
                // Badge de Duración / Cantidad
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: AppColors.cyanAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: AppColors.cyanAccent.withValues(alpha: 0.35),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 13.0,
                        color: AppColors.cyanAccent,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        plan.tiempoFormateado,
                        style: const TextStyle(
                          color: AppColors.cyanAccent,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8.0),

                // Badge de estado si no está activo
                if (!plan.esActivo)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'PROMO TEMPORAL',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                const Spacer(),

                // ID del plan como referencia sutil
                Text(
                  '#${plan.id}',
                  style: TextStyle(
                    color: AppColors.textMuted.withValues(alpha: 0.6),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10.0),

            // Nombre del Plan
            Text(
              plan.nombre,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                height: 1.25,
              ),
            ),

            const SizedBox(height: 14.0),

            // Barra divisoria sutil
            Container(
              height: 1.0,
              color: AppColors.border,
            ),

            const SizedBox(height: 14.0),

            // Pie: Precio de venta y botón de selección
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Columna de Precio
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRECIO VENTA',
                      style: TextStyle(
                        color: AppColors.textMuted.withValues(alpha: 0.8),
                        fontSize: 10.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: plan.esGratis
                            ? AppColors.cyanAccent.withValues(alpha: 0.2)
                            : AppColors.primary.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: plan.esGratis
                              ? AppColors.cyanAccent
                              : AppColors.primary,
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        plan.precioFormateado,
                        style: TextStyle(
                          color: plan.esGratis ? AppColors.cyanAccent : AppColors.primary,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ],
                ),

                // Botón CTA "Elegir Plan"
                PressableScale(
                  onTap: onSelect,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 11.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 16.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Elegir Plan',
                          style: TextStyle(
                            color: AppColors.textOnPrimary,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 15.0,
                          color: AppColors.textOnPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Construye la cabecera con la imagen real de `https://vous.bossux.com/`
  Widget _buildImageHeader() {
    final hasValidUrl = plan.fullImageUrl.isNotEmpty;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Container(
        height: 160.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surfaceElevated,
              AppColors.backgroundGradientStart,
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasValidUrl)
              Image.network(
                plan.fullImageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildImagePlaceholder(isLoading: true);
                },
                errorBuilder: (context, error, stackTrace) {
                  return _buildImagePlaceholder(isLoading: false);
                },
              )
            else
              _buildImagePlaceholder(isLoading: false),

            // Sutil viñeta degradada inferior para dar profundidad
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 60.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.65),
                    ],
                  ),
                ),
              ),
            ),

            // Badge de marca BOSSUX en la esquina superior izquierda
            Positioned(
              top: 10.0,
              left: 10.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.bolt_rounded,
                      size: 13.0,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'BOSSUX FIT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Placeholder con estética deportiva y orbes de gradiente
  Widget _buildImagePlaceholder({required bool isLoading}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceElevated,
            AppColors.indigoAccent.withValues(alpha: 0.15),
            AppColors.primary.withValues(alpha: 0.08),
          ],
        ),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 28.0,
                height: 28.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.fitness_center_rounded,
                      size: 32.0,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'BOSSUX ATHLETE',
                    style: TextStyle(
                      color: AppColors.textMuted.withValues(alpha: 0.7),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
