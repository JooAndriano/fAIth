import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:faith_mobile/core/config/app_config.dart';
import 'package:faith_mobile/features/ai/domain/ai_exception.dart';
import 'package:faith_mobile/features/ai/domain/ai_gateway.dart';
import 'package:faith_mobile/features/ai/domain/ai_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

/// Returns the current user's Firebase ID token, or null when signed out.
typedef IdTokenProvider = Future<String?> Function();

Future<String?> _firebaseIdToken() async => FirebaseAuth.instance.currentUser?.getIdToken();

/// [AiGateway] backed by the `faith-ai-gateway` Cloudflare Worker.
///
/// Authenticates with the user's Firebase ID token; no API keys live in the app.
class AiService implements AiGateway {
  AiService({
    http.Client? client,
    IdTokenProvider? idToken,
    String baseUrl = AppConfig.aiBaseUrl,
    this.timeout = const Duration(seconds: 25),
  })  : _client = client ?? http.Client(),
        _idToken = idToken ?? _firebaseIdToken,
        _endpoint = Uri.parse('$baseUrl/v1/generate');

  final http.Client _client;
  final IdTokenProvider _idToken;
  final Uri _endpoint;
  final Duration timeout;

  @override
  Future<String> generate({required String mode, required List<AiMessage> messages}) async {
    final token = await _getToken();

    final http.Response res;
    try {
      res = await _client
          .post(
            _endpoint,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'mode': mode,
              'messages': [for (final m in messages) m.toJson()],
            }),
          )
          .timeout(timeout);
    } on TimeoutException {
      throw const AiException(AiErrorKind.unavailable, AiException.busyMessage);
    } on SocketException {
      throw const AiException(AiErrorKind.unavailable, AiException.busyMessage);
    } on http.ClientException {
      throw const AiException(AiErrorKind.unavailable, AiException.busyMessage);
    }

    final body = _decode(res);
    switch (res.statusCode) {
      case 200:
        final text = body?['text'];
        if (text is String && text.trim().isNotEmpty) return text;
        throw const AiException(AiErrorKind.unknown, AiException.unknownMessage);
      case 401:
        throw const AiException(AiErrorKind.unauthenticated, AiException.loginAgainMessage);
      case 429:
        throw AiException(
          AiErrorKind.rateLimited,
          _serverMessage(body) ?? AiException.rateLimitedMessage,
        );
      case 400:
        throw AiException(
          AiErrorKind.badRequest,
          _serverMessage(body) ?? AiException.badRequestMessage,
        );
      case 502 || 503 || 504:
        throw const AiException(AiErrorKind.unavailable, AiException.busyMessage);
      default:
        throw const AiException(AiErrorKind.unknown, AiException.unknownMessage);
    }
  }

  Future<String> _getToken() async {
    try {
      final token = await _idToken();
      if (token != null && token.isNotEmpty) return token;
    } catch (_) {
      // Fall through: treat any token failure as "sign in again".
    }
    throw const AiException(AiErrorKind.unauthenticated, AiException.loginAgainMessage);
  }

  static Map<String, dynamic>? _decode(http.Response res) {
    try {
      final decoded = jsonDecode(utf8.decode(res.bodyBytes));
      return decoded is Map<String, dynamic> ? decoded : null;
    } on FormatException {
      return null;
    }
  }

  /// The gateway's user-facing message (`error`, or `message` as a fallback).
  static String? _serverMessage(Map<String, dynamic>? body) {
    for (final key in const ['error', 'message']) {
      final value = body?[key];
      if (value is String && value.trim().isNotEmpty) return value;
    }
    return null;
  }
}
