import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/material.dart';

/// Doa (prayer journal) tab. Built in bolt 012-prayer-journal.
class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jurnal Doa')),
      body: const EmptyState(icon: Icons.edit_note_outlined, title: 'Segera hadir'),
    );
  }
}
