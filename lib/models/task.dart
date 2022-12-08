import 'package:flutter/material.dart';

class Task {
  Task(this.title, this.isChecked);
  final String key = UniqueKey().toString();
  String title;
  String tempTitle = '';
  bool isChecked;
  bool editable = false;

  toggleEdit() {
    editable = true;
  }

  toggleChecked() {
    isChecked = !isChecked;
  }
}
