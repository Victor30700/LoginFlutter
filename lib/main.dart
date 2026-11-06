import 'package:flutter/material.dart';
import 'app.dart';
import 'features/auth/data/repositories/mock_auth_repository.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialización de la capa de datos (Mock en memoria)
  final authRepository = MockAuthRepository();

  // Inicialización del controlador de sesión
  final authController = AuthController(repository: authRepository);

  runApp(BossuxApp(authController: authController));
}
