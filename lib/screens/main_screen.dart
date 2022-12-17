import 'package:checklisttracker/methods/storage_controller.dart';
import 'package:checklisttracker/models/toplevellist.dart';
import 'package:checklisttracker/screens/detail_screen.dart';
import 'package:checklisttracker/shared_widgets/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:checklisttracker/screens/modal_controller.dart';
import 'package:flutter/cupertino.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {super.key, required this.storage, required this.checklistList});
  final Storage storage;
  final ListofLists checklistList;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool editMode = false;

  save() {
    widget.storage.saveItem(checklistList: widget.checklistList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          transitionBetweenRoutes: true,
          previousPageTitle: 'Checklists',
          backgroundColor: Colors.black,
          trailing: TextButton(
            child: Text(
                widget.checklistList.isEmpty
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
          launchModal(context: context, type: 'checklist').then((newlistname) {
            if (newlistname.isNotEmpty) {
              setState(() {
                widget.checklistList.insert(0, newlistname);
                save();
              });
            }
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ScreenTitle(title: 'Checklists'),
              Expanded(
                child: widget.checklistList.isEmpty
                    ? const Center(
                        child: Text(
                            'Nothing Here, click the + to add your first checklist',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                      blurRadius: 4,
                                      color: Color.fromARGB(255, 118, 10, 2),
                                      offset: Offset(4, 4))
                                ])),
                      )
                    : ListView(
                        children: widget.checklistList.list.map((checklist) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: ListTile(
                              title: Text(
                                checklist.title,
                              ),
                              trailing: editMode
                                  ? IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          widget.checklistList
                                              .delete(checklist.key);
                                          save();
                                        });
                                      },
                                      iconSize: 36,
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        saveMainList: save,
                                                        checklist: checklist)));
                                      }),
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
