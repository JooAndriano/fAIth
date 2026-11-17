import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/material.dart';

/// Beranda tab. Built in bolt 008-home.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: const EmptyState(icon: Icons.home_outlined, title: 'Segera hadir'),
    );
  }
}
