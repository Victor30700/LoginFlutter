import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_flutter/features/planes/data/models/plan_model.dart';
import 'package:login_flutter/features/planes/data/repositories/planes_repository.dart';
import 'package:login_flutter/features/planes/presentation/controllers/planes_controller.dart';
import 'package:login_flutter/features/planes/presentation/widgets/plan_card.dart';
import 'package:login_flutter/features/planes/presentation/widgets/search_plans_bar.dart';

class _FakePlanesRepository implements PlanesRepository {
  _FakePlanesRepository(this.items);

  final List<PlanModel> items;

  @override
  Future<List<PlanModel>> getPlanes() async => items;

  @override
  Future<List<PlanModel>> searchProductos(String query) async => items
      .where((p) => p.nombre.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

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

    test('Debe exponer horario, tipoEtiqueta, esConvenio y precioCompacto', () {
      final normalPlan = PlanModel.fromJson({
        'id': '2',
        'plan': 'Mensual',
        'foto': '_resources/_planes/test.png',
        'tiempo': '1',
        'precio': '300',
        'estado': '1',
        'tipo': '1',
        'h': '1',
      });

      expect(normalPlan.horario, '1');
      expect(normalPlan.horarioEtiqueta, '24 horas');
      expect(normalPlan.tipoEtiqueta, 'Normal');
      expect(normalPlan.esConvenio, false);
      expect(normalPlan.precioCompacto, '300 Bs.-');

      final convenioPlan = PlanModel.fromJson({
        'id': '3',
        'plan': 'Convenio Empresa',
        'foto': '',
        'tiempo': '1',
        'precio': '200',
        'estado': '1',
        'tipo': '2',
        'h': '08:00 - 18:00',
      });

      expect(convenioPlan.esConvenio, true);
      expect(convenioPlan.tipoEtiqueta, 'Convenio');
      expect(convenioPlan.horarioEtiqueta, '08:00 - 18:00');
    });
  });

  group('PlanesController - Filtro por categoría VOUS', () {
    test('setCategoryFilter filtra Todos, Paquetes y Convenios', () async {
      final repo = _FakePlanesRepository([
        PlanModel(
          id: '1',
          plan: 'Plan Mensual',
          foto: '',
          tiempo: '1',
          precio: 300,
          estado: '1',
          tipo: '1',
        ),
        PlanModel(
          id: '2',
          plan: 'Convenio Corporativo',
          foto: '',
          tiempo: '1',
          precio: 220,
          estado: '1',
          tipo: '2',
        ),
      ]);

      final controller = PlanesController(repository: repo);
      await controller.fetchPlanes();

      expect(controller.categoryFilter, PlanCategoryFilter.todos);
      expect(controller.planes.length, 2);

      controller.setCategoryFilter(PlanCategoryFilter.paquetes);
      expect(controller.planes.length, 1);
      expect(controller.planes.first.id, '1');

      controller.setCategoryFilter(PlanCategoryFilter.convenios);
      expect(controller.planes.length, 1);
      expect(controller.planes.first.id, '2');

      controller.setCategoryFilter(PlanCategoryFilter.todos);
      expect(controller.planes.length, 2);
    });
  });

  group('PlanCard & SearchPlansBar - Rediseño VOUS', () {
    testWidgets('PlanCard muestra formato compacto y estado seleccionado', (
      WidgetTester tester,
    ) async {
      final plan = PlanModel(
        id: '1',
        plan: 'PLAN MENSUAL',
        foto: '',
        tiempo: '1',
        precio: 2500,
        estado: '1',
        tipo: '1',
        horario: '1',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlanCard(
              plan: plan,
              isSelected: true,
              onSelect: () {},
            ),
          ),
        ),
      );

      expect(find.text('PLAN MENSUAL'), findsOneWidget);
      expect(find.text('2500 Bs.-'), findsOneWidget);
      expect(find.text('Normal'), findsOneWidget);
      expect(find.text('Tiempo: 1 Mes'), findsOneWidget);
      expect(find.text('Horario: 24 horas'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });

    testWidgets('SearchPlansBar muestra Todos, Paquetes y Convenios', (
      WidgetTester tester,
    ) async {
      PlanCategoryFilter selected = PlanCategoryFilter.todos;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return SearchPlansBar(
                  onSearch: (_) {},
                  onClear: () {},
                  soloActivos: false,
                  onToggleSoloActivos: () {},
                  categoryFilter: selected,
                  onCategoryChanged: (val) => setState(() => selected = val),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Todos'), findsOneWidget);
      expect(find.text('Paquetes'), findsOneWidget);
      expect(find.text('Convenios'), findsOneWidget);

      await tester.tap(find.text('Convenios'));
      await tester.pump();

      expect(selected, PlanCategoryFilter.convenios);
    });
  });
}
