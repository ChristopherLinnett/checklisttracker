import 'package:localstorage/localstorage.dart';
import 'package:checklisttracker/models/mainlist.dart';

class Storage {
  Storage({required LocalStorage storage});
  final LocalStorage storage = LocalStorage('checklisttracker');

  saveItem({required Checklist checklistList}) {
    storage.setItem('checklisttracker', checklistList.toEncodable());
  }
}
