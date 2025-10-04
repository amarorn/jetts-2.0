import 'package:flutter/material.dart';
import '../boat_details_screen.dart';
import '../../../../design_system/tokens/app_spacing.dart';
import '../../../../design_system/tokens/app_typography.dart';

class ReviewsSection extends StatelessWidget {
  final List<ReviewModel> reviews;
  final double averageRating;
  final int totalReviews;
  const ReviewsSection({super.key, required this.reviews, required this.averageRating, required this.totalReviews});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star_rounded, color: theme.colorScheme.primary, size: 20),
            const SizedBox(width: AppSpacing.xs),
            Text(
              averageRating.toStringAsFixed(1),
              style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text('($totalReviews avaliações)', style: AppTypography.bodySmall),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...reviews.take(3).map((review) => _ReviewTile(review: review)),
        if (reviews.length > 3)
          TextButton(
            onPressed: () {},
            child: const Text('Ver todas avaliações'),
          ),
        const SizedBox(height: AppSpacing.md),
        // Botão para avaliar
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('/detailed-review', arguments: {
                'boatId': 'sample_boat_id',
                'boatName': 'Nome do Barco',
              });
            },
            icon: const Icon(Icons.rate_review_rounded),
            label: const Text('Avaliar este Barco'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final ReviewModel review;
  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(review.userAvatar),
            radius: 20,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.userName,
                      style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(Icons.star_rounded, color: theme.colorScheme.primary, size: 16),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: AppTypography.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  review.comment,
                  style: AppTypography.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _formatDate(review.date),
                  style: AppTypography.bodySmall.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
} 