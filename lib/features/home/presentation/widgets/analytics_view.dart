import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/staggered_entrance.dart';

/// Vista de Analíticas y Progreso Fitness de BOSSUX con cristal translúcido Apple.
/// Inspirada en el gráfico semanal de calorías de img/gama_Colores y Apple Health.
class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Título y Selector de Periodo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Analytics',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'Rendimiento y Nutrición Semanal',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Esta Semana', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                    Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70, size: 16),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20.0),

          // 2. Gráfico de Barras Semanal de Calorías (Inspirado en img/gama_Colores)
          StaggeredEntrance(
            index: 0,
            child: _buildWeeklyCaloriesBarChart(),
          ),

          const SizedBox(height: 16.0),

          // 3. Grid de Métricas de Rendimiento (Pasos, Quema, Corazón, Sueño)
          StaggeredEntrance(
            index: 1,
            child: _buildHealthMetricsGrid(),
          ),

          const SizedBox(height: 16.0),

          // 4. Desglose y Balance de Macronutrientes
          StaggeredEntrance(
            index: 2,
            child: _buildMacrosBreakdownCard(),
          ),

          const SizedBox(height: 16.0),

          // 5. Progreso de Entrenamientos Semanales
          StaggeredEntrance(
            index: 3,
            child: _buildWorkoutPlanCard(),
          ),
        ],
      ),
    );
  }

  /// Gráfico de barras semanal con el día actual resaltado en Volt Lime
  Widget _buildWeeklyCaloriesBarChart() {
    final days = [
      {'day': 'SUN', 'value': 0.45, 'active': false},
      {'day': 'MON', 'value': 0.70, 'active': false},
      {'day': 'TUE', 'value': 0.95, 'active': true}, // Resaltado como en img/gama_Colores
      {'day': 'WED', 'value': 0.60, 'active': false},
      {'day': 'THU', 'value': 0.80, 'active': false},
      {'day': 'FRI', 'value': 0.50, 'active': false},
      {'day': 'SAT', 'value': 0.35, 'active': false},
    ];

    return GlassContainer(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CALORIES',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '2,140 kcal',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'WEEKLY AVERAGE',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(Icons.arrow_upward_rounded, color: AppColors.primaryAccent, size: 14),
                      Text(
                        '102 CAL',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24.0),

          // Barras
          SizedBox(
            height: 120.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: days.map((item) {
                final isHighlight = item['active'] as bool;
                final barHeight = (item['value'] as double) * 90.0;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 28.0,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: isHighlight
                            ? AppColors.primaryAccent
                            : Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: isHighlight
                            ? [
                                BoxShadow(
                                  color: AppColors.primaryGlow,
                                  blurRadius: 12.0,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      item['day'] as String,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: isHighlight ? FontWeight.w800 : FontWeight.w600,
                        color: isHighlight ? AppColors.primaryAccent : AppColors.textMuted,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 4 Tarjetas de métricas fisiológicas
  Widget _buildHealthMetricsGrid() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _buildMiniMetric(
                icon: Icons.directions_walk_rounded,
                iconColor: AppColors.primaryAccent,
                value: '6,359',
                label: 'STEPS',
              ),
              const SizedBox(height: 10.0),
              _buildMiniMetric(
                icon: Icons.favorite_rounded,
                iconColor: const Color(0xFFFF5252),
                value: '123 BPM',
                label: 'HEARTBEAT',
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            children: [
              _buildMiniMetric(
                icon: Icons.local_fire_department_rounded,
                iconColor: const Color(0xFFFF9800),
                value: '3,115 KCAL',
                label: 'CAL BURN',
              ),
              const SizedBox(height: 10.0),
              _buildMiniMetric(
                icon: Icons.bedtime_rounded,
                iconColor: AppColors.cyanAccent,
                value: '7h 45m',
                label: 'SLEEP',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMiniMetric({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return GlassContainer(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: iconColor, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Desglose de Macronutrientes
  Widget _buildMacrosBreakdownCard() {
    return GlassContainer(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BALANCE NUTRICIONAL',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildMacroProgressBar(
            label: 'Proteína',
            current: '142g',
            target: '160g',
            percentage: 0.88,
            color: AppColors.macroProtein,
          ),
          const SizedBox(height: 12.0),
          _buildMacroProgressBar(
            label: 'Carbohidratos',
            current: '195g',
            target: '220g',
            percentage: 0.88,
            color: AppColors.macroCarbs,
          ),
          const SizedBox(height: 12.0),
          _buildMacroProgressBar(
            label: 'Grasas Saludables',
            current: '52g',
            target: '60g',
            percentage: 0.86,
            color: AppColors.macroFat,
          ),
        ],
      ),
    );
  }

  Widget _buildMacroProgressBar({
    required String label,
    required String current,
    required String target,
    required double percentage,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              '$current / $target',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 7.0,
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  /// Tarjeta de plan de entrenamiento personalizado
  Widget _buildWorkoutPlanCard() {
    return GlassContainer(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColors.primaryAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppColors.primaryAccent.withValues(alpha: 0.4)),
            ),
            child: const Icon(
              Icons.fitness_center_rounded,
              color: AppColors.primaryAccent,
              size: 26.0,
            ),
          ),
          const SizedBox(width: 14.0),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CHEST WORKOUT',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  '45 Min • Hipertrofia • 5 Ejercicios',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'Hoy',
              style: TextStyle(
                color: AppColors.primaryAccent,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
