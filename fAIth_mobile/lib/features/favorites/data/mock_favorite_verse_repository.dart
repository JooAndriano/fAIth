import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';
import 'package:faith_mobile/features/favorites/domain/models/favorite_verse.dart';
import 'package:faith_mobile/features/favorites/domain/repositories/favorite_verse_repository.dart';
import 'package:faith_mobile/shared/data/mock_latency.dart';

/// In-memory favorite verses (Phase 2 dummy data).
class MockFavoriteVerseRepository implements FavoriteVerseRepository {
  MockFavoriteVerseRepository({this.latency = kMockLatency, List<FavoriteVerse>? seed})
      : _items = [...(seed ?? _sample())];

  final Duration latency;
  final List<FavoriteVerse> _items;

  @override
  Future<FavoriteVerse?> getDefault() async {
    await simulateLatency(latency);
    return _items.where((f) => f.isDefault).firstOrNull;
  }

  static List<FavoriteVerse> _sample() => [
        FavoriteVerse(
          id: 'fav-1',
          ref: VerseRef.parse('PSA:28:7'),
          translationCode: 'AYT',
          isDefault: true,
          createdAt: DateTime(2026, 11, 1),
        ),
        FavoriteVerse(
          id: 'fav-2',
          ref: VerseRef.parse('ISA:41:10'),
          translationCode: 'AYT',
          createdAt: DateTime(2026, 11, 5),
        ),
      ];
}
