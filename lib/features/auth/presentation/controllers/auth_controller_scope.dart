import 'package:flutter/widgets.dart';
import 'auth_controller.dart';

/// Provee AuthController a todo el subárbol de widgets de forma nativa sin paquetes externos.
class AuthControllerScope extends InheritedWidget {
  final AuthController controller;

  const AuthControllerScope({
    super.key,
    required this.controller,
    required super.child,
  });

  static AuthController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AuthControllerScope>();
    assert(scope != null, 'AuthControllerScope no fue encontrado en el árbol de widgets.');
    return scope!.controller;
  }

  @override
  bool updateShouldNotify(AuthControllerScope oldWidget) => controller != oldWidget.controller;
}
