import 'package:faith_mobile/features/bible/data/mock_bible_repository.dart';
import 'package:faith_mobile/features/bible/domain/models/bible_book.dart';
import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BibleBooks', () {
    test('has the 66-book canon with unique ids', () {
      expect(BibleBooks.all, hasLength(66));
      expect(BibleBooks.all.map((b) => b.id).toSet(), hasLength(66));
      expect(BibleBooks.all.where((b) => b.testament == Testament.old), hasLength(39));
    });
  });

  group('VerseRef', () {
    test('round-trips single verses and ranges', () {
      for (final key in ['PSA:23:1', 'PHP:4:6-7', '1JN:1:9']) {
        expect(VerseRef.parse(key).key, key);
      }
    });

    test('labels in Indonesian and English', () {
      final ref = VerseRef.parse('PHP:4:6-7');
      expect(ref.label(), 'Filipi 4:6-7');
      expect(ref.label(language: 'en'), 'Philippians 4:6-7');
      expect(ref.verses, [6, 7]);
    });

    test('rejects malformed keys and unknown books', () {
      for (final key in ['', 'PSA 23:1', 'XYZ:1:1', 'PSA:0:1', 'PSA:1:']) {
        expect(() => VerseRef.parse(key), throwsA(anything), reason: key);
      }
    });

    test('equality uses the key', () {
      expect(VerseRef.parse('PSA:23:1'), const VerseRef('PSA', 23, 1));
    });
  });

  group('MockBibleRepository', () {
    final repo = MockBibleRepository(latency: Duration.zero);

    test('only offers openly licensed translations', () async {
      final codes = (await repo.getTranslations()).map((t) => t.code);
      expect(codes, ['AYT', 'KJV', 'WEB']);
      expect(codes, isNot(anyOf(contains('TB'), contains('BIS'), contains('TL'))));
    });

    test('resolves known passages and returns null otherwise', () async {
      final passage = await repo.getPassage(VerseRef.parse('PSA:23:1'), translationCode: 'KJV');
      expect(passage?.text, contains('shepherd'));
      expect(passage?.label, 'Psalms 23:1 (KJV)');
      expect(await repo.getPassage(VerseRef.parse('GEN:1:1')), isNull);
    });
  });
}
