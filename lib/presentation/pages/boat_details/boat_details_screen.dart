import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../design_system/tokens/app_shadows.dart';
import 'widgets/image_gallery.dart';
import 'widgets/boat_info_card.dart';
import 'widgets/amenities_grid.dart';
import 'widgets/reviews_section.dart';
import 'widgets/booking_bottom_sheet.dart';
import '../booking/booking_screen.dart';
import '../../../domain/models/boat_model.dart';

// ... restante do código conforme fornecido pelo usuário ...

// Models
class BoatDetailsModel {
  final String id;
  final String name;
  final String location;
  final String price;
  final double rating;
  final int reviewsCount;
  final List<String> images;
  final String description;
  final int capacity;
  final double length;
  final List<AmenityModel> amenities;
  final List<SpecificationModel> specifications;
  final MarinaModel marina;
  final List<ReviewModel> reviews;

  BoatDetailsModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.description,
    required this.capacity,
    required this.length,
    required this.amenities,
    required this.specifications,
    required this.marina,
    required this.reviews,
  });
}

class AmenityModel {
  final String name;
  final IconData icon;
  final bool isAvailable;

  AmenityModel({
    required this.name,
    required this.icon,
    required this.isAvailable,
  });
}

class SpecificationModel {
  final String name;
  final String value;

  SpecificationModel({
    required this.name,
    required this.value,
  });
}

class MarinaModel {
  final String name;
  final String address;
  final String phone;

  MarinaModel({
    required this.name,
    required this.address,
    required this.phone,
  });
}

class ReviewModel {
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class BoatDetailsScreen extends StatefulWidget {
  final BoatDetailsModel boat;

  const BoatDetailsScreen({super.key, required this.boat});

  @override
  State<BoatDetailsScreen> createState() => _BoatDetailsScreenState();
}

class _BoatDetailsScreenState extends State<BoatDetailsScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _heroAnimationController;
  late AnimationController _fabAnimationController;
  
  bool _isScrolled = false;
  bool _isFavorite = false;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scrollController.addListener(_onScroll);
    _heroAnimationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _heroAnimationController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 200;
    if (isScrolled != _isScrolled) {
      setState(() => _isScrolled = isScrolled);
    }
  }

  void _showBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BookingBottomSheet(boat: widget.boat),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(theme),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Image Gallery
          SliverToBoxAdapter(
            child: SizedBox(
              height: size.height * 0.5,
              child: ImageGallery(
                images: widget.boat.images,
                currentIndex: _currentImageIndex,
                onIndexChanged: (index) {
                  setState(() => _currentImageIndex = index);
                },
              ),
            ),
          ),
          // Boat Info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BoatInfoCard(
                name: widget.boat.name,
                location: widget.boat.location,
                rating: widget.boat.rating,
                reviewsCount: widget.boat.reviewsCount,
                price: widget.boat.price,
                capacity: widget.boat.capacity,
                length: widget.boat.length,
              ),
            ),
          ),
          // Description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descrição',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.boat.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),
          ),
          // Amenities
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comodidades',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  AmenitiesGrid(amenities: widget.boat.amenities),
                  const SizedBox(height: 24),
                  // Avatar, nome e qualificação do condutor
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/conductor_profile',
                            arguments: {
                              'name': 'Carlos Andrade',
                              'id': '1',
                              'photoUrl': 'https://randomuser.me/api/portraits/men/32.jpg',
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                            // Mock de foto do condutor
                            'https://randomuser.me/api/portraits/men/32.jpg',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carlos Andrade', // Mock de nome
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '4.9', // Mock de nota
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 4),
                              Text('Condutor', style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Specifications
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Especificações',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Column(
                      children: widget.boat.specifications.asMap().entries.map((entry) {
                        final index = entry.key;
                        final spec = entry.value;
                        final isLast = index == widget.boat.specifications.length - 1;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(spec.name),
                                Text(spec.value, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            if (!isLast) ...[
                              const SizedBox(height: 12),
                              const Divider(),
                              const SizedBox(height: 12),
                            ],
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Location
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Localização',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceVariant,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on_rounded, size: 48, color: theme.colorScheme.primary),
                                const SizedBox(height: 8),
                                Text('Mapa da Localização', style: Theme.of(context).textTheme.titleMedium),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.boat.marina.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(widget.boat.marina.address),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(Icons.phone_outlined, size: 16, color: theme.colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text(widget.boat.marina.phone, style: TextStyle(color: theme.colorScheme.primary)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Reviews
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ReviewsSection(
                reviews: widget.boat.reviews,
                averageRating: widget.boat.rating,
                totalReviews: widget.boat.reviewsCount,
              ),
            ),
          ),
          // Bottom Padding
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(theme),
      floatingActionButton: _buildShareButton(theme),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: _isScrolled 
          ? theme.colorScheme.surface.withOpacity(0.95)
          : Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
      ),
      title: AnimatedOpacity(
        opacity: _isScrolled ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Text(
          widget.boat.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {
              // Implementar compartilhamento
            },
            icon: const Icon(Icons.share_rounded, color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {
              setState(() => _isFavorite = !_isFavorite);
            },
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(ThemeData theme) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24.0,
        16.0,
        24.0,
        MediaQuery.of(context).padding.bottom + 16.0,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Price Info
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  widget.boat.price,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
          // Book Button
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(
                        boat: BoatModel(
                          id: widget.boat.id,
                          name: widget.boat.name,
                          location: widget.boat.location,
                          price: double.tryParse(widget.boat.price.replaceAll(RegExp(r'[^0-9,.]'), '').replaceAll(',', '.')) ?? 0.0,
                          rating: widget.boat.rating,
                          imageUrl: widget.boat.images.isNotEmpty ? widget.boat.images.first : '',
                          features: widget.boat.amenities.map((a) => a.name).toList(),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_today_rounded),
                label: const Text('Reservar Agora'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(ThemeData theme) {
    return FloatingActionButton(
      onPressed: () {
        // Implementar compartilhamento
      },
      backgroundColor: theme.colorScheme.secondaryContainer,
      foregroundColor: theme.colorScheme.onSecondaryContainer,
      child: const Icon(Icons.share_rounded),
    );
  }
} 