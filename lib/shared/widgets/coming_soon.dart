import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/material.dart';

/// Shows the standard "Segera hadir" snackbar for features not built yet.
void showComingSoon(BuildContext context, [String? feature]) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(feature == null ? 'Segera hadir' : '$feature segera hadir')),
    );
}

/// Placeholder screen for routes whose screen is delivered by a later bolt.
class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const EmptyState(
        icon: Icons.construction_outlined,
        title: 'Segera hadir',
        message: 'Layar ini sedang disiapkan.',
      ),
    );
  }
}
