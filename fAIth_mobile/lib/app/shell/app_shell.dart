import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

/// Legacy shell shim.
///
/// Active shell is `pages/shell/shell_page.dart`. This file remains for stale
/// imports and delegates tab navigation through GetX route names.
class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final selectedIndex = AppRoutes.shellTabs.indexOf(currentRoute);

    return BottomNavigationBar(
      currentIndex: selectedIndex >= 0 ? selectedIndex : 0,
      onTap: (index) => Get.offNamed(AppRoutes.shellTabs[index]),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Study'),
        BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny), label: 'Devotional'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
