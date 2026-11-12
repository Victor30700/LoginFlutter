import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:login_flutter/core/constants/app_colors.dart';
import 'package:login_flutter/features/home/presentation/widgets/floating_bottom_nav_bar.dart';
import 'package:login_flutter/features/planes/data/repositories/http_planes_repository.dart';
import 'package:login_flutter/features/productos/data/models/producto_model.dart';
import 'package:login_flutter/features/productos/data/repositories/http_productos_repository.dart';

void main() {
  group('ProductoModel & Endpoints BOSSUX', () {
    test('ProductoModel.fromJson parsea nombre, foto y precio y resuelve URL de imagen', () {
      final json = {
        'id': '10',
        'nombre': 'Proteína Whey BOSSUX',
        'foto': '_resources/_productos/whey_01.png',
        'precio': '350',
      };

      final producto = ProductoModel.fromJson(json);

      expect(producto.id, '10');
      expect(producto.nombre, 'Proteína Whey BOSSUX');
      expect(producto.precio, 350.0);
      expect(producto.precioFormateado, 'Bs. 350');
      expect(
        producto.fullImageUrl,
        'https://vous.bossux.com/_resources/_productos/whey_01.png',
      );
    });

    test('HttpProductosRepository envía POST a /appv/lproduc con body JSON {"nombre": "x"}', () async {
      late http.Request capturedRequest;

      final mockClient = MockClient((request) async {
        capturedRequest = request;
        return http.Response(
          jsonEncode([
            {
              'id': '1',
              'nombre': 'Guantes Pro',
              'foto': '_resources/_productos/guantes.png',
              'precio': '180',
            }
          ]),
          200,
        );
      });

      final repo = HttpProductosRepository(client: mockClient);
      final results = await repo.searchProductos('x');

      expect(capturedRequest.method, 'POST');
      expect(capturedRequest.url.toString(), 'https://vous.bossux.com/appv/lproduc');
      expect(capturedRequest.headers['Content-Type'], contains('application/json'));
      expect(jsonDecode(capturedRequest.body), {'nombre': 'x'});
      expect(results.length, 1);
      expect(results.first.nombre, 'Guantes Pro');
      expect(
        results.first.fullImageUrl,
        'https://vous.bossux.com/_resources/_productos/guantes.png',
      );
    });

    test('HttpPlanesRepository envía GET a /apx/lplanes sin headers y parsea planes reales', () async {
      late http.Request capturedRequest;

      final mockClient = MockClient((request) async {
        capturedRequest = request;
        return http.Response(
          jsonEncode([
            {
              'id': '2',
              'plan': 'Mensual',
              'foto': '_resources/_planes/467a904d9d4c17dc010c6d89fbd18fa4.png',
              'tiempo': '1',
              'precio': '300',
              'estado': '1',
            },
          ]),
          200,
        );
      });

      final repo = HttpPlanesRepository(client: mockClient);
      final planes = await repo.getPlanes();

      expect(capturedRequest.method, 'GET');
      expect(capturedRequest.url.toString(), 'https://vous.bossux.com/apx/lplanes');
      expect(capturedRequest.headers, isEmpty);
      expect(planes.length, 1);
      expect(planes.first.nombre, 'Mensual');
      expect(planes.first.precioFormateado, 'Bs. 300');
      expect(
        planes.first.fullImageUrl,
        'https://vous.bossux.com/_resources/_planes/467a904d9d4c17dc010c6d89fbd18fa4.png',
      );
    });

    test('AppColors.primary usa paleta Apple Blue (no verde Volt Lime)', () {
      expect(AppColors.primary, const Color(0xFF0A84FF));
      expect(AppColors.primaryAccent, const Color(0xFF409CFF));
      expect(AppColors.primary, isNot(const Color(0xFFD4FE11)));
    });

    testWidgets('FloatingBottomNavBar muestra Productos en lugar de Analytics', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FloatingBottomNavBar(
              currentIndex: 1,
              onTabSelected: (_) {},
              onQuickAdd: () {},
            ),
          ),
        ),
      );

      expect(find.text('Productos'), findsOneWidget);
      expect(find.text('Planes'), findsOneWidget);
      expect(find.text('Analytics'), findsNothing);
    });
  });
}
