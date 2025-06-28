import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/components/inputs/app_text_field.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';

enum UserType { client, owner }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;
  UserType _selectedUserType = UserType.client;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Você precisa aceitar os termos de uso'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simular delay de registro
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // Navegar para a home baseada no tipo de usuário
      final route =
          _selectedUserType == UserType.client ? '/home' : '/owner-home';
      Navigator.of(context).pushReplacementNamed(route);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer registro: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.sunsetGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Back Button
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: AppSpacing.lg),

                // Header
                _buildHeader(),

                const SizedBox(height: AppSpacing.xxl),

                // User Type Selector
                _buildUserTypeSelector(),

                const SizedBox(height: AppSpacing.lg),

                // Register Form
                _buildRegisterForm(theme),

                // Footer
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Criar Conta',
          style: AppTypography.displayMedium.copyWith(
            color: Colors.white,
            fontWeight: AppTypography.bold,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Junte-se à nossa comunidade náutica',
          style: AppTypography.bodyLarge.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
      ],
    );
  }

  Widget _buildUserTypeSelector() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipo de Conta',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: AppTypography.semiBold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _buildUserTypeCard(
                    type: UserType.client,
                    title: 'Cliente',
                    subtitle: 'Alugar barcos',
                    icon: Icons.person_outline_rounded,
                    color: AppColors.primaryBlue500,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _buildUserTypeCard(
                    type: UserType.owner,
                    title: 'Proprietário',
                    subtitle: 'Alugar meus barcos',
                    icon: Icons.business_outlined,
                    color: AppColors.secondaryOrange500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3);
  }

  Widget _buildUserTypeCard({
    required UserType type,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedUserType == type;

    return GestureDetector(
      onTap: () => setState(() => _selectedUserType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          border: Border.all(
            color: color,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.md),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: AppTypography.titleSmall.copyWith(
                fontWeight: AppTypography.semiBold,
                color: isSelected ? Colors.white : color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: isSelected
                    ? Colors.white.withOpacity(0.9)
                    : color.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm(ThemeData theme) {
    return GlassCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name Field
            AppTextField(
              label: 'Nome Completo',
              hint: 'Digite seu nome completo',
              controller: _nameController,
              prefixIcon: Icons.person_outline_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, digite seu nome';
                }
                return null;
              },
            ).animate().fadeIn(delay: 900.ms).slideX(begin: -0.3),

            const SizedBox(height: AppSpacing.lg),

            // Email Field
            AppTextField(
              label: 'Email',
              hint: 'Digite seu email',
              controller: _emailController,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, digite seu email';
                }
                if (!value.contains('@')) {
                  return 'Por favor, digite um email válido';
                }
                return null;
              },
            ).animate().fadeIn(delay: 1100.ms).slideX(begin: -0.3),

            const SizedBox(height: AppSpacing.lg),

            // Password Field
            AppTextField(
              label: 'Senha',
              hint: 'Digite sua senha',
              controller: _passwordController,
              type: AppTextFieldType.password,
              prefixIcon: Icons.lock_outline_rounded,
              helper: 'Mínimo de 8 caracteres',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, digite sua senha';
                }
                if (value.length < 8) {
                  return 'A senha deve ter pelo menos 8 caracteres';
                }
                return null;
              },
            ).animate().fadeIn(delay: 1300.ms).slideX(begin: -0.3),

            const SizedBox(height: AppSpacing.lg),

            // Confirm Password Field
            AppTextField(
              label: 'Confirmar Senha',
              hint: 'Confirme sua senha',
              controller: _confirmPasswordController,
              type: AppTextFieldType.password,
              prefixIcon: Icons.lock_outline_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, confirme sua senha';
                }
                if (value != _passwordController.text) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
            ).animate().fadeIn(delay: 1500.ms).slideX(begin: -0.3),

            const SizedBox(height: AppSpacing.lg),

            // Terms Checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() => _acceptTerms = value ?? false);
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _acceptTerms = !_acceptTerms);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Eu aceito os ',
                        style: AppTypography.bodyMedium.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: 'Termos de Uso',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: AppTypography.semiBold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' e '),
                          TextSpan(
                            text: 'Política de Privacidade',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: AppTypography.semiBold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 1700.ms),

            const SizedBox(height: AppSpacing.xl),

            // Register Button
            AppButton(
              text: 'Criar Conta',
              isLoading: _isLoading,
              onPressed: _handleRegister,
            ).animate().fadeIn(delay: 1900.ms).slideY(begin: 0.3),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Já tem uma conta? ',
          style: AppTypography.bodyMedium.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Faça login',
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: AppTypography.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 2100.ms);
  }
}
