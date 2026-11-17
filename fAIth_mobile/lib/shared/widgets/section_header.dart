import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:flutter/material.dart';

/// Section title with an optional trailing action ("Lihat semua").
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(title, style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(foregroundColor: context.faith.gold),
              child: Text(actionLabel!),
            ),
        ],
      ),
    );
  }
}
