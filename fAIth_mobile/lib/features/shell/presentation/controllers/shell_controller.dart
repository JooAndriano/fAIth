import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Bottom navigation tabs, in display order.
enum ShellTab {
  home('Beranda', Icons.home_outlined, Icons.home),
  chat('Tanya fAIth', Icons.chat_bubble_outline, Icons.chat_bubble),
  bible('Alkitab', Icons.menu_book_outlined, Icons.menu_book),
  prayer('Doa', Icons.edit_note_outlined, Icons.edit_note),
  settings('Pengaturan', Icons.settings_outlined, Icons.settings);

  const ShellTab(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Holds the selected tab. Other features switch tabs with `Get.find<ShellController>().select`.
class ShellController extends GetxController {
  ShellController({ShellTab initial = ShellTab.home}) : current = initial.obs;

  final Rx<ShellTab> current;

  void select(ShellTab tab) => current.value = tab;

  void selectIndex(int index) => select(ShellTab.values[index]);

  /// Handles system back: from another tab, go to Beranda first.
  /// Returns true when the back press was consumed.
  bool handleBack() {
    if (current.value == ShellTab.home) return false;
    select(ShellTab.home);
    return true;
  }
}
