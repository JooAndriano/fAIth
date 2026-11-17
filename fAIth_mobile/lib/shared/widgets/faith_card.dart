import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Surface card using the theme's card shape (rounded, hairline border).
/// The ripple is drawn inside the card when [onTap] is set.
class FaithCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const FaithCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }
}
