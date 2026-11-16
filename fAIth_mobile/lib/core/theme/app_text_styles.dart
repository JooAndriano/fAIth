import 'package:flutter/material.dart';

/// Typography scale.
/// Web base rules (theme.css): h1-h4/label/button font-weight: 500; line-height: 1.5.
abstract final class AppTextStyles {
  static const double lineHeight = 1.5;

  // Light defaults
  static const Color _c = Color(0xFF1A2332); // AppColors.foreground (const avoid import cycles)
  static const Color _muted = Color(0xFF6B7280); // AppColors.mutedForeground

  // Web-ish semantic names
  static const TextStyle h1 = TextStyle(
    fontSize: 32, // approx --text-2xl
    fontWeight: FontWeight.w500,
    height: lineHeight,
    color: _c,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24, // approx --text-xl
    fontWeight: FontWeight.w500,
    height: lineHeight,
    color: _c,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18, // approx --text-lg
    fontWeight: FontWeight.w500,
    height: lineHeight,
    color: _c,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 16, // --text-base
    fontWeight: FontWeight.w500,
    height: lineHeight,
    color: _c,
  );

  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: lineHeight,
    color: _c,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: lineHeight,
    color: _c,
  );

  static const TextStyle input = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: lineHeight,
    color: _c,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: lineHeight,
    color: _c,
  );

  static const TextStyle bodyMuted = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: lineHeight,
    color: _muted,
  );

  // Legacy aliases (keep existing callers compiling)
  static const TextStyle displayLarge = h1;
  static const TextStyle displayMedium = h2;
  static const TextStyle displaySmall = h3;

  static const TextStyle headlineMedium = h3;
  static const TextStyle headlineSmall = h4;

  static const TextStyle titleLarge = h4;

  static const TextStyle bodyLarge = body;
  static const TextStyle bodyMedium = body;
  static const TextStyle bodySmall = bodyMuted;

  static const TextStyle labelLarge = label;
  static const TextStyle labelMedium = label;
}
