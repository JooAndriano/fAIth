import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';
import 'package:flutter/foundation.dart';

/// A verse the user saved. Stores the reference and translation code only;
/// the text is resolved through `BibleRepository` (see docs/DECISIONS.md).
@immutable
class FavoriteVerse {
  const FavoriteVerse({
    required this.id,
    required this.ref,
    required this.translationCode,
    required this.createdAt,
    this.note,
    this.isDefault = false,
  });

  final String id;
  final VerseRef ref;
  final String translationCode;
  final String? note;

  /// The default verse feeds the Home encouragement card. At most one is default.
  final bool isDefault;
  final DateTime createdAt;

  FavoriteVerse copyWith({
    VerseRef? ref,
    String? translationCode,
    String? note,
    bool? isDefault,
  }) {
    return FavoriteVerse(
      id: id,
      ref: ref ?? this.ref,
      translationCode: translationCode ?? this.translationCode,
      note: note ?? this.note,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt,
    );
  }
}
