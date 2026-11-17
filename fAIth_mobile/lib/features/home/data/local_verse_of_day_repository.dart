import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';
import 'package:faith_mobile/features/home/domain/verse_of_day_repository.dart';

/// Rotates through a fixed list of references by day of year. Needs no backend,
/// so it can stay in Phase 3 (only the list grows).
class LocalVerseOfDayRepository implements VerseOfDayRepository {
  LocalVerseOfDayRepository({List<String>? keys}) : _keys = keys ?? defaultKeys;

  final List<String> _keys;

  static const List<String> defaultKeys = [
    'JER:29:11',
    'PSA:23:1',
    'ISA:41:10',
    'MAT:11:28',
    'PHP:4:13',
    'JHN:14:27',
    'PSA:28:7',
  ];

  @override
  Future<VerseRef> getForDate(DateTime date) async {
    final dayOfYear = date.difference(DateTime(date.year)).inDays;
    return VerseRef.parse(_keys[dayOfYear % _keys.length]);
  }
}
