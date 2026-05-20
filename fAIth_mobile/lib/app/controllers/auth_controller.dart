import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService;

  AuthController({AuthService? authService})
      : _authService = authService ?? AuthService();

  final Rxn<User> user = Rxn<User>();
  final RxBool isLoading = false.obs;
  StreamSubscription<User?>? _sub;

  bool get isAuthenticated => user.value != null;

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
