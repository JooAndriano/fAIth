import 'package:faith_mobile/features/churches/domain/models/church.dart';

/// Churches near the user, nearest first.
abstract interface class ChurchRepository {
  Future<List<Church>> getNearby({int limit = 20});
}
