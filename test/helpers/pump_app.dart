import 'package:faith_mobile/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

/// Smallest supported layout (UX standard): 320dp wide, text scale 1.3.
const Size kSmallScreen = Size(320, 640);
const double kLargeTextScale = 1.3;

/// Pumps [child] inside a themed [GetMaterialApp].
///
/// Use [size] and [textScale] to check small screens and large text; any
/// RenderFlex overflow fails the test.
Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  bool dark = false,
  Size? size,
  double textScale = 1,
  bool wrapInScaffold = true,
}) async {
  if (size != null) {
    tester.view.physicalSize = size * tester.view.devicePixelRatio;
    addTearDown(tester.view.resetPhysicalSize);
  }
  await tester.pumpWidget(
    GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      builder: (context, app) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
        child: app!,
      ),
      home: wrapInScaffold ? Scaffold(body: child) : child,
    ),
  );
  await tester.pump();
}

/// Runs [body] for light and dark themes, each at default and small/large-text layouts.
void testWidgetsAllThemes(
  String description,
  Future<void> Function(WidgetTester tester, {required bool dark, required bool small}) body,
) {
  for (final dark in [false, true]) {
    for (final small in [false, true]) {
      final variant = '${dark ? 'dark' : 'light'}${small ? ', 320dp x1.3' : ''}';
      testWidgets('$description ($variant)', (tester) => body(tester, dark: dark, small: small));
    }
  }
}
