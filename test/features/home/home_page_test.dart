import 'package:faith_mobile/features/home/presentation/controllers/home_controller.dart';
import 'package:faith_mobile/features/home/presentation/pages/home_page.dart';
import 'package:faith_mobile/features/shell/presentation/controllers/shell_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  late ShellController shell;

  setUp(() => shell = Get.put(ShellController()));
  tearDown(Get.reset);

  Future<void> pumpHome(
    WidgetTester tester, {
    HomeController? controller,
    bool dark = false,
    bool small = false,
  }) async {
    putHomeController(controller);
    await pumpApp(
      tester,
      const HomePage(),
      dark: dark,
      size: small ? kSmallScreen : null,
      textScale: small ? kLargeTextScale : 1,
      wrapInScaffold: false,
    );
    await tester.pumpAndSettle();
  }

  testWidgetsAllThemes('renders every section', (tester, {required dark, required small}) async {
    await pumpHome(tester, dark: dark, small: small);

    expect(find.text('Selamat pagi,'), findsOneWidget);
    expect(find.text('Maria'), findsOneWidget);
    expect(find.textContaining('kekuatan dan perisaiku'), findsOneWidget);
    expect(find.text('Ayat Hari Ini'), findsOneWidget);
    expect(find.text('Renungan Hari Ini'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Gereja Kasih Karunia'), 200);
    expect(find.text('Tanya fAIth'), findsOneWidget);
    expect(find.text('Jurnal Doa'), findsOneWidget);
    expect(find.text('0,8 km • Interdenominasi'), findsOneWidget);
  });

  testWidgets('without a user greets Sahabat and shows the initial fallback', (tester) async {
    await pumpHome(tester, controller: buildHomeController(user: null));
    expect(find.text('Sahabat'), findsOneWidget);
  });

  testWidgets('without a default favorite shows the prompt', (tester) async {
    await pumpHome(tester, controller: buildHomeController(favorites: const []));
    expect(find.text('Pilih ayat favorit sebagai penguat harianmu.'), findsOneWidget);
  });

  testWidgets('quick actions switch shell tabs', (tester) async {
    await pumpHome(tester);

    await tester.ensureVisible(find.text('Jurnal Doa'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jurnal Doa'));
    expect(shell.current.value, ShellTab.prayer);

    await tester.tap(find.text('Tanya fAIth'));
    expect(shell.current.value, ShellTab.chat);
  });

  testWidgets('a failed section shows retry without hiding the others', (tester) async {
    await pumpHome(tester, controller: buildHomeController(churches: FailingChurchRepository()));

    await tester.scrollUntilVisible(find.text('Daftar gereja gagal dimuat.'), 200);
    expect(find.byTooltip('Coba lagi'), findsOneWidget);
    // Other sections still render.
    expect(find.text('Jurnal Doa'), findsOneWidget);
  });
}
