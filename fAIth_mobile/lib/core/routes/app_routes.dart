import 'package:faith_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:faith_mobile/features/not_found/presentation/pages/not_found_page.dart';
import 'package:faith_mobile/features/profile/presentation/pages/profile_page.dart';
import 'package:faith_mobile/features/shell/presentation/controllers/shell_controller.dart';
import 'package:faith_mobile/features/shell/presentation/pages/shell_page.dart';
import 'package:faith_mobile/features/splash/presentation/pages/splash_page.dart';
import 'package:faith_mobile/shared/widgets/coming_soon.dart';
import 'package:get/get.dart';

import 'auth_middleware.dart';

/// Route names and the GetX page table.
///
/// The five tabs live inside [shell]; every other screen is pushed on top of it
/// with `Get.toNamed` so the system back button returns to the previous screen.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String shell = '/shell';

  // Sub-screens (pushed over the shell).
  static const String devotional = '/devotional';
  static const String savedDevotionals = '/devotional/saved';
  static const String bibleReader = '/bible/reader';
  static const String favoriteVerses = '/favorite-verses';
  static const String allPrayers = '/prayers';
  static const String churches = '/churches';
  static const String profile = '/profile';
  static const String spiritualPreferences = '/settings/preferences';
  static const String about = '/settings/about';

  static const String notFound = '/not-found';

  /// Screens not built yet, with their titles. Each later bolt replaces its entry.
  static const Map<String, String> _pendingScreens = {
    devotional: 'Renungan Harian',
    savedDevotionals: 'Renungan Tersimpan',
    bibleReader: 'Baca Alkitab',
    favoriteVerses: 'Ayat Favorit',
    allPrayers: 'Semua Doa',
    churches: 'Gereja Terdekat',
    spiritualPreferences: 'Preferensi Rohani',
    about: 'Tentang fAIth',
  };

  static final List<GetPage<dynamic>> pages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(
      name: shell,
      page: () => const ShellPage(),
      binding: BindingsBuilder(() {
        Get.put(ShellController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: profile, page: () => const ProfilePage(), middlewares: [AuthMiddleware()]),
    for (final entry in _pendingScreens.entries)
      GetPage(
        name: entry.key,
        page: () => ComingSoonPage(title: entry.value),
        middlewares: [AuthMiddleware()],
      ),
    GetPage(name: notFound, page: () => const NotFoundPage()),
  ];
}
