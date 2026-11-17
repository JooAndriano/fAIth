import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:faith_mobile/shared/state/view_state.dart';
import 'package:flutter/material.dart';

/// Centered spinner with an optional message.
class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Icon + title + message, with an optional action (e.g. "Tambah").
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return _StateMessage(
      icon: icon,
      iconColor: context.faith.gold,
      title: title,
      message: message,
      action: actionLabel != null && onAction != null
          ? OutlinedButton(onPressed: onAction, child: Text(actionLabel!))
          : null,
    );
  }
}

/// Error message with a retry button.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    this.title = 'Terjadi kesalahan',
    required this.message,
    this.onRetry,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _StateMessage(
      icon: Icons.error_outline,
      iconColor: Theme.of(context).colorScheme.error,
      title: title,
      message: message,
      action: onRetry != null
          ? OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba lagi'),
            )
          : null,
    );
  }
}

class _StateMessage extends StatelessWidget {
  const _StateMessage({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.message,
    this.action,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: text.titleMedium, textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(message!, style: text.bodySmall, textAlign: TextAlign.center),
            ],
            if (action != null) ...[
              const SizedBox(height: AppSpacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Renders a [ViewState]: loading, empty, error (with retry) or [builder] for data.
class ViewStateBuilder<T> extends StatelessWidget {
  const ViewStateBuilder({
    super.key,
    required this.state,
    required this.builder,
    this.onRetry,
    this.emptyTitle = 'Belum ada data',
    this.emptyMessage,
    this.emptyIcon = Icons.inbox_outlined,
    this.emptyActionLabel,
    this.onEmptyAction,
    this.loadingMessage,
  });

  final ViewState<T> state;
  final Widget Function(BuildContext context, T data) builder;
  final VoidCallback? onRetry;
  final String emptyTitle;
  final String? emptyMessage;
  final IconData emptyIcon;
  final String? emptyActionLabel;
  final VoidCallback? onEmptyAction;
  final String? loadingMessage;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      ViewLoading<T>() => LoadingState(message: loadingMessage),
      ViewEmpty<T>() => EmptyState(
          title: emptyTitle,
          message: emptyMessage,
          icon: emptyIcon,
          actionLabel: emptyActionLabel,
          onAction: onEmptyAction,
        ),
      ViewError<T>(:final message) => ErrorState(message: message, onRetry: onRetry),
      ViewData<T>(:final data) => builder(context, data),
    };
  }
}
