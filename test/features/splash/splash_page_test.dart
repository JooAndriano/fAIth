import 'package:faith_mobile/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  final total = SplashPage.introDuration + SplashPage.holdDuration;

  Future<int Function()> pumpSplash(WidgetTester tester, {Size? size, double textScale = 1}) async {
    var finished = 0;
    await pumpApp(
      tester,
      SplashPage(onFinished: () => finished++),
      size: size,
      textScale: textScale,
      wrapInScaffold: false,
    );
    return () => finished;
  }

  testWidgets('shows logo, name and tagline after the intro', (tester) async {
    await pumpSplash(tester);
    await tester.pump(SplashPage.introDuration);

    expect(find.bySemanticsLabel('Logo fAIth'), findsOneWidget);
    expect(find.text('fAIth', findRichText: true), findsOneWidget);
    expect(find.text('Pendamping rohani pribadimu'), findsOneWidget);
  });

  testWidgets('calls onFinished once after intro + hold', (tester) async {
    final finished = await pumpSplash(tester);

    await tester.pump(SplashPage.introDuration);
    expect(finished(), 0);

    await tester.pump(SplashPage.holdDuration);
    await tester.pump(total);
    expect(finished(), 1);
  });

  testWidgets('logo starts centered like the native splash', (tester) async {
    await pumpSplash(tester);

    final logo = tester.getCenter(find.bySemanticsLabel('Logo fAIth'));
    final screen = tester.getCenter(find.byType(SplashPage));
    expect(logo.dx, moreOrLessEquals(screen.dx, epsilon: 0.5));
    expect(logo.dy, moreOrLessEquals(screen.dy, epsilon: 0.5));
  });

  testWidgets('fits a small screen with large text', (tester) async {
    await pumpSplash(tester, size: kSmallScreen, textScale: kLargeTextScale);
    await tester.pump(total);
    expect(tester.takeException(), isNull);
  });

  testWidgets('skips the animation when animations are disabled', (tester) async {
    var finished = 0;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MaterialApp(home: SplashPage(onFinished: () => finished++)),
      ),
    );

    expect(find.text('Pendamping rohani pribadimu'), findsOneWidget);
    await tester.pump(SplashPage.holdDuration);
    expect(finished, 1);
  });
}
