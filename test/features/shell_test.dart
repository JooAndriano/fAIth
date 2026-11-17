import 'package:faith_mobile/core/routes/app_routes.dart';
import 'package:faith_mobile/core/routes/auth_middleware.dart';
import 'package:faith_mobile/features/bible/presentation/pages/bible_page.dart';
import 'package:faith_mobile/features/home/presentation/pages/home_page.dart';
import 'package:faith_mobile/features/shell/presentation/controllers/shell_controller.dart';
import 'package:faith_mobile/features/shell/presentation/pages/shell_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

void main() {
  late ShellController controller;

  setUp(() {
    controller = Get.put(ShellController());
    putHomeController();
  });
  tearDown(Get.reset);

  Finder navLabel(String label) =>
      find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

  testWidgetsAllThemes('shows the five tabs', (tester, {required dark, required small}) async {
    await pumpApp(
      tester,
      const ShellPage(),
      dark: dark,
      size: small ? kSmallScreen : null,
      textScale: small ? kLargeTextScale : 1,
      wrapInScaffold: false,
    );

    for (final label in ['Beranda', 'Tanya fAIth', 'Alkitab', 'Doa', 'Pengaturan']) {
      expect(navLabel(label), findsOneWidget);
    }
  });

  testWidgets('tapping a tab switches content and keeps other tabs alive', (tester) async {
    await pumpApp(tester, const ShellPage(), wrapInScaffold: false);

    await tester.tap(navLabel('Alkitab'));
    await tester.pump();

    expect(controller.current.value, ShellTab.bible);
    final stack = tester.widget<IndexedStack>(find.byType(IndexedStack));
    expect(stack.index, ShellTab.bible.index);
    // Home stays mounted (offstage) so its state survives the switch.
    expect(find.byType(HomePage, skipOffstage: false), findsOneWidget);
    expect(find.byType(BiblePage), findsOneWidget);
  });

  test('back from another tab returns to Beranda first', () {
    controller.select(ShellTab.prayer);
    expect(controller.handleBack(), isTrue);
    expect(controller.current.value, ShellTab.home);
    expect(controller.handleBack(), isFalse);
  });

  group('AppRoutes', () {
    test('every sub-screen route is registered and guarded', () {
      const subRoutes = [
        AppRoutes.devotional,
        AppRoutes.savedDevotionals,
        AppRoutes.bibleReader,
        AppRoutes.favoriteVerses,
        AppRoutes.allPrayers,
        AppRoutes.churches,
        AppRoutes.profile,
        AppRoutes.spiritualPreferences,
        AppRoutes.about,
        AppRoutes.shell,
      ];
      for (final route in subRoutes) {
        final page = AppRoutes.pages.singleWhere((p) => p.name == route);
        expect(
          (page.middlewares ?? const []).whereType<AuthMiddleware>(),
          isNotEmpty,
          reason: route,
        );
      }
    });
  });
}
