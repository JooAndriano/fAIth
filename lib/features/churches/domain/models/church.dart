import 'package:flutter/foundation.dart';

@immutable
class Church {
  const Church({
    required this.id,
    required this.name,
    required this.address,
    required this.denomination,
    required this.distanceKm,
  });

  final String id;
  final String name;
  final String address;
  final String denomination;
  final double distanceKm;

  /// Distance in Indonesian notation, e.g. "0,8 km".
  String get distanceLabel => '${distanceKm.toStringAsFixed(1).replaceAll('.', ',')} km';
}
