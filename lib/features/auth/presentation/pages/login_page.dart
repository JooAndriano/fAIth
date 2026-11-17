import 'dart:async';

import 'package:faith_mobile/core/routes/app_routes.dart';
import 'package:faith_mobile/core/theme/app_colors.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:faith_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        // Centered when it fits; scrolls on small screens or with large text.
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Center(
                      child: Image.asset(
                        'assets/splash/splash_logo.png',
                        width: 120,
                        semanticLabel: 'Logo fAIth',
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Welcome to fAIth',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your personal AI spiritual companion',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    Obx(() {
                      final auth = Get.find<AuthController>();
                      final loading = auth.isLoading.value;
                      return ElevatedButton.icon(
                        onPressed: loading
                            ? null
                            : () async {
                                await auth.signInWithGoogle();
                                if (auth.isAuthenticated) {
                                  unawaited(Get.offNamed(AppRoutes.shell));
                                }
                              },
                        icon: loading
                            ? const SizedBox.square(
                                dimension: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppColors.navy,
                                  semanticsLabel: 'Sedang masuk',
                                ),
                              )
                            : const Icon(Icons.login),
                        label: Text(loading ? 'Signing in...' : 'Sign in with Google'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          // Keep the gold look while disabled during sign-in.
                          disabledBackgroundColor: context.faith.gold.withValues(alpha: 0.75),
                          disabledForegroundColor: AppColors.navy,
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    Text(
                      'By signing in, you agree to our Terms of Service and Privacy Policy',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
