import 'package:faith_mobile/core/theme/app_radius.dart';
import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:flutter/material.dart';

/// Primary call-to-action with the gold to sunset gradient.
///
/// Disabled when [onPressed] is null or [loading] is true.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  /// Fill the available width.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final enabled = onPressed != null && !loading;
    final radius = BorderRadius.circular(AppRadius.lg);
    final textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(color: faith.onAction);

    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: faith.onAction),
          )
        else if (icon != null)
          Icon(icon, size: 20, color: faith.onAction),
        if (loading || icon != null) const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(label, style: textStyle, textAlign: TextAlign.center),
        ),
      ],
    );

    return Semantics(
      button: true,
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(gradient: faith.actionGradient, borderRadius: radius),
            child: InkWell(
              onTap: enabled ? onPressed : null,
              borderRadius: radius,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  child: content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
