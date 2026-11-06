import 'package:flutter_test/flutter_test.dart';
import 'package:login_flutter/features/auth/data/exceptions/auth_exception.dart';
import 'package:login_flutter/features/auth/data/repositories/mock_auth_repository.dart';

void main() {
  group('MockAuthRepository tests', () {
    late MockAuthRepository repository;

    setUp(() {
      repository = MockAuthRepository();
    });

    test('signs in successfully with demo credentials', () async {
      final user = await repository.signIn(
        email: 'demo@calai.app',
        password: 'Calai2026!',
      );

      expect(user.email, 'demo@calai.app');
      expect(repository.currentUser, isNotNull);
    });

    test('throws InvalidCredentialsException on wrong password', () async {
      expect(
        () => repository.signIn(
          email: 'demo@calai.app',
          password: 'WrongPassword!',
        ),
        throwsA(isA<InvalidCredentialsException>()),
      );
    });

    test('registers new user and allows login', () async {
      final newUser = await repository.signUp(
        name: 'Jordan Gym',
        email: 'jordan@fit.com',
        password: 'Password123!',
      );

      expect(newUser.name, 'Jordan Gym');
      expect(newUser.email, 'jordan@fit.com');

      // Logout and login with new credentials
      await repository.signOut();
      expect(repository.currentUser, isNull);

      final loggedInUser = await repository.signIn(
        email: 'jordan@fit.com',
        password: 'Password123!',
      );

      expect(loggedInUser.id, newUser.id);
    });
  });
}
