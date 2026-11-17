import 'package:faith_mobile/features/bible/domain/models/verse_ref.dart';
import 'package:faith_mobile/features/devotional/domain/models/devotional.dart';
import 'package:faith_mobile/features/devotional/domain/repositories/devotional_repository.dart';
import 'package:faith_mobile/shared/data/mock_latency.dart';

/// In-memory devotionals (Phase 2 dummy data). Drafts are filtered out like in Phase 3.
class MockDevotionalRepository implements DevotionalRepository {
  MockDevotionalRepository({this.latency = kMockLatency, List<Devotional>? seed})
      : _items = seed ?? sampleDevotionals;

  final Duration latency;
  final List<Devotional> _items;

  List<Devotional> get _published =>
      _items.where((d) => d.isPublished).toList()..sort((a, b) => a.dayNumber - b.dayNumber);

  @override
  Future<Devotional?> getForDate(DateTime date) async {
    await simulateLatency(latency);
    final published = _published;
    if (published.isEmpty) return null;
    // Rotate through the published days by day of year.
    final dayOfYear = date.difference(DateTime(date.year)).inDays;
    return published[dayOfYear % published.length];
  }

  static final List<Devotional> sampleDevotionals = [
    Devotional(
      id: 'day-001',
      dayNumber: 1,
      title: 'Damai di Tengah Ketidakpastian',
      verseRef: VerseRef.parse('JHN:14:27'),
      verseText: 'Damai sejahtera Kutinggalkan bagimu; damai-Ku Kuberikan kepadamu. '
          'Janganlah hatimu gelisah dan gentar.',
      body: 'Hidup sering menghadirkan hal-hal yang tidak bisa kita kendalikan. Yesus tidak '
          'menjanjikan hidup tanpa badai, tetapi Ia menjanjikan damai-Nya sendiri. Damai ini '
          'tidak bergantung pada keadaan, melainkan pada kehadiran-Nya yang setia menyertai.',
      reflectionQuestions: [
        'Hal apa yang paling membuatmu gelisah minggu ini?',
        'Bagaimana kamu bisa menyerahkan hal itu kepada Tuhan hari ini?',
      ],
      prayer: 'Tuhan, tenangkan hatiku. Ajar aku memercayai-Mu di tengah hal yang belum '
          'kupahami. Amin.',
      tags: ['damai', 'kepercayaan'],
    ),
    Devotional(
      id: 'day-002',
      dayNumber: 2,
      title: 'Gembala yang Mencukupkan',
      verseRef: VerseRef.parse('PSA:23:1'),
      verseText: 'TUHAN menggembalakan aku; tak ada yang kurang padaku.',
      body: 'Seorang gembala mengenal setiap dombanya. Ia tahu kapan domba lapar, lelah, '
          'atau tersesat. Pemazmur mengingatkan bahwa Tuhan memperhatikan kebutuhan kita '
          'dengan cara yang sama, bahkan sebelum kita memintanya.',
      reflectionQuestions: [
        'Di bagian hidup mana kamu merasa "kekurangan" saat ini?',
        'Pemeliharaan Tuhan apa yang bisa kamu syukuri hari ini?',
      ],
      prayer: 'Gembalaku yang baik, terima kasih karena Engkau mencukupkan aku. '
          'Tuntun langkahku hari ini. Amin.',
      tags: ['pemeliharaan', 'syukur'],
    ),
    Devotional(
      id: 'day-003',
      dayNumber: 3,
      title: 'Kelegaan bagi yang Letih',
      verseRef: VerseRef.parse('MAT:11:28'),
      verseText: 'Datanglah kepada-Ku, kalian semua yang letih dan berbeban berat, '
          'Aku akan memberi kelegaan bagimu.',
      body: 'Undangan Yesus sederhana: datanglah. Ia tidak meminta kita membereskan semuanya '
          'lebih dulu. Ketika kita membawa beban apa adanya, Ia memberi kelegaan yang tidak '
          'bisa diberikan oleh istirahat biasa.',
      reflectionQuestions: [
        'Beban apa yang selama ini kamu pikul sendirian?',
        'Apa satu langkah kecil untuk beristirahat di dalam Tuhan hari ini?',
      ],
      prayer: 'Yesus, aku datang dengan segala bebanku. Berikan kelegaan dan kekuatan baru. '
          'Amin.',
      tags: ['istirahat', 'pengharapan'],
    ),
    Devotional(
      id: 'day-004',
      dayNumber: 4,
      title: 'Draf: belum ditinjau',
      verseRef: VerseRef.parse('PHP:4:13'),
      verseText: 'Aku sanggup menanggung segala sesuatu di dalam Dia yang menguatkan aku.',
      body: 'Draf renungan yang belum ditinjau tidak boleh tampil di aplikasi.',
      reflectionQuestions: ['-'],
      prayer: '-',
      status: DevotionalStatus.draft,
    ),
  ];
}
