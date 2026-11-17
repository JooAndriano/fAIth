import 'package:faith_mobile/features/bible/domain/models/passage.dart';
import 'package:faith_mobile/features/bible/domain/models/translation.dart';
import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';
import 'package:faith_mobile/features/bible/domain/repositories/bible_repository.dart';
import 'package:faith_mobile/shared/data/mock_latency.dart';

/// In-memory Bible with a handful of verses (Phase 2 dummy data).
///
/// Indonesian texts are short sample paraphrases written for UI testing, NOT the
/// official AYT text; they are replaced by the licensed AYT asset in Phase 3.
/// English texts are KJV (public domain).
class MockBibleRepository implements BibleRepository {
  MockBibleRepository({this.latency = kMockLatency});

  final Duration latency;

  static const List<Translation> translations = [
    Translation(code: 'AYT', name: 'Alkitab Yang Terbuka', language: 'id'),
    Translation(code: 'KJV', name: 'King James Version', language: 'en'),
    Translation(code: 'WEB', name: 'World English Bible', language: 'en'),
  ];

  static const Map<String, Map<String, String>> _texts = {
    'AYT': {
      'PSA:28:7': 'TUHAN menjadi kekuatan dan perisaiku; hatiku berharap kepada-Nya, '
          'dan Ia menolongku.',
      'JER:29:11': 'Aku tahu rencana yang Kusiapkan bagimu, firman TUHAN: rencana damai, '
          'bukan celaka, untuk memberimu masa depan dan harapan.',
      'PSA:23:1': 'TUHAN menggembalakan aku; tak ada yang kurang padaku.',
      'ISA:41:10': 'Jangan takut, sebab Aku menyertaimu; jangan cemas, sebab Aku Allahmu. '
          'Aku akan meneguhkan dan menolongmu.',
      'MAT:11:28': 'Datanglah kepada-Ku, kalian semua yang letih dan berbeban berat, '
          'Aku akan memberi kelegaan bagimu.',
      'PHP:4:13': 'Aku sanggup menanggung segala sesuatu di dalam Dia yang menguatkan aku.',
      'JHN:14:27': 'Damai sejahtera Kutinggalkan bagimu; damai-Ku Kuberikan kepadamu. '
          'Janganlah hatimu gelisah dan gentar.',
    },
    'KJV': {
      'PSA:28:7': 'The LORD is my strength and my shield; my heart trusted in him, '
          'and I am helped.',
      'PSA:23:1': 'The LORD is my shepherd; I shall not want.',
      'PHP:4:13': 'I can do all things through Christ which strengtheneth me.',
    },
  };

  @override
  Future<List<Translation>> getTranslations() async {
    await simulateLatency(latency);
    return translations;
  }

  @override
  Future<Passage?> getPassage(
    VerseRef ref, {
    String translationCode = Translation.defaultCode,
  }) async {
    await simulateLatency(latency);
    final translation = translations.where((t) => t.code == translationCode).firstOrNull;
    final text = _texts[translationCode]?[ref.key];
    if (translation == null || text == null) return null;
    return Passage(ref: ref, translation: translation, text: text);
  }
}
