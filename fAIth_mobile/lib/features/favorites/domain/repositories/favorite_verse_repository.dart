import 'package:faith_mobile/features/favorites/domain/models/favorite_verse.dart';

/// The signed-in user's favorite verses. Extended with CRUD in bolt 013.
abstract interface class FavoriteVerseRepository {
  /// The default favorite, or null when the user has none.
  Future<FavoriteVerse?> getDefault();
}
