import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/apple_ambient_background.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../controllers/auth_controller.dart';
import '../controllers/auth_controller_scope.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/book_spread_card.dart';
import '../widgets/custom_primary_button.dart';
import '../widgets/custom_text_field.dart';

/// Pantalla de registro de nuevos atletas perfectamente centrada con formato Libro Abierto.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late final AuthController _authController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authController = AuthControllerScope.of(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final success = await _authController.register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _authController,
      builder: (context, _) {
        final isLoading = _authController.isLoading;
        final errorMessage = _authController.errorMessage;

        return AppleAmbientBackground(
          child: SafeArea(
            child: BookSpreadCard(
              formContent: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Botón Volver
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18.0),
                        onPressed: isLoading ? null : () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // 0. Título y Subtítulo
                    StaggeredEntrance(
                      index: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.registerTitle,
                            style: AppTextStyles.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            AppStrings.registerSubtitle,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Banner de Error
                    if (errorMessage != null)
                      AuthErrorBanner(
                        message: errorMessage,
                        onDismiss: _authController.clearError,
                      ),

                    // 1. Campos de Nombre y Email
                    StaggeredEntrance(
                      index: 1,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: AppStrings.nameLabel,
                            hintText: AppStrings.nameHint,
                            controller: _nameController,
                            validator: Validators.name,
                            prefixIcon: Icons.person_outline_rounded,
                            autofillHints: const [AutofillHints.name],
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          CustomTextField(
                            label: AppStrings.emailLabel,
                            hintText: AppStrings.emailHint,
                            controller: _emailController,
                            validator: Validators.email,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.alternate_email_rounded,
                            autofillHints: const [AutofillHints.email],
                            enabled: !isLoading,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // 2. Campos de Contraseñas
                    StaggeredEntrance(
                      index: 2,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: AppStrings.passwordLabel,
                            hintText: AppStrings.passwordHint,
                            controller: _passwordController,
                            validator: Validators.password,
                            isPassword: true,
                            prefixIcon: Icons.lock_outline_rounded,
                            autofillHints: const [AutofillHints.newPassword],
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          CustomTextField(
                            label: AppStrings.confirmPasswordLabel,
                            hintText: AppStrings.confirmPasswordHint,
                            controller: _confirmPasswordController,
                            validator: (value) => Validators.confirmPassword(
                              value,
                              _passwordController.text,
                            ),
                            isPassword: true,
                            prefixIcon: Icons.lock_reset_rounded,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _handleRegister(),
                            enabled: !isLoading,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // 3. Botón de Registrarse
                    StaggeredEntrance(
                      index: 3,
                      child: CustomPrimaryButton(
                        text: AppStrings.signUpButton,
                        onPressed: _handleRegister,
                        isLoading: isLoading,
                        icon: Icons.fitness_center_rounded,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // 4. Enlace para volver al Login
                    StaggeredEntrance(
                      index: 4,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            AppStrings.hasAccountPrompt,
                            style: AppTextStyles.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: isLoading
                                ? null
                                : () {
                                    _authController.clearError();
                                    Navigator.pop(context);
                                  },
                            child: Text(
                              AppStrings.loginLink,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
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
        );
      },
    );
  }
}
