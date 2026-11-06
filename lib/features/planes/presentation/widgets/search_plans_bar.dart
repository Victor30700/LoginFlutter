import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/pressable_scale.dart';

/// Barra de búsqueda reactiva BOSSUX.
/// Permite ingresar un código o nombre y ejecutar la búsqueda tanto
/// localmente como en el endpoint remoto `POST /appv/lproduc` (equivalente a `BuscarCodigo`).
class SearchPlansBar extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final VoidCallback onClear;
  final bool soloActivos;
  final VoidCallback onToggleSoloActivos;

  const SearchPlansBar({
    super.key,
    required this.onSearch,
    required this.onClear,
    required this.soloActivos,
    required this.onToggleSoloActivos,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: _hasText ? AppColors.primary : AppColors.border,
                width: _hasText ? 1.2 : 1.0,
              ),
              boxShadow: [
                if (_hasText)
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 12.0,
                  ),
              ],
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
                    onChanged: (val) {
                      // Búsqueda en vivo reactiva
                      widget.onSearch(val);
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar plan o código (ej: 74, mensual)...',
                      hintStyle: TextStyle(
                        color: AppColors.textMuted.withValues(alpha: 0.7),
                        fontSize: 13.5,
                      ),
                      border: InputBorder.none,
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
                // Botón "Buscar" (equivalente al trigger de BuscarCodigo)
                PressableScale(
                  onTap: _submit,
                  child: Container(
                    margin: const EdgeInsets.only(right: 6.0),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      'Buscar',
                      style: TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8.0),

          // Selector de filtro de planes activos
          Row(
            children: [
              PressableScale(
                onTap: widget.onToggleSoloActivos,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: widget.soloActivos
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: widget.soloActivos
                          ? AppColors.primary
                          : AppColors.border,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.soloActivos
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 13.0,
                        color: widget.soloActivos
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'Solo Activos',
                        style: TextStyle(
                          color: widget.soloActivos
                              ? AppColors.primary
                              : AppColors.textMuted,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'vous.bossux.com API',
                style: TextStyle(
                  color: AppColors.textMuted.withValues(alpha: 0.5),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
