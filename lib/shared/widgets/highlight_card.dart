import 'package:faith_mobile/core/theme/app_radius.dart';
import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:flutter/material.dart';

/// Soft gold/sunset card for featured content (Verse of the Day, highlights).
class HighlightCard extends StatelessWidget {
  const HighlightCard({
    super.key,
    this.icon,
    this.label,
    required this.child,
    this.onTap,
  });

  final IconData? icon;
  final String? label;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final radius = BorderRadius.circular(AppRadius.lg);

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: faith.highlightGradient,
          borderRadius: radius,
          border: Border.all(color: faith.goldBorder),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null || label != null) ...[
                  Row(
                    children: [
                      if (icon != null) Icon(icon, size: 20, color: faith.gold),
                      if (icon != null && label != null) const SizedBox(width: AppSpacing.xs),
                      if (label != null)
                        Expanded(
                          child: Text(label!, style: Theme.of(context).textTheme.bodySmall),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
