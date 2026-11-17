import 'package:faith_mobile/features/bible/domain/models/passage.dart';
import 'package:faith_mobile/features/bible/domain/models/translation.dart';
import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';

/// Read access to Bible text. Phase 3 implements it from bundled assets.
abstract interface class BibleRepository {
  /// Translations available on this device.
  Future<List<Translation>> getTranslations();

  /// Text of [ref] in [translationCode], or null when the passage is not available.
  Future<Passage?> getPassage(VerseRef ref, {String translationCode = Translation.defaultCode});
}
