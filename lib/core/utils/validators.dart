import '../constants/app_strings.dart';

/// Funciones puras de validación de entradas de formulario.
class Validators {
  Validators._();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
  );

  /// Valida campo de correo electrónico
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    }
    final trimmed = value.trim();
    if (!_emailRegExp.hasMatch(trimmed)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  /// Valida campo de contraseña: al menos 8 caracteres, al menos 1 letra y 1 número
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 8) {
      return AppStrings.passwordTooShort;
    }
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value);
    final hasDigit = RegExp(r'[0-9]').hasMatch(value);
    if (!hasLetter || !hasDigit) {
      return AppStrings.passwordRequirements;
    }
    return null;
  }

  /// Valida nombre completo
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.nameRequired;
    }
    if (value.trim().length < 2) {
      return AppStrings.nameTooShort;
    }
    return null;
  }

  /// Valida que la confirmación coincida con la contraseña original
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value != originalPassword) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }
}
