import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:faith_mobile/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

const _longText = 'Teks panjang untuk menguji pembungkusan baris pada layar kecil dengan '
    'ukuran huruf yang diperbesar agar tidak terjadi overflow sama sekali.';

Future<void> _pump(WidgetTester tester, Widget child, {required bool dark, required bool small}) {
  return pumpApp(
    tester,
    SingleChildScrollView(child: child),
    dark: dark,
    size: small ? kSmallScreen : null,
    textScale: small ? kLargeTextScale : 1,
  );
}

void main() {
  testWidgetsAllThemes('GradientHeader shows title, subtitle and back', (
    tester, {
    required dark,
    required small,
  }) async {
    var back = 0;
    await _pump(
      tester,
      GradientHeader(
        subtitle: 'Selamat pagi,',
        title: 'Sahabat dengan nama yang cukup panjang',
        onBack: () => back++,
        trailing: const Icon(Icons.person),
        child: const Text(_longText),
      ),
      dark: dark,
      small: small,
    );

    expect(find.text('Selamat pagi,'), findsOneWidget);
    final title = tester.widget<Text>(find.text('Sahabat dengan nama yang cukup panjang'));
    final context = tester.element(find.byType(GradientHeader));
    expect(title.style?.color, context.faith.onHeader);

    await tester.tap(find.byTooltip('Kembali'));
    expect(back, 1);
  });

  testWidgetsAllThemes('SectionHeader action is tappable', (
    tester, {
    required dark,
    required small,
  }) async {
    var taps = 0;
    await _pump(
      tester,
      SectionHeader(title: 'Doa Terbaru', actionLabel: 'Lihat semua', onAction: () => taps++),
      dark: dark,
      small: small,
    );
    await tester.tap(find.text('Lihat semua'));
    expect(taps, 1);
  });

  testWidgetsAllThemes('HighlightCard renders label and content', (
    tester, {
    required dark,
    required small,
  }) async {
    await _pump(
      tester,
      const HighlightCard(
        icon: Icons.menu_book,
        label: 'Ayat Hari Ini',
        child: Text(_longText),
      ),
      dark: dark,
      small: small,
    );
    expect(find.text('Ayat Hari Ini'), findsOneWidget);
    expect(find.text(_longText), findsOneWidget);
  });

  testWidgetsAllThemes('GradientButton taps when enabled only', (
    tester, {
    required dark,
    required small,
  }) async {
    var taps = 0;
    await _pump(
      tester,
      Column(
        children: [
          GradientButton(label: 'Simpan Doa', icon: Icons.check, onPressed: () => taps++),
          GradientButton(label: 'Memuat', loading: true, onPressed: () => taps++),
          const GradientButton(label: 'Nonaktif', onPressed: null),
        ],
      ),
      dark: dark,
      small: small,
    );

    await tester.tap(find.text('Simpan Doa'));
    await tester.tap(find.text('Memuat'));
    await tester.tap(find.text('Nonaktif'));
    expect(taps, 1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgetsAllThemes('ChipSelector reports the selected option', (
    tester, {
    required dark,
    required small,
  }) async {
    String? picked;
    await _pump(
      tester,
      ChipSelector<String>(
        options: const ['Semua', 'Aktif', 'Dijawab'],
        selected: 'Semua',
        labelOf: (o) => o,
        onSelected: (o) => picked = o,
        wrap: small,
      ),
      dark: dark,
      small: small,
    );
    await tester.tap(find.text('Dijawab'));
    expect(picked, 'Dijawab');
  });

  testWidgetsAllThemes('state widgets render', (tester, {required dark, required small}) async {
    await _pump(
      tester,
      Column(
        children: [
          EmptyState(
            title: 'Belum ada ayat favorit',
            message: _longText,
            actionLabel: 'Tambah',
            onAction: () {},
          ),
          ErrorState(message: 'Gagal memuat', onRetry: () {}),
        ],
      ),
      dark: dark,
      small: small,
    );
    expect(find.text('Tambah'), findsOneWidget);
    expect(find.text('Coba lagi'), findsOneWidget);
  });

  testWidgetsAllThemes('showAppBottomSheet opens with title and actions', (
    tester, {
    required dark,
    required small,
  }) async {
    var edited = 0;
    await _pump(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () => showAppBottomSheet<void>(
            context: context,
            title: 'Doa untuk keluarga',
            builder: (_) => Column(
              children: [
                SheetAction(icon: Icons.edit, label: 'Ubah', onTap: () => edited++),
                SheetAction(
                  icon: Icons.delete_outline,
                  label: 'Hapus',
                  destructive: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
          child: const Text('Buka'),
        ),
      ),
      dark: dark,
      small: small,
    );

    await tester.tap(find.text('Buka'));
    await tester.pumpAndSettle();
    expect(find.text('Doa untuk keluarga'), findsOneWidget);
    await tester.tap(find.text('Ubah'));
    expect(edited, 1);
  });

  testWidgets('showComingSoon shows the snackbar', (tester) async {
    await pumpApp(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () => showComingSoon(context, 'Bagikan'),
          child: const Text('Bagikan'),
        ),
      ),
    );
    await tester.tap(find.text('Bagikan'));
    await tester.pump();
    expect(find.text('Bagikan segera hadir'), findsOneWidget);
  });
}
