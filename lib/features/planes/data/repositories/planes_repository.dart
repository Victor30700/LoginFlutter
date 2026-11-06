import '../models/plan_model.dart';

/// Contrato abstracto para el acceso a datos de planes y productos BOSSUX.
abstract class PlanesRepository {
  /// Obtiene la lista completa de planes desde el servidor
  Future<List<PlanModel>> getPlanes();

  /// Realiza una búsqueda de productos o planes por código o nombre
  /// Equivalente a la función web `BuscarCodigo()`
  Future<List<PlanModel>> searchProductos(String query);
}
