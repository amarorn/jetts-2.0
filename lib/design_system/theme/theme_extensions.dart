import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';

class BoatTheme extends ThemeExtension<BoatTheme> {
  final Gradient oceanGradient;
  final Gradient sunsetGradient;
  final Gradient primaryGradient;

  const BoatTheme({
    required this.oceanGradient,
    required this.sunsetGradient,
    required this.primaryGradient,
  });

  @override
  ThemeExtension<BoatTheme> copyWith({
    Gradient? oceanGradient,
    Gradient? sunsetGradient,
    Gradient? primaryGradient,
  }) {
    return BoatTheme(
      oceanGradient: oceanGradient ?? this.oceanGradient,
      sunsetGradient: sunsetGradient ?? this.sunsetGradient,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }

  @override
  ThemeExtension<BoatTheme> lerp(
    ThemeExtension<BoatTheme>? other,
    double t,
  ) {
    if (other is! BoatTheme) {
      return this;
    }

    return BoatTheme(
      oceanGradient: Gradient.lerp(oceanGradient, other.oceanGradient, t)!,
      sunsetGradient: Gradient.lerp(sunsetGradient, other.sunsetGradient, t)!,
      primaryGradient: Gradient.lerp(primaryGradient, other.primaryGradient, t)!,
    );
  }

  static const light = BoatTheme(
    oceanGradient: AppColors.oceanGradient,
    sunsetGradient: AppColors.sunsetGradient,
    primaryGradient: AppColors.primaryGradient,
  );

  static const dark = BoatTheme(
    oceanGradient: AppColors.oceanGradient,
    sunsetGradient: AppColors.sunsetGradient,
    primaryGradient: AppColors.primaryGradient,
  );
} 