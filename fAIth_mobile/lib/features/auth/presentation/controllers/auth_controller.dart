import 'dart:async';

import 'package:faith_mobile/features/auth/data/auth_service.dart';
import 'package:faith_mobile/features/auth/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements UserSession {
  final AuthService _authService;

  AuthController({AuthService? authService}) : _authService = authService ?? AuthService();

  final Rxn<User> user = Rxn<User>();
  final RxBool isLoading = false.obs;
  StreamSubscription<User?>? _sub;

  bool get isAuthenticated => user.value != null;

  @override
  AppUser? get currentUser {
    final u = user.value;
    if (u == null) return null;
    return AppUser(uid: u.uid, displayName: u.displayName, email: u.email, photoUrl: u.photoURL);
  }

  @override
  void onInit() {
    super.onInit();
    _sub = _authService.authStateChanges().listen((u) {
      user.value = u;
    });
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }

  Future<void> signInWithGoogle() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      await _authService.signInWithGoogle();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      await _authService.signOut();
    } finally {
      isLoading.value = false;
    }
  }
}
