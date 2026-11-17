import 'package:faith_mobile/features/ai/domain/ai_exception.dart';
import 'package:faith_mobile/features/ai/domain/ai_gateway.dart';
import 'package:faith_mobile/features/ai/domain/ai_message.dart';
import 'package:faith_mobile/shared/state/view_state.dart';
import 'package:get/get.dart';

/// Debug-only: sends "Halo" to the gateway in chat mode to test the path end to end.
class AiDebugController extends GetxController {
  AiDebugController({required AiGateway ai}) : _ai = ai;

  final AiGateway _ai;

  final Rx<ViewState<String>> reply = Rx<ViewState<String>>(const ViewEmpty());

  Future<void> sendHello() async {
    if (reply.value.isLoading) return;
    reply.value = const ViewLoading();
    try {
      final text = await _ai.generate(mode: 'chat', messages: const [AiMessage.user('Halo')]);
      reply.value = ViewData(text);
    } on AiException catch (e) {
      reply.value = ViewError(e.message);
    } catch (_) {
      reply.value = const ViewError(AiException.unknownMessage);
    }
  }
}
