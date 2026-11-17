import 'package:faith_mobile/core/theme/app_theme.dart';
import 'package:faith_mobile/shared/widgets/faith_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: child),
    );

void main() {
  group('FaithButton', () {
    testWidgets('renders label and triggers onPressed', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(_wrap(FaithButton(label: 'Masuk', onPressed: () => tapped++)));

      expect(find.text('Masuk'), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, 1);
    });

    testWidgets('shows progress and disables tap while loading', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        _wrap(FaithButton(label: 'Masuk', loading: true, onPressed: () => tapped++)),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, 0);
    });
  });
}
