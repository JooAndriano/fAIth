import 'package:faith_mobile/core/theme/app_radius.dart';
import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:flutter/material.dart';

/// Shows a themed modal bottom sheet with an optional [title].
///
/// The sheet scrolls when content is taller than the screen and lifts above the keyboard.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  String? title,
  required WidgetBuilder builder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheetContext).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          0,
          AppSpacing.xl,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              Text(title, style: Theme.of(sheetContext).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
            ],
            builder(sheetContext),
          ],
        ),
      ),
    ),
  );
}

/// Full-width action row for bottom sheets (icon chip + label).
class SheetAction extends StatelessWidget {
  const SheetAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final scheme = Theme.of(context).colorScheme;
    final color = destructive ? scheme.error : faith.gold;
    final radius = BorderRadius.circular(AppRadius.lg);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: faith.mutedSurface,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: destructive ? scheme.error : null,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
