import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

/// Vista de Configuración y Perfil de BOSSUX con estética Apple Liquid Glass.
class SettingsView extends StatefulWidget {
  final AuthController controller;
  final VoidCallback onLogout;

  const SettingsView({
    super.key,
    required this.controller,
    required this.onLogout,
  });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _healthSyncEnabled = true;
  bool _notificationsEnabled = true;
  bool _aiCameraHighPrecision = true;

  @override
  Widget build(BuildContext context) {
    final user = widget.controller.currentUser;
    final userName = user?.name ?? 'Alex Hunter';
    final userEmail = user?.email ?? 'demo@bossux.app';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Título
          const Text(
            'Settings & Perfil',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2.0),
          const Text(
            'Personalización y Preferencias de Atleta',
            style: TextStyle(
              fontSize: 13.0,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 20.0),

          // 2. Tarjeta de Perfil de Atleta Pro
          StaggeredEntrance(
            index: 0,
            child: _buildProfileCard(userName, userEmail),
          ),

          const SizedBox(height: 20.0),

          // 3. Metas Diarias
          StaggeredEntrance(
            index: 1,
            child: _buildDailyGoalsCard(),
          ),

          const SizedBox(height: 20.0),

          // 4. Conectividad y Sensores (Apple Health / Google Fit)
          StaggeredEntrance(
            index: 2,
            child: _buildIntegrationsCard(),
          ),

          const SizedBox(height: 20.0),

          // 5. Botón de Cierre de Sesión
          StaggeredEntrance(
            index: 3,
            child: PressableScale(
              onTap: widget.onLogout,
              child: Container(
                height: 52.0,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(26.0),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.35),
                  ),
                ),
                alignment: Alignment.center,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout_rounded, color: AppColors.error, size: 20.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16.0),

          // Versión de la App
          const Center(
            child: Text(
              'BOSSUX v1.0.0 • AI Fitness Engine',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 11.0,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tarjeta de Perfil del Usuario
  Widget _buildProfileCard(String name, String email) {
    return GlassContainer(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          // Avatar con borde Volt
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1E2638),
              border: Border.all(
                color: AppColors.primaryAccent,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryGlow,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 32.0,
              ),
            ),
          ),
          const SizedBox(width: 16.0),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Text(
                        'PRO',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Metas de Nutrición
  Widget _buildDailyGoalsCard() {
    return GlassContainer(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'METAS DE NUTRICIÓN',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 14.0),
          _buildGoalRow(
            icon: Icons.local_fire_department_rounded,
            iconColor: const Color(0xFFFF9800),
            title: 'Objetivo Calórico',
            value: '2,200 kcal/día',
          ),
          const Divider(color: AppColors.border, height: 20.0),
          _buildGoalRow(
            icon: Icons.fitness_center_rounded,
            iconColor: AppColors.macroProtein,
            title: 'Proteína Objetivo',
            value: '160 gramos',
          ),
          const Divider(color: AppColors.border, height: 20.0),
          _buildGoalRow(
            icon: Icons.water_drop_rounded,
            iconColor: AppColors.macroFat,
            title: 'Hidratación Diaria',
            value: '3.0 Litros',
          ),
        ],
      ),
    );
  }

  Widget _buildGoalRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20.0),
        const SizedBox(width: 12.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryAccent,
          ),
        ),
        const SizedBox(width: 4.0),
        const Icon(Icons.arrow_forward_ios_rounded, size: 12.0, color: AppColors.textMuted),
      ],
    );
  }

  /// Integraciones y Sensores
  Widget _buildIntegrationsCard() {
    return GlassContainer(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'INTEGRACIONES Y SENSORES',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12.0),
          _buildSwitchRow(
            icon: Icons.favorite_rounded,
            iconColor: const Color(0xFFFF5252),
            title: 'Apple Health / Google Fit',
            subtitle: 'Sincronizar pasos y quema pasiva',
            value: _healthSyncEnabled,
            onChanged: (v) => setState(() => _healthSyncEnabled = v),
          ),
          const Divider(color: AppColors.border, height: 20.0),
          _buildSwitchRow(
            icon: Icons.notifications_active_rounded,
            iconColor: AppColors.primaryAccent,
            title: 'Recordatorios de Comidas',
            subtitle: 'Alertas inteligentes para registrar platos',
            value: _notificationsEnabled,
            onChanged: (v) => setState(() => _notificationsEnabled = v),
          ),
          const Divider(color: AppColors.border, height: 20.0),
          _buildSwitchRow(
            icon: Icons.camera_alt_rounded,
            iconColor: AppColors.cyanAccent,
            title: 'Reconocimiento IA en HD',
            subtitle: 'Mayor precisión en detección de macros',
            value: _aiCameraHighPrecision,
            onChanged: (v) => setState(() => _aiCameraHighPrecision = v),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 22.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeThumbColor: AppColors.primaryAccent,
          activeTrackColor: AppColors.primaryAccent.withValues(alpha: 0.4),
          inactiveThumbColor: Colors.white60,
          inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
