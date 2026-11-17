import 'package:faith_mobile/features/ai/presentation/controllers/ai_debug_controller.dart';
import 'package:get/get.dart';

class AiDebugBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AiDebugController(ai: Get.find()));
  }
}
