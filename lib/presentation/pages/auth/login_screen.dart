import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/components/inputs/app_text_field.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simular delay de login
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email == 'user@teste.com' && password == '123456') {
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (email == 'admin@teste.com' && password == '123456') {
        Navigator.of(context).pushReplacementNamed('/owner-home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Usuário ou senha inválidos!'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer login: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleGoogleLogin() {
    // Implement Google Sign-In
  }

  void _handleAppleLogin() {
    // Implement Apple Sign-In
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.oceanGradient,
        ),
        child: Stack(
          children: [
            // Background Pattern
            _buildBackgroundPattern(),

            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: size.height - MediaQuery.of(context).padding.top,
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.xxl),

                      // Logo and Welcome
                      _buildHeader(),

                      const SizedBox(height: AppSpacing.huge),

                      // Login Form
                      _buildLoginForm(theme),

                      const Spacer(),

                      // Footer
                      _buildFooter(theme),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.1,
        child: Image.asset(
          'assets/images/ocean_pattern.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
          child: const Icon(
            Icons.sailing_rounded,
            size: 40,
            color: Colors.white,
          ),
        ).animate().scale(
              delay: 200.ms,
              duration: 600.ms,
              curve: Curves.elasticOut,
            ),

        const SizedBox(height: AppSpacing.xl),

        // Welcome Text
        Text(
          'Bem-vindo de volta!',
          style: AppTypography.displayMedium.copyWith(
            color: Colors.white,
            fontWeight: AppTypography.bold,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),

        const SizedBox(height: AppSpacing.sm),

        Text(
          'Entre na sua conta para continuar navegando',
          style: AppTypography.bodyLarge.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
      ],
    );
  }

  Widget _buildLoginForm(ThemeData theme) {
    return GlassCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            ).animate().fadeIn(delay: 800.ms).slideX(begin: -0.3),

            const SizedBox(height: AppSpacing.lg),

            // Password Field
            AppTextField(
              label: 'Senha',
              hint: 'Digite sua senha',
              controller: _passwordController,
              type: AppTextFieldType.password,
              prefixIcon: Icons.lock_outline_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, digite sua senha';
                }
                if (value.length < 6) {
                  return 'A senha deve ter pelo menos 6 caracteres';
                }
                return null;
              },
            ).animate().fadeIn(delay: 1000.ms).slideX(begin: -0.3),

            const SizedBox(height: AppSpacing.lg),

            // Remember Me & Forgot Password
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() => _rememberMe = value ?? false);
                        },
                      ),
                      Text(
                        'Lembrar-me',
                        style: AppTypography.bodyMedium.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to forgot password
                  },
                  child: Text(
                    'Esqueci a senha',
                    style: AppTypography.bodyMedium.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: AppTypography.semiBold,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 1200.ms),

            const SizedBox(height: AppSpacing.xl),

            // Login Button
            AppButton(
              text: 'Entrar',
              isLoading: _isLoading,
              onPressed: _handleLogin,
            ).animate().fadeIn(delay: 1400.ms).slideY(begin: 0.3),

            const SizedBox(height: AppSpacing.xl),

            // Divider
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Text(
                    'ou continue com',
                    style: AppTypography.bodyMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 1600.ms),

            const SizedBox(height: AppSpacing.xl),

            // Social Login Buttons
            Row(
              children: [
                Expanded(
                  child: _SocialButton(
                    icon: Icons.g_mobiledata_rounded,
                    label: 'Google',
                    onPressed: _handleGoogleLogin,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _SocialButton(
                    icon: Icons.apple_rounded,
                    label: 'Apple',
                    onPressed: _handleAppleLogin,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 1800.ms).slideY(begin: 0.3),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(ThemeData theme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Não tem uma conta? ',
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: Text(
                'Registre-se',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: AppTypography.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 2000.ms),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Ao continuar, você concorda com nossos\nTermos de Uso e Política de Privacidade',
          style: AppTypography.bodySmall.copyWith(
            color: Colors.white.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 2200.ms),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.button),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: theme.colorScheme.onSurface,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppTypography.labelLarge.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
