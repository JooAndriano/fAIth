import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Center(
        child: Text(
          'AI Spiritual Chat (placeholder)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
