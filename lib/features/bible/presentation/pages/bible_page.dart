import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/material.dart';

/// Alkitab tab. Built in bolt 011-bible-study.
class BiblePage extends StatelessWidget {
  const BiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alkitab')),
      body: const EmptyState(icon: Icons.menu_book_outlined, title: 'Segera hadir'),
    );
  }
}
