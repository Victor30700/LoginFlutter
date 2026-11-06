import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../data/models/plan_model.dart';
import '../../data/repositories/http_planes_repository.dart';
import '../controllers/planes_controller.dart';
import '../widgets/plan_card.dart';
import '../widgets/search_plans_bar.dart';

/// Pantalla principal del catálogo de Planes y Membresías BOSSUX.
/// Permite explorar, filtrar por planes activos y buscar por código o nombre
/// en comunicación directa con `https://vous.bossux.com/`.
class PlanesScreen extends StatefulWidget {
  final PlanesController? controller;

  const PlanesScreen({super.key, this.controller});

  @override
  State<PlanesScreen> createState() => _PlanesScreenState();
}

class _PlanesScreenState extends State<PlanesScreen> {
  late final PlanesController _controller;
  bool _createdOwnController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = PlanesController(repository: HttpPlanesRepository());
      _createdOwnController = true;
    }

    _controller.addListener(_onControllerUpdate);
    // Carga inicial de planes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchPlanes();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    if (_createdOwnController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  void _onSelectPlan(PlanModel plan) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _buildPlanDetailModal(plan),
    );
  }

  Widget _buildPlanDetailModal(PlanModel plan) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28.0)),
        border: Border.all(color: AppColors.border, width: 1.0),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppColors.textMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: 18.0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    color: AppColors.primary,
                    size: 22.0,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.nombre,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Código #${plan.id} • ${plan.tiempoFormateado}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.glassSurface,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total a Pagar:',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    plan.precioFormateado,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            PressableScale(
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    content: Text(
                      '¡Seleccionaste: ${plan.nombre}!',
                      style: const TextStyle(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Center(
                  child: Text(
                    'Confirmar Inscripción',
                    style: TextStyle(
                      color: AppColors.textOnPrimary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cabecera superior integrada
        _buildHeader(),

        // Barra de búsqueda y filtros
        SearchPlansBar(
          soloActivos: _controller.soloActivos,
          onToggleSoloActivos: _controller.toggleSoloActivos,
          onSearch: (q) => _controller.search(q),
          onClear: () => _controller.clearSearch(),
        ),

        // Cuerpo dinámico de la lista
        Expanded(
          child: RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.background,
            onRefresh: () => _controller.fetchPlanes(forceRefresh: true),
            child: _buildBody(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    'CATÁLOGO OFICIAL',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2.0),
              const Text(
                'Membresías & Planes',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              '${_controller.planes.length} planes',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_controller.isLoading && _controller.planes.isEmpty) {
      return ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.only(bottom: 120.0),
        itemBuilder: (context, index) => _buildSkeletonCard(),
      );
    }

    if (_controller.status == PlanesStatus.error && _controller.planes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                color: AppColors.macroProtein,
                size: 48.0,
              ),
              const SizedBox(height: 12.0),
              const Text(
                'No se pudo conectar al servidor',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                _controller.errorMessage ?? 'Verifica tu conexión a internet.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 16.0),
              PressableScale(
                onTap: () => _controller.fetchPlanes(forceRefresh: true),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text(
                    'Reintentar',
                    style: TextStyle(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_controller.planes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.search_off_rounded,
                color: AppColors.textMuted,
                size: 46.0,
              ),
              const SizedBox(height: 12.0),
              Text(
                'Sin resultados para "${_controller.currentQuery}"',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Intenta con otro término o limpia la búsqueda.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 16.0),
              PressableScale(
                onTap: () => _controller.clearSearch(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.glassSurface,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Text(
                    'Ver todos los planes',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.only(bottom: 120.0, top: 4.0),
      itemCount: _controller.planes.length,
      itemBuilder: (context, index) {
        final plan = _controller.planes[index];
        return PlanCard(
          plan: plan,
          onSelect: () => _onSelectPlan(plan),
        );
      },
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 260.0,
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Center(
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primary.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
