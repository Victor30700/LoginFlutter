import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_endpoints.dart';
import '../models/plan_model.dart';
import 'planes_repository.dart';

/// Implementación concreta de [PlanesRepository] que se comunica
/// con la API REST de BOSSUX en `https://vous.bossux.com/`.
class HttpPlanesRepository implements PlanesRepository {
  final http.Client _client;

  HttpPlanesRepository({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<List<PlanModel>> getPlanes() async {
    try {
      final uri = Uri.parse(ApiEndpoints.planesUrl);
      final response = await _client.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'BOSSUX-Flutter-App/1.0',
        },
      ).timeout(const Duration(seconds: 12));

      if (response.statusCode == 200) {
        final decoded = json.decode(utf8.decode(response.bodyBytes));
        if (decoded is List) {
          return decoded
              .map((item) => PlanModel.fromJson(Map<String, dynamic>.from(item as Map)))
              .toList();
        }
        return [];
      } else {
        throw Exception('Error del servidor: Código ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Tiempo de espera agotado al conectar con el servidor BOSSUX.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error al obtener la lista de planes: $e');
    }
  }

  @override
  Future<List<PlanModel>> searchProductos(String query) async {
    try {
      final uri = Uri.parse(ApiEndpoints.buscarProductosUrl);
      // Simula:
      // var url = "https://vous.bossux.com/appv/lproduc";
      // var obj = {nombre: codigo};
      // $.post(url, obj, function(res) { ... });
      final response = await _client.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'User-Agent': 'BOSSUX-Flutter-App/1.0',
        },
        body: {'nombre': query.trim()},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final bodyText = utf8.decode(response.bodyBytes).trim();
        if (bodyText.isEmpty || bodyText == '[]') {
          return [];
        }
        final decoded = json.decode(bodyText);
        if (decoded is List) {
          return decoded
              .map((item) => PlanModel.fromJson(Map<String, dynamic>.from(item as Map)))
              .toList();
        }
        return [];
      } else {
        throw Exception('Error en búsqueda: Código ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Tiempo de espera agotado en la búsqueda.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error en la búsqueda de productos: $e');
    }
  }
}
