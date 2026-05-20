import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_page.dart';
import '../chat/chat_page.dart';
import '../study/study_page.dart';
import '../devotional/devotional_page.dart';
import '../profile/profile_page.dart';

class ShellController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class ShellPage extends StatelessWidget {
  const ShellPage({Key? key}) : super(key: key);

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

    return Obx(() {
      return Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Study',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny),
              label: 'Devotional',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }
}
