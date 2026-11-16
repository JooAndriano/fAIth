import 'package:flutter/material.dart';

/// Design tokens: colors (mirrors `fAIth_web/src/styles/theme.css`).
abstract final class AppColors {
  // Base palette (web tokens)
  static const Color navy = Color(0xFF1A2332); // --navy/--foreground/--primary (light)
  static const Color ivory = Color(0xFFFAF8F5); // --ivory/--background (light)
  static const Color beige = Color(0xFFE8DCC8); // --beige/--secondary (light)
  static const Color muted = Color(0xFFF5F1E8); // --muted (light)

  static const Color accent = Color(0xFFD4A574); // --accent
  static const Color gold = Color(0xFFC9A961); // --gold (light)
  static const Color sunset = Color(0xFFE8956F); // --sunset

  // Theme semantic aliases (light)
  static const Color background = ivory; // --background (light)
  static const Color foreground = navy; // --foreground (light)
  static const Color surface = Color(0xFFFFFFFF); // --card (light)

  // Theme semantic aliases (dark)
  static const Color backgroundDark = Color(0xFF0F1419); // --background (dark)
  static const Color foregroundDark = ivory; // --foreground (dark)
  static const Color surfaceDark = navy; // --card/--popover (dark)
  static const Color secondaryDark = Color(0xFF2A3544); // --secondary/--muted (dark)

  // Text/utility
  static const Color mutedForeground = Color(0xFF6B7280); // --muted-foreground (light)
  static const Color mutedForegroundDark = Color(0xFF9CA3AF); // --muted-foreground (dark)

  static const Color border = Color.fromRGBO(26, 35, 50, 0.1); // --border (light)
  static const Color borderDark = Color.fromRGBO(232, 220, 200, 0.15); // --border (dark)

  static const Color destructive = Color(0xFFD4183D); // --destructive (light)

  // Legacy semantic (keep for existing UI; map to new tokens)
  static const Color primaryGold = accent;
  static const Color sunsetAccent = sunset;

  static const Color grey = mutedForegroundDark; // close to typical neutral
  static const Color darkGrey = mutedForeground;

  static const Color divider = border; // light divider

  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFDC2626);
}
