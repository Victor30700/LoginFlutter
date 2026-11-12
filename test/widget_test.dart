import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_flutter/app.dart';
import 'package:login_flutter/core/constants/app_colors.dart';
import 'package:login_flutter/core/constants/app_strings.dart';
import 'package:login_flutter/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:login_flutter/features/auth/presentation/controllers/auth_controller.dart';
import 'package:login_flutter/features/auth/presentation/widgets/custom_primary_button.dart';

void main() {
  testWidgets('Smoke test: Welcome screen renders hero and navigates to Login and Register', (WidgetTester tester) async {
    final authRepository = MockAuthRepository();
    final authController = AuthController(repository: authRepository);

    await tester.pumpWidget(BossuxApp(authController: authController));
    await tester.pumpAndSettle();

    // 1. Verifica elementos de la nueva pantalla de bienvenida BOSSUX
    expect(find.text(AppStrings.welcomeHeroTitle), findsOneWidget);
    expect(find.text(AppStrings.welcomeSignUpAction), findsOneWidget);
    expect(find.text(AppStrings.welcomeOrLogInAction), findsOneWidget);
    expect(find.text('ES'), findsOneWidget);

    // 2. Navega hacia el login pulsando "o Iniciar sesión"
    await tester.tap(find.text(AppStrings.welcomeOrLogInAction));
    await tester.pumpAndSettle();

    // 3. Verifica elementos de la pantalla de login BOSSUX (Google y Apple con íconos SVG)
    expect(find.text(AppStrings.loginTitle), findsOneWidget);
    expect(find.text(AppStrings.continueButton), findsOneWidget);
    expect(find.text(AppStrings.continueWithGoogle), findsOneWidget);
    expect(find.text(AppStrings.continueWithApple), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(2));
  });

  testWidgets('CustomPrimaryButton usa gradiente azul y no verde', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomPrimaryButton(
            text: AppStrings.signUpButton,
            onPressed: () {},
          ),
        ),
      ),
    );

    final container = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    final decoration = container.decoration as BoxDecoration;
    final gradient = decoration.gradient as LinearGradient;

    expect(gradient.colors.first, AppColors.primary);
    expect(gradient.colors, isNot(contains(const Color(0xFFD6FF1A))));
    expect(gradient.colors, isNot(contains(const Color(0xFFBFFF00))));
  });
}
