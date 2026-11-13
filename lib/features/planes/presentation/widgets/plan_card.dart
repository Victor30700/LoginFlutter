import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../data/models/plan_model.dart';

/// Tarjeta horizontal compacta estilo VOUS / BOSSUX (Apple Liquid Glass + Azul Eléctrico).
/// Muestra a la izquierda el recuadro oscuro con la imagen oficial del plan y a la derecha
/// el nombre, badge de tipo (`Normal`/`Convenio`), precio destacado y duración/horario.
class PlanCard extends StatelessWidget {
  final PlanModel plan;
  final VoidCallback? onSelect;
  final bool isSelected;

  const PlanCard({
    super.key,
    required this.plan,
    this.onSelect,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.primary.withValues(alpha: 0.85)
        : Colors.white.withValues(alpha: 0.09);

    return PressableScale(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isSelected
                ? const [
                    Color(0xFF162235),
                    Color(0xFF111927),
                  ]
                : const [
                    Color(0xFF171A23),
                    Color(0xFF11131A),
                  ],
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 1.4 : 0.9,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isSelected ? 0.45 : 0.34),
              blurRadius: isSelected ? 20.0 : 14.0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Panel izquierdo: Recuadro negro obsidiana con la imagen del plan
                _buildLeftImagePanel(),

                // Divisor vertical sutil
                Container(
                  width: 0.8,
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.25)
                      : Colors.white.withValues(alpha: 0.07),
                ),

                // Panel derecho: Información principal del plan
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 14.0, 14.0, 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1. Título del plan + Badge de tipo
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                plan.nombre,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            _buildTypeBadge(),
                          ],
                        ),

                        const SizedBox(height: 6.0),

                        // 2. Precio protagonista estilo Apple (blanco nítido, tabular)
                        Text(
                          plan.precioCompacto,
                          style: TextStyle(
                            color: plan.esGratis
                                ? AppColors.cyanAccent
                                : AppColors.textPrimary,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.6,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),

                        const SizedBox(height: 10.0),

                        // 3. Metadatos compactos: Tiempo y Horario + indicador
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildMetaRow(
                                    icon: Icons.calendar_today_rounded,
                                    text: 'Tiempo: ${plan.tiempoFormateado}',
                                  ),
                                  const SizedBox(height: 4.0),
                                  _buildMetaRow(
                                    icon: Icons.access_time_rounded,
                                    text: 'Horario: ${plan.horarioEtiqueta}',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check_circle_rounded,
                                      key: ValueKey('selected'),
                                      color: AppColors.primary,
                                      size: 22.0,
                                    )
                                  : Icon(
                                      Icons.chevron_right_rounded,
                                      key: const ValueKey('unselected'),
                                      color: AppColors.textMuted.withValues(alpha: 0.7),
                                      size: 22.0,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftImagePanel() {
    final hasValidUrl = plan.fullImageUrl.isNotEmpty;

    return Container(
      width: 112.0,
      constraints: const BoxConstraints(minHeight: 118.0),
      color: const Color(0xFF06080D),
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: hasValidUrl
            ? Image.network(
                plan.fullImageUrl,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildImagePlaceholder(isLoading: true);
                },
                errorBuilder: (context, error, stackTrace) {
                  return _buildImagePlaceholder(isLoading: false);
                },
              )
            : _buildImagePlaceholder(isLoading: false),
      ),
    );
  }

  Widget _buildTypeBadge() {
    if (!plan.esActivo) {
      return _pillBadge(
        label: plan.tipoEtiqueta,
        fill: const Color(0xFFFF9F0A).withValues(alpha: 0.14),
        border: const Color(0xFFFF9F0A).withValues(alpha: 0.32),
        textColor: const Color(0xFFFFB340),
      );
    }

    if (plan.esConvenio) {
      return _pillBadge(
        label: plan.tipoEtiqueta,
        fill: AppColors.primary.withValues(alpha: 0.14),
        border: AppColors.primary.withValues(alpha: 0.34),
        textColor: AppColors.primaryAccent,
      );
    }

    return _pillBadge(
      label: plan.tipoEtiqueta,
      fill: Colors.white.withValues(alpha: 0.07),
      border: Colors.white.withValues(alpha: 0.12),
      textColor: const Color(0xFFD1D5DB),
    );
  }

  Widget _pillBadge({
    required String label,
    required Color fill,
    required Color border,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 3.5),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: border, width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  Widget _buildMetaRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12.5,
          color: AppColors.textSecondary.withValues(alpha: 0.85),
        ),
        const SizedBox(width: 6.0),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder({required bool isLoading}) {
    if (isLoading) {
      return const SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    }

    return Container(
      width: 54.0,
      height: 54.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: 0.12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: const Center(
        child: Text(
          'B',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
