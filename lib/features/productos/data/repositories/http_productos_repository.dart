import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/http_client_factory.dart';
import '../models/producto_model.dart';
import 'productos_repository.dart';

/// Implementación concreta de [ProductosRepository] que consulta
/// `POST https://vous.bossux.com/appv/lproduc` enviando `{"nombre": "<valor>"}`.
class HttpProductosRepository implements ProductosRepository {
  final http.Client _client;

  HttpProductosRepository({http.Client? client})
    : _client = client ?? createPlatformHttpClient();

  @override
  Future<List<ProductoModel>> searchProductos(String nombre) async {
    try {
      final uri = Uri.parse(ApiEndpoints.buscarProductosUrl);
      final response = await _client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'nombre': nombre.trim()}),
          )
          .timeout(const Duration(seconds: 12));

      if (response.statusCode == 200) {
        final bodyText = utf8.decode(response.bodyBytes).trim();
        if (bodyText.isEmpty || bodyText == '[]' || bodyText == 'null') {
          return [];
        }

        final decoded = json.decode(bodyText);
        if (decoded is List) {
          return decoded
              .whereType<Map>()
              .map((item) => ProductoModel.fromJson(Map<String, dynamic>.from(item)))
              .toList();
        }
        if (decoded is Map) {
          final nested = decoded['data'] ?? decoded['productos'] ?? decoded['value'];
          if (nested is List) {
            return nested
                .whereType<Map>()
                .map((item) => ProductoModel.fromJson(Map<String, dynamic>.from(item)))
                .toList();
          }
          if (decoded.containsKey('nombre') || decoded.containsKey('precio')) {
            return [ProductoModel.fromJson(Map<String, dynamic>.from(decoded))];
          }
        }
        return [];
      } else {
        throw Exception('Error en búsqueda de productos: Código ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Tiempo de espera agotado al conectar con el servidor BOSSUX.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error al buscar productos: $e');
    }
  }
}
