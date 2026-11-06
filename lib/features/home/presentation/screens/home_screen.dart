import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/apple_ambient_background.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/controllers/auth_controller_scope.dart';
import '../widgets/analytics_view.dart';
import '../widgets/floating_bottom_nav_bar.dart';
import '../widgets/settings_view.dart';
import '../../../planes/presentation/screens/planes_screen.dart';

/// Pantalla Home Principal de BOSSUX con estética Apple Liquid Glass (VisionOS).
/// Gestiona la navegación fluida entre Home, Analytics y Settings mediante el Dock flotante.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  int _selectedDayIndex = 5; // Día actual seleccionado (S 26)

  final List<Map<String, dynamic>> _weekDays = [
    {'day': 'T', 'date': '21'},
    {'day': 'W', 'date': '22'},
    {'day': 'T', 'date': '23'},
    {'day': 'F', 'date': '24'},
    {'day': 'S', 'date': '25'},
    {'day': 'S', 'date': '26'},
    {'day': 'M', 'date': '27'},
  ];

  final List<Map<String, dynamic>> _recentMeals = [
    {
      'title': 'Potato Wedges',
      'time': '21:25',
      'calories': 900,
      'protein': '12g',
      'carbs': '120g',
      'fat': '12g',
      'icon': Icons.bakery_dining_rounded,
    },
    {
      'title': 'Fish with Greens',
      'time': '21:25',
      'calories': 450,
      'protein': '40g',
      'carbs': '15g',
      'fat': '20g',
      'icon': Icons.set_meal_rounded,
    },
    {
      'title': 'Shrimp Bowl with Avocado',
      'time': '21:25',
      'calories': 150,
      'protein': '24g',
      'carbs': '8g',
      'fat': '4g',
      'icon': Icons.ramen_dining_rounded,
    },
  ];

  Future<void> _handleLogout(BuildContext context, AuthController controller) async {
    final nav = Navigator.of(context);
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF161B26),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.18)),
        ),
        title: const Text(
          '¿Cerrar sesión?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Tendrás que volver a ingresar tus credenciales para acceder a tus métricas en BOSSUX.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar', style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && mounted) {
      await controller.logout();
      if (mounted) {
        nav.pushNamedAndRemoveUntil(
          AppRoutes.welcome,
          (route) => false,
        );
      }
    }
  }

  void _showQuickAddModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141924),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Registrar Comida o Ejercicio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt_rounded, color: AppColors.primaryAccent),
                  ),
                  title: const Text('Escanear con Cámara IA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  subtitle: const Text('Detecta calorías y macros automáticamente', style: TextStyle(color: AppColors.textSecondary)),
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cámara IA lista para escanear comida.')),
                    );
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.cyanAccent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.fitness_center_rounded, color: AppColors.cyanAccent),
                  ),
                  title: const Text('Registrar Entrenamiento', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  subtitle: const Text('Hipertrofia, cardio o pesas', style: TextStyle(color: AppColors.textSecondary)),
                  onTap: () => Navigator.pop(ctx),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = AuthControllerScope.of(context);
    final user = controller.currentUser;
    final userName = user?.name ?? 'Alex';

    return AppleAmbientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              // Contenido según la pestaña activa
              IndexedStack(
                index: _currentTabIndex,
                children: [
                  _buildHomeDashboard(userName, controller),
                  const AnalyticsView(),
                  const PlanesScreen(),
                  SettingsView(
                    controller: controller,
                    onLogout: () => _handleLogout(context, controller),
                  ),
                ],
              ),

              // Barra de navegación inferior flotante
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: FloatingBottomNavBar(
                  currentIndex: _currentTabIndex,
                  onTabSelected: (idx) {
                    setState(() {
                      _currentTabIndex = idx;
                    });
                  },
                  onQuickAdd: _showQuickAddModal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dashboard principal (Home)
  Widget _buildHomeDashboard(String userName, AuthController controller) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Header superior
          _buildTopHeader(userName, controller),

          const SizedBox(height: 20.0),

          // 2. Selector de días de la semana (Calendario horizontal)
          _buildWeeklyCalendarStrip(),

          const SizedBox(height: 20.0),

          // 3. Tarjeta Bento Principal: Contador de Calorías
          _buildCaloriesMainCard(),

          const SizedBox(height: 16.0),

          // 4. Trío Bento de Macros: Proteína, Carbos, Grasas
          _buildMacrosBentoRow(),

          const SizedBox(height: 28.0),

          // 5. Encabezado de sección "Recently logged"
          const Text(
            AppStrings.recentlyLogged,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.4,
            ),
          ),

          const SizedBox(height: 14.0),

          // 6. Lista de Comidas Registradas
          ..._recentMeals.asMap().entries.map((entry) {
            final index = entry.key;
            final meal = entry.value;
            return StaggeredEntrance(
              index: index,
              child: _buildMealCard(meal),
            );
          }),
        ],
      ),
    );
  }

  /// Barra superior con el nombre BOSSUX, racha de fuego y logout
  Widget _buildTopHeader(String userName, AuthController controller) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF161B26),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: const Center(
            child: Text(
              'B',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'BOSSUX',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const Spacer(),

        // Píldora de Racha Diaria (🔥 1)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: AppColors.caloriesBurn.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🔥', style: TextStyle(fontSize: 15)),
              SizedBox(width: 4),
              Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        IconButton(
          tooltip: 'Cerrar sesión',
          icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondary, size: 22),
          onPressed: () => _handleLogout(context, controller),
        ),
      ],
    );
  }

  /// Franja horizontal de días de la semana interactiva
  Widget _buildWeeklyCalendarStrip() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_weekDays.length, (idx) {
          final item = _weekDays[idx];
          final isSelected = _selectedDayIndex == idx;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = idx;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryAccent : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item['day'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.black : Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    item['date'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Tarjeta principal Bento de Calorías
  Widget _buildCaloriesMainCard() {
    return GlassContainer(
      padding: const EdgeInsets.all(22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1121',
                style: TextStyle(
                  fontSize: 44.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -1.0,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 6.0),
              Row(
                children: [
                  Text(
                    'Calories over',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  const Icon(
                    Icons.trending_up_rounded,
                    color: AppColors.primaryAccent,
                    size: 18.0,
                  ),
                ],
              ),
            ],
          ),

          // Anillo Circular de progreso
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 72.0,
                height: 72.0,
                child: CircularProgressIndicator(
                  value: 0.72,
                  strokeWidth: 7.0,
                  backgroundColor: Colors.white.withValues(alpha: 0.12),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryAccent),
                ),
              ),
              const Icon(
                Icons.local_fire_department_rounded,
                color: AppColors.primaryAccent,
                size: 28.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Trío Bento de Macros
  Widget _buildMacrosBentoRow() {
    return Row(
      children: [
        Expanded(
          child: _buildMacroCard(
            amount: '6g',
            label: 'Protein left',
            progress: 0.35,
            color: AppColors.macroProtein,
            icon: Icons.fitness_center_rounded,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _buildMacroCard(
            amount: '23g',
            label: 'Carbs left',
            progress: 0.60,
            color: AppColors.macroCarbs,
            icon: Icons.grain_rounded,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _buildMacroCard(
            amount: '69g',
            label: 'Fat over',
            progress: 0.85,
            color: AppColors.macroFat,
            icon: Icons.water_drop_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildMacroCard({
    required String amount,
    required String label,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      child: Column(
        children: [
          Text(
            amount,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12.0),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 44.0,
                height: 44.0,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 4.5,
                  backgroundColor: Colors.white.withValues(alpha: 0.10),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Icon(icon, color: color, size: 18.0),
            ],
          ),
        ],
      ),
    );
  }

  /// Tarjeta de comida en "Recently logged"
  Widget _buildMealCard(Map<String, dynamic> meal) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Icon(
              meal['icon'] as IconData,
              color: AppColors.primaryAccent,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 14.0),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      meal['title'] as String,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      meal['time'] as String,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department_rounded, size: 14.0, color: AppColors.caloriesBurn),
                    const SizedBox(width: 2.0),
                    Text(
                      '${meal['calories']} kcal',
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      'P: ${meal['protein']} • C: ${meal['carbs']} • G: ${meal['fat']}',
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
