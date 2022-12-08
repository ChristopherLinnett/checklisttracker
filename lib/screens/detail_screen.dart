import 'package:flutter/material.dart';
import '../models/mainlist.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.checklist});
  final Checklist checklist;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF7CE577),
        appBar: AppBar(
          title: const Text('ChecklistApp'),
          backgroundColor: const Color.fromARGB(255, 68, 159, 19),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 68, 159, 19),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: ListView(
          children: widget.checklist.tasks.map((task) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: ListTile(
                title: Text(
                  task.title,
                ),
                trailing: GestureDetector(
                  child: Checkbox(
                    value: task.isChecked,
                    onChanged: (value) {
                      setState(() {
                        task.toggleChecked();
                      });
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }
}
