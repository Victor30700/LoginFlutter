import '../../../../core/constants/api_endpoints.dart';

/// Modelo inmutable que representa un producto BOSSUX devuelto por `/appv/lproduc`.
class ProductoModel {
  final String id;
  final String nombre;
  final String foto;
  final double precio;

  const ProductoModel({
    this.id = '',
    required this.nombre,
    required this.foto,
    required this.precio,
  });

  /// URL absoluta de la fotografía resuelta contra `https://vous.bossux.com/`
  String get fullImageUrl => ApiEndpoints.resolveImageUrl(foto);

  /// Determina si el producto es gratuito o promocional
  bool get esGratis => precio <= 0;

  /// Formateo amigable del precio de venta (ej: "Bs. 300", "GRATIS")
  String get precioFormateado {
    if (esGratis) {
      return 'GRATIS';
    }
    final esEntero = precio == precio.truncateToDouble();
    final valorStr = esEntero ? precio.toInt().toString() : precio.toStringAsFixed(2);
    return 'Bs. $valorStr';
  }

  /// Formateo estilo VOUS (ej: "300 Bs.-", "GRATIS")
  String get precioCompacto {
    if (esGratis) {
      return 'GRATIS';
    }
    final esEntero = precio == precio.truncateToDouble();
    final valorStr = esEntero ? precio.toInt().toString() : precio.toStringAsFixed(2);
    return '$valorStr Bs.-';
  }

  /// Construye una instancia a partir del mapa JSON retornado por `/appv/lproduc`
  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    final rawPrecio = json['precio'];
    double precioParsed = 0.0;
    if (rawPrecio is num) {
      precioParsed = rawPrecio.toDouble();
    } else if (rawPrecio is String) {
      precioParsed = double.tryParse(rawPrecio.replaceAll(',', '.')) ?? 0.0;
    }

    final rawNombre = json['nombre'] ?? json['plan'] ?? json['producto'];
    final nombreParsed = rawNombre?.toString().trim();

    return ProductoModel(
      id: json['id']?.toString().trim() ?? '',
      nombre: (nombreParsed == null || nombreParsed.isEmpty)
          ? 'Producto sin nombre'
          : nombreParsed,
      foto: json['foto']?.toString().trim() ?? '',
      precio: precioParsed,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id.isNotEmpty) 'id': id,
        'nombre': nombre,
        'foto': foto,
        'precio': precio.toString(),
      };

  @override
  String toString() => 'ProductoModel(id: $id, nombre: $nombre, precio: $precio)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductoModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nombre == other.nombre &&
          foto == other.foto &&
          precio == other.precio;

  @override
  int get hashCode => Object.hash(id, nombre, foto, precio);
}
