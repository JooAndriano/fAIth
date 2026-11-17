import 'package:faith_mobile/core/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Temporary debug-only floating button (bug icon) that opens the AI gateway test screen.
///
/// Renders nothing in profile/release builds.
class AiDebugFab extends StatelessWidget {
  const AiDebugFab({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();
    return FloatingActionButton.small(
      heroTag: 'ai-debug-fab',
      tooltip: 'Debug: AI Gateway',
      onPressed: () => Get.toNamed<void>(AppRoutes.aiDebug),
      child: const Icon(Icons.bug_report_outlined),
    );
  }
}
