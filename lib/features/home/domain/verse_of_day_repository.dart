import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';

/// Picks the Verse of the Day. Text is resolved through `BibleRepository`.
abstract interface class VerseOfDayRepository {
  Future<VerseRef> getForDate(DateTime date);
}
