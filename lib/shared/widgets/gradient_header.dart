import 'package:faith_mobile/core/theme/app_radius.dart';
import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:flutter/material.dart';

/// Navy gradient header with rounded bottom corners (prototype screen headers).
///
/// Text and icons inside inherit `FaithColors.onHeader`. Pass [onBack] for pushed
/// sub-screens to show a back button.
class GradientHeader extends StatelessWidget {
  const GradientHeader({
    super.key,
    this.title,
    this.subtitle,
    this.onBack,
    this.trailing,
    this.child,
  });

  final String? title;
  final String? subtitle;
  final VoidCallback? onBack;
  final Widget? trailing;

  /// Extra content below the title row (e.g. a search field or a card).
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final text = Theme.of(context).textTheme;
    final hasTitleRow = title != null || onBack != null || trailing != null;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: faith.headerGradient,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppRadius.xxl)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.md,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: IconTheme.merge(
            data: IconThemeData(color: faith.onHeader),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: faith.onHeader),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasTitleRow)
                    Row(
                      children: [
                        if (onBack != null) ...[
                          IconButton(
                            onPressed: onBack,
                            icon: const Icon(Icons.arrow_back),
                            tooltip: 'Kembali',
                            color: faith.onHeader,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (subtitle != null)
                                Text(
                                  subtitle!,
                                  style: text.bodyMedium?.copyWith(color: faith.onHeaderMuted),
                                ),
                              if (title != null)
                                Text(
                                  title!,
                                  style: text.headlineMedium?.copyWith(color: faith.onHeader),
                                ),
                            ],
                          ),
                        ),
                        if (trailing != null) trailing!,
                      ],
                    ),
                  if (child != null) ...[
                    if (hasTitleRow) const SizedBox(height: AppSpacing.lg),
                    child!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
