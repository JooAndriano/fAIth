import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Study'),
      ),
      body: Center(
        child: Text(
          'Bible Study (placeholder)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
