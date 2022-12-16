import 'package:checklisttracker/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const ChecklistApp());
}

class ChecklistApp extends StatelessWidget {
  const ChecklistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'main': (context) => MainScreen(),
      },
      initialRoute: 'main',
    );
  }
}
