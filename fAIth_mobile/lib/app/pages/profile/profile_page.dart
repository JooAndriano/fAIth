import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final user = auth.user.value;
          if (user == null) {
            return const Center(child: Text('Not signed in'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Name: ${user.displayName ?? "-"}'),
              Text('Email: ${user.email ?? "-"}'),
              Text('UID: ${user.uid}'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: auth.isLoading.value
                    ? null
                    : () async {
                        await auth.signOut();
                        Get.offAllNamed(AppRoutes.login);
                      },
                child: const Text('Sign out'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
