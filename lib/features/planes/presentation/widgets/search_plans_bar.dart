import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../controllers/planes_controller.dart';

/// Barra de búsqueda reactiva y selector de categoría estilo VOUS / BOSSUX.
class SearchPlansBar extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final VoidCallback onClear;
  final bool soloActivos;
  final VoidCallback onToggleSoloActivos;
  final PlanCategoryFilter categoryFilter;
  final ValueChanged<PlanCategoryFilter> onCategoryChanged;

  const SearchPlansBar({
    super.key,
    required this.onSearch,
    required this.onClear,
    required this.soloActivos,
    required this.onToggleSoloActivos,
    this.categoryFilter = PlanCategoryFilter.todos,
    required this.onCategoryChanged,
  });

  @override
  State<SearchPlansBar> createState() => _SearchPlansBarState();
}

class _SearchPlansBarState extends State<SearchPlansBar> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() => _hasText = hasText);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    widget.onSearch(_controller.text);
  }

  void _clear() {
    _controller.clear();
    widget.onClear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Column(
        children: [
          // 1. Campo de búsqueda
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.055),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: _hasText
                    ? AppColors.primary.withValues(alpha: 0.70)
                    : Colors.white.withValues(alpha: 0.10),
                width: _hasText ? 1.1 : 0.9,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 14.0),
                const Icon(
                  Icons.search_rounded,
                  color: AppColors.textSecondary,
                  size: 20.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _submit(),
                    onChanged: (val) => widget.onSearch(val),
                    decoration: InputDecoration(
                      hintText: 'Buscar plan (ej: mensual)...',
                      hintStyle: TextStyle(
                        color: AppColors.textMuted.withValues(alpha: 0.7),
                        fontSize: 13.5,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
                ),
                if (_hasText)
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 18.0,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: _clear,
                  ),
                PressableScale(
                  onTap: _submit,
                  child: Container(
                    margin: const EdgeInsets.only(right: 6.0),
                    padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.primary, Color(0xFF0066D6)],
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.16),
                        width: 0.7,
                      ),
                    ),
                    child: const Text(
                      'Buscar',
                      style: TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10.0),

          // 2. UISegmentedControl oscuro estilo iOS ("Todos | Paquetes | Convenios") + Activos
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.055),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.09),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildSegment(
                        label: 'Todos',
                        selected: widget.categoryFilter == PlanCategoryFilter.todos,
                        onTap: () => widget.onCategoryChanged(PlanCategoryFilter.todos),
                      ),
                      _buildSegment(
                        label: 'Paquetes',
                        selected: widget.categoryFilter == PlanCategoryFilter.paquetes,
                        onTap: () => widget.onCategoryChanged(PlanCategoryFilter.paquetes),
                      ),
                      _buildSegment(
                        label: 'Convenios',
                        selected: widget.categoryFilter == PlanCategoryFilter.convenios,
                        onTap: () => widget.onCategoryChanged(PlanCategoryFilter.convenios),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              PressableScale(
                onTap: widget.onToggleSoloActivos,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.5),
                  decoration: BoxDecoration(
                    color: widget.soloActivos
                        ? AppColors.primary.withValues(alpha: 0.14)
                        : Colors.white.withValues(alpha: 0.055),
                    borderRadius: BorderRadius.circular(11.0),
                    border: Border.all(
                      color: widget.soloActivos
                          ? AppColors.primary.withValues(alpha: 0.45)
                          : Colors.white.withValues(alpha: 0.09),
                      width: 0.9,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.soloActivos
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 13.5,
                        color: widget.soloActivos
                            ? AppColors.primaryAccent
                            : AppColors.textMuted,
                      ),
                      const SizedBox(width: 4.5),
                      Text(
                        'Activos',
                        style: TextStyle(
                          color: widget.soloActivos
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSegment({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 6.5),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF262B38)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(9.5),
            border: selected
                ? Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 0.8,
                  )
                : null,
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.28),
                      blurRadius: 6.0,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selected ? AppColors.textPrimary : AppColors.textSecondary,
              fontSize: 12.0,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ),
    );
  }
}
