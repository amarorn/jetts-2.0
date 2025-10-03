import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../domain/models/performance_model.dart';

class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  late PerformanceMetrics _metrics;
  late List<BoatPerformance> _boatPerformances;
  late List<RecentActivity> _recentActivities;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    _metrics = PerformanceMetrics(
      totalRevenue: 45680.50,
      monthlyRevenue: 8950.00,
      totalBookings: 127,
      monthlyBookings: 18,
      occupancyRate: 0.72,
      averageRating: 4.8,
      totalReviews: 89,
      profileViews: 2340,
      monthlyViews: 456,
      revenueHistory: [
        MonthlyData(month: 'Jan', value: 6500, date: DateTime(2024, 1)),
        MonthlyData(month: 'Fev', value: 7200, date: DateTime(2024, 2)),
        MonthlyData(month: 'Mar', value: 8950, date: DateTime(2024, 3)),
      ],
      bookingHistory: [
        MonthlyData(month: 'Jan', value: 12, date: DateTime(2024, 1)),
        MonthlyData(month: 'Fev', value: 15, date: DateTime(2024, 2)),
        MonthlyData(month: 'Mar', value: 18, date: DateTime(2024, 3)),
      ],
    );

    _boatPerformances = [
      BoatPerformance(
        boatId: '1',
        boatName: 'Iate Luxo',
        revenue: 25600.00,
        bookings: 45,
        rating: 4.9,
        views: 1200,
        occupancyRate: 0.85,
      ),
      BoatPerformance(
        boatId: '2',
        boatName: 'Lancha Rápida',
        revenue: 20080.50,
        bookings: 82,
        rating: 4.7,
        views: 1140,
        occupancyRate: 0.68,
      ),
    ];

    _recentActivities = [
      RecentActivity(
        id: '1',
        type: ActivityType.newBooking,
        title: 'Nova reserva',
        description: 'João Silva reservou o Iate Luxo',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        boatName: 'Iate Luxo',
        amount: 1500.00,
      ),
      RecentActivity(
        id: '2',
        type: ActivityType.paymentReceived,
        title: 'Pagamento recebido',
        description: 'Pagamento de R\$ 2.400,00 processado',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        amount: 2400.00,
      ),
      RecentActivity(
        id: '3',
        type: ActivityType.reviewReceived,
        title: 'Nova avaliação',
        description: 'Maria deu 5 estrelas para Lancha Rápida',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        boatName: 'Lancha Rápida',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildMetricsOverview(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildRevenueChart(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildBoatPerformance(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildRecentActivity(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, Proprietário!',
                  style: AppTypography.headlineSmall.copyWith(
                    color: Colors.white,
                    fontWeight: AppTypography.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Aqui está o resumo do seu negócio',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: const Icon(
              Icons.dashboard_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildMetricsOverview(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visão Geral',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.5,
          children: [
            _buildMetricCard(
              theme,
              'Receita Total',
              'R\$ ${_metrics.totalRevenue.toStringAsFixed(2)}',
              Icons.attach_money_rounded,
              AppColors.success500,
              '+${_metrics.revenueGrowthRate.toStringAsFixed(1)}%',
            ),
            _buildMetricCard(
              theme,
              'Reservas',
              '${_metrics.totalBookings}',
              Icons.calendar_today_rounded,
              AppColors.primaryBlue500,
              '+${_metrics.bookingGrowthRate.toStringAsFixed(1)}%',
            ),
            _buildMetricCard(
              theme,
              'Taxa de Ocupação',
              '${(_metrics.occupancyRate * 100).toStringAsFixed(0)}%',
              Icons.trending_up_rounded,
              AppColors.secondaryOrange500,
              null,
            ),
            _buildMetricCard(
              theme,
              'Avaliação Média',
              '${_metrics.averageRating}',
              Icons.star_rounded,
              AppColors.tertiaryGold500,
              '${_metrics.totalReviews} avaliações',
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildMetricCard(
    ThemeData theme,
    String title,
    String value,
    IconData icon,
    Color color,
    String? subtitle,
  ) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.bodySmall.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 16,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: AppTypography.headlineSmall.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: AppTypography.bold,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: AppTypography.labelSmall.copyWith(
                  color: subtitle.startsWith('+')
                      ? AppColors.success500
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Receita dos Últimos Meses',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GlassCard(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Este mês',
                      style: AppTypography.titleMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                    Text(
                      'R\$ ${_metrics.monthlyRevenue.toStringAsFixed(2)}',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.success500,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                // Aqui seria implementado um gráfico real
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bar_chart_rounded,
                          size: 40,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Gráfico de receita',
                          style: AppTypography.bodyMedium.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildBoatPerformance(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance dos Barcos',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _boatPerformances.length,
          itemBuilder: (context, index) {
            final boat = _boatPerformances[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            boat.boatName,
                            style: AppTypography.titleMedium.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: AppTypography.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success500.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppRadius.full),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 14,
                                  color: AppColors.success500,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  boat.rating.toString(),
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.success500,
                                    fontWeight: AppTypography.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: _buildBoatMetric(
                              theme,
                              'Receita',
                              'R\$ ${boat.revenue.toStringAsFixed(2)}',
                            ),
                          ),
                          Expanded(
                            child: _buildBoatMetric(
                              theme,
                              'Reservas',
                              '${boat.bookings}',
                            ),
                          ),
                          Expanded(
                            child: _buildBoatMetric(
                              theme,
                              'Ocupação',
                              '${(boat.occupancyRate * 100).toStringAsFixed(0)}%',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildBoatMetric(ThemeData theme, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: AppTypography.titleSmall.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.semiBold,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Atividade Recente',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentActivities.length,
          itemBuilder: (context, index) {
            final activity = _recentActivities[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getActivityColor(activity.type).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(
                        _getActivityIcon(activity.type),
                        color: _getActivityColor(activity.type),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.title,
                            style: AppTypography.titleSmall.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: AppTypography.semiBold,
                            ),
                          ),
                          Text(
                            activity.description,
                            style: AppTypography.bodySmall.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _formatTimestamp(activity.timestamp),
                      style: AppTypography.labelSmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ).animate().fadeIn(delay: 800.ms);
  }

  Color _getActivityColor(ActivityType type) {
    switch (type) {
      case ActivityType.newBooking:
        return AppColors.primaryBlue500;
      case ActivityType.paymentReceived:
        return AppColors.success500;
      case ActivityType.reviewReceived:
        return AppColors.tertiaryGold500;
      case ActivityType.profileView:
        return AppColors.secondaryOrange500;
      case ActivityType.bookingCancelled:
        return AppColors.error500;
      case ActivityType.messageReceived:
        return AppColors.primaryBlue300;
    }
  }

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.newBooking:
        return Icons.event_available_rounded;
      case ActivityType.paymentReceived:
        return Icons.payment_rounded;
      case ActivityType.reviewReceived:
        return Icons.star_rounded;
      case ActivityType.profileView:
        return Icons.visibility_rounded;
      case ActivityType.bookingCancelled:
        return Icons.event_busy_rounded;
      case ActivityType.messageReceived:
        return Icons.message_rounded;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inHours < 1) {
      return '${difference.inMinutes}min';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }
}
