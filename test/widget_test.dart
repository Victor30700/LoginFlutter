import 'package:flutter_test/flutter_test.dart';
import 'package:login_flutter/app.dart';
import 'package:login_flutter/core/constants/app_strings.dart';
import 'package:login_flutter/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:login_flutter/features/auth/presentation/controllers/auth_controller.dart';

void main() {
  testWidgets('Smoke test: Welcome screen renders headline and navigates to Login', (WidgetTester tester) async {
    final authRepository = MockAuthRepository();
    final authController = AuthController(repository: authRepository);

    await tester.pumpWidget(BossuxApp(authController: authController));
    await tester.pumpAndSettle();

    // 1. Verifica elementos de la pantalla de bienvenida BOSSUX
    expect(find.text(AppStrings.welcomeHeadline), findsOneWidget);
    expect(find.text(AppStrings.welcomeButton), findsOneWidget);
    expect(find.text('ES'), findsOneWidget);

    // 2. Navega hacia el login pulsando "¡Perfecto!"
    await tester.tap(find.text(AppStrings.welcomeButton));
    await tester.pumpAndSettle();

    // 3. Verifica elementos de la pantalla de login BOSSUX
    expect(find.text(AppStrings.loginTitle), findsOneWidget);
    expect(find.text(AppStrings.continueButton), findsOneWidget);
    expect(find.text(AppStrings.continueWithGoogle), findsOneWidget);
  });
}
