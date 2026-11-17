import 'package:faith_mobile/core/routes/app_routes.dart';
import 'package:faith_mobile/features/ai/domain/ai_exception.dart';
import 'package:faith_mobile/features/ai/domain/ai_gateway.dart';
import 'package:faith_mobile/features/ai/domain/ai_message.dart';
import 'package:faith_mobile/features/ai/presentation/bindings/ai_debug_binding.dart';
import 'package:faith_mobile/features/ai/presentation/pages/ai_debug_page.dart';
import 'package:faith_mobile/features/ai/presentation/widgets/ai_debug_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class _FakeAi implements AiGateway {
  _FakeAi(this._respond);

  final Future<String> Function() _respond;

  @override
  Future<String> generate({required String mode, required List<AiMessage> messages}) => _respond();
}

Future<void> _pumpHomeWithFab(WidgetTester tester, AiGateway ai) async {
  Get.put<AiGateway>(ai);
  await tester.pumpWidget(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const Scaffold(body: SizedBox(), floatingActionButton: AiDebugFab()),
        ),
        GetPage(
          name: AppRoutes.aiDebug,
          page: () => const AiDebugPage(),
          binding: AiDebugBinding(),
        ),
      ],
    ),
  );
}

void main() {
  tearDown(Get.reset);

  testWidgets('bug FAB opens the debug page, which shows the reply', (tester) async {
    await _pumpHomeWithFab(tester, _FakeAi(() async => 'Shalom dari gateway'));

    await tester.tap(find.byIcon(Icons.bug_report_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(AiDebugPage), findsOneWidget);

    await tester.tap(find.text('Kirim "Halo" (mode chat)'));
    await tester.pumpAndSettle();
    expect(find.text('Shalom dari gateway'), findsOneWidget);
  });

  testWidgets('debug page shows the error message', (tester) async {
    await _pumpHomeWithFab(
      tester,
      _FakeAi(
        () => Future.error(const AiException(AiErrorKind.unavailable, AiException.busyMessage)),
      ),
    );

    await tester.tap(find.byIcon(Icons.bug_report_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kirim "Halo" (mode chat)'));
    await tester.pumpAndSettle();
    expect(find.text(AiException.busyMessage), findsOneWidget);
  });
}
