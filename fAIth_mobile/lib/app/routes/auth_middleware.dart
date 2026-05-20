import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthController>();
    if (!auth.isAuthenticated) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}
