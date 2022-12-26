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
            launchModal(context: context, type: 'checklist')
                .then((newlistname) {
              if (newlistname.isNotEmpty) {
                setState(() {
                  widget.checklistList.insert(0, newlistname);
                  editMode = false;
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
                  widget.checklistList.list.isEmpty
                      ? const Expanded(
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
                      : AnimatedContainer(
                          color: const Color.fromARGB(255, 47, 13, 0),
                          height: widget.checklistList.list.isNotEmpty
                              ? widget.checklistList.list.length * 70
                              : 100,
                          duration: const Duration(milliseconds: 300),
                          child: ListView.builder(
                            itemCount: widget.checklistList.list.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    widget.checklistList.list[index].title,
                                  ),
                                  trailing: editMode
                                      ? IconButton(
                                          icon: const Icon(Icons.delete),
                                          color: Colors.red,
                                          onPressed: () {
                                            setState(() {
                                              widget.checklistList.delete(widget
                                                  .checklistList
                                                  .list[index]
                                                  .key);
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
                                                        checklist: widget
                                                            .checklistList
                                                            .list[index]),
                                              ),
                                            );
                                          }),
                                ),
                                const Divider(color: Colors.white),
                              ],
                            ),
                          ),
                        )
                ]),
          ),
        ));
  }
}
