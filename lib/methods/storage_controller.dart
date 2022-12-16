import 'package:checklisttracker/models/toplevellist.dart';
import 'package:localstorage/localstorage.dart';

class Storage {
  LocalStorage storage = LocalStorage('checklisttracker');
  final String storageName = 'checklisttracker';

  init() {
    ListofLists outputList = ListofLists(checklistList: []);
    var totalMap = storage.getItem(storageName);
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

  saveItem({required ListofLists checklistList}) {
    storage.setItem(storageName, checklistList.toEncodable());
    print(storage.getItem(storageName));
  }

  clearStorage() async {
    await storage.clear();
  }
}
