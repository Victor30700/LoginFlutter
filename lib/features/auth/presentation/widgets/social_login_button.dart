import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/pressable_scale.dart';

enum SocialProvider { google, apple }

/// Botón estilizado para inicio de sesión social con micro-interacción de escala.
/// Utiliza los íconos oficiales SVG en `assets/icons/` para Google y Apple.
class SocialLoginButton extends StatelessWidget {
  final SocialProvider provider;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool useWhiteStyle;

  const SocialLoginButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
    this.useWhiteStyle = true,
  });

  @override
  Widget build(BuildContext context) {
    final isGoogle = provider == SocialProvider.google;
    final label = isGoogle
        ? AppStrings.continueWithGoogle
        : AppStrings.continueWithApple;
    final isEnabled = !isLoading && onPressed != null;

    final bgColor = useWhiteStyle
        ? Colors.white
        : const Color(0x351F2A3F);

    final textColor = useWhiteStyle
        ? const Color(0xFF1E222B)
        : AppColors.textPrimary;

    final borderColor = useWhiteStyle
        ? const Color(0xFFE0E0E0)
        : Colors.white.withValues(alpha: 0.18);

    return PressableScale(
      onPressed: isEnabled ? onPressed : null,
      enabled: isEnabled,
      child: Container(
        height: 52.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppSpacing.roundedPill,
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProviderLogo(isGoogle: isGoogle, textColor: textColor),
                    const SizedBox(width: 12.0),
                    Text(
                      label,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProviderLogo({
    required bool isGoogle,
    required Color textColor,
  }) {
    if (isGoogle) {
      return SvgPicture.asset(
        'assets/icons/google_logo.svg',
        width: 22,
        height: 22,
      );
    }

    return SvgPicture.asset(
      'assets/icons/apple_logo.svg',
      width: 22,
      height: 22,
      colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
    );
  }
}
