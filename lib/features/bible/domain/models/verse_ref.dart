import 'package:flutter/foundation.dart';

import 'bible_book.dart';

/// Reference to one verse or a verse range within a single chapter.
///
/// Stored as a key `BOOK:chapter:verse[-verseEnd]` (e.g. `PSA:23:1`, `PHP:4:6-7`),
/// never with the verse text (decision D8).
@immutable
class VerseRef {
  const VerseRef(this.bookId, this.chapter, this.verseStart, [this.verseEnd])
      : assert(chapter > 0 && verseStart > 0),
        assert(verseEnd == null || verseEnd > verseStart);

  final String bookId;
  final int chapter;
  final int verseStart;
  final int? verseEnd;

  static final RegExp _keyPattern = RegExp(r'^([1-3]?[A-Z]{2,3}):(\d+):(\d+)(?:-(\d+))?$');

  /// Parses a key produced by [key]. Throws [FormatException] when malformed.
  factory VerseRef.parse(String key) {
    final m = _keyPattern.firstMatch(key);
    if (m == null || BibleBooks.byId(m.group(1)!) == null) {
      throw FormatException('Invalid verse reference', key);
    }
    final end = m.group(4);
    return VerseRef(
      m.group(1)!,
      int.parse(m.group(2)!),
      int.parse(m.group(3)!),
      end == null ? null : int.parse(end),
    );
  }

  String get key => '$bookId:$chapter:$verseStart${verseEnd == null ? '' : '-$verseEnd'}';

  BibleBook? get book => BibleBooks.byId(bookId);

  /// Verse numbers covered by this reference.
  Iterable<int> get verses sync* {
    for (var v = verseStart; v <= (verseEnd ?? verseStart); v++) {
      yield v;
    }
  }

  /// Human-readable label, e.g. "Mazmur 23:1" or "Philippians 4:6-7".
  String label({String language = 'id'}) {
    final name = book?.nameFor(language) ?? bookId;
    return '$name $chapter:$verseStart${verseEnd == null ? '' : '-$verseEnd'}';
  }

  @override
  bool operator ==(Object other) => other is VerseRef && other.key == key;

  @override
  int get hashCode => key.hashCode;

  @override
  String toString() => key;
}
