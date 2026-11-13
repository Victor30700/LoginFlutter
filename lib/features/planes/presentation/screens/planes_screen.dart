import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../data/models/plan_model.dart';
import '../../data/repositories/http_planes_repository.dart';
import '../controllers/planes_controller.dart';
import '../widgets/plan_card.dart';
import '../widgets/search_plans_bar.dart';

/// Pantalla principal del catálogo de Planes y Membresías BOSSUX.
/// Inspirada en el flujo de selección VOUS: tarjetas horizontales compactas,
/// selector de categoría y botón flotante de continuación.
class PlanesScreen extends StatefulWidget {
  final PlanesController? controller;

  const PlanesScreen({super.key, this.controller});

  @override
  State<PlanesScreen> createState() => _PlanesScreenState();
}

class _PlanesScreenState extends State<PlanesScreen> {
  late final PlanesController _controller;
  bool _createdOwnController = false;
  String? _selectedPlanId;

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

  PlanModel? get _selectedPlan {
    if (_selectedPlanId == null) return null;
    for (final plan in _controller.planes) {
      if (plan.id == _selectedPlanId) return plan;
    }
    return null;
  }

  void _onTapPlan(PlanModel plan) {
    if (_selectedPlanId == plan.id) {
      _openPlanModal(plan);
      return;
    }
    setState(() {
      _selectedPlanId = plan.id;
    });
  }

  void _openPlanModal(PlanModel plan) {
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
                  width: 56.0,
                  height: 56.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF06080D),
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: plan.fullImageUrl.isNotEmpty
                      ? Image.network(
                          plan.fullImageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.bolt_rounded,
                            color: AppColors.primary,
                          ),
                        )
                      : const Icon(Icons.bolt_rounded, color: AppColors.primary),
                ),
                const SizedBox(width: 14.0),
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
                      const SizedBox(height: 2.0),
                      Text(
                        'Tiempo: ${plan.tiempoFormateado} • Horario: ${plan.horarioEtiqueta}',
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
                    plan.precioCompacto,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                      fontFeatures: [FontFeature.tabularFigures()],
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
                    backgroundColor: const Color(0xFF1C202B),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.14)),
                    ),
                    content: Text(
                      '¡Seleccionaste: ${plan.nombre}!',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primary, Color(0xFF0066D6)],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                    width: 0.8,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Confirmar Inscripción',
                    style: TextStyle(
                      color: AppColors.textOnPrimary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
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
    final selectedPlan = _selectedPlan;

    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(),
            SearchPlansBar(
              soloActivos: _controller.soloActivos,
              onToggleSoloActivos: _controller.toggleSoloActivos,
              categoryFilter: _controller.categoryFilter,
              onCategoryChanged: _controller.setCategoryFilter,
              onSearch: (q) => _controller.search(q),
              onClear: () => _controller.clearSearch(),
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.background,
                onRefresh: () => _controller.fetchPlanes(forceRefresh: true),
                child: _buildBody(),
              ),
            ),
          ],
        ),

        // Dock flotante Apple Liquid Glass cuando hay un plan seleccionado
        if (selectedPlan != null)
          Positioned(
            left: 18.0,
            right: 18.0,
            bottom: 106.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(18.0, 11.0, 10.0, 11.0),
                  decoration: BoxDecoration(
                    color: const Color(0xD8151923),
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.16),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.45),
                        blurRadius: 24.0,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'PLAN SELECCIONADO',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 1.5),
                            Text(
                              '${selectedPlan.nombre} • ${selectedPlan.precioCompacto}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                                fontFeatures: [FontFeature.tabularFigures()],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      PressableScale(
                        onTap: () => _openPlanModal(selectedPlan),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.5,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [AppColors.primary, Color(0xFF0066D6)],
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.18),
                              width: 0.8,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Continuar',
                                style: TextStyle(
                                  color: AppColors.textOnPrimary,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.1,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: AppColors.textOnPrimary,
                                size: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    width: 6.5,
                    height: 6.5,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  const Text(
                    'VOUS • BOSSUX',
                    style: TextStyle(
                      color: AppColors.primaryAccent,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.9,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2.0),
              const Text(
                'Elige un Plan',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
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
        padding: const EdgeInsets.only(bottom: 140.0),
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
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 140.0),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.search_off_rounded,
                color: AppColors.textMuted,
                size: 46.0,
              ),
              const SizedBox(height: 12.0),
              Text(
                _controller.currentQuery.isNotEmpty
                    ? 'Sin resultados para "${_controller.currentQuery}"'
                    : 'No hay planes en esta categoría',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Intenta cambiar el filtro o limpiar la búsqueda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 16.0),
              PressableScale(
                onTap: () {
                  _controller.setCategoryFilter(PlanCategoryFilter.todos);
                  _controller.clearSearch();
                },
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
        ],
      );
    }

    final bottomPadding = _selectedPlan != null ? 180.0 : 120.0;

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.only(bottom: bottomPadding, top: 6.0),
      itemCount: _controller.planes.length,
      itemBuilder: (context, index) {
        final plan = _controller.planes[index];
        return PlanCard(
          plan: plan,
          isSelected: plan.id == _selectedPlanId,
          onSelect: () => _onTapPlan(plan),
        );
      },
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
      height: 124.0,
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(22.0),
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
