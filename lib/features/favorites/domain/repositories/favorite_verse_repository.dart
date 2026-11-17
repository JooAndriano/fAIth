import 'package:faith_mobile/features/favorites/domain/models/favorite_verse.dart';

/// The signed-in user's favorite verses. CRUD is added with the favorites screen.
abstract interface class FavoriteVerseRepository {
  /// The default favorite, or null when the user has none.
  Future<FavoriteVerse?> getDefault();
}
