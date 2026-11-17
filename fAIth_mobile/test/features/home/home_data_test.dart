import 'package:faith_mobile/features/auth/domain/app_user.dart';
import 'package:faith_mobile/features/churches/data/mock_church_repository.dart';
import 'package:faith_mobile/features/devotional/data/mock_devotional_repository.dart';
import 'package:faith_mobile/features/home/data/local_verse_of_day_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppUser', () {
    test('firstName and initial', () {
      const user = AppUser(uid: '1', displayName: '  Maria   Lestari ');
      expect(user.firstName, 'Maria');
      expect(user.initial, 'M');
    });

    test('falls back to email for the initial and null first name', () {
      const user = AppUser(uid: '1', email: 'budi@example.com');
      expect(user.firstName, isNull);
      expect(user.initial, 'B');
    });
  });

  group('MockDevotionalRepository', () {
    test('never returns drafts', () async {
      final repo = MockDevotionalRepository(latency: Duration.zero);
      for (var day = 0; day < 30; day++) {
        final d = await repo.getForDate(DateTime(2026).add(Duration(days: day)));
        expect(d?.isPublished, isTrue);
      }
    });

    test('returns null when nothing is published', () async {
      final repo = MockDevotionalRepository(latency: Duration.zero, seed: const []);
      expect(await repo.getForDate(DateTime(2026, 11, 17)), isNull);
    });
  });

  test('MockChurchRepository sorts nearest first and honors limit', () async {
    final list = await MockChurchRepository(latency: Duration.zero).getNearby(limit: 2);
    expect(list, hasLength(2));
    expect(list.first.distanceKm, lessThanOrEqualTo(list.last.distanceKm));
    expect(list.first.distanceLabel, '0,8 km');
  });

  test('LocalVerseOfDayRepository is stable for a date and rotates daily', () async {
    final repo = LocalVerseOfDayRepository(keys: const ['PSA:23:1', 'MAT:11:28']);
    final a = await repo.getForDate(DateTime(2026, 1, 1, 8));
    final b = await repo.getForDate(DateTime(2026, 1, 1, 22));
    final c = await repo.getForDate(DateTime(2026, 1, 2));
    expect(a, b);
    expect(a, isNot(c));
  });
}
