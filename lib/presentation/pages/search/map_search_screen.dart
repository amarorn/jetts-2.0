import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/components/cards/boat_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../domain/models/boat_model.dart';

class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({super.key});

  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  bool _showList = false;
  List<BoatModel> _nearbyBoats = [];
  BoatModel? _selectedBoat;

  @override
  void initState() {
    super.initState();
    _loadNearbyBoats();
  }

  void _loadNearbyBoats() {
    _nearbyBoats = [
      BoatModel(
        id: '1',
        name: 'Iate Luxo Marina',
        location: 'Marina da Glória, RJ',
        price: 1500.0,
        rating: 4.8,
        imageUrl: 'https://picsum.photos/400/300?1',
        features: ['Luxo', 'Piscina', 'Jacuzzi'],
      ),
      BoatModel(
        id: '2',
        name: 'Lancha Rápida',
        location: 'Copacabana, RJ',
        price: 800.0,
        rating: 4.5,
        imageUrl: 'https://picsum.photos/400/300?2',
        features: ['Rápido', 'Econômico'],
      ),
      BoatModel(
        id: '3',
        name: 'Veleiro Clássico',
        location: 'Urca, RJ',
        price: 1200.0,
        rating: 4.9,
        imageUrl: 'https://picsum.photos/400/300?3',
        features: ['Romântico', 'Silencioso'],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Mapa (placeholder)
          _buildMapPlaceholder(theme),
          
          // Barra de busca
          _buildSearchBar(theme),
          
          // Botões de filtro
          _buildFilterButtons(theme),
          
          // Lista de barcos (quando ativada)
          if (_showList) _buildBoatsList(theme),
          
          // Card do barco selecionado
          if (_selectedBoat != null && !_showList) 
            _buildSelectedBoatCard(theme),
          
          // Botão de alternar visualização
          _buildToggleButton(theme),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryBlue100,
            AppColors.primaryBlue200,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Simulação de pontos no mapa
          ..._nearbyBoats.asMap().entries.map((entry) {
            final index = entry.key;
            final boat = entry.value;
            return Positioned(
              left: 100.0 + (index * 80),
              top: 200.0 + (index * 60),
              child: GestureDetector(
                onTap: () => _selectBoat(boat),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _selectedBoat?.id == boat.id 
                        ? AppColors.secondaryOrange500
                        : AppColors.primaryBlue500,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.directions_boat_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ).animate().scale(delay: Duration(milliseconds: 200 * index)),
              ),
            );
          }).toList(),
          
          // Indicador de localização do usuário
          const Positioned(
            left: 150,
            top: 300,
            child: Icon(
              Icons.my_location_rounded,
              color: AppColors.error500,
              size: 30,
            ),
          ),
          
          // Texto indicativo
          Center(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              margin: const EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Mapa Interativo',
                    style: AppTypography.titleLarge.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Toque nos ícones para ver os barcos',
                    style: AppTypography.bodyMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
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

  Widget _buildSearchBar(ThemeData theme) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + AppSpacing.md,
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                'Buscar por localização...',
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
      ).animate().slideY(begin: -1.0).fadeIn(),
    );
  }

  Widget _buildFilterButtons(ThemeData theme) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 80,
      left: AppSpacing.lg,
      child: Column(
        children: [
          _buildFilterChip(theme, 'Preço', Icons.attach_money_rounded),
          const SizedBox(height: AppSpacing.sm),
          _buildFilterChip(theme, 'Tipo', Icons.directions_boat_rounded),
          const SizedBox(height: AppSpacing.sm),
          _buildFilterChip(theme, 'Avaliação', Icons.star_rounded),
        ],
      ).animate().slideX(begin: -1.0, delay: 200.ms).fadeIn(),
    );
  }

  Widget _buildFilterChip(ThemeData theme, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: AppTypography.semiBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoatsList(ThemeData theme) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.outline,
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_nearbyBoats.length} barcos encontrados',
                    style: AppTypography.titleLarge.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _showList = false),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            
            // Lista
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: _nearbyBoats.length,
                itemBuilder: (context, index) {
                  final boat = _nearbyBoats[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: BoatCard(
                      boat: boat,
                      onTap: () {
                        // Navegar para detalhes
                      },
                      onFavorite: () {
                        // Adicionar aos favoritos
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ).animate().slideY(begin: 1.0).fadeIn(),
    );
  }

  Widget _buildSelectedBoatCard(ThemeData theme) {
    return Positioned(
      bottom: AppSpacing.xl,
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Image.network(
                    _selectedBoat!.imageUrl,
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
                        _selectedBoat!.name,
                        style: AppTypography.titleMedium.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _selectedBoat!.location,
                        style: AppTypography.bodySmall.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: AppColors.tertiaryGold500,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            _selectedBoat!.rating.toString(),
                            style: AppTypography.labelMedium.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: AppTypography.semiBold,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Text(
                            'R\$ ${_selectedBoat!.price.toStringAsFixed(2)}',
                            style: AppTypography.titleSmall.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: AppTypography.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _selectedBoat = null),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Ver Detalhes',
                    type: AppButtonType.secondary,
                    onPressed: () {
                      // Navegar para detalhes
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    text: 'Reservar',
                    onPressed: () {
                      // Navegar para reserva
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ).animate().slideY(begin: 1.0).fadeIn(),
    );
  }

  Widget _buildToggleButton(ThemeData theme) {
    return Positioned(
      bottom: _selectedBoat != null ? 200 : AppSpacing.xl,
      right: AppSpacing.lg,
      child: FloatingActionButton(
        onPressed: () => setState(() => _showList = !_showList),
        backgroundColor: theme.colorScheme.primary,
        child: Icon(
          _showList ? Icons.map_rounded : Icons.list_rounded,
          color: Colors.white,
        ),
      ).animate().scale(delay: 400.ms),
    );
  }

  void _selectBoat(BoatModel boat) {
    setState(() {
      _selectedBoat = boat;
      _showList = false;
    });
  }
}
