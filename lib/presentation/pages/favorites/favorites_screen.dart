import 'package:flutter/material.dart';
import '../../../domain/models/boat_model.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/components/cards/boat_card.dart';
import '../boat_details/boat_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<BoatModel> _favorites = [];

  @override
  void initState() {
    super.initState();
    _favorites = _mockFavorites();
  }

  void _removeFavorite(String id) {
    setState(() {
      _favorites.removeWhere((b) => b.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: _favorites.isEmpty
            ? Center(
                child: Text(
                  'Nenhum barco favorito ainda. :(',
                  style: AppTypography.bodyLarge,
                ),
              )
            : ListView.separated(
                itemCount: _favorites.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
                itemBuilder: (context, index) {
                  final boat = _favorites[index];
                  return BoatCard(
                    boat: boat,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BoatDetailsScreen(
                            boat: BoatDetailsModel(
                              id: boat.id,
                              name: boat.name,
                              location: boat.location,
                              price: 'R\$ ${boat.price.toStringAsFixed(2)}',
                              rating: boat.rating,
                              reviewsCount: 10,
                              images: [boat.imageUrl],
                              description: 'Barco favorito do usuário.',
                              capacity: 10,
                              length: 12.0,
                              amenities: [],
                              specifications: [],
                              marina: MarinaModel(name: 'Marina X', address: 'Endereço', phone: '0000-0000'),
                              reviews: [],
                            ),
                          ),
                        ),
                      );
                    },
                    onFavorite: () => _removeFavorite(boat.id),
                  );
                },
              ),
      ),
    );
  }

  List<BoatModel> _mockFavorites() {
    return [
      BoatModel(
        id: '1',
        name: 'Barco de Luxo',
        location: 'Rio de Janeiro, RJ',
        price: 1500.0,
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
        features: ['Luxo', 'Piscina', 'Jacuzzi'],
      ),
      BoatModel(
        id: '2',
        name: 'Iate Moderno',
        location: 'São Paulo, SP',
        price: 2000.0,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=800&q=80',
        features: ['Moderno', 'Bar', 'Churrasqueira'],
      ),
    ];
  }
} 