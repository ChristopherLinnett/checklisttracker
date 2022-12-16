import 'package:checklisttracker/models/mainlist.dart';

class ListofLists {
  ListofLists(this.checklistList);
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

  void insert(int index, Checklist checklist) {
    checklistList.insert(index, checklist);
  }
}
