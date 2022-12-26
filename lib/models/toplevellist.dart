import 'package:checklisttracker/models/mainlist.dart';

class ListofLists {
  ListofLists({required this.checklistList});
  List<Checklist> checklistList;

  toEncodable() {
    Map encodedTopList = {};
    encodedTopList['checklist'] = checklistList.map((checklist) {
      return checklist.toEncodable();
    }).toList();
    return encodedTopList;
  }

  List<Checklist> get list {
    return checklistList;
  }

  bool get isEmpty {
    return checklistList.isEmpty;
  }

  void delete(String key) {
    checklistList.removeWhere((list) {
      return list.key == key;
    });
  }

  void insert(int index, String listname) {
    checklistList.add(Checklist(title: listname, tasks: []));
  }
}
