import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/components/cards/boat_card.dart';
import '../../../design_system/components/inputs/app_text_field.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../design_system/theme/theme_extensions.dart';
import 'widgets/location_selector.dart';
import 'widgets/weather_card.dart';
import 'widgets/quick_actions.dart';
import '../../../domain/models/boat_model.dart';
import '../../../domain/models/category_model.dart';
import '../../../domain/models/destination_model.dart';
import 'widgets/custom_bottom_nav.dart';
import '../boat_details/boat_details_screen.dart';
import '../owner/client_support_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late final AnimationController _fabAnimationController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection == AxisDirection.down) {
      _fabAnimationController.reverse();
    } else {
      _fabAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(theme),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroSection(theme),
                  const SizedBox(height: AppSpacing.lg),
                  _buildLocationAndWeather(theme),
                  const SizedBox(height: AppSpacing.lg),
                  _buildQuickActions(theme),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSearchSection(theme),
                  const SizedBox(height: AppSpacing.lg),
                  _buildFeaturedBoats(theme),
                  const SizedBox(height: AppSpacing.lg),
                  _buildCategories(theme),
                  const SizedBox(height: AppSpacing.lg),
                  _buildPopularDestinations(theme),
                  const SizedBox(height: AppSpacing.lg),
                  _buildRecentBookings(theme),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimationController,
        child: FloatingActionButton(
          onPressed: () {
            // Mostrar tela de SOS
          },
          backgroundColor: theme.colorScheme.error,
          child: const Icon(
            Icons.sos_rounded,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          NavItem(
            label: 'Início',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home_rounded,
          ),
          NavItem(
            label: 'Explorar',
            icon: Icons.explore_outlined,
            selectedIcon: Icons.explore_rounded,
          ),
          NavItem(
            label: 'Reservas',
            icon: Icons.calendar_today_outlined,
            selectedIcon: Icons.calendar_today_rounded,
          ),
          NavItem(
            label: 'Perfil',
            icon: Icons.person_outline_rounded,
            selectedIcon: Icons.person_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(ThemeData theme) {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Icon(
              Icons.person_rounded,
              color: theme.colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, João',
                style: AppTypography.titleMedium.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
              Text(
                'Bem-vindo de volta!',
                style: AppTypography.bodySmall.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            Navigator.of(context).pushNamed('/search');
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite_rounded),
          onPressed: () {
            Navigator.of(context).pushNamed('/favorites');
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_rounded),
          onPressed: () {
            Navigator.of(context).pushNamed('/profile');
          },
        ),
        IconButton(
          onPressed: () {
            // Mostrar notificações
          },
          icon: Icon(
            Icons.notifications_none_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        IconButton(
          onPressed: () {
            // Mostrar configurações
          },
          icon: Icon(
            Icons.settings_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Encontre seu próximo',
          style: AppTypography.headlineLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        Text(
          'passeio de barco',
          style: AppTypography.headlineLarge.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: AppTypography.bold,
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildLocationAndWeather(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: LocationSelector(
            selectedLocation: 'Rio de Janeiro, RJ',
            onLocationChanged: (location) {
              // Atualizar localização
            },
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: WeatherCard(
            temperature: '28°C',
            condition: 'Ensolarado',
            icon: 'sunny',
          ),
        ),
      ],
    ).animate().fadeIn().slideX(begin: 0.2, end: 0);
  }

  Widget _buildQuickActions(ThemeData theme) {
    return QuickActions(
      actions: [
        QuickAction(
          title: 'Favoritos',
          icon: Icons.favorite_rounded,
          color: AppColors.error500,
          onTap: () {
            // Navegar para favoritos
          },
        ),
        QuickAction(
          title: 'Histórico',
          icon: Icons.history_rounded,
          color: AppColors.primaryBlue500,
          onTap: () {
            // Navegar para histórico
          },
        ),
        QuickAction(
          title: 'Promoções',
          icon: Icons.local_offer_rounded,
          color: AppColors.secondaryOrange500,
          onTap: () {
            // Navegar para promoções
          },
        ),
        QuickAction(
          title: 'Suporte',
          icon: Icons.support_agent_rounded,
          color: AppColors.success500,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ClientSupportChatScreen(),
              ),
            );
          },
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildSearchSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Buscar barcos, destinos...',
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              Icons.tune_rounded,
              color: theme.colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildFeaturedBoats(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Barcos em destaque',
              style: AppTypography.titleLarge.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: AppTypography.semiBold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para lista de barcos
              },
              child: Text(
                'Ver todos',
                style: AppTypography.labelMedium.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 340,
          child: Swiper(
            itemBuilder: (context, index) {
              final boat = _getFeaturedBoats()[index];
              return BoatCard(
                boat: boat,
                onTap: () {
                  // Mock para BoatDetailsModel
                  final details = BoatDetailsModel(
                    id: boat.id,
                    name: boat.name,
                    location: boat.location,
                    price: 'R\$ ${boat.price.toStringAsFixed(2)}',
                    rating: boat.rating,
                    reviewsCount: 12,
                    images: [boat.imageUrl],
                    description: 'Descrição detalhada do barco...',
                    capacity: 10,
                    length: 12.5,
                    amenities: [
                      AmenityModel(
                          name: 'Piscina', icon: Icons.pool, isAvailable: true),
                      AmenityModel(
                          name: 'Bar',
                          icon: Icons.local_bar,
                          isAvailable: false),
                      AmenityModel(
                          name: 'Jacuzzi',
                          icon: Icons.hot_tub,
                          isAvailable: true),
                    ],
                    specifications: [
                      SpecificationModel(name: 'Ano', value: '2022'),
                      SpecificationModel(name: 'Motor', value: 'Yamaha 300HP'),
                    ],
                    marina: MarinaModel(
                      name: 'Marina Rio',
                      address: 'Av. Atlântica, 1000 - Rio de Janeiro, RJ',
                      phone: '(21) 99999-9999',
                    ),
                    reviews: [
                      ReviewModel(
                        userName: 'Maria',
                        userAvatar:
                            'https://randomuser.me/api/portraits/women/1.jpg',
                        rating: 4.8,
                        comment: 'Barco excelente!',
                        date: DateTime.now().subtract(const Duration(days: 2)),
                      ),
                    ],
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BoatDetailsScreen(boat: details),
                    ),
                  );
                },
                onFavorite: () {},
              );
            },
            itemCount: _getFeaturedBoats().length,
            viewportFraction: 0.8,
            scale: 0.9,
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: AppColors.primaryBlue500,
                color: AppColors.neutral200,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildCategories(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categorias',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.semiBold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _getCategories().length,
            itemBuilder: (context, index) {
              final category = _getCategories()[index];
              return Padding(
                padding: EdgeInsets.only(
                  right:
                      index == _getCategories().length - 1 ? 0 : AppSpacing.sm,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Icon(
                        category.icon,
                        color: category.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      category.name,
                      style: AppTypography.labelSmall.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildPopularDestinations(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Destinos populares',
              style: AppTypography.titleLarge.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: AppTypography.semiBold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para lista de destinos
              },
              child: Text(
                'Ver todos',
                style: AppTypography.labelMedium.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _getPopularDestinations().length,
            itemBuilder: (context, index) {
              final destination = _getPopularDestinations()[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == _getPopularDestinations().length - 1
                      ? 0
                      : AppSpacing.sm,
                ),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    image: DecorationImage(
                      image: NetworkImage(destination.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination.name,
                          style: AppTypography.titleMedium.copyWith(
                            color: Colors.white,
                            fontWeight: AppTypography.semiBold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${destination.boatsCount} barcos disponíveis',
                          style: AppTypography.bodySmall.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildRecentBookings(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reservas recentes',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.semiBold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _getRecentBookings().length,
          itemBuilder: (context, index) {
            final booking = _getRecentBookings()[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: Image.network(
                        booking.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.name,
                            style: AppTypography.titleMedium.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: AppTypography.semiBold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            booking.location,
                            style: AppTypography.bodySmall.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.sm),
                                ),
                                child: Text(
                                  booking.status ?? 'Sem status',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                    fontWeight: AppTypography.semiBold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                booking.date ?? 'Data não definida',
                                style: AppTypography.labelSmall.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Navegar para detalhes da reserva
                      },
                      icon: Icon(
                        Icons.chevron_right_rounded,
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
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  List<BoatModel> _getFeaturedBoats() {
    return [
      BoatModel(
        id: '1',
        name: 'Barco de Luxo',
        location: 'Rio de Janeiro, RJ',
        price: 1500.0,
        rating: 4.8,
        imageUrl: 'https://picsum.photos/400/300',
        features: ['Luxo', 'Piscina', 'Jacuzzi'],
        discount: 20,
      ),
      BoatModel(
        id: '2',
        name: 'Iate Moderno',
        location: 'São Paulo, SP',
        price: 2000.0,
        rating: 4.9,
        imageUrl: 'https://picsum.photos/400/300',
        features: ['Moderno', 'Bar', 'Churrasqueira'],
      ),
      BoatModel(
        id: '3',
        name: 'Lancha Rápida',
        location: 'Florianópolis, SC',
        price: 800.0,
        rating: 4.5,
        imageUrl: 'https://picsum.photos/400/300',
        features: ['Rápido', 'Econômico', 'Prático'],
      ),
    ];
  }

  List<CategoryModel> _getCategories() {
    return [
      CategoryModel(
        name: 'Luxo',
        icon: Icons.diamond_rounded,
        color: AppColors.primaryBlue500,
        count: 12,
      ),
      CategoryModel(
        name: 'Esporte',
        icon: Icons.sports_handball_rounded,
        color: AppColors.secondaryOrange500,
        count: 8,
      ),
      CategoryModel(
        name: 'Família',
        icon: Icons.family_restroom_rounded,
        color: AppColors.success500,
        count: 15,
      ),
      CategoryModel(
        name: 'Romântico',
        icon: Icons.favorite_rounded,
        color: AppColors.error500,
        count: 6,
      ),
    ];
  }

  List<DestinationModel> _getPopularDestinations() {
    return [
      DestinationModel(
        name: 'Rio de Janeiro',
        imageUrl: 'https://picsum.photos/400/300',
        boatsCount: 25,
      ),
      DestinationModel(
        name: 'São Paulo',
        imageUrl: 'https://picsum.photos/400/300',
        boatsCount: 18,
      ),
      DestinationModel(
        name: 'Florianópolis',
        imageUrl: 'https://picsum.photos/400/300',
        boatsCount: 15,
      ),
    ];
  }

  List<BoatModel> _getRecentBookings() {
    return [
      BoatModel(
        id: '1',
        name: 'Barco de Luxo',
        location: 'Rio de Janeiro, RJ',
        price: 1500.0,
        rating: 4.8,
        imageUrl: 'https://picsum.photos/400/300',
        features: ['Luxo', 'Piscina', 'Jacuzzi'],
        status: 'Confirmado',
        date: '15/05/2024',
      ),
      BoatModel(
        id: '2',
        name: 'Iate Moderno',
        location: 'São Paulo, SP',
        price: 2000.0,
        rating: 4.9,
        imageUrl: 'https://picsum.photos/400/300',
        features: ['Moderno', 'Bar', 'Churrasqueira'],
        status: 'Pendente',
        date: '20/05/2024',
      ),
    ];
  }
}
