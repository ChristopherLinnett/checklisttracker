class Task {
  Task(this.title, this.isChecked);

  String title;
  bool isChecked;

  toggleChecked() {
    isChecked = !isChecked;
  }
}
