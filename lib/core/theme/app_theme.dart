import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // ── Brand palette (60-30-10) ──────────────────────────────────────────
  static const Color primary = Color(
    0xFF1D3557,
  ); // 30% Navy — structure & depth
  static const Color primaryLight = Color(0xFF2E4E7E);
  static const Color accent = Color(0xFF136DEC); // 10% Blue — action & focus
  static const Color accentHover = Color(0xFF0F5CC0);
  static const Color accentLight = Color(0xFFEBF3FE); // very light blue tint

  // ── Backgrounds (60% white base) ──────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF); // Main page bg
  static const Color surface = Color(0xFFF4F6F8); // Alternate section bg
  static const Color surfaceLight = Color(0xFFEDF2FB); // Light blue-gray
  static const Color cardBg = Color(0xFFFFFFFF); // Card background

  // ── Text ──────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1D3557); // Navy headings
  static const Color textSecondary = Color(0xFF6B7280); // Gray paragraphs
  static const Color textMuted = Color(0xFF9CA3AF); // Placeholders / muted
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkMuted = Color(0xFFDDE3EA);

  // ── Borders ───────────────────────────────────────────────────────────
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);

  // ── Semantic ──────────────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);

  // ── Gradients ─────────────────────────────────────────────────────────

  /// Hero background: white → very light blue
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF0F5FF)],
  );

  /// CTA buttons
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF136DEC), Color(0xFF0F5CC0)],
  );

  /// Icon bubbles in steps / badges
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1D3557), Color(0xFF2E4E7E)],
  );

  /// Light card gradient
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFF)],
  );

  /// Dark sections (technicians + footer)
  static const LinearGradient darkSectionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1D3557), Color(0xFF152840)],
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.primary,
        surface: AppColors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    );
  }
}
