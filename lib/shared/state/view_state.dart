/// UI state of a data-driven screen or section.
///
/// Controllers expose `Rx<ViewState<T>>`; pages render it with `ViewStateBuilder`.
sealed class ViewState<T> {
  const ViewState();

  /// Data if this is [ViewData], otherwise null.
  T? get dataOrNull => switch (this) {
        ViewData<T>(:final data) => data,
        _ => null,
      };

  bool get isLoading => this is ViewLoading<T>;
}

final class ViewLoading<T> extends ViewState<T> {
  const ViewLoading();
}

final class ViewEmpty<T> extends ViewState<T> {
  const ViewEmpty();
}

final class ViewError<T> extends ViewState<T> {
  const ViewError(this.message);

  /// User-facing message (Bahasa Indonesia).
  final String message;
}

final class ViewData<T> extends ViewState<T> {
  const ViewData(this.data);

  final T data;
}

/// Maps a loaded collection to [ViewEmpty] or [ViewData].
ViewState<List<E>> viewStateOfList<E>(List<E> items) =>
    items.isEmpty ? ViewEmpty<List<E>>() : ViewData<List<E>>(items);
