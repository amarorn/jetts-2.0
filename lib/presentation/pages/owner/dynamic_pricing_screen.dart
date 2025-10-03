import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../domain/models/dynamic_pricing_model.dart';

class DynamicPricingScreen extends StatefulWidget {
  final String boatId;
  final String boatName;

  const DynamicPricingScreen({
    super.key,
    required this.boatId,
    required this.boatName,
  });

  @override
  State<DynamicPricingScreen> createState() => _DynamicPricingScreenState();
}

class _DynamicPricingScreenState extends State<DynamicPricingScreen> {
  late PricingConfiguration _config;
  final TextEditingController _basePriceController = TextEditingController();
  bool _isAutomaticPricingEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadConfiguration();
  }

  void _loadConfiguration() {
    // Carregar configuração existente ou criar padrão
    _config = PricingConfiguration(
      boatId: widget.boatId,
      basePrice: 1000.0,
      multipliers: {
        PricingRule.weekday: 1.0,
        PricingRule.weekend: 1.3,
        PricingRule.holiday: 1.5,
        PricingRule.highSeason: 1.4,
        PricingRule.lowSeason: 0.8,
      },
      durationDiscounts: {
        3: 5.0,  // 3+ dias: 5% desconto
        7: 10.0, // 7+ dias: 10% desconto
        14: 15.0, // 14+ dias: 15% desconto
        30: 20.0, // 30+ dias: 20% desconto
      },
      customRules: [],
      isAutomaticPricingEnabled: _isAutomaticPricingEnabled,
    );

    _basePriceController.text = _config.basePrice.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _basePriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Precificação Dinâmica'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveConfiguration,
            child: Text(
              'Salvar',
              style: AppTypography.labelLarge.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: AppTypography.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBoatInfo(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildAutomaticPricingToggle(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildBasePriceSection(theme),
            const SizedBox(height: AppSpacing.xl),
            if (_isAutomaticPricingEnabled) ...[
              _buildMultipliersSection(theme),
              const SizedBox(height: AppSpacing.xl),
              _buildDurationDiscountsSection(theme),
              const SizedBox(height: AppSpacing.xl),
              _buildPricePreview(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBoatInfo(ThemeData theme) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                Icons.directions_boat_rounded,
                color: theme.colorScheme.onPrimaryContainer,
                size: 30,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.boatName,
                    style: AppTypography.titleLarge.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Configure preços inteligentes',
                    style: AppTypography.bodyMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildAutomaticPricingToggle(ThemeData theme) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Precificação Automática',
                        style: AppTypography.titleMedium.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Ajuste preços automaticamente baseado na demanda e temporada',
                        style: AppTypography.bodySmall.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isAutomaticPricingEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isAutomaticPricingEnabled = value;
                    });
                  },
                  activeColor: AppColors.success500,
                ),
              ],
            ),
            if (_isAutomaticPricingEnabled) ...[
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.success500.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.success500,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Seus preços serão otimizados automaticamente',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.success500,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildBasePriceSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preço Base',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: TextField(
            controller: _basePriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: 'R\$ ',
              hintText: '0,00',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(AppSpacing.lg),
            ),
            style: AppTypography.headlineSmall.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: AppTypography.bold,
            ),
            onChanged: (value) {
              final price = double.tryParse(value) ?? 0.0;
              setState(() {
                _config = PricingConfiguration(
                  boatId: _config.boatId,
                  basePrice: price,
                  multipliers: _config.multipliers,
                  durationDiscounts: _config.durationDiscounts,
                  customRules: _config.customRules,
                  isAutomaticPricingEnabled: _config.isAutomaticPricingEnabled,
                );
              });
            },
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildMultipliersSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ajustes por Período',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Multiplique o preço base em diferentes situações',
          style: AppTypography.bodyMedium.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildMultiplierItem(
          theme,
          'Dias de Semana',
          'Segunda a Sexta-feira',
          PricingRule.weekday,
          Icons.calendar_today_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildMultiplierItem(
          theme,
          'Fins de Semana',
          'Sábado e Domingo',
          PricingRule.weekend,
          Icons.weekend_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildMultiplierItem(
          theme,
          'Feriados',
          'Feriados nacionais',
          PricingRule.holiday,
          Icons.celebration_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildMultiplierItem(
          theme,
          'Alta Temporada',
          'Dezembro, Janeiro, Fevereiro, Julho',
          PricingRule.highSeason,
          Icons.trending_up_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildMultiplierItem(
          theme,
          'Baixa Temporada',
          'Março, Abril, Maio, Agosto, Setembro',
          PricingRule.lowSeason,
          Icons.trending_down_rounded,
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildMultiplierItem(
    ThemeData theme,
    String title,
    String description,
    PricingRule rule,
    IconData icon,
  ) {
    final multiplier = _config.multipliers[rule] ?? 1.0;
    final percentage = ((multiplier - 1.0) * 100).round();
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.onPrimaryContainer,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.titleSmall.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                    Text(
                      description,
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
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
                  color: percentage >= 0 
                      ? AppColors.success500.withOpacity(0.1)
                      : AppColors.error500.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  '${percentage >= 0 ? '+' : ''}$percentage%',
                  style: AppTypography.labelMedium.copyWith(
                    color: percentage >= 0 
                        ? AppColors.success500
                        : AppColors.error500,
                    fontWeight: AppTypography.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Slider(
            value: multiplier,
            min: 0.5,
            max: 2.0,
            divisions: 30,
            activeColor: theme.colorScheme.primary,
            onChanged: (value) {
              setState(() {
                _config.multipliers[rule] = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDurationDiscountsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descontos por Duração',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Ofereça descontos para aluguéis mais longos',
          style: AppTypography.bodyMedium.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ..._config.durationDiscounts.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _buildDiscountItem(theme, entry.key, entry.value),
          );
        }).toList(),
      ],
    ).animate().fadeIn(delay: 800.ms);
  }

  Widget _buildDiscountItem(ThemeData theme, int days, double discount) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryOrange500.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              Icons.access_time_rounded,
              color: AppColors.secondaryOrange500,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$days+ dias',
                  style: AppTypography.titleSmall.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
                Text(
                  'Desconto para aluguéis longos',
                  style: AppTypography.bodySmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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
              color: AppColors.success500.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              '-${discount.toStringAsFixed(0)}%',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.success500,
                fontWeight: AppTypography.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricePreview(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Simulação de Preços',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Veja como ficam os preços em diferentes cenários',
          style: AppTypography.bodyMedium.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildPreviewItem(
          theme,
          'Dia de Semana (Normal)',
          DateTime.now().add(const Duration(days: 1)),
          1,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildPreviewItem(
          theme,
          'Fim de Semana',
          DateTime.now().add(const Duration(days: 6)),
          1,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildPreviewItem(
          theme,
          'Aluguel de 7 dias',
          DateTime.now().add(const Duration(days: 1)),
          7,
        ),
      ],
    ).animate().fadeIn(delay: 1000.ms);
  }

  Widget _buildPreviewItem(
    ThemeData theme,
    String scenario,
    DateTime date,
    int duration,
  ) {
    final price = _config.calculatePrice(date, duration);
    final difference = price - _config.basePrice;
    final isIncrease = difference > 0;
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scenario,
                  style: AppTypography.titleSmall.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
                if (difference != 0)
                  Text(
                    '${isIncrease ? '+' : ''}R\$ ${difference.toStringAsFixed(2)}',
                    style: AppTypography.bodySmall.copyWith(
                      color: isIncrease 
                          ? AppColors.error500 
                          : AppColors.success500,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            'R\$ ${price.toStringAsFixed(2)}',
            style: AppTypography.titleMedium.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: AppTypography.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _saveConfiguration() {
    // Implementar salvamento da configuração
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configuração salva com sucesso!'),
        backgroundColor: AppColors.success500,
      ),
    );
    
    Navigator.of(context).pop();
  }
}
