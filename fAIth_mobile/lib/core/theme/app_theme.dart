import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';
import 'faith_colors.dart';

/// Light and dark [ThemeData] built from one recipe so both stay in parity.
abstract final class AppTheme {
  static ThemeData get lightTheme => _build(
        brightness: Brightness.light,
        scheme: const ColorScheme.light(
          primary: AppColors.navy, // web --primary (light)
          onPrimary: AppColors.ivory,
          secondary: AppColors.beige,
          onSecondary: AppColors.navy,
          tertiary: AppColors.gold,
          onTertiary: AppColors.navy,
          surface: AppColors.surface, // --card
          onSurface: AppColors.navy,
          onSurfaceVariant: AppColors.mutedForeground,
          surfaceContainerHighest: AppColors.muted,
          outline: AppColors.border,
          outlineVariant: AppColors.border,
          error: AppColors.destructive,
          onError: AppColors.surface,
        ),
        background: AppColors.background,
        muted: AppColors.mutedForeground,
        inputFill: AppColors.muted,
        border: AppColors.border,
        faith: FaithColors.light,
      );

  static ThemeData get darkTheme => _build(
        brightness: Brightness.dark,
        scheme: const ColorScheme.dark(
          primary: AppColors.beige, // web --primary (dark)
          onPrimary: AppColors.navy,
          secondary: AppColors.secondaryDark,
          onSecondary: AppColors.ivory,
          tertiary: AppColors.accent,
          onTertiary: AppColors.navy,
          surface: AppColors.surfaceDark, // --card (dark)
          onSurface: AppColors.ivory,
          onSurfaceVariant: AppColors.mutedForegroundDark,
          surfaceContainerHighest: AppColors.secondaryDark,
          outline: AppColors.borderDark,
          outlineVariant: AppColors.borderDark,
          error: AppColors.destructiveDark,
          onError: AppColors.navy,
        ),
        background: AppColors.backgroundDark,
        muted: AppColors.mutedForegroundDark,
        inputFill: AppColors.secondaryDark,
        border: AppColors.borderDark,
        faith: FaithColors.dark,
      );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required Color background,
    required Color muted,
    required Color inputFill,
    required Color border,
    required FaithColors faith,
  }) {
    final textTheme = AppTextStyles.textTheme(foreground: scheme.onSurface, muted: muted);
    final radiusLg = BorderRadius.circular(AppRadius.lg);
    OutlineInputBorder inputBorder(Color c, [double w = 1]) =>
        OutlineInputBorder(borderRadius: radiusLg, borderSide: BorderSide(color: c, width: w));

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: background,
      dividerColor: border,
      extensions: [faith],
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: border),
        ),
      ),
      dividerTheme: DividerThemeData(color: border, space: 1, thickness: 1),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: faith.goldBorder,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? faith.gold : muted,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppTextStyles.label.copyWith(fontSize: 12, color: faith.gold)
              : AppTextStyles.body.copyWith(fontSize: 12, color: muted),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: faith.gold,
          foregroundColor: AppColors.navy,
          elevation: 0,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.sm),
          shape: RoundedRectangleBorder(borderRadius: radiusLg),
          textStyle: AppTextStyles.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          minimumSize: const Size(48, 48),
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(borderRadius: radiusLg),
          textStyle: AppTextStyles.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.onSurface,
          textStyle: AppTextStyles.label,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: inputFill,
        selectedColor: faith.gold,
        side: BorderSide.none,
        labelStyle: AppTextStyles.label.copyWith(color: scheme.onSurface),
        secondaryLabelStyle: AppTextStyles.label.copyWith(color: AppColors.navy),
        shape: const StadiumBorder(),
        showCheckmark: false,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: muted,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: faith.gold),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? faith.gold : inputFill,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill, // web --input-background
        hintStyle: AppTextStyles.body.copyWith(color: muted),
        border: inputBorder(border),
        enabledBorder: inputBorder(border),
        focusedBorder: inputBorder(faith.gold, 2),
        errorBorder: inputBorder(scheme.error),
        focusedErrorBorder: inputBorder(scheme.error, 2),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}
