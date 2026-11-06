import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/auth/presentation/controllers/auth_controller_scope.dart';

/// Configuración raíz de la aplicación BOSSUX.
class BossuxApp extends StatelessWidget {
  final AuthController authController;

  const BossuxApp({
    super.key,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return AuthControllerScope(
      controller: authController,
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: AppRoutes.welcome,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}

// Compatibilidad
typedef CalAiApp = BossuxApp;
