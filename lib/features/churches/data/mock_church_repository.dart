import 'package:faith_mobile/features/churches/domain/models/church.dart';
import 'package:faith_mobile/features/churches/domain/repositories/church_repository.dart';
import 'package:faith_mobile/shared/data/mock_latency.dart';

/// Fictional churches with fixed distances (no location access in Phase 2).
class MockChurchRepository implements ChurchRepository {
  MockChurchRepository({this.latency = kMockLatency, List<Church>? seed})
      : _items = seed ?? sampleChurches;

  final Duration latency;
  final List<Church> _items;

  @override
  Future<List<Church>> getNearby({int limit = 20}) async {
    await simulateLatency(latency);
    final sorted = [..._items]..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return sorted.take(limit).toList();
  }

  static const List<Church> sampleChurches = [
    Church(
      id: 'church-1',
      name: 'Gereja Kasih Karunia',
      address: 'Jl. Melati No. 12, Jakarta Selatan',
      denomination: 'Interdenominasi',
      distanceKm: 0.8,
    ),
    Church(
      id: 'church-2',
      name: 'Gereja Terang Pengharapan',
      address: 'Jl. Kenanga Raya No. 5, Jakarta Selatan',
      denomination: 'Protestan',
      distanceKm: 1.6,
    ),
    Church(
      id: 'church-3',
      name: 'Paroki Santa Maria Damai',
      address: 'Jl. Cempaka No. 21, Jakarta Selatan',
      denomination: 'Katolik',
      distanceKm: 2.3,
    ),
    Church(
      id: 'church-4',
      name: 'Gereja Sukacita Sejati',
      address: 'Jl. Anggrek No. 3, Jakarta Selatan',
      denomination: 'Pentakosta',
      distanceKm: 3.4,
    ),
  ];
}
