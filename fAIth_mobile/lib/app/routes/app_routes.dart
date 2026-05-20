import 'package:get/get.dart';

import 'auth_middleware.dart';
import '../pages/splash/splash_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/shell/shell_page.dart';
import '../pages/not_found/not_found_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';

  static const String shell = '/shell';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String study = '/study';
  static const String devotional = '/devotional';
  static const String profile = '/profile';

  static const String _notFound = '/not-found';
  static String get notFound => _notFound;

  static final List<String> shellTabs = [
    home,
    chat,
    study,
    devotional,
    profile
  ];

  static final List<GetPage> _pages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: login, page: () => const LoginPage()),

    // Shell wrapper
    GetPage(
      name: shell,
      page: () => const ShellPage(),
      middlewares: [AuthMiddleware()],
    ),

    // Tab routes (route-driven shell)
    GetPage(
      name: home,
      page: () => const ShellPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: chat,
      page: () => const ShellPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: study,
      page: () => const ShellPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: devotional,
      page: () => const ShellPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: profile,
      page: () => const ShellPage(),
      middlewares: [AuthMiddleware()],
    ),

    // Unknown route fallback
    GetPage(name: _notFound, page: () => const NotFoundPage()),
  ];

  static List<GetPage> get pages => _pages;
}
