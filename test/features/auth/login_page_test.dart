import 'dart:async';

import 'package:faith_mobile/features/auth/data/auth_service.dart';
import 'package:faith_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:faith_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../helpers/pump_app.dart';

/// Sign-in that stays pending until [signIn] is completed.
class _PendingAuthService implements AuthService {
  // Created on first call so it lives in the test's fake-async zone.
  Completer<UserCredential?>? _signIn;
  Completer<UserCredential?> get signIn => _signIn ??= Completer<UserCredential?>();
  int calls = 0;

  @override
  Stream<User?> authStateChanges() => const Stream.empty();

  @override
  Future<UserCredential?> signInWithGoogle() {
    calls++;
    return signIn.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _PendingAuthService service;

  setUp(() {
    service = _PendingAuthService();
    Get.put(AuthController(authService: service));
  });

  tearDown(Get.reset);

  testWidgets('shows a loading indicator and blocks taps while signing in', (tester) async {
    await pumpApp(tester, const LoginPage(), wrapInScaffold: false);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text('Sign in with Google'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Signing in...'), findsOneWidget);

    await tester.tap(find.text('Signing in...'));
    await tester.pump();
    expect(service.calls, 1);

    service.signIn.complete(null); // cancelled by the user
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Sign in with Google'), findsOneWidget);
  });

  testWidgets('fits a small screen with large text while loading', (tester) async {
    await pumpApp(
      tester,
      const LoginPage(),
      wrapInScaffold: false,
      size: kSmallScreen,
      textScale: kLargeTextScale,
    );
    await tester.tap(find.text('Sign in with Google'));
    await tester.pump();
    expect(tester.takeException(), isNull);

    service.signIn.complete(null);
    await tester.pumpAndSettle();
  });
}
