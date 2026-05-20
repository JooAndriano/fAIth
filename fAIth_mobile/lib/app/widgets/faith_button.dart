import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

class FaithButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final Widget? leading;

  const FaithButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (loading) ...[
                const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: AppSpacing.xs),
              ] else if (leading != null) ...[
                leading!,
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
