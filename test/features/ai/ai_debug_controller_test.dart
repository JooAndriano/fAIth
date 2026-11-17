import 'package:faith_mobile/features/ai/domain/ai_exception.dart';
import 'package:faith_mobile/features/ai/domain/ai_gateway.dart';
import 'package:faith_mobile/features/ai/domain/ai_message.dart';
import 'package:faith_mobile/features/ai/presentation/controllers/ai_debug_controller.dart';
import 'package:faith_mobile/shared/state/view_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAi implements AiGateway {
  _FakeAi(this._respond);

  final Future<String> Function() _respond;
  String? lastMode;
  List<AiMessage>? lastMessages;

  @override
  Future<String> generate({required String mode, required List<AiMessage> messages}) {
    lastMode = mode;
    lastMessages = messages;
    return _respond();
  }
}

void main() {
  test('sendHello sends "Halo" in chat mode and shows the reply', () async {
    final ai = _FakeAi(() async => 'Shalom!');
    final c = AiDebugController(ai: ai);

    expect(c.reply.value, isA<ViewEmpty<String>>());
    await c.sendHello();

    expect(ai.lastMode, 'chat');
    expect(ai.lastMessages, const [AiMessage.user('Halo')]);
    expect(c.reply.value.dataOrNull, 'Shalom!');
  });

  test('sendHello shows the AiException message', () async {
    final c = AiDebugController(
      ai: _FakeAi(
        () => Future.error(
          const AiException(AiErrorKind.unavailable, AiException.busyMessage),
        ),
      ),
    );
    await c.sendHello();

    final state = c.reply.value;
    expect(state, isA<ViewError<String>>());
    expect((state as ViewError<String>).message, AiException.busyMessage);
  });
}
