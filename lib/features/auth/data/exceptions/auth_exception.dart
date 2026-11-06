/// Excepciones tipadas lanzadas durante el proceso de autenticación.
class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException(this.message, {this.code});

  @override
  String toString() => 'AuthException: $message ($code)';
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException([super.message = 'El correo o la contraseña son incorrectos.'])
      : super(code: 'INVALID_CREDENTIALS');
}

class UserAlreadyExistsException extends AuthException {
  const UserAlreadyExistsException([super.message = 'Ya existe una cuenta registrada con este correo electrónico.'])
      : super(code: 'USER_ALREADY_EXISTS');
}

class NetworkAuthException extends AuthException {
  const NetworkAuthException([super.message = 'Error de conexión. Verifica tu conexión a internet.'])
      : super(code: 'NETWORK_ERROR');
}
