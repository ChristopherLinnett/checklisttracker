import 'package:checklisttracker/models/toplevellist.dart';
import 'package:checklisttracker/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:checklisttracker/methods/storage_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('checklisttracker');
  Storage storage = Storage(box);
  ListofLists checklist = await storage.init();

  runApp(ChecklistApp(storage: storage, list: checklist));
}

class ChecklistApp extends StatelessWidget {
  final Storage storage;
  final ListofLists list;
  const ChecklistApp({super.key, required this.storage, required this.list});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'main': (context) => MainScreen(storage: storage, checklistList: list),
      },
      initialRoute: 'main',
    );
  }
}
