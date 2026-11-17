import 'package:flutter/foundation.dart';

import 'translation.dart';
import 'verse_ref.dart';

/// A reference resolved to text in one translation.
@immutable
class Passage {
  const Passage({required this.ref, required this.translation, required this.text});

  final VerseRef ref;
  final Translation translation;
  final String text;

  /// e.g. "Mazmur 23:1 (AYT)".
  String get label => '${ref.label(language: translation.language)} (${translation.code})';
}
