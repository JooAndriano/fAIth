import 'package:faith_mobile/features/devotional/domain/models/devotional.dart';

/// Published devotionals. Implementations never return drafts.
abstract interface class DevotionalRepository {
  /// Devotional scheduled for [date], or null when none is published.
  Future<Devotional?> getForDate(DateTime date);
}
