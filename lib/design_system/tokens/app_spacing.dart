class AppSpacing {
  // 📐 Base unit: 4px
  static const double base = 4.0;

  // 📏 Spacing Scale
  static const double none = 0.0;
  static const double xxs = base * 0.5;    // 2px
  static const double xs = base;           // 4px
  static const double sm = base * 2;       // 8px
  static const double md = base * 3;       // 12px
  static const double lg = base * 4;       // 16px
  static const double xl = base * 6;       // 24px
  static const double xxl = base * 8;      // 32px
  static const double xxxl = base * 12;    // 48px
  static const double huge = base * 16;    // 64px
  static const double giant = base * 24;   // 96px

  // 📱 Semantic Spacing
  static const double screenPadding = lg;
  static const double cardPadding = lg;
  static const double sectionSpacing = xxl;
  static const double elementSpacing = md;
  static const double microSpacing = xs;
} 