import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

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
    Get.offNamed(AppRoutes.login);
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
            const Icon(
              Icons.favorite,
              size: 80,
              color: Color(0xFFD4A574),
            ),
            const SizedBox(height: 24),
            Text(
              'fAIth',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: const Color(0xFFD4A574),
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
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
