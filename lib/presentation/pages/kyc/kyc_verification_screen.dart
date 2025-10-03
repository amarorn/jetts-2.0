import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../domain/models/kyc_model.dart';

class KYCVerificationScreen extends StatefulWidget {
  const KYCVerificationScreen({super.key});

  @override
  State<KYCVerificationScreen> createState() => _KYCVerificationScreenState();
}

class _KYCVerificationScreenState extends State<KYCVerificationScreen> {
  late KYCProfile _kycProfile;
  int _currentStep = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _kycProfile = KYCProfile(
      userId: 'user_123',
      fullName: '',
      email: '',
      phone: '',
      documents: [],
      overallStatus: KYCStatus.notStarted,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificação de Identidade'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(theme),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildWelcomeStep(theme),
                _buildPersonalInfoStep(theme),
                _buildDocumentStep(theme),
                _buildCompletionStep(theme),
              ],
            ),
          ),
          _buildBottomNavigation(theme),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Row(
            children: List.generate(4, (index) {
              final isCompleted = index < _currentStep;
              final isCurrent = index == _currentStep;
              
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index < 3 ? AppSpacing.xs : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Etapa ${_currentStep + 1} de 4',
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeStep(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified_user_rounded,
              size: 60,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ).animate().scale(delay: 200.ms),
          
          const SizedBox(height: AppSpacing.xl),
          
          Text(
            'Verificação de Identidade',
            style: AppTypography.headlineMedium.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: AppTypography.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          
          const SizedBox(height: AppSpacing.md),
          
          Text(
            'Para garantir a segurança de todos os usuários, precisamos verificar sua identidade. O processo é rápido e seus dados são protegidos.',
            style: AppTypography.bodyLarge.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms),
          
          const SizedBox(height: AppSpacing.xl),
          
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  _buildBenefitItem(
                    theme,
                    Icons.security_rounded,
                    'Maior segurança',
                    'Perfil verificado aumenta a confiança',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildBenefitItem(
                    theme,
                    Icons.priority_high_rounded,
                    'Prioridade nas reservas',
                    'Proprietários preferem usuários verificados',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildBenefitItem(
                    theme,
                    Icons.verified_rounded,
                    'Selo de verificação',
                    'Destaque no seu perfil',
                  ),
                ],
              ),
            ),
          ).animate().slideY(begin: 0.3, delay: 800.ms),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(ThemeData theme, IconData icon, String title, String description) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
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
      ],
    );
  }

  Widget _buildPersonalInfoStep(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informações Pessoais',
            style: AppTypography.headlineSmall.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: AppTypography.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Preencha seus dados pessoais para continuar',
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          
          // Formulário seria implementado aqui
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 48,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Formulário de dados pessoais',
                  style: AppTypography.titleMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Nome completo, email, telefone, etc.',
                  style: AppTypography.bodySmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentStep(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documento de Identidade',
            style: AppTypography.headlineSmall.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: AppTypography.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Fotografe seu documento para verificação',
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 48,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Upload de documento',
                  style: AppTypography.titleMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'RG, CNH ou Passaporte',
                  style: AppTypography.bodySmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionStep(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.success500.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 60,
              color: AppColors.success500,
            ),
          ).animate().scale(delay: 200.ms),
          
          const SizedBox(height: AppSpacing.xl),
          
          Text(
            'Verificação Enviada!',
            style: AppTypography.headlineMedium.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: AppTypography.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          
          const SizedBox(height: AppSpacing.md),
          
          Text(
            'Seus documentos foram enviados para análise. Você receberá uma notificação em até 24 horas com o resultado.',
            style: AppTypography.bodyLarge.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: AppButton(
                  text: 'Voltar',
                  type: AppButtonType.secondary,
                  onPressed: _previousStep,
                ),
              )
            else
              const Expanded(child: SizedBox()),
            
            if (_currentStep > 0) const SizedBox(width: AppSpacing.md),
            
            Expanded(
              flex: 2,
              child: AppButton(
                text: _currentStep == 3 ? 'Finalizar' : 'Continuar',
                onPressed: _currentStep == 3 
                    ? () => Navigator.of(context).pop()
                    : _nextStep,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
