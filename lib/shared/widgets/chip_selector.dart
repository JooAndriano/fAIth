import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Single-choice chip group (filters, categories).
///
/// Scrolls horizontally by default; set [wrap] to lay chips out on multiple lines.
class ChipSelector<T> extends StatelessWidget {
  const ChipSelector({
    super.key,
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
    this.wrap = false,
  });

  final List<T> options;
  final T? selected;
  final String Function(T option) labelOf;
  final ValueChanged<T> onSelected;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    final chips = [
      for (final option in options)
        ChoiceChip(
          label: Text(labelOf(option)),
          selected: option == selected,
          onSelected: (_) => onSelected(option),
        ),
    ];

    if (wrap) {
      return Wrap(spacing: AppSpacing.xs, runSpacing: AppSpacing.xs, children: chips);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < chips.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.xs),
            chips[i],
          ],
        ],
      ),
    );
  }
}
