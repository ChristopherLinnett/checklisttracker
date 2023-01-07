import 'package:checklisttracker/screens/modal_controller.dart';
import 'package:checklisttracker/shared_widgets/screen_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/mainlist.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {super.key, required this.checklist, required this.saveMainList});
  final Checklist checklist;
  final Function saveMainList;

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
                  widget.checklist.createTask(taskName: newTask);
                  widget.saveMainList();
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
              AnimatedContainer(
                color: const Color.fromARGB(255, 59, 52, 49),
                duration: const Duration(milliseconds: 300),
                height: widget.checklist.tasks.length * 70,
                child: ListView.builder(
                    itemCount: widget.checklist.tasks.length,
                    itemBuilder: ((context, index) => Column(children: [
                          ListTile(
                            title: editMode
                                ? TextFormField(
                                    initialValue:
                                        widget.checklist.tasks[index].title,
                                    onChanged: (value) {
                                      widget.checklist.tasks[index].tempTitle =
                                          value;
                                      setState(() {
                                        if (value !=
                                            widget
                                                .checklist.tasks[index].title) {
                                          widget.checklist.tasks[index]
                                              .editable = true;
                                        } else {
                                          widget.checklist.tasks[index]
                                              .editable = false;
                                        }
                                      });
                                    })
                                : Text(
                                    widget.checklist.tasks[index].title,
                                  ),
                            trailing: editMode
                                ? (widget.checklist.tasks[index].editable
                                    ? IconButton(
                                        icon: const Icon(Icons.check),
                                        color: Colors.blue,
                                        onPressed: () {
                                          setState(() {
                                            widget.checklist.tasks[index]
                                                    .title =
                                                widget.checklist.tasks[index]
                                                    .tempTitle;
                                            widget.checklist.tasks[index]
                                                .tempTitle = '';
                                            widget.checklist.tasks[index]
                                                .editable = false;
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        onPressed: () {
                                          setState(() {
                                            widget.checklist.deleteTask(widget
                                                .checklist.tasks[index].key);
                                            widget.saveMainList();
                                          });
                                        },
                                        iconSize: 36,
                                      ))
                                : Checkbox(
                                    checkColor: Colors.black,
                                    fillColor:
                                        MaterialStateProperty.all(Colors.white),
                                    value:
                                        widget.checklist.tasks[index].isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        widget.checklist.tasks[index]
                                            .toggleChecked();
                                        widget.saveMainList();
                                      });
                                    },
                                  ),
                          ),
                          const Divider(color: Colors.white)
                        ]))),
              )
            ],
          ),
        ));
  }
}
