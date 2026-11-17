import 'package:faith_mobile/features/home/presentation/controllers/home_controller.dart';
import 'package:faith_mobile/features/shell/presentation/controllers/shell_controller.dart';
import 'package:get/get.dart';

/// Controllers of the shell and its tabs (all tabs live as long as the shell).
class ShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShellController());
    Get.put(
      HomeController(
        session: Get.find(),
        devotionals: Get.find(),
        favorites: Get.find(),
        verseOfDay: Get.find(),
        bible: Get.find(),
        churches: Get.find(),
      ),
    );
  }
}
