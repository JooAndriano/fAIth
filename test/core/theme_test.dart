import 'package:faith_mobile/core/theme/app_colors.dart';
import 'package:faith_mobile/core/theme/app_theme.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('light and dark have the expected brightness', () {
      expect(AppTheme.lightTheme.brightness, Brightness.light);
      expect(AppTheme.darkTheme.brightness, Brightness.dark);
    });

    test('both themes register FaithColors', () {
      expect(AppTheme.lightTheme.extension<FaithColors>(), FaithColors.light);
      expect(AppTheme.darkTheme.extension<FaithColors>(), FaithColors.dark);
    });

    test('text colors follow brightness (no navy text on dark)', () {
      expect(AppTheme.lightTheme.textTheme.bodyMedium?.color, AppColors.navy);
      expect(AppTheme.darkTheme.textTheme.bodyMedium?.color, AppColors.ivory);
      expect(AppTheme.darkTheme.textTheme.titleLarge?.color, AppColors.ivory);
      expect(AppTheme.darkTheme.textTheme.bodySmall?.color, AppColors.mutedForegroundDark);
    });

    test('body text is at least 14sp', () {
      final t = AppTheme.lightTheme.textTheme;
      for (final style in [t.bodyMedium, t.bodySmall, t.labelMedium, t.labelSmall]) {
        expect(style?.fontSize, greaterThanOrEqualTo(14));
      }
    });
  });

  group('FaithColors', () {
    test('lerp endpoints return each side', () {
      final start = FaithColors.light.lerp(FaithColors.dark, 0);
      final end = FaithColors.light.lerp(FaithColors.dark, 1);
      expect(start.gold, FaithColors.light.gold);
      expect(end.gold, FaithColors.dark.gold);
    });

    test('copyWith overrides only the given field', () {
      final copy = FaithColors.light.copyWith(gold: AppColors.sunset);
      expect(copy.gold, AppColors.sunset);
      expect(copy.sunset, FaithColors.light.sunset);
    });

    testWidgets('context.faith resolves the active theme', (tester) async {
      late FaithColors resolved;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Builder(
            builder: (context) {
              resolved = context.faith;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(resolved, FaithColors.dark);
    });
  });
}
