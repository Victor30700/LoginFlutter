import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/pressable_scale.dart';

/// Botón principal estilo píldora Volt Neon con feedback táctil elástico y glow.
class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && !isLoading;

    return PressableScale(
      onPressed: isEnabled ? onPressed : null,
      enabled: isEnabled,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 52.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: AppSpacing.roundedPill,
          gradient: isEnabled
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFD6FF1A),
                    Color(0xFFBFFF00),
                  ],
                )
              : null,
          color: isEnabled ? null : AppColors.surfaceElevated,
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 22.0,
                    spreadRadius: -2.0,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22.0,
                  height: 22.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.textOnPrimary),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 20.0, color: AppColors.textOnPrimary),
                      const SizedBox(width: AppSpacing.xs),
                    ],
                    Text(
                      text,
                      style: AppTextStyles.buttonPrimary,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
