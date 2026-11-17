import 'package:faith_mobile/shared/state/view_state.dart';
import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  group('ViewState', () {
    test('dataOrNull only returns data for ViewData', () {
      expect(const ViewData<int>(3).dataOrNull, 3);
      expect(const ViewLoading<int>().dataOrNull, isNull);
      expect(const ViewError<int>('x').dataOrNull, isNull);
      expect(const ViewEmpty<int>().dataOrNull, isNull);
    });

    test('viewStateOfList maps empty lists to ViewEmpty', () {
      expect(viewStateOfList(<int>[]), isA<ViewEmpty<List<int>>>());
      expect(viewStateOfList([1]), isA<ViewData<List<int>>>());
    });
  });

  group('ViewStateBuilder', () {
    Widget build(ViewState<String> state, {VoidCallback? onRetry}) => ViewStateBuilder<String>(
          state: state,
          onRetry: onRetry,
          emptyTitle: 'Belum ada doa',
          builder: (_, data) => Text('data:$data'),
        );

    testWidgets('loading shows a spinner', (tester) async {
      await pumpApp(tester, build(const ViewLoading()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('empty shows the empty title', (tester) async {
      await pumpApp(tester, build(const ViewEmpty()));
      expect(find.text('Belum ada doa'), findsOneWidget);
    });

    testWidgets('error shows message and retries', (tester) async {
      var retries = 0;
      await pumpApp(tester, build(const ViewError('Gagal memuat'), onRetry: () => retries++));
      expect(find.text('Gagal memuat'), findsOneWidget);
      await tester.tap(find.text('Coba lagi'));
      expect(retries, 1);
    });

    testWidgets('data renders the builder', (tester) async {
      await pumpApp(tester, build(const ViewData('ok')));
      expect(find.text('data:ok'), findsOneWidget);
    });
  });
}
