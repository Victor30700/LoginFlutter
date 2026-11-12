import '../../../../core/constants/api_endpoints.dart';

/// Modelo inmutable que representa un plan o membresía de entrenamiento BOSSUX.
class PlanModel {
  final String id;
  final String plan;
  final String foto;
  final String tiempo;
  final double precio;
  final String estado;
  final String? fechaInsert;
  final String? user;
  final String? tipo;
  final String? horario;

  const PlanModel({
    required this.id,
    required this.plan,
    required this.foto,
    required this.tiempo,
    required this.precio,
    required this.estado,
    this.fechaInsert,
    this.user,
    this.tipo,
    this.horario,
  });

  /// Nombre público del plan
  String get nombre => plan;

  /// URL absoluta de la fotografía resuelta contra el servidor de BOSSUX
  String get fullImageUrl => ApiEndpoints.resolveImageUrl(foto);

  /// Determina si el plan está activo (`estado == '1'`)
  bool get esActivo => estado == '1';

  /// Determina si corresponde a un convenio (`tipo == '2'`)
  bool get esConvenio => tipo == '2';

  /// Etiqueta de categoría del plan para el badge superior derecho
  String get tipoEtiqueta {
    if (!esActivo) return 'Promo';
    if (esConvenio) return 'Convenio';
    return 'Normal';
  }

  /// Etiqueta de horario legible según campo `h` de la API
  String get horarioEtiqueta {
    if (horario == null || horario == '1' || horario!.isEmpty) {
      return '24 horas';
    }
    return horario!;
  }

  /// Determina si es una membresía gratuita o promocional
  bool get esGratis => precio <= 0;

  /// Formateo amigable del precio de venta (ej: "Bs. 250", "Bs. 120", "GRATIS")
  String get precioFormateado {
    if (esGratis) {
      return 'GRATIS';
    }
    final esEntero = precio == precio.truncateToDouble();
    final valorStr = esEntero ? precio.toInt().toString() : precio.toStringAsFixed(2);
    return 'Bs. $valorStr';
  }

  /// Formateo estilo VOUS (ej: "2500 Bs.-", "GRATIS")
  String get precioCompacto {
    if (esGratis) {
      return 'GRATIS';
    }
    final esEntero = precio == precio.truncateToDouble();
    final valorStr = esEntero ? precio.toInt().toString() : precio.toStringAsFixed(2);
    return '$valorStr Bs.-';
  }

  /// Formateo inteligente de la duración o cantidad de tiempo
  String get tiempoFormateado {
    final lower = plan.toLowerCase();
    final valor = int.tryParse(tiempo) ?? 1;

    if (lower.contains('dia') || valor == 1 && lower.contains('sesion 1 dia')) {
      return valor == 1 ? '1 Día' : '$valor Días';
    }
    if (valor == 7 || lower.contains('semanal') || lower.contains('1 semana')) {
      return '1 Semana (7 Días)';
    }
    if (valor == 14 || lower.contains('2 semanas')) {
      return '2 Semanas (14 Días)';
    }
    if (valor == 15) {
      return '15 Días';
    }
    if (valor == 1) {
      return '1 Mes';
    }
    if (valor == 2) {
      return '2 Meses (Bimensual)';
    }
    if (valor == 3) {
      return '3 Meses (Trimestral)';
    }
    if (valor == 6) {
      return '6 Meses (Semestral)';
    }
    if (valor == 12) {
      return '1 Año (12 Meses)';
    }
    return '$valor Meses';
  }

  /// Construye una instancia a partir del mapa JSON retornado por la API
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    // Normalizar precio: viene como string "250", "0", etc.
    final rawPrecio = json['precio'];
    double precioParsed = 0.0;
    if (rawPrecio is num) {
      precioParsed = rawPrecio.toDouble();
    } else if (rawPrecio is String) {
      precioParsed = double.tryParse(rawPrecio.replaceAll(',', '.')) ?? 0.0;
    }

    return PlanModel(
      id: json['id']?.toString() ?? '',
      plan: (json['plan'] ?? json['nombre'] ?? json['producto'])?.toString().trim() ?? 'Plan sin nombre',
      foto: json['foto']?.toString().trim() ?? '',
      tiempo: json['tiempo']?.toString().trim() ?? '1',
      precio: precioParsed,
      estado: json['estado']?.toString().trim() ?? '1',
      fechaInsert: json['fecha_insert']?.toString(),
      user: json['user']?.toString(),
      tipo: json['tipo']?.toString(),
      horario: json['h']?.toString().trim(),
    );
  }

  /// Convierte la instancia a formato JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan': plan,
      'foto': foto,
      'tiempo': tiempo,
      'precio': precio.toString(),
      'estado': estado,
      if (fechaInsert != null) 'fecha_insert': fechaInsert,
      if (user != null) 'user': user,
      if (tipo != null) 'tipo': tipo,
      if (horario != null) 'h': horario,
    };
  }

  @override
  String toString() => 'PlanModel(id: $id, plan: $plan, precio: $precio, tiempo: $tiempo)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
