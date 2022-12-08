import 'package:checklisttracker/models/task.dart';
import 'package:flutter/material.dart';

class Checklist {
  Checklist(this.title, this.tasks);
  final String key = UniqueKey().toString();
  String title;
  List<Task> tasks;
}
