import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Brand tokens not covered by [ColorScheme], resolved per brightness.
///
/// Read with `context.faith` (see [FaithColorsX]).
@immutable
class FaithColors extends ThemeExtension<FaithColors> {
  const FaithColors({
    required this.gold,
    required this.sunset,
    required this.mutedForeground,
    required this.mutedSurface,
    required this.headerGradient,
    required this.onHeader,
    required this.onHeaderMuted,
    required this.highlightGradient,
    required this.goldBorder,
    required this.actionGradient,
    required this.onAction,
    required this.success,
  });

  /// Accent for active states, icons and verse references.
  final Color gold;
  final Color sunset;
  final Color mutedForeground;

  /// Subtle filled surface (web `--muted`).
  final Color mutedSurface;

  /// Navy header gradient (web `from-navy to-[#0f1419]`).
  final Gradient headerGradient;
  final Color onHeader;
  final Color onHeaderMuted;

  /// Soft gold to sunset card background (web `from-gold/10 to-sunset/10`).
  final Gradient highlightGradient;
  final Color goldBorder;

  /// Primary call-to-action gradient (web `from-gold to-sunset`).
  final Gradient actionGradient;

  /// Foreground on [actionGradient]: navy instead of the prototype's ivory, for contrast.
  final Color onAction;
  final Color success;

  static const FaithColors light = FaithColors(
    gold: AppColors.gold,
    sunset: AppColors.sunset,
    mutedForeground: AppColors.mutedForeground,
    mutedSurface: AppColors.muted,
    headerGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.navy, AppColors.backgroundDark],
    ),
    onHeader: AppColors.ivory,
    onHeaderMuted: Color(0xCCE8DCC8), // beige 80%
    highlightGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0x1AC9A961), Color(0x1AE8956F)],
    ),
    goldBorder: Color(0x33C9A961),
    actionGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.gold, AppColors.sunset],
    ),
    onAction: AppColors.navy,
    success: AppColors.success,
  );

  static const FaithColors dark = FaithColors(
    gold: AppColors.accent, // web --gold (dark)
    sunset: AppColors.sunset,
    mutedForeground: AppColors.mutedForegroundDark,
    mutedSurface: AppColors.secondaryDark,
    headerGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.secondaryDark, AppColors.navy],
    ),
    onHeader: AppColors.ivory,
    onHeaderMuted: Color(0xCCE8DCC8),
    highlightGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0x26D4A574), Color(0x1AE8956F)],
    ),
    goldBorder: Color(0x40D4A574),
    actionGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.accent, AppColors.sunset],
    ),
    onAction: AppColors.navy,
    success: Color(0xFF4ADE80),
  );

  @override
  FaithColors copyWith({
    Color? gold,
    Color? sunset,
    Color? mutedForeground,
    Color? mutedSurface,
    Gradient? headerGradient,
    Color? onHeader,
    Color? onHeaderMuted,
    Gradient? highlightGradient,
    Color? goldBorder,
    Gradient? actionGradient,
    Color? onAction,
    Color? success,
  }) {
    return FaithColors(
      gold: gold ?? this.gold,
      sunset: sunset ?? this.sunset,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      mutedSurface: mutedSurface ?? this.mutedSurface,
      headerGradient: headerGradient ?? this.headerGradient,
      onHeader: onHeader ?? this.onHeader,
      onHeaderMuted: onHeaderMuted ?? this.onHeaderMuted,
      highlightGradient: highlightGradient ?? this.highlightGradient,
      goldBorder: goldBorder ?? this.goldBorder,
      actionGradient: actionGradient ?? this.actionGradient,
      onAction: onAction ?? this.onAction,
      success: success ?? this.success,
    );
  }

  @override
  FaithColors lerp(ThemeExtension<FaithColors>? other, double t) {
    if (other is! FaithColors) return this;
    return FaithColors(
      gold: Color.lerp(gold, other.gold, t)!,
      sunset: Color.lerp(sunset, other.sunset, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      mutedSurface: Color.lerp(mutedSurface, other.mutedSurface, t)!,
      headerGradient: Gradient.lerp(headerGradient, other.headerGradient, t)!,
      onHeader: Color.lerp(onHeader, other.onHeader, t)!,
      onHeaderMuted: Color.lerp(onHeaderMuted, other.onHeaderMuted, t)!,
      highlightGradient: Gradient.lerp(highlightGradient, other.highlightGradient, t)!,
      goldBorder: Color.lerp(goldBorder, other.goldBorder, t)!,
      actionGradient: Gradient.lerp(actionGradient, other.actionGradient, t)!,
      onAction: Color.lerp(onAction, other.onAction, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

extension FaithColorsX on BuildContext {
  /// Brand colors of the current theme (falls back to light tokens).
  FaithColors get faith => Theme.of(this).extension<FaithColors>() ?? FaithColors.light;
}
