import '../models/producto_model.dart';

/// Contrato abstracto para la búsqueda y obtención de productos BOSSUX.
abstract class ProductosRepository {
  /// Busca productos mediante `POST /appv/lproduc` con `{"nombre": "<query>"}`.
  Future<List<ProductoModel>> searchProductos(String nombre);
}
