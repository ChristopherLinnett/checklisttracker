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
  List<Checklist> checklistList = [Checklist('Monday', [])];
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(editMode ? 'cancel' : 'edit',
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 16)),
                    onPressed: () {
                      setState(() {
                        editMode = !editMode;
                      });
                    },
                  )
                ],
              ),
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
      ),
    );
  }
}
