import 'package:faith_mobile/features/ai/presentation/controllers/ai_debug_controller.dart';
import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Debug-only screen (registered only when `kDebugMode`) to test the AI gateway.
class AiDebugPage extends GetView<AiDebugController> {
  const AiDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug: AI Gateway')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => FilledButton.icon(
                onPressed: controller.reply.value.isLoading ? null : controller.sendHello,
                icon: const Icon(Icons.send),
                label: const Text('Kirim "Halo" (mode chat)'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => ViewStateBuilder<String>(
                  state: controller.reply.value,
                  onRetry: controller.sendHello,
                  emptyTitle: 'Belum ada balasan',
                  emptyIcon: Icons.smart_toy_outlined,
                  loadingMessage: 'Menunggu balasan...',
                  builder: (context, text) => SingleChildScrollView(child: SelectableText(text)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
