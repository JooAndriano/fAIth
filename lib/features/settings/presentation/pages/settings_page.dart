import 'package:faith_mobile/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Pengaturan tab.
///
/// Interim version: lists every sub-screen so navigation can be checked on device.
/// Replaced by the real settings screen later in Phase 2.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const List<(String, IconData, String)> _links = [
    ('Profil', Icons.person_outline, AppRoutes.profile),
    ('Renungan Harian', Icons.wb_sunny_outlined, AppRoutes.devotional),
    ('Renungan Tersimpan', Icons.bookmark_border, AppRoutes.savedDevotionals),
    ('Ayat Favorit', Icons.favorite_border, AppRoutes.favoriteVerses),
    ('Baca Alkitab', Icons.chrome_reader_mode_outlined, AppRoutes.bibleReader),
    ('Semua Doa', Icons.list_alt, AppRoutes.allPrayers),
    ('Gereja Terdekat', Icons.place_outlined, AppRoutes.churches),
    ('Preferensi Rohani', Icons.tune, AppRoutes.spiritualPreferences),
    ('Tentang fAIth', Icons.info_outline, AppRoutes.about),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        children: [
          for (final (label, icon, route) in _links)
            ListTile(
              leading: Icon(icon),
              title: Text(label),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Get.toNamed<void>(route),
            ),
        ],
      ),
    );
  }
}
