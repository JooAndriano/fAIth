import 'package:get/get.dart';

import 'package:faith_mobile/features/auth/presentation/controllers/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
