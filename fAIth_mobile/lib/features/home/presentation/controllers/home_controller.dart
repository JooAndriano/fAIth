import 'package:faith_mobile/features/auth/domain/app_user.dart';
import 'package:faith_mobile/features/bible/domain/models/passage.dart';
import 'package:faith_mobile/features/bible/domain/repositories/bible_repository.dart';
import 'package:faith_mobile/features/churches/domain/models/church.dart';
import 'package:faith_mobile/features/churches/domain/repositories/church_repository.dart';
import 'package:faith_mobile/features/devotional/domain/models/devotional.dart';
import 'package:faith_mobile/features/devotional/domain/repositories/devotional_repository.dart';
import 'package:faith_mobile/features/favorites/domain/repositories/favorite_verse_repository.dart';
import 'package:faith_mobile/features/home/domain/verse_of_day_repository.dart';
import 'package:faith_mobile/shared/state/view_state.dart';
import 'package:get/get.dart';

/// Beranda. Each section has its own [ViewState] so one failing source does not
/// hide the others.
class HomeController extends GetxController {
  HomeController({
    required UserSession session,
    required DevotionalRepository devotionals,
    required FavoriteVerseRepository favorites,
    required VerseOfDayRepository verseOfDay,
    required BibleRepository bible,
    required ChurchRepository churches,
    DateTime Function()? clock,
  })  : _session = session,
        _devotionals = devotionals,
        _favorites = favorites,
        _verseOfDay = verseOfDay,
        _bible = bible,
        _churches = churches,
        _clock = clock ?? DateTime.now;

  final UserSession _session;
  final DevotionalRepository _devotionals;
  final FavoriteVerseRepository _favorites;
  final VerseOfDayRepository _verseOfDay;
  final BibleRepository _bible;
  final ChurchRepository _churches;
  final DateTime Function() _clock;

  /// Default favorite verse; empty when the user has none.
  final encouragement = Rx<ViewState<Passage>>(const ViewLoading());
  final verseOfDay = Rx<ViewState<Passage>>(const ViewLoading());
  final todayDevotional = Rx<ViewState<Devotional>>(const ViewLoading());
  final nearestChurch = Rx<ViewState<Church>>(const ViewLoading());

  AppUser? get user => _session.currentUser;

  String get firstName => user?.firstName ?? 'Sahabat';

  String get greeting => greetingFor(_clock());

  /// "Selamat pagi/siang/sore/malam" by local hour.
  static String greetingFor(DateTime time) {
    final h = time.hour;
    if (h >= 4 && h < 11) return 'Selamat pagi';
    if (h >= 11 && h < 15) return 'Selamat siang';
    if (h >= 15 && h < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() => Future.wait([
        loadEncouragement(),
        loadVerseOfDay(),
        loadDevotional(),
        loadChurch(),
      ]);

  Future<void> loadEncouragement() => _run(encouragement, 'Ayat penguatan gagal dimuat.', () async {
        final favorite = await _favorites.getDefault();
        if (favorite == null) return null;
        return _bible.getPassage(favorite.ref, translationCode: favorite.translationCode);
      });

  Future<void> loadVerseOfDay() => _run(verseOfDay, 'Ayat hari ini gagal dimuat.', () async {
        final ref = await _verseOfDay.getForDate(_clock());
        return _bible.getPassage(ref);
      });

  Future<void> loadDevotional() => _run(
        todayDevotional,
        'Renungan hari ini gagal dimuat.',
        () => _devotionals.getForDate(_clock()),
      );

  Future<void> loadChurch() => _run(nearestChurch, 'Daftar gereja gagal dimuat.', () async {
        final list = await _churches.getNearby(limit: 1);
        return list.firstOrNull;
      });

  /// Runs [task] into [target]: null result becomes [ViewEmpty], a throw becomes [ViewError].
  Future<void> _run<T>(
    Rx<ViewState<T>> target,
    String errorMessage,
    Future<T?> Function() task,
  ) async {
    target.value = ViewLoading<T>();
    try {
      final result = await task();
      target.value = result == null ? ViewEmpty<T>() : ViewData<T>(result);
    } catch (_) {
      target.value = ViewError<T>(errorMessage);
    }
  }
}
