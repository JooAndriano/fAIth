/// Who wrote an [AiMessage]. The gateway accepts only these two roles.
enum AiRole { user, assistant }

/// One turn of a conversation sent to the AI gateway.
class AiMessage {
  const AiMessage({required this.role, required this.text});

  const AiMessage.user(this.text) : role = AiRole.user;

  const AiMessage.assistant(this.text) : role = AiRole.assistant;

  final AiRole role;
  final String text;

  Map<String, dynamic> toJson() => {'role': role.name, 'text': text};

  @override
  bool operator ==(Object other) => other is AiMessage && other.role == role && other.text == text;

  @override
  int get hashCode => Object.hash(role, text);
}
