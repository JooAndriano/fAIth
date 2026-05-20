import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../chat/chat_page.dart';
import '../devotional/devotional_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../study/study_page.dart';

class ShellController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void setIndex(int index) {
    currentIndex.value = index;
  }

  void goToTab(int index) {
    setIndex(index);
    final target = AppRoutes.shellTabs[index];
    Get.offNamed(target);
  }

  int indexFromRoute(String? route) {
    final r = route ?? AppRoutes.home;
    final idx = AppRoutes.shellTabs.indexOf(r);
    return idx >= 0 ? idx : 0;
  }
}

class ShellPage extends StatelessWidget {
  const ShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShellController());

    final pages = [
      const HomePage(),
      const ChatPage(),
      const StudyPage(),
      const DevotionalPage(),
      const ProfilePage(),
    ];

    final route = Get.currentRoute;
    controller.setIndex(controller.indexFromRoute(route));

    return Obx(() {
      return Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.goToTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Study'),
            BottomNavigationBarItem(icon: Icon(Icons.wb_sunny), label: 'Devotional'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      );
    });
  }
}
