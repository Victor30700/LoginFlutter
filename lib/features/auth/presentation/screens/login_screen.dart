import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/apple_ambient_background.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../controllers/auth_controller.dart';
import '../controllers/auth_controller_scope.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/social_login_button.dart';

/// Pantalla de Login de BOSSUX con estética Apple Liquid Glass (Cristal Translúcido).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController(text: 'Bossux2026!');
  final bool _showPasswordField = false;

  late final AuthController _authController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authController = AuthControllerScope.of(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _fillDemoEmail() {
    _emailController.text = 'demo@bossux.app';
    _passwordController.text = 'Bossux2026!';
    _authController.clearError();
  }

  Future<void> _handleContinue() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final success = await _authController.login(
      email: email,
      password: password.isEmpty ? 'Bossux2026!' : password,
    );

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  Future<void> _handleGoogleLogin() async {
    final success = await _authController.loginWithGoogle();
    if (success && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
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
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Barra superior: Botón Atrás
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushReplacementNamed(context, AppRoutes.welcome);
                                }
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // 2. Isotipo exclusivo BOSSUX con cristal
                          Center(
                            child: StaggeredEntrance(
                              index: 0,
                              child: _buildBossuxLogo(),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // 3. Título y Subtítulo
                          StaggeredEntrance(
                            index: 1,
                            child: Column(
                              children: [
                                const Text(
                                  AppStrings.loginTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  AppStrings.loginSubtitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withValues(alpha: 0.70),
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // 4. Chip de acceso demo rápido
                          Center(
                            child: PressableScale(
                              onTap: _fillDemoEmail,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryAccent.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.primaryAccent.withValues(alpha: 0.4),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.flash_on_rounded, size: 14, color: AppColors.primaryAccent),
                                    SizedBox(width: 4),
                                    Text(
                                      'Demo: demo@bossux.app',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          if (errorMessage != null) ...[
                            AuthErrorBanner(
                              message: errorMessage,
                              onDismiss: _authController.clearError,
                            ),
                            const SizedBox(height: 16),
                          ],

                          // 5. Campo de Entrada de Correo Electrónico Translúcido
                          StaggeredEntrance(
                            index: 2,
                            child: GlassContainer(
                              borderRadius: BorderRadius.circular(20.0),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                controller: _emailController,
                                validator: Validators.email,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: AppStrings.emailHint,
                                  hintStyle: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.45),
                                    fontSize: 15,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          if (_showPasswordField) ...[
                            const SizedBox(height: 14),
                            GlassContainer(
                              borderRadius: BorderRadius.circular(20.0),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: 'Contraseña',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.45),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 20),

                          // 6. Botón "Continuar" (Blanco sólido con sombra sutil)
                          StaggeredEntrance(
                            index: 3,
                            child: PressableScale(
                              onTap: isLoading ? null : _handleContinue,
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(27.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.25),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Color(0xFF0F1218),
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        AppStrings.continueButton,
                                        style: TextStyle(
                                          color: Color(0xFF0F1218),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // 7. Separador "o"
                          StaggeredEntrance(
                            index: 4,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    AppStrings.orDivider,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          // 8. Botón Social: "Continuar con Google"
                          StaggeredEntrance(
                            index: 5,
                            child: SocialLoginButton(
                              provider: SocialProvider.google,
                              onPressed: isLoading ? null : _handleGoogleLogin,
                              isLoading: isLoading,
                              useWhiteStyle: true,
                            ),
                          ),

                          const SizedBox(height: 36),

                          // 9. Términos y Condiciones al pie
                          Text(
                            AppStrings.legalTermsDisclaimer,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.40),
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Construye el isotipo moderno de BOSSUX con cristal translúcido
  Widget _buildBossuxLogo() {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: const Color(0xFF141923).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.22),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGlow.withValues(alpha: 0.20),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'B',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            Icon(
              Icons.bolt_rounded,
              color: AppColors.primaryAccent,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}
