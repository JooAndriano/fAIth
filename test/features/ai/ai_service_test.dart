import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:faith_mobile/features/ai/data/ai_service.dart';
import 'package:faith_mobile/features/ai/domain/ai_exception.dart';
import 'package:faith_mobile/features/ai/domain/ai_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

const _hello = [AiMessage.user('Halo')];

AiService _service(
  MockClientHandler handler, {
  Future<String?> Function()? idToken,
  Duration timeout = const Duration(seconds: 25),
}) {
  return AiService(
    client: MockClient(handler),
    idToken: idToken ?? () async => 'tok',
    baseUrl: 'https://gw.test',
    timeout: timeout,
  );
}

http.Response _json(Object body, int status) => http.Response.bytes(
      utf8.encode(jsonEncode(body)),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

Matcher _aiError(AiErrorKind kind, [String? message]) => isA<AiException>()
    .having((e) => e.kind, 'kind', kind)
    .having((e) => e.message, 'message', message ?? isNotEmpty);

void main() {
  test('AiMessage.toJson uses user/assistant roles', () {
    expect(const AiMessage.user('a').toJson(), {'role': 'user', 'text': 'a'});
    expect(const AiMessage.assistant('b').toJson(), {'role': 'assistant', 'text': 'b'});
  });

  test('sends authorized JSON request and returns text', () async {
    late http.Request sent;
    final ai = _service((req) async {
      sent = req;
      return _json({'text': 'Shalom, apa kabar?'}, 200);
    });

    final text = await ai.generate(
      mode: 'chat',
      messages: const [AiMessage.user('Halo'), AiMessage.assistant('Hai'), AiMessage.user('Doa')],
    );

    expect(text, 'Shalom, apa kabar?');
    expect(sent.method, 'POST');
    expect(sent.url.toString(), 'https://gw.test/v1/generate');
    expect(sent.headers['Authorization'], 'Bearer tok');
    expect(sent.headers['Content-Type'], startsWith('application/json'));
    expect(jsonDecode(sent.body), {
      'mode': 'chat',
      'messages': [
        {'role': 'user', 'text': 'Halo'},
        {'role': 'assistant', 'text': 'Hai'},
        {'role': 'user', 'text': 'Doa'},
      ],
    });
  });

  group('errors', () {
    test('signed out / token failure -> login again, no request sent', () async {
      var called = false;
      Future<http.Response> handler(http.Request _) async {
        called = true;
        return _json({'text': 'x'}, 200);
      }

      await expectLater(
        _service(handler, idToken: () async => null).generate(mode: 'chat', messages: _hello),
        throwsA(_aiError(AiErrorKind.unauthenticated, AiException.loginAgainMessage)),
      );
      await expectLater(
        _service(handler, idToken: () => Future.error(Exception('x')))
            .generate(mode: 'chat', messages: _hello),
        throwsA(_aiError(AiErrorKind.unauthenticated, AiException.loginAgainMessage)),
      );
      expect(called, isFalse);
    });

    test('401 -> login again', () async {
      final ai = _service((_) async => _json({'error': 'Sesi tidak valid.'}, 401));
      await expectLater(
        ai.generate(mode: 'chat', messages: _hello),
        throwsA(_aiError(AiErrorKind.unauthenticated, AiException.loginAgainMessage)),
      );
    });

    test('429 -> server message (error, then message, then default)', () async {
      for (final (body, expected) in [
        ({'error': 'Batas harian tercapai.'}, 'Batas harian tercapai.'),
        ({'message': 'Kuota habis.'}, 'Kuota habis.'),
        (<String, String>{}, AiException.rateLimitedMessage),
      ]) {
        final ai = _service((_) async => _json(body, 429));
        await expectLater(
          ai.generate(mode: 'chat', messages: _hello),
          throwsA(_aiError(AiErrorKind.rateLimited, expected)),
        );
      }
    });

    test('502/503/504 -> busy', () async {
      for (final status in [502, 503, 504]) {
        final ai = _service((_) async => _json({'error': 'detail'}, status));
        await expectLater(
          ai.generate(mode: 'chat', messages: _hello),
          throwsA(_aiError(AiErrorKind.unavailable, AiException.busyMessage)),
        );
      }
    });

    test('timeout -> busy', () async {
      final ai = _service(
        (_) => Completer<http.Response>().future,
        timeout: const Duration(milliseconds: 10),
      );
      await expectLater(
        ai.generate(mode: 'chat', messages: _hello),
        throwsA(_aiError(AiErrorKind.unavailable, AiException.busyMessage)),
      );
    });

    test('no network -> busy', () async {
      for (final error in [
        const SocketException('offline'),
        http.ClientException('offline'),
      ]) {
        final ai = _service((_) => Future.error(error));
        await expectLater(
          ai.generate(mode: 'chat', messages: _hello),
          throwsA(_aiError(AiErrorKind.unavailable, AiException.busyMessage)),
        );
      }
    });

    test('400 -> server message; other/invalid -> generic', () async {
      await expectLater(
        _service((_) async => _json({'error': 'Maksimal 20 pesan.'}, 400))
            .generate(mode: 'chat', messages: _hello),
        throwsA(_aiError(AiErrorKind.badRequest, 'Maksimal 20 pesan.')),
      );
      await expectLater(
        _service((_) async => http.Response('oops', 500)).generate(mode: 'chat', messages: _hello),
        throwsA(_aiError(AiErrorKind.unknown, AiException.unknownMessage)),
      );
      await expectLater(
        _service((_) async => http.Response('not json', 200))
            .generate(mode: 'chat', messages: _hello),
        throwsA(_aiError(AiErrorKind.unknown, AiException.unknownMessage)),
      );
    });
  });
}
