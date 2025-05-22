import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import 'widgets/floating_elements.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Descubra o Mar',
      subtitle: 'Encontre a embarcação perfeita para sua aventura náutica',
      description: 'Lanchas, iates, jet skis e veleiros disponíveis nas melhores marinas do Brasil.',
      image: 'assets/images/onboarding_1.png',
      gradient: AppColors.oceanGradient,
    ),
    OnboardingPage(
      title: 'Reserve com Facilidade',
      subtitle: 'Processo simples e seguro',
      description: 'Reserve em poucos cliques, pague com segurança e receba todas as informações no seu celular.',
      image: 'assets/images/onboarding_2.png',
      gradient: AppColors.sunsetGradient,
    ),
    OnboardingPage(
      title: 'Navegue com Conforto',
      subtitle: 'Suporte 24/7 durante sua experiência',
      description: 'Nossa equipe está sempre disponível para garantir que sua aventura seja inesquecível.',
      image: 'assets/images/onboarding_3.png',
      gradient: AppColors.primaryGradient,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToAuth();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToAuth() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void _skip() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Page Content
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildPage(_pages[index], size);
            },
          ),

          // Floating Elements
          const FloatingElements(),

          // Skip Button
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.lg,
            right: AppSpacing.lg,
            child: TextButton(
              onPressed: _skip,
              child: Text(
                'Pular',
                style: AppTypography.labelMedium.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ).animate().fadeIn(delay: 500.ms),
          ),

          // Bottom Controls
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + AppSpacing.xl,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: _buildBottomControls(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, Size size) {
    return Container(
      decoration: BoxDecoration(
        gradient: page.gradient,
      ),
      child: Stack(
        children: [
          // Efeito de mar (onda)
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: _WaveClipper(),
              child: Container(
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade200.withOpacity(0.7),
                      Colors.blue.shade400.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          // Conteúdo centralizado
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    page.title,
                    style: AppTypography.displayMedium.copyWith(
                      color: Colors.white,
                      fontWeight: AppTypography.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    page.subtitle,
                    style: AppTypography.titleLarge.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: AppTypography.medium,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    page.description,
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.white.withOpacity(0.85),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Page Indicator
        SmoothPageIndicator(
          controller: _pageController,
          count: _pages.length,
          effect: WormEffect(
            dotColor: Colors.white.withOpacity(0.3),
            activeDotColor: Colors.white,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 12,
          ),
        ).animate().fadeIn(delay: 1000.ms),

        const SizedBox(height: AppSpacing.xxl),

        // Navigation Buttons
        Row(
          children: [
            // Previous Button
            if (_currentPage > 0)
              Expanded(
                child: AppButton(
                  text: 'Anterior',
                  type: AppButtonType.ghost,
                  onPressed: _previousPage,
                  customChild: Text(
                    'Anterior',
                    style: AppTypography.labelLarge.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: AppTypography.semiBold,
                    ),
                  ),
                ).animate().fadeIn(delay: 1200.ms).slideX(begin: -0.3),
              )
            else
              const Expanded(child: SizedBox()),

            const SizedBox(width: AppSpacing.lg),

            // Next/Finish Button
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: AppButton(
                  text: _currentPage == _pages.length - 1 ? 'Começar' : 'Próximo',
                  type: AppButtonType.ghost,
                  onPressed: _nextPage,
                  customChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentPage == _pages.length - 1 ? 'Começar' : 'Próximo',
                        style: AppTypography.labelLarge.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        _currentPage == _pages.length - 1
                            ? Icons.rocket_launch_rounded
                            : Icons.arrow_forward_rounded,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 1200.ms).slideX(begin: 0.3),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final String image;
  final Gradient gradient;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.gradient,
  });
}

// Clipper para efeito de onda
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.6,
      size.width, size.height * 0.8,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
} 