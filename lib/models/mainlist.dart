import 'package:checklisttracker/models/task.dart';
import 'package:flutter/material.dart';

class Checklist {
  Checklist(this.title, this.tasks);
  final String key = UniqueKey().toString();
  String title;
  List<Task> tasks;

  deleteTask(String taskKey) {
    tasks.removeWhere((task) {
      return task.key == taskKey;
    });
  }

  createTask(String taskName) {
    tasks.add(
      Task(taskName, false),
    );
  }

  toEncodable() {
    Map checklist = {};
    checklist['title'] = title;
    checklist['tasks'] = tasks.map((task) {
      return task.toEncodable();
    }).toList();
    return checklist;
  }
}
