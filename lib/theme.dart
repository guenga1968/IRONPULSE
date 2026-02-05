import 'package:flutter/material.dart';

// ================================================
// 🎨 LUXURY DESIGN SYSTEM - IRON PULSE
// ================================================
// Commitment: LUXURY + EXTREME ASYMMETRY (90/10)
// Geometry: 0px borders (sharp brutalist luxury)
// Palette: Black + Gold + Cyan (brand preservation)
// Depth: Multi-layer shadows (3-5 layers per card)
// ================================================

class LuxuryColors {
  // Primary Luxury Palette
  static const Color pureBlack = Color(0xFF000000); // Luxury base
  static const Color gold = Color(0xFFD4AF37); // Premium accent
  static const Color brandCyan = Color(0xFF06B6D4); // Preserved branding

  // Surface & Background
  static const Color background = Color(0xFF0F1115); // Deep near-black
  static const Color surface = Color(0xFF1C1F26); // Elevated dark
  static const Color surfaceElevated = Color(0xFF2D333D); // Higher elevation

  // Typography
  static const Color textPrimary = Color(0xFFFFFFFF); // Pure white
  static const Color textSecondary = Color(0xFF94A3B8); // Slate-400
  static const Color textTertiary = Color(0xFF64748B); // Slate-500

  // Semantic Colors
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color error = Color(0xFFEF4444); // Red-500

  // Input States
  static const Color inputBackground = Color(0xFF1C1F26);
  static const Color inputBorder = Color(0xFF2D333D);
  static const Color inputFocusBorder = gold; // Gold focus (luxury)
}

// ================================================
// 🌊 DEPTH SYSTEM - Multi-Layer Shadows
// ================================================
class DepthSystem {
  // Z-Layer Definitions
  static const double zBase = 0;
  static const double zLow = 1;
  static const double zMid = 2;
  static const double zHigh = 3;
  static const double zTop = 4;

  // Multi-Layer Shadow Presets
  static List<BoxShadow> get depth1 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get depth2 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get depth3 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get depth4 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      offset: const Offset(0, 16),
      blurRadius: 48,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get depth5 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      offset: const Offset(0, 24),
      blurRadius: 64,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      offset: const Offset(0, 16),
      blurRadius: 48,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  // Gold Glow Effect (for premium highlights)
  static List<BoxShadow> get goldGlow => [
    BoxShadow(
      color: LuxuryColors.gold.withValues(alpha: 0.3),
      offset: const Offset(0, 0),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: LuxuryColors.gold.withValues(alpha: 0.1),
      offset: const Offset(0, 0),
      blurRadius: 32,
      spreadRadius: 0,
    ),
  ];
}

// ================================================
// 📐 ASYMMETRIC CONSTANTS - 90/10 Layout Ratios
// ================================================
class AsymmetricConstants {
  // Layout Ratios
  static const double contentRatio = 0.10; // 10% content
  static const double spaceRatio = 0.90; // 90% negative space

  // Spacing System (extreme micro/macro)
  static const double spaceMicro = 8.0;
  static const double spaceSmall = 16.0;
  static const double spaceMedium = 24.0;
  static const double spaceLarge = 48.0;
  static const double spaceXLarge = 64.0;
  static const double spaceXXLarge = 96.0;

  // Border Radius (ALWAYS 0px for luxury brutalism)
  static const double borderRadiusSharp = 0.0;

  // Border Width
  static const double borderThin = 1.0;
  static const double borderMedium = 2.0;
  static const double borderThick = 3.0;
}

// ================================================
// 🎨 APP THEME - Luxury Dark Theme
// ================================================
class AppTheme {
  static ThemeData get luxuryDarkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: LuxuryColors.gold,
    scaffoldBackgroundColor: LuxuryColors.background,
    cardColor: LuxuryColors.surface,

    // Typography - Ultra-thin + Ultra-bold contrast
    textTheme: const TextTheme(
      // Display - Massive headlines (for asymmetric backgrounds)
      displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w900, // Ultra-bold
        color: LuxuryColors.textPrimary,
        letterSpacing: -3.0,
        height: 0.9,
      ),
      displayMedium: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.w900,
        color: LuxuryColors.textPrimary,
        letterSpacing: -2.0,
        height: 0.95,
      ),
      displaySmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: LuxuryColors.textPrimary,
        letterSpacing: -1.5,
        height: 1.0,
      ),

      // Headlines - Section titles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: LuxuryColors.textPrimary,
        letterSpacing: -0.64,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: LuxuryColors.textPrimary,
        letterSpacing: -0.48,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: LuxuryColors.textPrimary,
        letterSpacing: -0.4,
      ),

      // Titles - Card headers
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: LuxuryColors.textPrimary,
        letterSpacing: -0.36,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: LuxuryColors.textPrimary,
        letterSpacing: -0.32,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: LuxuryColors.textPrimary,
        letterSpacing: -0.28,
      ),

      // Body - Content text
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: LuxuryColors.textPrimary,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: LuxuryColors.textSecondary,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: LuxuryColors.textTertiary,
        height: 1.4,
      ),

      // Labels - Metadata, captions
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: LuxuryColors.textSecondary,
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: LuxuryColors.textSecondary,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w100, // Ultra-thin for luxury
        color: LuxuryColors.textTertiary,
        letterSpacing: 1.0,
      ),
    ),

    // Input Decoration - Sharp luxury inputs
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LuxuryColors.inputBackground,

      // Sharp borders (0px radius)
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: LuxuryColors.inputBorder,
          width: AsymmetricConstants.borderThin,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: LuxuryColors.gold, // Gold focus
          width: AsymmetricConstants.borderMedium,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: LuxuryColors.error,
          width: AsymmetricConstants.borderThin,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: LuxuryColors.error,
          width: AsymmetricConstants.borderMedium,
        ),
      ),

      labelStyle: const TextStyle(
        color: LuxuryColors.textSecondary,
        fontWeight: FontWeight.w100, // Ultra-thin
      ),
      hintStyle: TextStyle(
        color: LuxuryColors.textPrimary.withValues(alpha: 0.2),
        fontWeight: FontWeight.w100,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),

    // Elevated Button - Luxury gold buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: LuxuryColors.pureBlack,
        foregroundColor: LuxuryColors.gold,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Sharp edges
          side: BorderSide(
            color: LuxuryColors.gold,
            width: AsymmetricConstants.borderMedium,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
        elevation: 0, // No default elevation (we use custom shadows)
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LuxuryColors.gold,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Card Theme - Sharp luxury cards
    cardTheme: const CardThemeData(
      color: LuxuryColors.surface,
      elevation: 0, // Custom shadows via DepthSystem
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Sharp edges
      ),
      margin: EdgeInsets.zero,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: LuxuryColors.textPrimary.withValues(alpha: 0.1),
      thickness: 1,
      space: 1,
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: LuxuryColors.textPrimary, size: 24),
  );
}

// Backwards compatibility (deprecated, use LuxuryColors)
class AppColors {
  static const Color background = LuxuryColors.background;
  static const Color surface = LuxuryColors.surface;
  static const Color primary = LuxuryColors.brandCyan;
  static const Color secondary = LuxuryColors.textSecondary;
  static const Color textPrimary = LuxuryColors.textPrimary;
  static const Color textSecondary = LuxuryColors.textSecondary;
  static const Color success = LuxuryColors.success;
  static const Color warning = LuxuryColors.warning;
  static const Color error = LuxuryColors.error;
  static const Color inputBackground = LuxuryColors.inputBackground;
  static const Color inputBorder = LuxuryColors.inputBorder;
}
