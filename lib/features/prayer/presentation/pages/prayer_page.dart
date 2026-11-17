import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/material.dart';

/// Doa (prayer journal) tab. Placeholder until the prayer journal is built.
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
