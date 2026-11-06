import '../models/user_model.dart';

/// Contrato abstracto para el servicio de autenticación.
/// Permite alternar fácilmente entre Mock, API REST o Firebase.
abstract class AuthRepository {
  /// Iniciar sesión con email y contraseña
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  /// Registrar un nuevo usuario
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Iniciar sesión con Google
  Future<UserModel> signInWithGoogle();

  /// Iniciar sesión con Apple
  Future<UserModel> signInWithApple();

  /// Cerrar la sesión actual
  Future<void> signOut();

  /// Obtener el usuario activo actual si existe
  UserModel? get currentUser;
}
