import 'package:faith_mobile/features/ai/domain/ai_message.dart';

/// Text generation through the fAIth AI gateway.
abstract interface class AiGateway {
  /// Generates a reply for [messages] in [mode] (`chat` or `devotional`).
  ///
  /// Throws `AiException` with a user-facing message on failure.
  Future<String> generate({required String mode, required List<AiMessage> messages});
}
