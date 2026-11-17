import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/material.dart';

/// Tanya fAIth tab. Built in bolt 009-chat.
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tanya fAIth')),
      body: const EmptyState(icon: Icons.chat_bubble_outline, title: 'Segera hadir'),
    );
  }
}
