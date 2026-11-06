import 'package:flutter_test/flutter_test.dart';
import 'package:login_flutter/features/planes/data/models/plan_model.dart';

void main() {
  group('PlanModel - Parseo y Formateo', () {
    test('Debe parsear correctamente un plan de pago desde JSON de BOSSUX', () {
      final json = {
        'id': '74',
        'plan': 'PLAN MENSUAL',
        'foto': r'_resources\/_planes\/b0d1f1fd2d6a6477d037ed1bc88475b7.jpg',
        'tiempo': '1',
        'precio': '250',
        'estado': '2',
        'fecha_insert': '2026-07-09 11:23:30',
        'user': '1',
        'tipo': '1',
      };

      final plan = PlanModel.fromJson(json);

      expect(plan.id, '74');
      expect(plan.nombre, 'PLAN MENSUAL');
      expect(plan.precio, 250.0);
      expect(plan.precioFormateado, 'Bs. 250');
      expect(plan.tiempoFormateado, '1 Mes');
      expect(plan.esGratis, false);
      expect(
        plan.fullImageUrl,
        'https://vous.bossux.com/_resources/_planes/b0d1f1fd2d6a6477d037ed1bc88475b7.jpg',
      );
    });

    test('Debe formatear adecuadamente un plan de 2 semanas gratuito', () {
      final json = {
        'id': '72',
        'plan': '2 SEMANAS GRATIS POR TRAER UN AMIGO',
        'foto': '_resources/_planes/ae1dc0907efbf5412adeacce1e5815c7.jpg',
        'tiempo': '14',
        'precio': '0',
        'estado': '2',
      };

      final plan = PlanModel.fromJson(json);

      expect(plan.esGratis, true);
      expect(plan.precioFormateado, 'GRATIS');
      expect(plan.tiempoFormateado, '2 Semanas (14 Días)');
      expect(
        plan.fullImageUrl,
        'https://vous.bossux.com/_resources/_planes/ae1dc0907efbf5412adeacce1e5815c7.jpg',
      );
    });

    test('Debe formatear planes anuales y semestrales', () {
      final planAnual = PlanModel(
        id: '15',
        plan: 'Anual',
        foto: '',
        tiempo: '12',
        precio: 1000.0,
        estado: '1',
      );

      expect(planAnual.tiempoFormateado, '1 Año (12 Meses)');
      expect(planAnual.precioFormateado, 'Bs. 1000');
      expect(planAnual.esActivo, true);
    });
  });
}
