import 'package:checklisttracker/models/toplevellist.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Storage {
  Storage(this.storage);
  final Box storage;
  final String storageName = 'checklisttracker';

  init() async {
    ListofLists outputList = ListofLists(checklistList: []);
    var totalMap = storage.get(storageName);
    var checklists = totalMap != null ? totalMap['checklist'] : ['empty'];
    for (var list in checklists) {
      outputList.insert(0, list['title']);
      for (var task in list['tasks']) {
        outputList.list[0]
            .createTask(taskName: task['title'], isChecked: task['isChecked']);
      }
    }
    return outputList;
  }

  saveItem({required ListofLists checklistList}) async {
    await storage.put(storageName, checklistList.toEncodable());
  }

  clearStorage() async {
    await storage.clear();
  }
}
