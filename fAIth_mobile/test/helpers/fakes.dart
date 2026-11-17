import 'package:faith_mobile/features/auth/domain/app_user.dart';
import 'package:faith_mobile/features/bible/data/mock_bible_repository.dart';
import 'package:faith_mobile/features/churches/data/mock_church_repository.dart';
import 'package:faith_mobile/features/churches/domain/models/church.dart';
import 'package:faith_mobile/features/churches/domain/repositories/church_repository.dart';
import 'package:faith_mobile/features/devotional/data/mock_devotional_repository.dart';
import 'package:faith_mobile/features/favorites/data/mock_favorite_verse_repository.dart';
import 'package:faith_mobile/features/favorites/domain/models/favorite_verse.dart';
import 'package:faith_mobile/features/home/data/local_verse_of_day_repository.dart';
import 'package:faith_mobile/features/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class FakeUserSession implements UserSession {
  FakeUserSession([this.currentUser]);

  @override
  AppUser? currentUser;
}

class FailingChurchRepository implements ChurchRepository {
  @override
  Future<List<Church>> getNearby({int limit = 20}) => Future.error(Exception('offline'));
}

const testUser = AppUser(uid: 'u1', displayName: 'Maria Lestari', email: 'maria@example.com');

/// Fixed clock: 17 Nov 2026, 07:30 (pagi).
DateTime morningClock() => DateTime(2026, 11, 17, 7, 30);

/// HomeController wired to zero-latency mocks.
HomeController buildHomeController({
  AppUser? user = testUser,
  List<FavoriteVerse>? favorites,
  ChurchRepository? churches,
  DateTime Function() clock = morningClock,
}) {
  return HomeController(
    session: FakeUserSession(user),
    devotionals: MockDevotionalRepository(latency: Duration.zero),
    favorites: MockFavoriteVerseRepository(latency: Duration.zero, seed: favorites),
    verseOfDay: LocalVerseOfDayRepository(),
    bible: MockBibleRepository(latency: Duration.zero),
    churches: churches ?? MockChurchRepository(latency: Duration.zero),
    clock: clock,
  );
}

/// Registers HomeController for widgets that build the Beranda tab.
HomeController putHomeController([HomeController? controller]) =>
    Get.put(controller ?? buildHomeController());
