import 'package:flutter/foundation.dart';

/// A Bible translation the app can display.
///
/// Only openly licensed translations are allowed (AYT, KJV, WEB). TB/BIS/TL are
/// copyrighted by LAI and must never be added.
@immutable
class Translation {
  const Translation({required this.code, required this.name, required this.language});

  /// Short code stored with references, e.g. `AYT`.
  final String code;
  final String name;

  /// Language code: `id` or `en`.
  final String language;

  static const String defaultCode = 'AYT';

  @override
  bool operator ==(Object other) => other is Translation && other.code == code;

  @override
  int get hashCode => code.hashCode;
}
