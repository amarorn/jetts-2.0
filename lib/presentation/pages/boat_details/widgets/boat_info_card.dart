import 'package:flutter/material.dart';
import '../../../../design_system/tokens/app_typography.dart';
import '../../../../design_system/tokens/app_spacing.dart';
import '../../../../design_system/tokens/app_colors.dart';

class BoatInfoCard extends StatelessWidget {
  final String name;
  final String location;
  final double rating;
  final int reviewsCount;
  final String price;
  final int capacity;
  final double length;

  const BoatInfoCard({
    super.key,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    required this.capacity,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTypography.displaySmall.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.xs),
            Text(
              location,
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.star_rounded, size: 16, color: AppColors.tertiaryGold600),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    rating.toString(),
                    style: AppTypography.labelMedium.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '($reviewsCount)',
                    style: AppTypography.labelSmall.copyWith(
                      color: theme.colorScheme.onPrimaryContainer.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Text(
              price,
              style: AppTypography.headlineMedium.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: AppTypography.bold,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Row(
              children: [
                Icon(Icons.people_outline_rounded, size: 16, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Text('$capacity'),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Row(
              children: [
                Icon(Icons.straighten_rounded, size: 16, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Text('${length}m'),
              ],
            ),
          ],
        ),
      ],
    );
  }
} 