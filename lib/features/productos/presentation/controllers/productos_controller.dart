import 'package:flutter/foundation.dart';
import '../../data/models/producto_model.dart';
import '../../data/repositories/productos_repository.dart';

enum ProductosStatus { initial, loading, success, error }

/// Controlador reactivo para la búsqueda y visualización de Productos BOSSUX.
class ProductosController extends ChangeNotifier {
  final ProductosRepository repository;

  ProductosStatus _status = ProductosStatus.initial;
  List<ProductoModel> _productos = [];
  String _currentQuery = '';
  String? _errorMessage;

  ProductosController({required this.repository});

  ProductosStatus get status => _status;
  List<ProductoModel> get productos => _productos;
  String get currentQuery => _currentQuery;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == ProductosStatus.loading;

  /// Consulta `POST /appv/lproduc` con `{"nombre": "<query>"}`
  Future<void> search(String query) async {
    _currentQuery = query.trim();
    _status = ProductosStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await repository.searchProductos(_currentQuery);
      _productos = results;
      _status = ProductosStatus.success;
    } catch (e) {
      _status = ProductosStatus.error;
      _errorMessage = _formatErrorMessage(e);
    } finally {
      notifyListeners();
    }
  }

  String _formatErrorMessage(Object e) {
    final raw = e.toString().replaceFirst(RegExp(r'^(Client)?Exception:\s*'), '');
    if (kIsWeb && raw.contains('Failed to fetch')) {
      return 'El navegador bloqueó la petición por CORS (vous.bossux.com no incluye Access-Control-Allow-Origin). Funciona en Android/Windows o habilitando CORS en el servidor.';
    }
    return raw;
  }

  /// Limpia la búsqueda actual y vuelve a consultar
  Future<void> clearSearch() async {
    await search('');
  }

  /// Refresca los resultados usando el término actual
  Future<void> refresh() async {
    await search(_currentQuery);
  }
}
