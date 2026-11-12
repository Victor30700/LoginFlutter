import 'package:flutter/foundation.dart';
import '../../data/models/plan_model.dart';
import '../../data/repositories/planes_repository.dart';

enum PlanesStatus { initial, loading, success, error }

enum PlanCategoryFilter { todos, paquetes, convenios }

/// Controlador que gestiona el estado reactivo del catálogo de planes
/// y la funcionalidad de búsqueda en vivo (`BuscarCodigo`).
class PlanesController extends ChangeNotifier {
  final PlanesRepository repository;

  PlanesStatus _status = PlanesStatus.initial;
  List<PlanModel> _allPlanes = [];
  List<PlanModel> _displayedPlanes = [];
  String? _errorMessage;
  String _currentQuery = '';
  bool _isSearching = false;
  bool _soloActivos = true;
  PlanCategoryFilter _categoryFilter = PlanCategoryFilter.todos;

  PlanesController({required this.repository});

  PlanesStatus get status => _status;
  List<PlanModel> get planes => _displayedPlanes;
  int get totalPlanes => _allPlanes.length;
  String? get errorMessage => _errorMessage;
  String get currentQuery => _currentQuery;
  bool get isSearching => _isSearching;
  bool get isLoading => _status == PlanesStatus.loading;
  bool get soloActivos => _soloActivos;
  PlanCategoryFilter get categoryFilter => _categoryFilter;

  /// Cambia el filtro de categoría (Todos | Paquetes | Convenios)
  void setCategoryFilter(PlanCategoryFilter filter) {
    if (_categoryFilter == filter) return;
    _categoryFilter = filter;
    _aplicarFiltrosLocales();
    notifyListeners();
  }

  /// Cambia el filtro de solo planes activos
  void toggleSoloActivos() {
    _soloActivos = !_soloActivos;
    _aplicarFiltrosLocales();
    notifyListeners();
  }

  /// Carga inicial o actualización forzada de la lista de planes
  Future<void> fetchPlanes({bool forceRefresh = false}) async {
    if (_status == PlanesStatus.loading) return;

    if (_allPlanes.isNotEmpty && !forceRefresh) {
      return;
    }

    _status = PlanesStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final items = await repository.getPlanes();
      _allPlanes = items;
      _aplicarFiltrosLocales();
      _status = PlanesStatus.success;
    } catch (e) {
      _status = PlanesStatus.error;
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

  /// Ejecuta la búsqueda de planes/productos (Equivalente a `BuscarCodigo`)
  Future<void> search(String query) async {
    _currentQuery = query.trim();

    if (_currentQuery.isEmpty) {
      _isSearching = false;
      _aplicarFiltrosLocales();
      notifyListeners();
      return;
    }

    // 1. Filtrado instantáneo en memoria sobre la lista cargada
    _isSearching = true;
    _aplicarFiltrosLocales();
    notifyListeners();

    // 2. Consulta en el endpoint remoto de búsqueda POST `/appv/lproduc`
    try {
      final remoteResults = await repository.searchProductos(_currentQuery);
      if (remoteResults.isNotEmpty) {
        // Combinar evitando duplicados por ID
        final idsExistentes = _displayedPlanes.map((p) => p.id).toSet();
        for (final item in remoteResults) {
          if (!idsExistentes.contains(item.id)) {
            _displayedPlanes.add(item);
          }
        }
        notifyListeners();
      }
    } catch (_) {
      // Si la búsqueda remota falla o no devuelve datos, se mantienen los resultados locales
    }
  }

  /// Limpia la barra de búsqueda y restablece el listado completo
  void clearSearch() {
    _currentQuery = '';
    _isSearching = false;
    _aplicarFiltrosLocales();
    notifyListeners();
  }

  void _aplicarFiltrosLocales() {
    var resultado = List<PlanModel>.from(_allPlanes);

    if (_soloActivos) {
      resultado = resultado.where((p) => p.esActivo).toList();
    }

    if (_categoryFilter == PlanCategoryFilter.paquetes) {
      resultado = resultado.where((p) => !p.esConvenio).toList();
    } else if (_categoryFilter == PlanCategoryFilter.convenios) {
      resultado = resultado.where((p) => p.esConvenio).toList();
    }

    if (_currentQuery.isNotEmpty) {
      final q = _currentQuery.toLowerCase();
      resultado = resultado.where((p) {
        final nombreCoincide = p.nombre.toLowerCase().contains(q);
        final idCoincide = p.id.contains(q);
        return nombreCoincide || idCoincide;
      }).toList();
    }

    _displayedPlanes = resultado;
  }
}
