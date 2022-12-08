import 'package:checklisttracker/models/task.dart';
import 'package:checklisttracker/screens/detail_screen.dart';
import 'package:checklisttracker/shared_widgets/screen_title.dart';
import 'package:flutter/material.dart';
import '../models/mainlist.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Checklist> checklistList = [
    Checklist('Monday', [Task('do homwork', false)])
  ];
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7CE577),
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text(editMode ? 'cancel' : 'edit',
                style: const TextStyle(color: Colors.white, fontSize: 24)),
            onPressed: () {
              setState(() {
                editMode = !editMode;
              });
            },
          )
        ],
        backgroundColor: const Color.fromARGB(255, 68, 159, 19),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 68, 159, 19),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ScreenTitle(title: 'Checklists'),
            Expanded(
              child: ListView(
                children: checklistList.map((checklist) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: ListTile(
                      title: Text(
                        checklist.title,
                      ),
                      trailing: GestureDetector(
                        child: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(checklist: checklist)));
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
