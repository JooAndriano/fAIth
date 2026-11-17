import 'package:faith_mobile/features/bible/presentation/pages/bible_page.dart';
import 'package:faith_mobile/features/chat/presentation/pages/chat_page.dart';
import 'package:faith_mobile/features/home/presentation/pages/home_page.dart';
import 'package:faith_mobile/features/prayer/presentation/pages/prayer_page.dart';
import 'package:faith_mobile/features/settings/presentation/pages/settings_page.dart';
import 'package:faith_mobile/features/shell/presentation/controllers/shell_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Five-tab shell. Tabs are kept alive in an [IndexedStack] so their scroll
/// position and state survive tab switches.
class ShellPage extends GetView<ShellController> {
  const ShellPage({super.key});

  static const List<Widget> _tabs = [
    HomePage(),
    ChatPage(),
    BiblePage(),
    PrayerPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final current = controller.current.value;
      return PopScope(
        canPop: current == ShellTab.home,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) controller.handleBack();
        },
        child: Scaffold(
          body: IndexedStack(index: current.index, children: _tabs),
          bottomNavigationBar: NavigationBar(
            selectedIndex: current.index,
            onDestinationSelected: controller.selectIndex,
            destinations: [
              for (final tab in ShellTab.values)
                NavigationDestination(
                  icon: Icon(tab.icon),
                  selectedIcon: Icon(tab.selectedIcon),
                  label: tab.label,
                  tooltip: tab.label,
                ),
            ],
          ),
        ),
      );
    });
  }
}
