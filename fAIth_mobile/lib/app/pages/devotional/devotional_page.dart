import 'package:flutter/material.dart';

class DevotionalPage extends StatelessWidget {
  const DevotionalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devotional'),
      ),
      body: Center(
        child: Text(
          'Daily Devotionals (placeholder)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
