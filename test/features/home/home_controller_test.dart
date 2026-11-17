import 'package:faith_mobile/features/home/presentation/controllers/home_controller.dart';
import 'package:faith_mobile/shared/state/view_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

void main() {
  group('greetingFor', () {
    final cases = {
      4: 'Selamat pagi',
      10: 'Selamat pagi',
      11: 'Selamat siang',
      14: 'Selamat siang',
      15: 'Selamat sore',
      17: 'Selamat sore',
      18: 'Selamat malam',
      3: 'Selamat malam',
    };
    cases.forEach((hour, expected) {
      test('$hour:00 -> $expected', () {
        expect(HomeController.greetingFor(DateTime(2026, 1, 1, hour)), expected);
      });
    });
  });

  test('first name falls back to Sahabat', () {
    expect(buildHomeController().firstName, 'Maria');
    expect(buildHomeController(user: null).firstName, 'Sahabat');
  });

  test('load fills every section', () async {
    final c = buildHomeController();
    await c.load();

    expect(c.encouragement.value.dataOrNull?.ref.key, 'PSA:28:7');
    expect(c.verseOfDay.value, isA<ViewData<Object>>());
    expect(c.todayDevotional.value.dataOrNull?.isPublished, isTrue);
    expect(c.nearestChurch.value.dataOrNull?.name, 'Gereja Kasih Karunia');
  });

  test('no default favorite gives an empty encouragement', () async {
    final c = buildHomeController(favorites: const []);
    await c.load();
    expect(c.encouragement.value, isA<ViewEmpty<Object>>());
  });

  test('a failing source only errors its own section', () async {
    final c = buildHomeController(churches: FailingChurchRepository());
    await c.load();
    expect(c.nearestChurch.value, isA<ViewError<Object>>());
    expect(c.todayDevotional.value, isA<ViewData<Object>>());
  });
}
