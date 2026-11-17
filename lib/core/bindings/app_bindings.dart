import 'package:faith_mobile/features/ai/data/ai_service.dart';
import 'package:faith_mobile/features/ai/domain/ai_gateway.dart';
import 'package:faith_mobile/features/auth/domain/app_user.dart';
import 'package:faith_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:faith_mobile/features/bible/data/mock_bible_repository.dart';
import 'package:faith_mobile/features/bible/domain/repositories/bible_repository.dart';
import 'package:faith_mobile/features/churches/data/mock_church_repository.dart';
import 'package:faith_mobile/features/churches/domain/repositories/church_repository.dart';
import 'package:faith_mobile/features/devotional/data/mock_devotional_repository.dart';
import 'package:faith_mobile/features/devotional/domain/repositories/devotional_repository.dart';
import 'package:faith_mobile/features/favorites/data/mock_favorite_verse_repository.dart';
import 'package:faith_mobile/features/favorites/domain/repositories/favorite_verse_repository.dart';
import 'package:faith_mobile/features/home/data/local_verse_of_day_repository.dart';
import 'package:faith_mobile/features/home/domain/verse_of_day_repository.dart';
import 'package:get/get.dart';

/// App-wide dependencies.
///
/// Repository interfaces are bound to their implementations here and only here;
/// Phase 3 swaps the Mock classes for Firestore/asset implementations.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    final auth = Get.put(AuthController(), permanent: true);
    Get.put<UserSession>(auth, permanent: true);

    Get.lazyPut<BibleRepository>(MockBibleRepository.new, fenix: true);
    Get.lazyPut<DevotionalRepository>(MockDevotionalRepository.new, fenix: true);
    Get.lazyPut<FavoriteVerseRepository>(MockFavoriteVerseRepository.new, fenix: true);
    Get.lazyPut<ChurchRepository>(MockChurchRepository.new, fenix: true);
    Get.lazyPut<VerseOfDayRepository>(LocalVerseOfDayRepository.new, fenix: true);
    Get.lazyPut<AiGateway>(AiService.new, fenix: true);
  }
}
