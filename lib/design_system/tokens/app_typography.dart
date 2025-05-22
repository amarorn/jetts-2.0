import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // 📝 Font Families
  static String get primary => GoogleFonts.inter().fontFamily!;
  static String get display => GoogleFonts.poppins().fontFamily!;
  static String get mono => GoogleFonts.jetBrainsMono().fontFamily!;

  // 📏 Font Sizes
  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double base = 14.0;
  static const double md = 16.0;
  static const double lg = 18.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 28.0;
  static const double display1 = 32.0;
  static const double display2 = 36.0;
  static const double display3 = 48.0;
  static const double display4 = 56.0;

  // ⚖️ Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // 📐 Line Heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;
  static const double lineHeightLoose = 1.8;

  // 🎨 Text Styles
  static TextStyle get displayLarge => GoogleFonts.poppins(
    fontSize: display4,
    fontWeight: bold,
    height: lineHeightTight,
  );

  static TextStyle get displayMedium => GoogleFonts.poppins(
    fontSize: display2,
    fontWeight: bold,
    height: lineHeightTight,
  );

  static TextStyle get displaySmall => GoogleFonts.poppins(
    fontSize: display1,
    fontWeight: bold,
    height: lineHeightTight,
  );

  static TextStyle get headlineLarge => GoogleFonts.poppins(
    fontSize: xxxl,
    fontWeight: semiBold,
    height: lineHeightNormal,
  );

  static TextStyle get headlineMedium => GoogleFonts.poppins(
    fontSize: xxl,
    fontWeight: semiBold,
    height: lineHeightNormal,
  );

  static TextStyle get headlineSmall => GoogleFonts.poppins(
    fontSize: xl,
    fontWeight: semiBold,
    height: lineHeightNormal,
  );

  static TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: lg,
    fontWeight: semiBold,
    height: lineHeightNormal,
  );

  static TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: md,
    fontWeight: semiBold,
    height: lineHeightNormal,
  );

  static TextStyle get titleSmall => GoogleFonts.inter(
    fontSize: base,
    fontWeight: medium,
    height: lineHeightNormal,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: md,
    fontWeight: regular,
    height: lineHeightRelaxed,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: base,
    fontWeight: regular,
    height: lineHeightRelaxed,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: sm,
    fontWeight: regular,
    height: lineHeightNormal,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: base,
    fontWeight: medium,
    height: lineHeightNormal,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: sm,
    fontWeight: medium,
    height: lineHeightNormal,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: xs,
    fontWeight: medium,
    height: lineHeightNormal,
  );
} 