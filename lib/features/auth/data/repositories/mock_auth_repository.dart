import 'dart:async';
import '../exceptions/auth_exception.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';

/// Implementación en memoria del repositorio de autenticación para pruebas y prototipado.
class MockAuthRepository implements AuthRepository {
  UserModel? _currentUser;

  // Base de datos de usuarios en memoria
  final Map<String, _MockUserData> _usersDb = {
    'demo@calai.app': _MockUserData(
      id: 'usr_demo_01',
      name: 'Victor Hugo Saldana',
      email: 'demo@calai.app',
      password: 'Calai2026!',
      createdAt: DateTime(2026, 1, 1),
    ),
  };

  @override
  UserModel? get currentUser => _currentUser;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    // Simula latencia de red de un servidor real
    await Future.delayed(const Duration(milliseconds: 1200));

    final normalizedEmail = email.trim().toLowerCase();
    final userRecord = _usersDb[normalizedEmail];

    if (userRecord == null || userRecord.password != password) {
      throw const InvalidCredentialsException();
    }

    _currentUser = UserModel(
      id: userRecord.id,
      name: userRecord.name,
      email: userRecord.email,
      provider: 'email',
      createdAt: userRecord.createdAt,
    );

    return _currentUser!;
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1300));

    final normalizedEmail = email.trim().toLowerCase();
    if (_usersDb.containsKey(normalizedEmail)) {
      throw const UserAlreadyExistsException();
    }

    final newId = 'usr_${DateTime.now().millisecondsSinceEpoch}';
    final user = _MockUserData(
      id: newId,
      name: name.trim(),
      email: normalizedEmail,
      password: password,
      createdAt: DateTime.now(),
    );

    _usersDb[normalizedEmail] = user;

    _currentUser = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      provider: 'email',
      createdAt: user.createdAt,
    );

    return _currentUser!;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _currentUser = UserModel(
      id: 'usr_google_123',
      name: 'Atleta Google',
      email: 'athlete.google@calai.app',
      provider: 'google',
      createdAt: DateTime.now(),
    );
    return _currentUser!;
  }

  @override
  Future<UserModel> signInWithApple() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _currentUser = UserModel(
      id: 'usr_apple_456',
      name: 'Atleta Apple',
      email: 'athlete.apple@calai.app',
      provider: 'apple',
      createdAt: DateTime.now(),
    );
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _currentUser = null;
  }
}

class _MockUserData {
  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;

  _MockUserData({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
  });
}
