import 'package:flutter/material.dart';
import '../boat_details_screen.dart';
import '../../../../design_system/tokens/app_spacing.dart';

class AmenitiesGrid extends StatelessWidget {
  final List<AmenityModel> amenities;
  const AmenitiesGrid({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 1,
      ),
      itemCount: amenities.length,
      itemBuilder: (context, index) {
        final amenity = amenities[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              amenity.icon,
              color: amenity.isAvailable ? theme.colorScheme.primary : theme.disabledColor,
              size: 28,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              amenity.name,
              style: TextStyle(
                color: amenity.isAvailable ? theme.colorScheme.onSurface : theme.disabledColor,
                fontWeight: amenity.isAvailable ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
} 