import 'package:flutter/foundation.dart';
import '../../data/exceptions/auth_exception.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  error,
}

/// Controlador de estado de autenticación reactivo basado en ChangeNotifier.
class AuthController extends ChangeNotifier {
  final AuthRepository repository;

  AuthStatus _status = AuthStatus.initial;
  UserModel? _currentUser;
  String? _errorMessage;

  AuthController({required this.repository}) {
    _currentUser = repository.currentUser;
    if (_currentUser != null) {
      _status = AuthStatus.authenticated;
    }
  }

  // Getters
  AuthStatus get status => _status;
  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated && _currentUser != null;

  /// Inicia sesión con correo y contraseña
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading();
    try {
      final user = await repository.signIn(
        email: email,
        password: password,
      );
      _currentUser = user;
      _status = AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
      return true;
    } on AuthException catch (e) {
      _setError(e.message);
      return false;
    } catch (_) {
      _setError('Error inesperado al conectar con el servidor.');
      return false;
    }
  }

  /// Registra un nuevo usuario
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading();
    try {
      final user = await repository.signUp(
        name: name,
        email: email,
        password: password,
      );
      _currentUser = user;
      _status = AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
      return true;
    } on AuthException catch (e) {
      _setError(e.message);
      return false;
    } catch (_) {
      _setError('Error inesperado al crear la cuenta.');
      return false;
    }
  }

  /// Inicio de sesión simulado con Google
  Future<bool> loginWithGoogle() async {
    _setLoading();
    try {
      final user = await repository.signInWithGoogle();
      _currentUser = user;
      _status = AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (_) {
      _setError('Error al autenticar con Google.');
      return false;
    }
  }

  /// Inicio de sesión simulado con Apple
  Future<bool> loginWithApple() async {
    _setLoading();
    try {
      final user = await repository.signInWithApple();
      _currentUser = user;
      _status = AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (_) {
      _setError('Error al autenticar con Apple.');
      return false;
    }
  }

  /// Cierra la sesión
  Future<void> logout() async {
    await repository.signOut();
    _currentUser = null;
    _status = AuthStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }

  /// Limpia mensajes de error activos
  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      _status = AuthStatus.initial;
      notifyListeners();
    }
  }

  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }
}
