import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/pressable_scale.dart';

/// Barra de navegación inferior flotante con estilo cristal líquido translúcido (Apple VisionOS / macOS).
class FloatingBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onQuickAdd;

  const FloatingBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onQuickAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 24.0),
      height: 68.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Fondo esmerilado translúcido con desenfoque de 25px
          ClipRRect(
            borderRadius: BorderRadius.circular(34.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(34.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.22),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 24.0,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      index: 0,
                    ),
                    _buildNavItem(
                      icon: Icons.shopping_bag_rounded,
                      label: 'Productos',
                      index: 1,
                    ),
                    _buildNavItem(
                      icon: Icons.card_membership_rounded,
                      label: 'Planes',
                      index: 2,
                    ),
                    _buildNavItem(
                      icon: Icons.settings_rounded,
                      label: 'Settings',
                      index: 3,
                    ),
                    const SizedBox(width: 44.0), // Espacio para el botón flotante +
                  ],
                ),
              ),
            ),
          ),

          // 2. Botón flotante circular "+" en el extremo derecho
          Positioned(
            right: 8.0,
            child: PressableScale(
              onTap: onQuickAdd,
              child: Container(
                width: 52.0,
                height: 52.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF141822).withValues(alpha: 0.92),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.20),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.42),
                      blurRadius: 14.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: AppColors.primary,
                  size: 28.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? AppColors.primaryAccent : Colors.white60;

    return PressableScale(
      onTap: () => onTabSelected(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.0,
              color: color,
            ),
            const SizedBox(height: 3.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: color,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
