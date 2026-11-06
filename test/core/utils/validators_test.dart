import 'package:flutter_test/flutter_test.dart';
import 'package:login_flutter/core/utils/validators.dart';

void main() {
  group('Validators tests', () {
    test('email validator returns null on valid emails', () {
      expect(Validators.email('demo@calai.app'), isNull);
      expect(Validators.email('athlete.pro@gmail.com'), isNull);
    });

    test('email validator returns error on invalid emails', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('invalid-email'), isNotNull);
      expect(Validators.email('test@domain'), isNotNull);
    });

    test('password validator returns null on strong password', () {
      expect(Validators.password('Calai2026!'), isNull);
      expect(Validators.password('Password123'), isNull);
    });

    test('password validator returns error if too short or lacking digits', () {
      expect(Validators.password('123'), isNotNull);
      expect(Validators.password('short'), isNotNull);
      expect(Validators.password('onlyletters'), isNotNull);
    });

    test('confirmPassword returns null only if matching', () {
      expect(Validators.confirmPassword('Calai2026!', 'Calai2026!'), isNull);
      expect(Validators.confirmPassword('Calai2026!', 'Different123'), isNotNull);
    });
  });
}
