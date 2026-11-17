import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';
import 'package:flutter/foundation.dart';

enum DevotionalStatus { draft, published }

/// One daily devotional, in the Phase 3 content format (decision D7).
///
/// [verseText] is quoted from the Bible asset, never written by AI.
@immutable
class Devotional {
  const Devotional({
    required this.id,
    required this.dayNumber,
    required this.title,
    required this.verseRef,
    required this.verseText,
    required this.body,
    required this.reflectionQuestions,
    required this.prayer,
    this.tags = const [],
    this.status = DevotionalStatus.published,
  });

  final String id;
  final int dayNumber;
  final String title;
  final VerseRef verseRef;
  final String verseText;
  final String body;
  final List<String> reflectionQuestions;
  final String prayer;
  final List<String> tags;
  final DevotionalStatus status;

  bool get isPublished => status == DevotionalStatus.published;
}
