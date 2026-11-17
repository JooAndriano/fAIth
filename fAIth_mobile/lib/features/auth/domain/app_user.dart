import 'package:flutter/foundation.dart';

/// Signed-in user as seen by features (decoupled from Firebase types).
@immutable
class AppUser {
  const AppUser({required this.uid, this.displayName, this.email, this.photoUrl});

  final String uid;
  final String? displayName;
  final String? email;
  final String? photoUrl;

  /// First word of the display name, or null when there is none.
  String? get firstName {
    final name = displayName?.trim();
    if (name == null || name.isEmpty) return null;
    return name.split(RegExp(r'\s+')).first;
  }

  /// Uppercase initial for avatar fallbacks.
  String get initial {
    final source = (displayName?.trim().isNotEmpty ?? false) ? displayName! : (email ?? '?');
    return String.fromCharCode(source.trim().runes.first).toUpperCase();
  }
}

/// Read access to the current session, implemented by `AuthController`.
abstract interface class UserSession {
  AppUser? get currentUser;
}
