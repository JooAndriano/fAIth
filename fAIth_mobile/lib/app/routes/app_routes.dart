import 'package:get/get.dart';
import '../pages/splash/splash_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/shell/shell_page.dart';
import '../pages/home/home_page.dart';
import '../pages/chat/chat_page.dart';
import '../pages/study/study_page.dart';
import '../pages/devotional/devotional_page.dart';
import '../pages/profile/profile_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String shell = '/shell';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String study = '/study';
  static const String devotional = '/devotional';
  static const String profile = '/profile';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: shell,
      page: () => const ShellPage(),
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: chat,
      page: () => const ChatPage(),
    ),
    GetPage(
      name: study,
      page: () => const StudyPage(),
    ),
    GetPage(
      name: devotional,
      page: () => const DevotionalPage(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
    ),
  ];
}
