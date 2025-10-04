import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import 'owner_bookings_screen.dart';
import 'owner_rentals_screen.dart';
import 'owner_profile_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryBlue900,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Content
              Expanded(
                child: _buildContent(),
              ),

              // Bottom Navigation
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(
              Icons.business_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, Proprietário!',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: AppTypography.bold,
                  ),
                ),
                Text(
                  'Gerencie seus barcos e alugueis',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Implementar notificações
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.3);
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return const OwnerBookingsScreen();
      case 2:
        return const OwnerRentalsScreen();
      case 3:
        return const OwnerProfileScreen();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Barcos Ativos',
                  value: '5',
                  icon: Icons.directions_boat_rounded,
                  color: AppColors.primaryBlue500,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildStatCard(
                  title: 'Alugueis Hoje',
                  value: '3',
                  icon: Icons.calendar_today_rounded,
                  color: AppColors.secondaryOrange500,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Receita Mensal',
                  value: 'R\$ 8.500',
                  icon: Icons.attach_money_rounded,
                  color: AppColors.success500,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildStatCard(
                  title: 'Avaliações',
                  value: '4.8',
                  icon: Icons.star_rounded,
                  color: AppColors.tertiaryGold500,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),

          const SizedBox(height: AppSpacing.xl),

          // Dashboard Button
          Container(
            width: double.infinity,
            child: AppButton(
              text: 'Ver Dashboard Completo',
              onPressed: () => Navigator.of(context).pushNamed('/owner-dashboard'),
              customChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Ver Dashboard Completo',
                    style: AppTypography.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 800.ms),

          const SizedBox(height: AppSpacing.xl),

          // Quick Actions
          Text(
            'Ações Rápidas',
            style: AppTypography.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: AppTypography.bold,
            ),
          ).animate().fadeIn(delay: 1000.ms),

          const SizedBox(height: AppSpacing.lg),

          _buildQuickActions().animate().fadeIn(delay: 1200.ms),

          const SizedBox(height: AppSpacing.xl),

          // Recent Bookings
          Text(
            'Alugueis Recentes',
            style: AppTypography.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: AppTypography.bold,
            ),
          ).animate().fadeIn(delay: 1200.ms),

          const SizedBox(height: AppSpacing.lg),

          _buildRecentBookings().animate().fadeIn(delay: 1400.ms),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: AppTypography.titleLarge.copyWith(
                fontWeight: AppTypography.bold,
                color: color,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              title,
              style: AppTypography.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Adicionar Barco',
                icon: Icons.add_business_rounded,
                color: AppColors.primaryBlue500,
                onTap: () {
                  // Implementar adicionar barco
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildActionCard(
                title: 'Ver Calendário',
                icon: Icons.calendar_month_rounded,
                color: AppColors.secondaryOrange500,
                onTap: () {
                  // Implementar calendário
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Preços Dinâmicos',
                icon: Icons.trending_up_rounded,
                color: AppColors.success500,
                onTap: () {
                  Navigator.of(context).pushNamed('/dynamic-pricing', arguments: {
                    'boatId': 'sample_boat_id',
                    'boatName': 'Meu Barco',
                  });
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildActionCard(
                title: 'Configurações',
                icon: Icons.settings_rounded,
                color: AppColors.neutral600,
                onTap: () {
                  // Implementar configurações
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: AppTypography.semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentBookings() {
    return Column(
      children: [
        _buildBookingCard(
          boatName: 'Lancha Azul',
          clientName: 'João Silva',
          date: '15/12/2024',
          status: 'Confirmado',
          statusColor: AppColors.success500,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildBookingCard(
          boatName: 'Iate Luxo',
          clientName: 'Maria Santos',
          date: '16/12/2024',
          status: 'Pendente',
          statusColor: AppColors.warning500,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildBookingCard(
          boatName: 'Jet Ski',
          clientName: 'Pedro Costa',
          date: '17/12/2024',
          status: 'Cancelado',
          statusColor: AppColors.error500,
        ),
      ],
    );
  }

  Widget _buildBookingCard({
    required String boatName,
    required String clientName,
    required String date,
    required String status,
    required Color statusColor,
  }) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: statusColor.withOpacity(0.1),
              child: Icon(
                Icons.directions_boat_rounded,
                color: statusColor,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    boatName,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: AppTypography.semiBold,
                    ),
                  ),
                  Text(
                    '$clientName • $date',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: Text(
                status,
                style: AppTypography.bodySmall.copyWith(
                  color: statusColor,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyBoats() {
    return const Center(
      child: Text(
        'Meus Barcos',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  Widget _buildProfile() {
    return const Center(
      child: Text(
        'Perfil',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.xl),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.dashboard_rounded, 'Dashboard'),
            _buildNavItem(1, Icons.directions_boat_rounded, 'Meus Barcos'),
            _buildNavItem(2, Icons.calendar_today_rounded, 'Alugueis'),
            _buildNavItem(3, Icons.person_rounded, 'Perfil'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.md),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                fontWeight:
                    isSelected ? AppTypography.semiBold : AppTypography.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
