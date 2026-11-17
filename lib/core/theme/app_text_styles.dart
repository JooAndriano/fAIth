import 'package:flutter/material.dart';

/// Typography scale (sizes and weights only).
///
/// Colors are intentionally absent: [textTheme] applies the foreground color per
/// brightness, so widgets must read styles from `Theme.of(context).textTheme`.
/// Web base rules (theme.css): headings/labels weight 500, line-height 1.5.
abstract final class AppTextStyles {
  static const double lineHeight = 1.5;

  static const TextStyle h1 = TextStyle(fontSize: 32, fontWeight: FontWeight.w500, height: 1.25);
  static const TextStyle h2 = TextStyle(fontSize: 24, fontWeight: FontWeight.w500, height: 1.3);
  static const TextStyle h3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1.4);
  static const TextStyle h4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: lineHeight,
  );
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: lineHeight,
  );
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: lineHeight,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: lineHeight,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: lineHeight,
  );

  /// Full [TextTheme] colored for one brightness.
  /// `bodySmall`/`labelSmall` use the muted color; minimum size is 14sp (UX standard).
  static TextTheme textTheme({required Color foreground, required Color muted}) {
    return TextTheme(
      displayLarge: h1.copyWith(color: foreground),
      displayMedium: h2.copyWith(color: foreground),
      displaySmall: h3.copyWith(color: foreground),
      headlineLarge: h1.copyWith(color: foreground),
      headlineMedium: h2.copyWith(color: foreground),
      headlineSmall: h3.copyWith(color: foreground),
      titleLarge: h3.copyWith(color: foreground),
      titleMedium: h4.copyWith(color: foreground),
      titleSmall: label.copyWith(color: foreground),
      bodyLarge: bodyLarge.copyWith(color: foreground),
      bodyMedium: body.copyWith(color: foreground),
      bodySmall: body.copyWith(color: muted),
      labelLarge: button.copyWith(color: foreground),
      labelMedium: label.copyWith(color: foreground),
      labelSmall: label.copyWith(color: muted),
    );
  }
}
