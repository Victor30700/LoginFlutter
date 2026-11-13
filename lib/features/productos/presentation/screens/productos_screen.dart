import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../data/models/producto_model.dart';
import '../../data/repositories/http_productos_repository.dart';
import '../controllers/productos_controller.dart';
import '../widgets/producto_card.dart';

/// Pantalla de búsqueda y listado de Productos BOSSUX.
/// Se comunica con `POST https://vous.bossux.com/appv/lproduc` enviando `{"nombre": "<termino>"}`.
class ProductosScreen extends StatefulWidget {
  final ProductosController? controller;

  const ProductosScreen({super.key, this.controller});

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  late final ProductosController _controller;
  late final TextEditingController _searchController;
  bool _createdOwnController = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      final hasText = _searchController.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() => _hasText = hasText);
      }
    });

    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = ProductosController(repository: HttpProductosRepository());
      _createdOwnController = true;
    }

    _controller.addListener(_onControllerUpdate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.search('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.removeListener(_onControllerUpdate);
    if (_createdOwnController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  void _submitSearch() {
    FocusScope.of(context).unfocus();
    _controller.search(_searchController.text);
  }

  void _clearSearch() {
    _searchController.clear();
    _controller.clearSearch();
  }

  void _onSelectProducto(ProductoModel producto) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _buildProductoDetailModal(producto),
    );
  }

  Widget _buildProductoDetailModal(ProductoModel producto) {
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
                    Icons.shopping_bag_rounded,
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
                        producto.nombre,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (producto.id.isNotEmpty)
                        Text(
                          'Código #${producto.id}',
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
                    'Precio:',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    producto.precioFormateado,
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
                      'Producto seleccionado: ${producto.nombre}',
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
                    'Solicitar Producto',
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
        _buildHeader(),
        _buildSearchBar(),
        Expanded(
          child: RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.background,
            onRefresh: () => _controller.refresh(),
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
                  const Text(
                    'TIENDA OFICIAL',
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
                'Productos',
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
              '${_controller.productos.length} productos',
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
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
                    controller: _searchController,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _submitSearch(),
                    decoration: InputDecoration(
                      hintText: 'Buscar producto por nombre...',
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
                    onPressed: _clearSearch,
                  ),
                PressableScale(
                  onTap: _submitSearch,
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
          const SizedBox(height: 6.0),
          Row(
            children: [
              const Spacer(),
              Text(
                'vous.bossux.com/appv/lproduc',
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

  Widget _buildBody() {
    if (_controller.isLoading && _controller.productos.isEmpty) {
      return ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.only(bottom: 120.0),
        itemBuilder: (context, index) => _buildSkeletonCard(),
      );
    }

    if (_controller.status == ProductosStatus.error && _controller.productos.isEmpty) {
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
                onTap: () => _controller.refresh(),
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

    if (_controller.productos.isEmpty) {
      final hasQuery = _controller.currentQuery.isNotEmpty;
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 120.0),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                hasQuery ? Icons.search_off_rounded : Icons.inventory_2_outlined,
                color: AppColors.textMuted,
                size: 48.0,
              ),
              const SizedBox(height: 14.0),
              Text(
                hasQuery
                    ? 'Sin resultados para "${_controller.currentQuery}"'
                    : 'Explora los productos BOSSUX',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                hasQuery
                    ? 'Intenta buscar con otro nombre o limpia la búsqueda.'
                    : 'Ingresa el nombre de un producto arriba y pulsa "Buscar".',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.0,
                ),
              ),
              if (hasQuery) ...[
                const SizedBox(height: 16.0),
                PressableScale(
                  onTap: _clearSearch,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: AppColors.glassSurface,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Text(
                      'Limpiar búsqueda',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.only(bottom: 120.0, top: 4.0),
      itemCount: _controller.productos.length,
      itemBuilder: (context, index) {
        final producto = _controller.productos[index];
        return ProductoCard(
          producto: producto,
          onSelect: () => _onSelectProducto(producto),
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
