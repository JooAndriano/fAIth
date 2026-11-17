import 'dart:async';

import 'package:faith_mobile/core/routes/app_routes.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:faith_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    final auth = Get.find<AuthController>();
    if (auth.isAuthenticated) {
      unawaited(Get.offNamed(AppRoutes.shell));
    } else {
      unawaited(Get.offNamed(AppRoutes.login));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Icon(
              Icons.favorite,
              size: 80,
              color: context.faith.gold,
            ),
            const SizedBox(height: 24),
            Text(
              'fAIth',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: context.faith.gold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Personal AI Spiritual Companion',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: CircularProgressIndicator(
                color: context.faith.gold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
