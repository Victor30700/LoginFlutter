import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../data/models/producto_model.dart';

/// Tarjeta horizontal compacta de Producto BOSSUX (misma estética VOUS + Liquid Glass azul).
class ProductoCard extends StatelessWidget {
  final ProductoModel producto;
  final VoidCallback? onSelect;

  const ProductoCard({
    super.key,
    required this.producto,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF171A23),
              Color(0xFF11131A),
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.09),
            width: 0.9,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.34),
              blurRadius: 14.0,
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
                _buildLeftImagePanel(),
                Container(
                  width: 0.8,
                  color: Colors.white.withValues(alpha: 0.07),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 14.0, 14.0, 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                producto.nombre,
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.5,
                                vertical: 3.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.07),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  width: 0.8,
                                ),
                              ),
                              child: const Text(
                                'Tienda',
                                style: TextStyle(
                                  color: Color(0xFFD1D5DB),
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          producto.precioCompacto,
                          style: TextStyle(
                            color: producto.esGratis
                                ? AppColors.cyanAccent
                                : AppColors.textPrimary,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.6,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag_rounded,
                              size: 12.5,
                              color: AppColors.textSecondary.withValues(alpha: 0.85),
                            ),
                            const SizedBox(width: 6.0),
                            const Expanded(
                              child: Text(
                                'Producto oficial BOSSUX',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textMuted.withValues(alpha: 0.7),
                              size: 22.0,
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
    final hasValidUrl = producto.fullImageUrl.isNotEmpty;

    return Container(
      width: 112.0,
      constraints: const BoxConstraints(minHeight: 118.0),
      color: const Color(0xFF06080D),
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: hasValidUrl
            ? Image.network(
                producto.fullImageUrl,
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
      child: const Icon(
        Icons.shopping_bag_rounded,
        size: 24.0,
        color: AppColors.primary,
      ),
    );
  }
}
