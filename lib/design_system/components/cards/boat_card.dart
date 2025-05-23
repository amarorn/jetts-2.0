import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../../tokens/app_radius.dart';
import '../../../domain/models/boat_model.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class BoatCard extends StatelessWidget {
  final BoatModel boat;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const BoatCard({
    super.key,
    required this.boat,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                // Boat Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.card),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      boat.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),

                // Discount Badge
                if (boat.discount != null)
                  Positioned(
                    top: AppSpacing.md,
                    left: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error500,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text(
                        '-${boat.discount}%',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                    ),
                  ),

                // Favorite Button
                Positioned(
                  top: AppSpacing.md,
                  right: AppSpacing.md,
                  child: GestureDetector(
                    onTap: onFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          boat.name,
                          style: AppTypography.titleLarge.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: AppTypography.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
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
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: AppColors.success500,
                              size: 16,
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

                  const SizedBox(height: AppSpacing.xs),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          boat.location,
                          style: AppTypography.bodyMedium.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Features
                  Wrap(
                    spacing: 6,
                    runSpacing: 2,
                    children: [
                      ...boat.features.take(3).map((feature) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: const EdgeInsets.only(right: 2, bottom: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          feature,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontSize: 11,
                          ),
                        ),
                      )),
                      if (boat.features.length > 3)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          margin: const EdgeInsets.only(right: 2, bottom: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            '+${boat.features.length - 3}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontSize: 11,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Price
                  Text(
                    'R\$ ${boat.price.toStringAsFixed(2)}',
                    style: AppTypography.titleLarge.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 