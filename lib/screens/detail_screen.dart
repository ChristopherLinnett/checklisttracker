import 'package:checklisttracker/screens/modal_controller.dart';
import 'package:checklisttracker/shared_widgets/screen_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/mainlist.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.checklist});
  final Checklist checklist;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
            transitionBetweenRoutes: true,
            previousPageTitle: 'Checklists',
            backgroundColor: Colors.black,
            trailing: TextButton(
              child: Text(
                  widget.checklist.tasks.isEmpty
                      ? ''
                      : editMode
                          ? 'done'
                          : 'edit',
                  style: const TextStyle(color: Colors.blue, fontSize: 16)),
              onPressed: () {
                setState(() {
                  editMode = !editMode;
                });
              },
            )),
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            launchModal(context: context, type: 'task').then((newTask) {
              if (newTask != '') {
                setState(() {
                  widget.checklist.createTask(newTask);
                });
              }
            });
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScreenTitle(
                title: widget.checklist.title,
              ),
              Expanded(
                child: ListView(
                  children: widget.checklist.tasks.map((task) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: ListTile(
                        title: editMode
                            ? TextFormField(
                                initialValue: task.title,
                                onChanged: (value) {
                                  task.tempTitle = value;
                                  setState(() {
                                    if (value != task.title) {
                                      task.editable = true;
                                    } else {
                                      task.editable = false;
                                    }
                                  });
                                })
                            : Text(
                                task.title,
                              ),
                        trailing: editMode
                            ? (task.editable
                                ? IconButton(
                                    icon: const Icon(Icons.check),
                                    color: Colors.blue,
                                    onPressed: () {
                                      setState(() {
                                        task.title = task.tempTitle;
                                        task.tempTitle = '';
                                        task.editable = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        widget.checklist.deleteTask(task.key);
                                      });
                                    },
                                    iconSize: 36,
                                  ))
                            : Checkbox(
                                value: task.isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    task.toggleChecked();
                                  });
                                },
                              ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ));
  }
}
