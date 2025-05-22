import 'package:flutter/material.dart';

class AppColors {
  // 🌊 Primary Palette - Ocean Blues
  static const Color primaryBlue50 = Color(0xFFE3F2FD);
  static const Color primaryBlue100 = Color(0xFFBBDEFB);
  static const Color primaryBlue200 = Color(0xFF90CAF9);
  static const Color primaryBlue300 = Color(0xFF64B5F6);
  static const Color primaryBlue400 = Color(0xFF42A5F5);
  static const Color primaryBlue500 = Color(0xFF2196F3); // Primary
  static const Color primaryBlue600 = Color(0xFF1E88E5);
  static const Color primaryBlue700 = Color(0xFF1976D2);
  static const Color primaryBlue800 = Color(0xFF1565C0);
  static const Color primaryBlue900 = Color(0xFF0D47A1);

  // 🌅 Secondary Palette - Sunset Orange
  static const Color secondaryOrange50 = Color(0xFFFFF3E0);
  static const Color secondaryOrange100 = Color(0xFFFFE0B2);
  static const Color secondaryOrange200 = Color(0xFFFFCC80);
  static const Color secondaryOrange300 = Color(0xFFFFB74D);
  static const Color secondaryOrange400 = Color(0xFFFFA726);
  static const Color secondaryOrange500 = Color(0xFFFF9800); // Secondary
  static const Color secondaryOrange600 = Color(0xFFFB8C00);
  static const Color secondaryOrange700 = Color(0xFFF57C00);
  static const Color secondaryOrange800 = Color(0xFFEF6C00);
  static const Color secondaryOrange900 = Color(0xFFE65100);

  // 🏖️ Tertiary Palette - Sandy Gold
  static const Color tertiaryGold50 = Color(0xFFFFFDE7);
  static const Color tertiaryGold100 = Color(0xFFFFF9C4);
  static const Color tertiaryGold200 = Color(0xFFFFF59D);
  static const Color tertiaryGold300 = Color(0xFFFFF176);
  static const Color tertiaryGold400 = Color(0xFFFFEE58);
  static const Color tertiaryGold500 = Color(0xFFFFEB3B); // Tertiary
  static const Color tertiaryGold600 = Color(0xFFFDD835);
  static const Color tertiaryGold700 = Color(0xFFFBC02D);
  static const Color tertiaryGold800 = Color(0xFFF9A825);
  static const Color tertiaryGold900 = Color(0xFFF57F17);

  // 🎨 Neutral Palette - Modern Grays
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);
  static const Color neutral950 = Color(0xFF0A0A0A);

  // 🚨 Semantic Colors
  static const Color success50 = Color(0xFFE8F5E8);
  static const Color success500 = Color(0xFF4CAF50);
  static const Color success100 = Color(0xFFC8E6C9);
  static const Color success900 = Color(0xFF1B5E20);

  static const Color error50 = Color(0xFFFFEBEE);
  static const Color error500 = Color(0xFFF44336);
  static const Color error100 = Color(0xFFFFCDD2);
  static const Color error900 = Color(0xFFB71C1C);

  static const Color warning50 = Color(0xFFFFF8E1);
  static const Color warning500 = Color(0xFFFF9800);
  static const Color warning100 = Color(0xFFFFF8E1);
  static const Color warning900 = Color(0xFFFF6F00);

  static const Color info50 = Color(0xFFE3F2FD);
  static const Color info500 = Color(0xFF2196F3);
  static const Color info900 = Color(0xFF0D47A1);

  // 🌙 Dark Theme Colors
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkSurfaceVariant = Color(0xFF1E1E1E);
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkOutline = Color(0xFF2E2E2E);

  // 🎭 Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryBlue400, primaryBlue600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient secondaryGradient = LinearGradient(
    colors: [secondaryOrange400, secondaryOrange600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient oceanGradient = LinearGradient(
    colors: [primaryBlue300, primaryBlue700, primaryBlue900],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient sunsetGradient = LinearGradient(
    colors: [secondaryOrange300, secondaryOrange600, primaryBlue400],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
} 